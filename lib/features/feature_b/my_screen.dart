import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_example/features/feature_a/bloc/random_int_loader_bloc.dart';
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
            child: ListView.builder(
              itemCount: 6,
              itemBuilder: (context, index) {
                return BlocProvider(
                  create: (context) => RandomIntLoaderBloc()..add(Load()),
                  child: Center(
                    child:
                        BlocBuilder<RandomIntLoaderBloc, RandomIntLoaderState>(
                      builder: (context, state) {
                        if (state is LoadingState) {
                          return const CircularProgressIndicator();
                        } else if (state is SuccessState) {
                          return Text(state.item.toString());
                        }
                        return const SizedBox();
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
