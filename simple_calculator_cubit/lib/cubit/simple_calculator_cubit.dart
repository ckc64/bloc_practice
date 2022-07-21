import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'simple_calculator_state.dart';

class SimpleCalculatorCubit extends Cubit<SimpleCalculatorState> {
  SimpleCalculatorCubit() : super(const SimpleCalculatorInitial());

  var operandState;
  var operandSymbol = ' ';
  bool isSelected = false;

  double stringToDouble(String s) {
    if (s.isEmpty) {
      s = "0.0";
    }
    double res = double.parse(s);
    return res;
  }

  dynamic setOperand(String operand) {
    print("first $isSelected");
    switch (operand) {
      case '+':
        operandState = Addition;
        operandSymbol = '+';
        isSelected = true;
        break;
      case '-':
        operandState = Subtraction;
        operandSymbol = '-';

        break;
      case 'x':
        operandState = Multiplication;
        operandSymbol = 'x';

        break;
      case '/':
        operandState = Division;
        operandSymbol = '/';

        break;
      default:
        operandSymbol = ' ';

        break;
    }
    print("second $isSelected");
  }

  void executeOperation(String num1, String num2) {
    final res;
    if (operandState == Addition) {
      res = stringToDouble(num1) + stringToDouble(num2);
      emit(Addition(res));
    } else if (operandState == Subtraction) {
      res = stringToDouble(num1) - stringToDouble(num2);
      emit(Subtraction(res));
    } else if (operandState == Multiplication) {
      res = stringToDouble(num1) * stringToDouble(num2);
      emit(Multiplication(res));
    } else if (operandState == Division) {
      res = stringToDouble(num1) / stringToDouble(num2);
      emit(Division(res));
    } else {
      emit(const SimpleCalculatorInitial());
    }
  }
}
