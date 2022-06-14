part of 'random_int_loader_bloc.dart';

@immutable
abstract class RandomIntLoaderState {}

class InitialState extends RandomIntLoaderState {}

class LoadingState extends RandomIntLoaderState {}

class SuccessState extends RandomIntLoaderState {
  final int item;

  SuccessState(this.item);
}
