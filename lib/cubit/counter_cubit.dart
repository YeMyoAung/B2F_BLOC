import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

///Cubit(state) => ValueNotifier (value)
///Bloc,Cubit => Stream (yield,emit)
class CounterCubit extends Cubit<int> {
  ///
  CounterCubit(super.initialState);

  void increase() {
    emit(Random.secure().nextInt(10));

    ///emit အပြောင်း
  }

  void reset(BuildContext context) {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text("hello World"),
          );
        });
  }
}
