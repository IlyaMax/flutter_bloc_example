import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'random_int_loader_event.dart';
part 'random_int_loader_state.dart';

class RandomIntLoaderBloc
    extends Bloc<RandomIntLoaderEvent, RandomIntLoaderState> {
  final _random = Random();

  RandomIntLoaderBloc() : super(InitialState()) {
    on<Load>((event, emit) async {
      emit(LoadingState());
      await Future.delayed(const Duration(seconds: 2));
      emit(SuccessState(_random.nextInt(20)));
    });
  }
}
