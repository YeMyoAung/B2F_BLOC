import 'package:bloc_example/cubit/quiz_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QuizScreenWithBlocBuilder extends StatefulWidget {
  const QuizScreenWithBlocBuilder({Key? key}) : super(key: key);

  @override
  State<QuizScreenWithBlocBuilder> createState() =>
      _QuizScreenWithBlocBuilderState();
}

class _QuizScreenWithBlocBuilderState extends State<QuizScreenWithBlocBuilder> {
  final TextEditingController questionC = TextEditingController(),
      answerC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: Text("Quiz Example With Bloc Builder & Listener"),
        actions: [
          TextButton(
            onPressed: () {
              showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  builder: (_) {
                    return SizedBox(
                      height: 500,
                      child: Column(
                        children: [
                          TextField(
                            controller: questionC,
                            decoration: InputDecoration(
                              hintText: "Question",
                            ),
                          ),
                          TextField(
                            controller: answerC,
                            decoration: InputDecoration(
                              hintText: "Answer",
                            ),
                          ),
                          ElevatedButton(
                              onPressed: () {
                                context.read<QuizCubit>().addQuiz(QuizQuestion(
                                    question: questionC.text,
                                    answer: answerC.text));
                              },
                              child: Text("Add"))
                        ],
                      ),
                    );
                  });
            },
            child: Text(
              "Add Quiz",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          BlocListener<QuizCubit, QuizUseCase>(
            listener: (_, value) {
              print("Add Listener is working with $value");
              Navigator.pop(context);
            },
            listenWhen: (previous, current) {
              return current is Add;
            },
            child: SizedBox(),
          ),
          BlocListener<QuizCubit, QuizUseCase>(
            listener: (_, value) {
              print("Edit Listener is working with $value");
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text("Edited")));
            },
            listenWhen: (previous, current) {
              return current is Edit;
            },
            child: SizedBox(),
          ),
          BlocListener<QuizCubit, QuizUseCase>(
            listener: (_, value) {
              print("Delete Listener is working with $value");
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text("Deleted")));
            },
            listenWhen: (previous, current) {
              return current is Delete;
            },
            child: SizedBox(),
          ),
          Expanded(
            child: BlocBuilder<QuizCubit, QuizUseCase>(
              builder: (_, quiz) {
                return ListView.builder(
                  itemCount: quiz.quiz.length,
                  itemBuilder: (_, i) {
                    return ListTile(
                      onTap: () {},
                      title: Text(quiz.quiz[i].question),
                      trailing: IconButton(
                        onPressed: () {
                          context.read<QuizCubit>().deleteQuiz(quiz.quiz[i]);
                        },
                        icon: Icon(Icons.delete),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// return Scaffold(
// appBar: AppBar(
// title: Text("Quiz Screen With Bloc Builder"),
// ),
// body: ListView(
// children: [
// Padding(
//   padding: EdgeInsets.all(40),
//   child: Center(
//     child: BlocBuilder<QuizCubit, List<QuizQuestion>>(
//       builder: (context, bloc) {
//         return Text("hello world ${bloc.length}");
//       },
//     ),
//   ),
// ),
// Padding(
//   padding: const EdgeInsets.all(8.0),
//   child: TextField(
//     controller: questionC,
//     decoration: InputDecoration(
//       hintText: "Question",
//     ),
//   ),
// ),
// Padding(
//   padding: const EdgeInsets.all(8.0),
//   child: TextField(
//     controller: answerC,
//     decoration: InputDecoration(
//       hintText: "Answer",
//     ),
//   ),
// ),
// ElevatedButton(
//   onPressed: () {
//     context.read<QuizCubit>().addQuiz(
//         QuizQuestion(question: questionC.text, answer: answerC.text));
//   },
//   child: Text("Add Quiz"),
// )
// ],
// ),
// );
