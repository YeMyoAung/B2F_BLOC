import 'package:bloc_example/bloc/counter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterBlocExample extends StatelessWidget {
  const CounterBlocExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Counter Bloc Example"),
        centerTitle: true,
      ),
      body: Center(
        child: BlocConsumer<CounterBloc, int>(
          builder: (_, state) {
            return Text(
              state.toString(),
              style: const TextStyle(
                fontSize: 40,
              ),
            );
          },
          buildWhen: (previous, current) {
            print(previous);
            print(current);
            return true;
          },
          listenWhen: (previous, current) {
            print(previous);
            print(current);
            return true;
          },
          listener: (context, state) {},
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<CounterBloc>().add((emit, state) {
            emit(state + 1);
          });

          // if (Random.secure().nextInt(2) == 1) {
          //   context
          //       .read<CounterBlocWithMultiEvent>()
          //       .add(AddCounterEvent(by: 2));
          // } else {
          //   context
          //       .read<CounterBlocWithMultiEvent>()
          //       .add(MinusCounterEvent(by: 2));
          // }
          // context
          //     .read<CounterBlocWithMultiEvent>()
          //     .add(MinusCounterEvent(by: 2));
        },
      ),
    );
  }
}
