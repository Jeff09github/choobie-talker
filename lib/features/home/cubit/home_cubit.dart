import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(const HomeState());

  void changeStatus({required HomeStatus status}) {
    emit(state.copyWith(status: status));
  }

  void toggleShowSubtitleOnly() {
    emit(state.copyWith(
        showSubtitleOnly: !state.showSubtitleOnly, status: HomeStatus.success));
  }
}
