import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/counter_cubit.dart';

class CounterScreenWithCubit extends StatelessWidget {
  const CounterScreenWithCubit({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Counter Screen With Cubit"),
      ),
      body: Center(
        child: Text(context.watch<CounterCubit>().state.toString()),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<CounterCubit>().increase();
        },
      ),
    );
  }
}
