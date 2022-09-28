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

class ToggleLinkTts extends DefaultSttEvent {
  const ToggleLinkTts();
}

class AddTextLog extends DefaultSttEvent {
  const AddTextLog({required this.textLog});
  final TextLog textLog;

  @override
  List<Object> get props => [textLog];
}
