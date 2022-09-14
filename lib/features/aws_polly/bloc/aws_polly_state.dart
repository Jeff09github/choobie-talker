part of 'aws_polly_bloc.dart';

enum AwsPollyStatus { initial, loading, success, failure }

class Filter {
  Filter({this.gender});
  final Gender? gender;

  Filter copyWith({Gender? gender}) => Filter(gender: gender ?? this.gender);
}

class AwsPollyState extends Equatable {
  const AwsPollyState({
    this.status = AwsPollyStatus.initial,
    this.voices = const [],
    this.filteredVoices = const [],
    this.selectedVoice,
    this.sampleRate = "22050",
    required this.filter,
  });

  final AwsPollyStatus status;
  final List<Voice> voices;
  final List<Voice> filteredVoices;
  final Voice? selectedVoice;
  final Filter filter;
  final String sampleRate;

  AwsPollyState copyWith({
    AwsPollyStatus? status,
    List<Voice>? voices,
    List<Voice>? filteredVoices,
    Voice? selectedVoice,
    Filter? filter,
    String? sampleRate,
  }) =>
      AwsPollyState(
        status: status ?? this.status,
        voices: voices ?? this.voices,
        filteredVoices: filteredVoices ?? this.filteredVoices,
        selectedVoice: selectedVoice ?? this.selectedVoice,
        filter: filter ?? this.filter,
        sampleRate: sampleRate ?? this.sampleRate,
      );

  @override
  List<Object?> get props =>
      [status, voices, selectedVoice, filter, filteredVoices, sampleRate];
}
