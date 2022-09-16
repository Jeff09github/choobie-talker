part of 'subtitle_bloc.dart';

enum SubtitleStatus { initial, loading, success, failure }

class SubtitleState extends Equatable {
  const SubtitleState({
    this.color = Colors.white,
    this.fontWeight = FontWeight.bold,
    this.fontSize = 24.0,
    this.containerHeight = 150.0,
    this.text = 'Final Output Text from Speech',
    this.status = SubtitleStatus.initial,
  });

  final SubtitleStatus status;
  final Color color;
  final FontWeight fontWeight;
  final double fontSize;
  final double containerHeight;
  final String text;

  SubtitleState copyWith({
    SubtitleStatus? status,
    Color? color,
    FontWeight? fontWeight,
    double? fontSize,
    double? containerHeight,
    String? text,
  }) =>
      SubtitleState(
        status: status ?? this.status,
        color: color ?? this.color,
        fontWeight: fontWeight ?? this.fontWeight,
        fontSize: fontSize ?? this.fontSize,
        containerHeight: containerHeight ?? this.containerHeight,
        text: text ?? this.text,
      );

  @override
  List<Object> get props => [
        status,
        color,
        fontWeight,
        fontSize,
        containerHeight,
        text,
      ];
}
