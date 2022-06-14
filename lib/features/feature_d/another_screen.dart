import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_example/features/feature_a/bloc/random_int_loader_bloc.dart';

class AnotherScreenRoute extends MaterialPageRoute<void> {
  AnotherScreenRoute()
      : super(builder: (context) {
          return BlocProvider(
            create: (context) => RandomIntLoaderBloc(),
            child: const AnotherScreen(),
          );
        });
}

/// Reuses [ItemLoaderBloc] but with different ui and without list
class AnotherScreen extends StatelessWidget {
  const AnotherScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () =>
                BlocProvider.of<RandomIntLoaderBloc>(context).add(Load()),
            child: const Text('load'),
          ),
          Center(
            child: BlocBuilder<RandomIntLoaderBloc, RandomIntLoaderState>(
              builder: (context, state) {
                if (state is LoadingState) {
                  return const CircularProgressIndicator();
                } else if (state is SuccessState) {
                  return Text(
                    state.item.toString(),
                    style: const TextStyle(color: Colors.white),
                  );
                }
                return const SizedBox();
              },
            ),
          ),
        ],
      ),
    );
  }
}
