part of 'subtitle_bloc.dart';

abstract class SubtitleEvent extends Equatable {
  const SubtitleEvent();

  @override
  List<Object> get props => [];
}

class ChangedContainerHeight extends SubtitleEvent {
  const ChangedContainerHeight({required this.height});
  final double height;
  @override
  List<Object> get props => [height];
}

class ChangedSubtitleText extends SubtitleEvent {
  const ChangedSubtitleText({required this.text});
  final String text;

  @override
  List<Object> get props => [text];
}

class ChangedFontSize extends SubtitleEvent {
  const ChangedFontSize({required this.size});
  final double size;
  @override
  List<Object> get props => [size];
}

class ChangedFontColor extends SubtitleEvent {
  const ChangedFontColor({required this.fontColor});
  final Color fontColor;
  @override
  List<Object> get props => [fontColor];
}

class ChangedFontFamily extends SubtitleEvent {
  const ChangedFontFamily({required this.fontFamily});
  final String fontFamily;

  @override
  List<Object> get props => [fontFamily];
}

class ChangedFontWeight extends SubtitleEvent {
  const ChangedFontWeight({required this.fontWeight});
  final FontWeight fontWeight;
  @override
  List<Object> get props => [fontWeight];
}

class ChangedStrokeColor extends SubtitleEvent {
  const ChangedStrokeColor({required this.strokeColor});
  final Color strokeColor;
  @override
  List<Object> get props => [strokeColor];
}

class ChangedStrokeWidth extends SubtitleEvent {
  const ChangedStrokeWidth({required this.strokeWidth});
  final double strokeWidth;

  @override
  List<Object> get props => [strokeWidth];
}

class ChangedBackgroundColor extends SubtitleEvent {
  const ChangedBackgroundColor({required this.backgroundColor});
  final Color backgroundColor;
  @override
  List<Object> get props => [backgroundColor];
}

class ChangedTranslateTo extends SubtitleEvent {
  const ChangedTranslateTo({required this.code});
  final String code;
  @override
  List<Object> get props => [code];
}

class ToggleTranstionOn extends SubtitleEvent {
  const ToggleTranstionOn();
}
