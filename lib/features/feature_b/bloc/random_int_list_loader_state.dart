part of 'random_int_list_loader_bloc.dart';

@immutable
abstract class RandomIntListLoaderState {}

class RandomIntListLoaderInitial extends RandomIntListLoaderState {
  final List<RandomIntLoaderState> items;

  RandomIntListLoaderInitial(this.items);
}
