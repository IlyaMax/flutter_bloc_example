import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc_example/features/feature_a/bloc/random_int_loader_bloc.dart';
import 'package:meta/meta.dart';

part 'random_int_list_loader_event.dart';
part 'random_int_list_loader_state.dart';

class RandomIntListLoaderBloc
    extends Bloc<RandomIntListLoaderEvent, RandomIntListLoaderState> {
  late List<RandomIntLoaderBloc> _blocs;
  final List<StreamSubscription<RandomIntLoaderState>> _blocSubscriptions = [];

  /// could be changed dynamically too
  static const _itemsCount = 5;
  RandomIntListLoaderBloc() : super(RandomIntListLoaderInitial(const [])) {
    on<LoadAll>((event, emit) {
      _blocs = List.generate(_itemsCount, (index) {
        final bloc = RandomIntLoaderBloc();
        _blocSubscriptions.add(bloc.stream.listen((itemState) {
          add(ItemStateChanged(index, itemState));
        }));
        bloc.add(Load());
        return bloc;
      });
      /// set initial state which is specified in RandomIntLoaderBloc
      emit(RandomIntListLoaderInitial(_blocs.map((b) => b.state).toList()));
    });
    on<LoadItem>((event, emit) {
      _blocs[event.index].add(Load());
    });
    on<ItemStateChanged>((event, emit) {
      final oldState = state;
      if (oldState is RandomIntListLoaderInitial) {
        final oldStateItems = oldState.items;
        final newStateItems = List.of(oldStateItems);
        newStateItems[event.index] = event.itemState;
        emit(RandomIntListLoaderInitial(newStateItems));
      }
    });
  }
  @override
  Future<void> close() {
    for (var sub in _blocSubscriptions) {
      sub.cancel();
    }
    return super.close();
  }
}
