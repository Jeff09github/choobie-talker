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

class AwsPollyChangedSampleRate extends AwsPollyEvent {
  const AwsPollyChangedSampleRate({required this.sampleRate});
  final String sampleRate;

  @override
  List<Object> get props => [sampleRate];
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
