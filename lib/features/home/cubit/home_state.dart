part of 'home_cubit.dart';

enum HomeStatus { initial, disabled, loading, success, failure }

enum Selected { defaultStt, defaultTts, polly }

class HomeState extends Equatable {
  const HomeState({
    this.status = HomeStatus.initial,
    this.selected = Selected.defaultStt,
  });

  final HomeStatus status;
  final Selected selected;


  HomeState copyWith({
    HomeStatus? status,
    Selected? selected,
    bool? subtitleOnly,
  }) =>
      HomeState(
        status: status ?? this.status,
        selected: selected ?? this.selected,
      );

  @override
  // TODO: implement props
  List<Object?> get props => [status, selected];
}
