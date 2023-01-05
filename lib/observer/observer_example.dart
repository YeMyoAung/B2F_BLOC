import 'package:bloc_example/cubit/cubit_last.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ObserverExample extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    print("${bloc.runtimeType} is Create");
    super.onCreate(bloc);
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    print("${bloc.runtimeType} receive a event $event");

    super.onEvent(bloc, event);
  }

  @override
  void onClose(BlocBase bloc) {
    print("${bloc.runtimeType} is Close");
    super.onClose(bloc);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    print("${bloc.runtimeType} get an error $error $stackTrace");
    if (bloc is CubitLast) {
      bloc.checker('-1');
    }
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    print("${bloc.runtimeType} - ${DateTime.now()}");
    super.onChange(bloc, change);
  }
}

class fjslfjal extends BlocObserver {}
