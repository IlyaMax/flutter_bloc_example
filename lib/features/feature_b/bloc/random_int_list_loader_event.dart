part of 'random_int_list_loader_bloc.dart';

@immutable
abstract class RandomIntListLoaderEvent {}

class LoadAll extends RandomIntListLoaderEvent {}

class LoadItem extends RandomIntListLoaderEvent {
  final int index;

  LoadItem(this.index);
}

class ItemStateChanged extends RandomIntListLoaderEvent {
  final int index;
  final RandomIntLoaderState itemState;

  ItemStateChanged(this.index, this.itemState);
}
