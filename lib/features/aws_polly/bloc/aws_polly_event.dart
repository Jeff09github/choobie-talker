part of 'aws_polly_bloc.dart';

abstract class AwsPollyEvent extends Equatable {
  const AwsPollyEvent();

  @override
  List<Object> get props => [];
}

class AwsPollyInitial extends AwsPollyEvent {
  const AwsPollyInitial();
}

class AwsPollyChangedSelectedVoice extends AwsPollyEvent {
  const AwsPollyChangedSelectedVoice({required this.voice});
  final Voice voice;

  @override
  List<Object> get props => [voice];
}

class AwsPollyChangedFilter extends AwsPollyEvent {
  const AwsPollyChangedFilter({required this.filter});

  final Filter filter;
  @override
  List<Object> get props => [filter];
}

class AwsPollyChangedAudioFrequency extends AwsPollyEvent {
  const AwsPollyChangedAudioFrequency({required this.audioFrequency});
  final String audioFrequency;

  @override
  List<Object> get props => [audioFrequency];
}

class AwsPollyChangedPitch extends AwsPollyEvent {
  const AwsPollyChangedPitch(this.pitch);
  final int pitch;
  @override
  List<Object> get props => [pitch];
}

class AwsPollySynthesizeSpeech extends AwsPollyEvent {
  const AwsPollySynthesizeSpeech({required this.text});
  final String text;

  @override
  List<Object> get props => [text];
}

class AwsPollySpeech extends AwsPollyEvent {
  const AwsPollySpeech({required this.uint8list});
  final Uint8List uint8list;

  @override
  List<Object> get props => [uint8list];
}

class AwsPollyChangedTranslation extends AwsPollyEvent {
  const AwsPollyChangedTranslation({required this.languageCode});
  final String languageCode;

  @override
  List<Object> get props => [languageCode];
}

class AwsPollyToggleTranstionOn extends AwsPollyEvent {
  const AwsPollyToggleTranstionOn();
}

class AwsPollyAddTextLog extends AwsPollyEvent {
  const AwsPollyAddTextLog({required this.textLog});
  final TextLog textLog;

  @override
  List<Object> get props => [textLog];
}

class AwsPollyChangedVoiceVolume extends AwsPollyEvent {
  const AwsPollyChangedVoiceVolume(this.voiceVolume);
  final int voiceVolume;
  @override
  List<Object> get props => [voiceVolume];
}

class AwsPollyChangedSpeechRate extends AwsPollyEvent {
  const AwsPollyChangedSpeechRate(this.speechRate);
  final int speechRate;
  @override
  List<Object> get props => [speechRate];
}

class AwsPollyChangedTimbre extends AwsPollyEvent {
  const AwsPollyChangedTimbre(this.timbre);
  final int timbre;
  @override
  List<Object> get props => [timbre];
}
