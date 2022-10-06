part of 'aws_polly_bloc.dart';

enum AwsPollyStatus { initial, loading, success, failure }

class Filter {
  Filter({this.gender});
  final Gender? gender;

  Filter copyWith({Gender? gender}) => Filter(gender: gender ?? this.gender);
}

class AwsPollyState extends Equatable {
  const AwsPollyState({
    this.status = AwsPollyStatus.success,
    this.voices = const [],
    this.filteredVoices = const [],
    this.selectedVoice,
    this.audioFrequency = "22050", //"8000", "16000", "22050", and "24000"
    this.pitch = 0,
    required this.filter,
    this.translateTo = 'en',
    this.translationOn = false,
    this.textlogs = const [],
    this.voiceVolume = 0,
    this.speechRate = 100,
    this.timbre = 0,
  }) : assert(speechRate >= 20 && speechRate <= 200);

  final AwsPollyStatus status;
  final List<Voice> voices;
  final List<Voice> filteredVoices;
  final Voice? selectedVoice;
  final int pitch;
  final Filter filter;
  final String audioFrequency;
  final String translateTo;
  final bool translationOn;
  final List<TextLog> textlogs;
  final int voiceVolume;
  final int speechRate;
  final int timbre;

  AwsPollyState copyWith({
    AwsPollyStatus? status,
    List<Voice>? voices,
    List<Voice>? filteredVoices,
    Voice? selectedVoice,
    Filter? filter,
    String? audioFrequency,
    int? pitch,
    String? translateTo,
    bool? translationOn,
    List<TextLog>? textlogs,
    int? voiceVolume,
    int? speechRate,
    int? timbre,
  }) =>
      AwsPollyState(
        status: status ?? this.status,
        voices: voices ?? this.voices,
        filteredVoices: filteredVoices ?? this.filteredVoices,
        selectedVoice: selectedVoice ?? this.selectedVoice,
        filter: filter ?? this.filter,
        audioFrequency: audioFrequency ?? this.audioFrequency,
        pitch: pitch ?? this.pitch,
        translateTo: translateTo ?? this.translateTo,
        translationOn: translationOn ?? this.translationOn,
        textlogs: textlogs ?? this.textlogs,
        voiceVolume: voiceVolume ?? this.voiceVolume,
        speechRate: speechRate ?? this.speechRate,
        timbre: timbre ?? this.timbre,
      );

  @override
  List<Object?> get props => [
        status,
        voices,
        selectedVoice,
        filter,
        filteredVoices,
        audioFrequency,
        pitch,
        translateTo,
        translationOn,
        textlogs,
        voiceVolume,
        speechRate,
        timbre,
      ];
}
