part of 'default_tts_bloc.dart';

abstract class DefaultTtsEvent extends Equatable {
  const DefaultTtsEvent();

  @override
  List<Object?> get props => [];
}

class DefaultTtsInitialize extends DefaultTtsEvent {
  const DefaultTtsInitialize();
}

class PlayButtonTap extends DefaultTtsEvent {
  const PlayButtonTap({this.voiceText});

  final String? voiceText;

  @override
  List<Object?> get props => [voiceText];
}

class StopButtonTap extends DefaultTtsEvent {
  const StopButtonTap();
}

class ChangedLanguage extends DefaultTtsEvent {
  const ChangedLanguage({required this.language});
  final String language;

  @override
  List<Object> get props => [language];
}

class ChangedVolume extends DefaultTtsEvent {
  const ChangedVolume({required this.value});
  final double value;

  @override
  List<Object> get props => [value];
}

class ChangedPitch extends DefaultTtsEvent {
  const ChangedPitch({required this.value});
  final double value;

  @override
  List<Object> get props => [value];
}

class ChangedRate extends DefaultTtsEvent {
  const ChangedRate({required this.value});
  final double value;

  @override
  List<Object> get props => [value];
}

class ChangedVoiceText extends DefaultTtsEvent {
  const ChangedVoiceText({required this.value});
  final String value;

  @override
  List<Object> get props => [value];
}
