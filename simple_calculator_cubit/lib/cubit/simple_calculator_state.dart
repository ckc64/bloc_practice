part of 'simple_calculator_cubit.dart';

enum OPERATION { ADD, MULTIPLY, SUBRACTION, DIVISION }

abstract class SimpleCalculatorState extends Equatable {
  final double result;

  const SimpleCalculatorState(this.result);

  @override
  List<Object> get props => [result];
}

class SimpleCalculatorInitial extends SimpleCalculatorState {
  const SimpleCalculatorInitial() : super(0.0);
}

class Addition extends SimpleCalculatorState {
  final double res;

  const Addition(this.res) : super(res);
}

class Subtraction extends SimpleCalculatorState {
  final double res;

  const Subtraction(this.res) : super(res);
}

class Division extends SimpleCalculatorState {
  final double res;

  const Division(this.res) : super(res);
}

class Multiplication extends SimpleCalculatorState {
  final double res;

  const Multiplication(this.res) : super(res);
}
