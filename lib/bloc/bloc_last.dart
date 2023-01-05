import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PredictEvent {}

class BeatEvent extends PredictEvent {
  final String predict;
  BeatEvent(this.predict);
}

class ShowPreviousEvent extends PredictEvent {}

class PredictState {
  final Map<int, int> values;
  final bool isLoading;
  final Color color;
  final String message;
  PredictState({
    required this.values,
    required this.isLoading,
    required this.color,
    required this.message,
  });

  @override
  String toString() {
    return "loading:$isLoading,color:$color,message:$message";
  }
}

class DefaultState extends PredictState {
  DefaultState(
      {required super.values,
      required super.isLoading,
      required super.color,
      required super.message});
}

class PredictingState extends PredictState {
  PredictingState(
      {required super.values,
      required super.isLoading,
      required super.color,
      required super.message});
}

class BadState extends PredictState {
  BadState(
      {required super.values,
      required super.isLoading,
      required super.color,
      required super.message});
}

class NotBadState extends PredictState {
  NotBadState(
      {required super.values,
      required super.isLoading,
      required super.color,
      required super.message});
}

class GoodState extends PredictState {
  GoodState(
      {required super.values,
      required super.isLoading,
      required super.color,
      required super.message});
}

class PredictBloc extends Bloc<PredictEvent, PredictState> {
  PredictBloc(super.initialState) {
    on<BeatEvent>((event, emit) async {
      try {
        final copy = {
          0: 0,
          1: 0,
          2: 0,
          3: 0,
          4: 0,
          5: 0,
        };
        emit(PredictingState(
          isLoading: true,
          color: Colors.grey,
          message: "Loading",
          values: state.values,
        ));
        // final int predict = int.parse(event.predict);
        // copy.add(predict);
        int count = 0;
        for (var i = 0; i < 100; i++) {
          // await Future.delayed(const Duration(milliseconds: 10));
          final predict = Random.secure().nextInt(5);
          copy[predict] = copy[predict]! + 1;
          if (predict == int.parse(event.predict)) {
            count++;
          }
        }
        print(count);
        // throw "here";
        if (count < 20) {
          emit(BadState(
            isLoading: false,
            color: Colors.red,
            message: "Hmm",
            values: copy,
          ));
          return;
        }
        if (count > 20 && count <= 40) {
          emit(NotBadState(
            isLoading: false,
            color: Colors.amber,
            message: "Not Bad",
            values: copy,
          ));
          return;
        }

        emit(GoodState(
          isLoading: false,
          color: Colors.green,
          message: "Wow",
          values: copy,
        ));
      } catch (e) {
        ///observerတွေရဲ့ onErrorမှာပေါ်စေချင်ရင် AddErrorနဲ့errorကိုထည့်ပေးရမယ်
        // addError(e);
        emit(PredictState(
          isLoading: false,
          color: Colors.red,
          message: "$e",
          values: state.values,
        ));
        print('error is ${event.predict}');
      }
    });
    on<ShowPreviousEvent>((event, emit) {
      print("hello show previous");
    });
  }
}
