part of 'subtitle_bloc.dart';

enum SubtitleStatus { initial, loading, success, failure }

class SubtitleState extends Equatable {
  const SubtitleState({
    this.fontColor = Colors.white,
    this.fontFamily = 'Roboto',
    this.fontSize = 24.0,
    this.fontWeight = FontWeight.w700,
    this.strokeColor = Colors.black,
    this.strokeWidth = 2,
    this.backgroundColor = Colors.green,
    this.containerHeight = 150.0,
    this.text = 'Final Output Text from Speech',
    this.status = SubtitleStatus.initial,
    this.translateTo = 'en',
    this.translateOn = false,
  });

  final SubtitleStatus status;
  final Color fontColor;
  final String fontFamily;
  final Color strokeColor;
  final Color backgroundColor;
  final FontWeight fontWeight;
  final double fontSize;
  final double containerHeight;
  final double strokeWidth;
  final String text;

  final String translateTo;
  final bool translateOn;

  SubtitleState copyWith({
    SubtitleStatus? status,
    Color? fontColor,
    String? fontFamily,
    Color? strokeColor,
    Color? backgroundColor,
    FontWeight? fontWeight,
    double? fontSize,
    double? containerHeight,
    double? strokeWidth,
    String? text,
    String? translateTo,
    bool? translateOn,
  }) =>
      SubtitleState(
        status: status ?? this.status,
        fontColor: fontColor ?? this.fontColor,
        fontFamily: fontFamily ?? this.fontFamily,
        strokeColor: strokeColor ?? this.strokeColor,
        backgroundColor: backgroundColor ?? this.backgroundColor,
        fontWeight: fontWeight ?? this.fontWeight,
        fontSize: fontSize ?? this.fontSize,
        containerHeight: containerHeight ?? this.containerHeight,
        strokeWidth: strokeWidth ?? this.strokeWidth,
        text: text ?? this.text,
        translateTo: translateTo ?? this.translateTo,
        translateOn: translateOn ?? this.translateOn,
      );

  @override
  List<Object> get props => [
        status,
        fontColor,
        fontFamily,
        strokeColor,
        backgroundColor,
        fontWeight,
        fontSize,
        containerHeight,
        strokeWidth,
        text,
        translateTo,
        translateOn
      ];
}
