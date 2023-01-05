import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/bloc_last.dart';

class BlocLastExample extends StatefulWidget {
  const BlocLastExample({super.key});

  @override
  State<BlocLastExample> createState() => _BlocLastExampleState();
}

class _BlocLastExampleState extends State<BlocLastExample> {
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Predict"),
      ),
      body: ListView(
        children: [
          BlocBuilder<PredictBloc, PredictState>(
            builder: (blocBuildContext, state) {
              return Container(
                width: double.infinity,
                height: 200,
                color: state.color,
                margin: const EdgeInsets.all(20),
                alignment: Alignment.center,
                child: state is PredictingState
                    ? const CircularProgressIndicator(
                        color: Colors.white,
                      )
                    : Text(
                        state.message,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              );
            },
            buildWhen: (previous, current) => true,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              controller: controller,
              decoration: const InputDecoration(
                hintText: "Number",
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: ElevatedButton(
              onPressed: () {
                context.read<PredictBloc>().add(BeatEvent(controller.text));
              },
              child: const Text("Beat"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: ElevatedButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (_) {
                      return AlertDialog(
                        content: Text(context
                            .read<PredictBloc>()
                            .state
                            .values
                            .toString()),
                      );
                    });
              },
              child: const Text("Show Previous Values"),
            ),
          ),
        ],
      ),
    );
  }
}
