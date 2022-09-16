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

class ChangedFontSize extends SubtitleEvent {
  const ChangedFontSize({required this.size});
  final double size;
   @override
  List<Object> get props => [size];
}
