import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'aws_polly_event.dart';
part 'aws_polly_state.dart';

class AwsPollyBloc extends Bloc<AwsPollyEvent, AwsPollyState> {
  AwsPollyBloc() : super(AwsPollyInitial()) {
    on<AwsPollyEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
