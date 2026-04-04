import SwiftUI
import Speech
import AVFoundation

// MARK: - Speech Recognizer

class SpeechRecognizer: ObservableObject {
    @Published var transcript = ""
    @Published var isRecording = false
    @Published var errorMessage: String?
    @Published var isAuthorized = false

    private var recognitionTask: SFSpeechRecognitionTask?
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    private let audioEngine = AVAudioEngine()
    private let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "en-US"))

    func requestAuthorization() {
        SFSpeechRecognizer.requestAuthorization { [weak self] status in
            DispatchQueue.main.async {
                switch status {
                case .authorized:
                    self?.isAuthorized = true
                case .denied, .restricted, .notDetermined:
                    self?.isAuthorized = false
                    self?.errorMessage = "Speech recognition not authorized. Please enable it in Settings > Privacy > Speech Recognition."
                @unknown default:
                    self?.isAuthorized = false
                }
            }
        }
    }

    func startRecording() {
        guard let speechRecognizer, speechRecognizer.isAvailable else {
            errorMessage = "Speech recognizer is not available."
            return
        }

        // Reset
        recognitionTask?.cancel()
        recognitionTask = nil
        transcript = ""
        errorMessage = nil

        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(.record, mode: .measurement, options: .duckOthers)
            try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
        } catch {
            errorMessage = "Audio session error: \(error.localizedDescription)"
            return
        }

        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        guard let recognitionRequest else {
            errorMessage = "Unable to create recognition request."
            return
        }
        recognitionRequest.shouldReportPartialResults = true

        let inputNode = audioEngine.inputNode
        let recordingFormat = inputNode.outputFormat(forBus: 0)

        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { buffer, _ in
            recognitionRequest.append(buffer)
        }

        recognitionTask = speechRecognizer.recognitionTask(with: recognitionRequest) { [weak self] result, error in
            DispatchQueue.main.async {
                if let result {
                    self?.transcript = result.bestTranscription.formattedString
                }
                if error != nil || (result?.isFinal ?? false) {
                    self?.stopRecording()
                }
            }
        }

        do {
            audioEngine.prepare()
            try audioEngine.start()
            isRecording = true
        } catch {
            errorMessage = "Audio engine error: \(error.localizedDescription)"
            stopRecording()
        }
    }

    func stopRecording() {
        audioEngine.stop()
        audioEngine.inputNode.removeTap(onBus: 0)
        recognitionRequest?.endAudio()
        recognitionRequest = nil
        recognitionTask?.cancel()
        recognitionTask = nil
        isRecording = false
    }
}

// MARK: - Voice Input Button

struct VoiceInputButton: View {
    @ObservedObject var speechRecognizer: SpeechRecognizer
    @Binding var text: String

    var body: some View {
        Button {
            if speechRecognizer.isRecording {
                speechRecognizer.stopRecording()
                if !speechRecognizer.transcript.isEmpty {
                    if !text.isEmpty { text += " " }
                    text += speechRecognizer.transcript
                }
            } else {
                if speechRecognizer.isAuthorized {
                    speechRecognizer.startRecording()
                } else {
                    speechRecognizer.requestAuthorization()
                }
            }
        } label: {
            HStack(spacing: 8) {
                Image(systemName: speechRecognizer.isRecording ? "stop.circle.fill" : "mic.fill")
                    .font(.title3)
                Text(speechRecognizer.isRecording ? "Stop Recording" : "Voice Input")
                    .font(.subheadline.bold())
            }
            .foregroundStyle(.white)
            .padding(.horizontal, 16)
            .padding(.vertical, 10)
            .background(speechRecognizer.isRecording ? Color.red : Color.indigo, in: Capsule())
        }
    }
}

// MARK: - Voice-Aware Response Editor (replaces ResponseEditorView)

struct VoiceResponseEditorView: View {
    let placeholder: String
    @Binding var text: String
    @StateObject private var speechRecognizer = SpeechRecognizer()

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text("Your Response")
                    .font(.headline)
                Spacer()
                VoiceInputButton(speechRecognizer: speechRecognizer, text: $text)
            }

            // Live transcript preview while recording
            if speechRecognizer.isRecording {
                HStack(spacing: 8) {
                    Circle()
                        .fill(.red)
                        .frame(width: 10, height: 10)
                    Text("Listening...")
                        .font(.caption)
                        .foregroundStyle(.red)
                }
                .padding(.vertical, 4)

                if !speechRecognizer.transcript.isEmpty {
                    Text(speechRecognizer.transcript)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .italic()
                        .padding(10)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color.red.opacity(0.06), in: RoundedRectangle(cornerRadius: 8))
                }
            }

            // Error message
            if let error = speechRecognizer.errorMessage {
                Label(error, systemImage: "exclamationmark.triangle.fill")
                    .font(.caption)
                    .foregroundStyle(.red)
            }

            // Text editor
            ZStack(alignment: .topLeading) {
                if text.isEmpty {
                    Text(placeholder)
                        .foregroundStyle(.tertiary)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 12)
                }
                TextEditor(text: $text)
                    .frame(minHeight: 200)
                    .scrollContentBackground(.hidden)
            }
            .padding(4)
            .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))

            HStack {
                Text("\(text.split(separator: " ").count) words")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                Spacer()
                if !text.isEmpty {
                    Button("Clear") { text = "" }
                        .font(.caption)
                }
            }
        }
        .onAppear {
            speechRecognizer.requestAuthorization()
        }
    }
}
