import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/counter_cubit.dart';

class CounterCubitScreenWithConsumer extends StatelessWidget {
  const CounterCubitScreenWithConsumer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Counter Cubit Screen With Consumer")),
      body: Center(
        child: BlocConsumer<CounterCubit, int>(
          builder: (ctx, value) {
            ///Error
            log("Build $value");
            return Text("$value");
          },
          buildWhen: (previous, current) {
            log("current is $current");
            log("previous is $previous");
            return false;
          },
          listener: (_, value) {
            print("Listener $value");
            if (value == 5) {
              context.read<CounterCubit>().reset(context);
            }
            // if (value == -1) {
            //   context.read<CounterCubit>().reset();
            // }
            // context.read<CounterCubit>().reset(value % 2 == 0);
          },
          listenWhen: (previous, current) {
            return true;
            // return previous != current;
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<CounterCubit>().increase();
        },
      ),
    );
  }
}
