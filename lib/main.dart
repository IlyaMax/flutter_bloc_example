import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_example/features/feature_b/bloc/random_int_list_loader_bloc.dart';
import 'package:flutter_bloc_example/features/feature_b/presentation/my_screen.dart';
import 'package:flutter_bloc_example/features/feature_c/toggle_cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => ToggleCubit(),
          ),
          BlocProvider(
            create: (context) => RandomIntListLoaderBloc()..add(LoadAll()),
          ),
        ],
        child: const MyScreen(),
      ),
    );
  }
}
