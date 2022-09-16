part of 'default_stt_bloc.dart';

enum DefaultSttStatus { loading, off, listening, notListening, done, error }

class DefaultSttState extends Equatable {
  const DefaultSttState({
    this.status = DefaultSttStatus.off,
    this.speechToText,
    this.isAvailable = false,
    this.lastHeard = "",
    this.pauseTime = 1.5, //3 secs max //listenfore 30 secs max need to add
    this.isSubtitleOn = false,
    this.recognizedWords = 'Speech Log',
  });

  final SpeechToText? speechToText;
  final DefaultSttStatus status;
  final bool isAvailable;
  final String lastHeard;
  final double pauseTime;

  final bool isSubtitleOn;

  final String recognizedWords;

  DefaultSttState copyWith({
    DefaultSttStatus? status,
    SpeechToText? speechToText,
    bool? isAvailable,
    String? lastHeard,
    double? pauseTime,
    bool? isSubtitleOn,
    String? recognizedWords,
  }) =>
      DefaultSttState(
        status: status ?? this.status,
        speechToText: speechToText ?? this.speechToText,
        isAvailable: isAvailable ?? this.isAvailable,
        lastHeard: lastHeard ?? this.lastHeard,
        pauseTime: pauseTime ?? this.pauseTime,
        isSubtitleOn: isSubtitleOn ?? this.isSubtitleOn,
        recognizedWords: recognizedWords ?? this.recognizedWords,
      );

  @override
  List<Object?> get props => [
        status,
        speechToText,
        isAvailable,
        lastHeard,
        pauseTime,
        isSubtitleOn,
        recognizedWords
      ];
}
