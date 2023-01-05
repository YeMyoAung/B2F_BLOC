import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterBloc extends Bloc<Function(dynamic, int), int> {
  CounterBloc(super.initialState) {
    on<Function(dynamic, int)>((event, emit) {
      // if (event) {
      //   emit(state + 1);
      // } else {
      //   emit(state - 1);
      // }

      event(emit, state);
    });
  }
}

class CounterBlocEvent {
  final String event;
  final int by;
  CounterBlocEvent({
    required this.event,
    required this.by,
  });
}

class CounterBlocComplexEvent {
  final int by;
  CounterBlocComplexEvent({
    required this.by,
  });
}

class AddCounterEvent extends CounterBlocComplexEvent {
  AddCounterEvent({required super.by});
}

class MinusCounterEvent extends CounterBlocComplexEvent {
  MinusCounterEvent({required super.by});
}

class CounterState {
  final int count;
  CounterState(this.count);
}

class DefaultCounterState extends CounterState {
  DefaultCounterState(super.count);
}

class AddCounterState extends CounterState {
  AddCounterState(super.count);
}

class MinusCounterState extends CounterState {
  MinusCounterState(super.count);
}

///Cubit => event မရှိဘူး
///Bloc  => <event>
///
///Event => action (bool,String)
///
///state => ui change
///
class CounterBlocWithMultiEvent
    extends Bloc<CounterBlocComplexEvent, CounterState> {
  CounterBlocWithMultiEvent(super.initialState) {
    on<AddCounterEvent>(
      (event, emit) async {
        await Future.delayed(const Duration(seconds: 2));
        emit(AddCounterState(state.count + event.by));
      },
      transformer: concurrent(),
    );
    on<MinusCounterEvent>(
      (event, emit) {
        emit(MinusCounterState(state.count - event.by));
      },
      transformer: restartable(),
    );

    // on<CounterBlocComplexEvent>((event, emit) {
    //   // print(event);
    //   if (event is AddCounterEvent) {
    //     addError("Hello World");
    //     // emit(state + event.by);
    //     return;
    //   }
    //   if (event is MinusCounterEvent) {
    //     emit(state - event.by);
    //     return;
    //   }

    //   // switch (event.event) {
    //   //   case 'add':
    //   //     emit(state + event.by);
    //   //     break;
    //   //   case 'minus':
    //   //     emit(state - event.by);
    //   //     break;
    //   //   default:
    //   // }
    // });
  }
}
