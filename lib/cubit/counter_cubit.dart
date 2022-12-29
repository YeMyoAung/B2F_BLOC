import 'dart:math';

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

  void reset(bool value) {
    emit(value ? 1 : 0);
  }
}
