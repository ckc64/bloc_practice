// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_calculator_cubit/cubit/simple_calculator_cubit.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController firstNumController = TextEditingController();
    TextEditingController secondNumController = TextEditingController();
    final calcCubit = context.read<SimpleCalculatorCubit>();

    return BlocBuilder<SimpleCalculatorCubit, SimpleCalculatorState>(
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
              child: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextField(
                  controller: firstNumController,
                  decoration: InputDecoration(
                    hintText: "Enter First Number",
                  ),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: secondNumController,
                  decoration: InputDecoration(
                    hintText: "Enter Second Number",
                  ),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    OperationButton(operation: "+"),
                    OperationButton(operation: "-"),
                    OperationButton(operation: "/"),
                    OperationButton(operation: "x")
                  ],
                ),
                ElevatedButton(
                  onPressed: () {
                    if (calcCubit.operandState == null) {
                      print("Provide an Operand. Tap Any.");
                    } else {
                      calcCubit.executeOperation(
                          firstNumController.text, secondNumController.text);
                    }
                  },
                  child: Text(
                    "Result",
                    style: TextStyle(color: Colors.black),
                  ),
                  style: ElevatedButton.styleFrom(primary: Colors.yellow),
                ),
                Text(
                  "Result : ${calcCubit.stringToDouble(firstNumController.text)} ${calcCubit.operandSymbol} ${calcCubit.stringToDouble(secondNumController.text)} = ${state.result}",
                  style: TextStyle(color: Colors.black, fontSize: 24),
                ),
              ],
            ),
          )),
        );
      },
    );
  }
}

class OperationButton extends StatelessWidget {
  const OperationButton({
    Key? key,
    required this.operation,
  }) : super(key: key);
  final String operation;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SimpleCalculatorCubit, SimpleCalculatorState>(
      builder: (context, state) {
        return ElevatedButton(
          onPressed: () {
            print(context.read<SimpleCalculatorCubit>.call().operandState);
            context.read<SimpleCalculatorCubit>.call().setOperand(operation);
          },
          child: Text(
            operation,
            style: TextStyle(color: Colors.black),
          ),
          style: ElevatedButton.styleFrom(primary: Colors.yellow),
        );
      },
    );
  }
}
