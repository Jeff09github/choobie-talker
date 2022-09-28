part of 'default_stt_bloc.dart';

enum DefaultSttStatus { loading, off, listening, notListening, done, error }

class DefaultSttState extends Equatable {
  const DefaultSttState({
    this.status = DefaultSttStatus.off,
    this.speechToText,
    this.localNames = const [],
    this.isAvailable = false,
    this.pauseTime = 1.5, //3 secs max //listenfore 30 secs max need to add
    this.linkTts = false,
    this.textlogs = const [],
  });

  final SpeechToText? speechToText;
  final List<LocaleName> localNames;
  final bool isAvailable;

  final DefaultSttStatus status;

  final double pauseTime;
  final bool linkTts;
  final List<TextLog> textlogs;

  DefaultSttState copyWith({
    DefaultSttStatus? status,
    SpeechToText? speechToText,
    List<LocaleName>? localNames,
    bool? isAvailable,
    String? lastHeard,
    double? pauseTime,
    String? recognizedWords,
    bool? linkTts,
    List<TextLog>? textlogs,
  }) =>
      DefaultSttState(
        status: status ?? this.status,
        speechToText: speechToText ?? this.speechToText,
        localNames: localNames ?? this.localNames,
        isAvailable: isAvailable ?? this.isAvailable,
        pauseTime: pauseTime ?? this.pauseTime,
        linkTts: linkTts ?? this.linkTts,
        textlogs: textlogs ?? this.textlogs,
      );

  @override
  List<Object?> get props => [
        status,
        speechToText,
        localNames,
        isAvailable,
        pauseTime,
        linkTts,
        textlogs,
      ];
}
