import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sealed_class_tut/ui_state.dart';

class HomePageCubit extends Cubit<UIState> {
  HomePageCubit() : super(const InitialState());

  Future<void> randomDivision() async {
    try {
      final num1 = Random().nextInt(10);
      final num2 = Random().nextInt(3);
      final randomNumbers = RandomNumbers(num1: num1, num2: num2);
      emit(SuccessState<RandomNumbers>(randomNumbers));
      await Future.delayed(const Duration(milliseconds: 50));
      emit(const LoadingState());
      await Future.delayed(const Duration(seconds: 2));
      if (num2 == 0) throw UnsupportedError('Division By Zero');
      final result = num1 / num2;
      emit(SuccessState<double>(result));
    } catch (e) {
      emit(ErrorState(e.toString()));
    }
  }
}

class RandomNumbers {
  final int num1;
  final int num2;

  const RandomNumbers({required this.num1, required this.num2});
}