part of 'default_stt_bloc.dart';

abstract class DefaultSttEvent extends Equatable {
  const DefaultSttEvent();

  @override
  List<Object> get props => [];
}

class DefaultSttInitialize extends DefaultSttEvent {
  const DefaultSttInitialize();
  @override
  List<Object> get props => [];
}

class StartListening extends DefaultSttEvent {
  const StartListening();
  @override
  List<Object> get props => [];
}

class StopListening extends DefaultSttEvent {
  const StopListening();
  @override
  List<Object> get props => [];
}

class LastHeardChanged extends DefaultSttEvent {
  const LastHeardChanged({required this.lastHeard});
  final String lastHeard;

  @override
  List<Object> get props => [lastHeard];
}

class ChangedRecognizedWords extends DefaultSttEvent {
  const ChangedRecognizedWords({required this.words});
  final String words;
  @override
  List<Object> get props => [words];
}

class ChangedSubtitleIsOn extends DefaultSttEvent {
  const ChangedSubtitleIsOn({required this.value});
  final bool value;

  @override
  List<Object> get props => [value];
}

class ChangedPauseTime extends DefaultSttEvent {
  const ChangedPauseTime({required this.value});
  final double value;
  @override
  List<Object> get props => [value];
}
