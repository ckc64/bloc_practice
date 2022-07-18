import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_calculator_cubit/cubit/simple_calculator_cubit.dart';
import 'package:simple_calculator_cubit/view/index.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => SimpleCalculatorCubit(),
        child: MaterialApp(
          home: const HomeScreen(),
        ));
  }
}
