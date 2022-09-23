part of 'default_stt_bloc.dart';

enum DefaultSttStatus { loading, off, listening, notListening, done, error }

class DefaultSttState extends Equatable {
  const DefaultSttState({
    this.status = DefaultSttStatus.off,
    this.speechToText,
    this.localNames = const [],
    this.isAvailable = false,
    this.lastHeard = "",
    this.pauseTime = 1.5, //3 secs max //listenfore 30 secs max need to add
    this.recognizedWords = 'Speech Log',
    this.linkTts = false,
  });

  final SpeechToText? speechToText;
  final List<LocaleName> localNames;
  final bool isAvailable;

  final DefaultSttStatus status;

  final String lastHeard;
  final double pauseTime;
  final String recognizedWords;
  final bool linkTts;

  DefaultSttState copyWith({
    DefaultSttStatus? status,
    SpeechToText? speechToText,
    List<LocaleName>? localNames,
    bool? isAvailable,
    String? lastHeard,
    double? pauseTime,
    String? recognizedWords,
    bool? linkTts,
  }) =>
      DefaultSttState(
        status: status ?? this.status,
        speechToText: speechToText ?? this.speechToText,
        localNames: localNames ?? this.localNames,
        isAvailable: isAvailable ?? this.isAvailable,
        lastHeard: lastHeard ?? this.lastHeard,
        pauseTime: pauseTime ?? this.pauseTime,
        recognizedWords: recognizedWords ?? this.recognizedWords,
        linkTts: linkTts ?? this.linkTts,
      );

  @override
  List<Object?> get props => [
        status,
        speechToText,
        localNames,
        isAvailable,
        lastHeard,
        pauseTime,
        recognizedWords,
        linkTts,
      ];
}
