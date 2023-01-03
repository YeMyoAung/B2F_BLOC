import 'dart:math';

import 'package:bloc_example/cubit/cubit_last.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SetStateExample extends StatefulWidget {
  const SetStateExample({super.key});

  @override
  State<SetStateExample> createState() => _SetStateExampleState();
}

class _SetStateExampleState extends State<SetStateExample> {
  ///random number ထည့်ပေးလိုက်တဲ့ တန်ဖိုးညီလားစစ်မယ်
  ///အကြိမ်100မှာ ဘယ်နှစ်ကြိမ်ညီနိုင်မလဲဆိုတာစစ်မယ်
  ///10ကြိမ်အောက်ဆိုရင် bad review  (Color => Red, Message = Hmmm)
  ///50 နဲ့ 70ကြားဆိုရင် good review (Color => Amber, Message = Not Bad)
  ///70နဲ့ 100ကြား ဆိုရင် best review (Color => Green,Message = Wow)
  ///စစ်နေတဲ့အချိန်အတွင်းမှာဆိုရင် loadingပြပေးမယ်

  Color color = Colors.grey;
  String message = "Let's Predict";
  bool isLoading = false;

  Future<void> checker(int predict) async {
    isLoading = true;
    setState(() {});
    int count = 0;
    for (var i = 0; i < 100; i++) {
      await Future.delayed(const Duration(milliseconds: 10));
      if (predict == Random.secure().nextInt(9)) {
        count++;
      }
    }
    if (count < 10) {
      color = Colors.red;
      message = 'Hmmm';
      isLoading = false;
      setState(() {});
      return;
    }
    if (count >= 50 && count <= 70) {
      color = Colors.amber;
      message = 'Not Bad';
      isLoading = false;

      setState(() {});
      return;
    }
    color = Colors.green;
    message = 'Wow';
    isLoading = false;

    setState(() {});
  }

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
          Container(
            width: double.infinity,
            height: 200,
            color: color,
            margin: const EdgeInsets.all(20),
            alignment: Alignment.center,
            child: isLoading
                ? const CircularProgressIndicator(
                    color: Colors.white,
                  )
                : Text(
                    message,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
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
                checker(int.tryParse(controller.text) ?? -1);
              },
              child: const Text("Beat"),
            ),
          )
        ],
      ),
    );
  }
}

class CubitExample extends StatefulWidget {
  const CubitExample({super.key});

  @override
  State<CubitExample> createState() => _CubitExampleState();
}

class _CubitExampleState extends State<CubitExample> {
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
          BlocBuilder<CubitLast, PredictState>(
            builder: (blocBuildContext, state) {
              return Container(
                width: double.infinity,
                height: 200,
                color: state.color,
                margin: const EdgeInsets.all(20),
                alignment: Alignment.center,
                child: state.isLoading
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
                ///Function (Bloc,Provider)
                context.read<CubitLast>().checker(controller.text);
              },
              child: const Text("Beat"),
            ),
          )
        ],
      ),
    );
  }
}
