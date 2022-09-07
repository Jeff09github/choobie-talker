part of 'default_tts_bloc.dart';

enum DefaultTtsStatus { initial, playing, stopped, paused, continued, error }

class DefaultTtsState extends Equatable {
  const DefaultTtsState({
    this.fluterTts,
    this.language,
    this.engine,
    this.volume = 1.0,
    this.pitch = 1.0,
    this.rate = 0.7,
    this.isCurrentLanguagedInstalled = false,
    this.languages = const [],
    this.voices = const [],
    this.engines = const [],
    this.status = DefaultTtsStatus.initial,
    this.voiceText,
    this.inputLength,
  });

  final DefaultTtsStatus status;
  final FlutterTts? fluterTts;
  final String? language;
  final String? engine;
  final double volume;
  final double pitch;
  final double rate;
  final bool isCurrentLanguagedInstalled;
  final dynamic languages;
  final dynamic voices;
  final List<String> engines;

  final String? voiceText;
  final int? inputLength;

  DefaultTtsState copyWith({
    DefaultTtsStatus? status,
    FlutterTts? fluterTts,
    String? language,
    String? engine,
    double? volume,
    double? pitch,
    double? rate,
    bool? isCurrentLanguagedInstalled,
    dynamic languages,
    dynamic voices,
    List<String>? engines,
    String? voiceText,
    int? inputLength,
  }) =>
      DefaultTtsState(
        status: status ?? this.status,
        fluterTts: fluterTts ?? this.fluterTts,
        language: language ?? this.language,
        engine: engine ?? this.engine,
        volume: volume ?? this.volume,
        pitch: pitch ?? this.pitch,
        rate: rate ?? this.rate,
        isCurrentLanguagedInstalled:
            isCurrentLanguagedInstalled ?? this.isCurrentLanguagedInstalled,
        languages: languages ?? this.languages,
        voices: voices ?? this.voices,
        engines: engines ?? this.engines,
        voiceText: voiceText ?? this.voiceText,
        inputLength: inputLength ?? this.inputLength,
      );

  @override
  List<Object?> get props => [
        status,
        fluterTts,
        language,
        engine,
        volume,
        pitch,
        rate,
        isCurrentLanguagedInstalled,
        languages,
        voices,
        engines,
        voiceText,
        inputLength,
      ];
}
