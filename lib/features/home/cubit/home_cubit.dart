import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(const HomeState());

  void changeSelected(Selected selected) {
    emit(state.copyWith(status: HomeStatus.loading));
    if (selected != state.selected) {
      emit(state.copyWith(selected: selected, status: HomeStatus.success));
    } else {
      emit(state.copyWith(
        status: HomeStatus.success,
      ));
    }
  }

  void changeStatus({required HomeStatus status}) {
    emit(state.copyWith(status: status));
  }
}
