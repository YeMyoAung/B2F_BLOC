import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PredictState {
  final bool isLoading;
  final Color color;
  final String message;
  PredictState({
    required this.isLoading,
    required this.color,
    required this.message,
  });

  @override
  String toString() {
    return "loading:$isLoading,color:$color,message:$message";
  }
}

///Bloc => Bloc (Event)
class CubitLast extends Cubit<PredictState> {
  CubitLast(super.initialState);

  ///random number ထည့်ပေးလိုက်တဲ့ တန်ဖိုးညီလားစစ်မယ်
  ///အကြိမ်100မှာ ဘယ်နှစ်ကြိမ်ညီနိုင်မလဲဆိုတာစစ်မယ်
  ///10ကြိမ်အောက်ဆိုရင် bad review  (Color => Red, Message = Hmmm)
  ///50 နဲ့ 70ကြားဆိုရင် good review (Color => Amber, Message = Not Bad)
  ///70နဲ့ 100ကြား ဆိုရင် best review (Color => Green,Message = Wow)
  ///စစ်နေတဲ့အချိန်အတွင်းမှာဆိုရင် loadingပြပေးမယ်
  Future<void> checker(String predict) async {
    try {
      ///StatefulWidget =>  Setstate (function)
      ///Provider       =>  notifyListener (invoke)
      ///Bloc           =>  emit  (ပြောင်းလဲချင်တဲ့Stateထည့်ပေးရမယ်)
      emit(PredictState(
        isLoading: true,
        color: Colors.grey,
        message: "Let's Predict",
      ));
      int count = 0;
      for (var i = 0; i < 5; i++) {
        await Future.delayed(const Duration(seconds: 1));
        if (int.parse(predict) == Random.secure().nextInt(20)) {
          count++;
        }
      }
      // throw "here";
      if (count < 20) {
        emit(
            PredictState(isLoading: false, color: Colors.red, message: 'Hmmm'));
        return;
      }
      if (count > 20 && count <= 40) {
        emit(PredictState(
            isLoading: false, color: Colors.amber, message: 'Not Bad'));
        return;
      }

      emit(PredictState(isLoading: false, color: Colors.green, message: 'Wow'));
    } catch (e) {
      ///observerတွေရဲ့ onErrorမှာပေါ်စေချင်ရင် AddErrorနဲ့errorကိုထည့်ပေးရမယ်
      addError(e);
      emit(PredictState(isLoading: false, color: Colors.red, message: 'Hmm'));
      print('error is $e');
    }
  }

  // @override
  // void onError(Object error, StackTrace stackTrace) {
  //   print("bulid-in observer $error");
  //   super.onError(error, stackTrace);
  // }

  // @override
  // void onChange(Change<PredictState> change) {
  //   print("bulid-in observer $change");
  //   super.onChange(change);
  // }
}
