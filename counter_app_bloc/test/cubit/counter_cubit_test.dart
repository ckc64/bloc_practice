import 'dart:developer';

import 'package:bloc_test/bloc_test.dart';
import 'package:counter_app_bloc/cubit/counter_cubit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CounterCubit', () {
    CounterCubit? counterCubit;

    setUp(() {
      counterCubit = CounterCubit();
    });

    tearDown(() {
      counterCubit?.close();
    });

    test("initial state: must be CounterState(counterValue: 0)", () {
      expect(counterCubit?.state, CounterState(counterValue: 0));
    });
    blocTest<CounterCubit, CounterState>('Increment Test',
        build: () => CounterCubit(),
        act: (cubit) => cubit.increment(),
        expect: () => [CounterState(counterValue: 1, wasIncremented: true)]);

    blocTest<CounterCubit, CounterState>('Decrement Test',
        build: () => CounterCubit(),
        act: (cubit) => cubit.decrement(),
        expect: () => [CounterState(counterValue: -1, wasIncremented: false)]);
  });
}
