part of 'home_cubit.dart';

enum HomeStatus { initial, disabled, loading, success, failure }

enum Selected { defaultStt, defaultTts, polly }

class HomeState extends Equatable {
  const HomeState({
    this.status = HomeStatus.initial,
    this.showSubtitleOnly = false,
  });

  final HomeStatus status;

  final bool showSubtitleOnly;

  HomeState copyWith({
    HomeStatus? status,
    Selected? selected,
    bool? showSubtitleOnly,
  }) =>
      HomeState(
        status: status ?? this.status,
        showSubtitleOnly: showSubtitleOnly ?? this.showSubtitleOnly,
      );

  @override
  // TODO: implement props
  List<Object?> get props => [status, showSubtitleOnly];
}
