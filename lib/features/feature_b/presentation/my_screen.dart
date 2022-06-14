import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_example/features/feature_a/bloc/random_int_loader_bloc.dart';
import 'package:flutter_bloc_example/features/feature_b/bloc/random_int_list_loader_bloc.dart';
import 'package:flutter_bloc_example/features/feature_c/toggle_cubit.dart';
import 'package:flutter_bloc_example/features/feature_d/another_screen.dart';

class MyScreen extends StatelessWidget {
  const MyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ElevatedButton(
            onPressed: BlocProvider.of<ToggleCubit>(context).toggle,
            child: const Text('toggle'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).push(AnotherScreenRoute()),
            child: const Text('navigate to another screen'),
          ),
          Expanded(
            child:
                BlocBuilder<RandomIntListLoaderBloc, RandomIntListLoaderState>(
              builder: (context, state) {
                if (state is RandomIntListLoaderInitial) {
                  return ListView.builder(
                    itemCount: state.items.length,
                    itemBuilder: (context, index) {
                      return Center(
                        child: Builder(
                          builder: (context) {
                            final itemState = state.items[index];
                            if (itemState is LoadingState) {
                              return const CircularProgressIndicator();
                            } else if (itemState is SuccessState) {
                              return Text(itemState.item.toString());
                            }
                            return const SizedBox();
                          },
                        ),
                      );
                    },
                  );
                }
                throw Exception('Unknown state type ${state.runtimeType}');
              },
            ),
          ),
        ],
      ),
    );
  }
}
