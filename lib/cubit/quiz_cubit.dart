import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QuizQuestion extends Equatable {
  ///Object => Variable => properties
  ///Object => function => method
  final String question, answer;
  const QuizQuestion({
    required this.question,
    required this.answer,
  });

  @override

  ///properties
  List<Object?> get props => [question, answer];

  // operator ==(covariant )

}

//List<QuizQuestion>

///Delete , Add, Update
abstract class QuizUseCase extends Equatable {
  final List<QuizQuestion> quiz;
  const QuizUseCase(this.quiz);
  @override
  List<Object?> get props => [quiz];
}

class Default extends QuizUseCase {
  const Default(super.quiz);
}

class Add extends QuizUseCase {
  const Add(super.quiz);
}

class Edit extends QuizUseCase {
  const Edit(super.quiz);
}

class Delete extends QuizUseCase {
  const Delete(super.quiz);
}

///Distinct =>
///! State ကိုတူညီတယ်လို့ ခံစားရရင် UI ကိုပြန်ပြီးမတည်ဆောက်ဘူး
class QuizCubit extends Cubit<QuizUseCase> {
  QuizCubit(super.initialState);

  void addQuiz(QuizQuestion quiz) {
    try {} catch (e) {
      ///state
      // emit(state);
      throw "Error";
    }

    ///state = [] isEmpty
    ///state = [Instance] isNotEmpty
    // state.add(quiz);

    //Object = Null  null state
    //Object = Instance not null state
    //Object = Instance not null state

    ///List   => .toList() copy
    ///Map    => .map((key,value) => MapE(key,value)) copy
    ///Object =>
    final List<QuizQuestion> newState = state.quiz.toList();
    if (newState.contains(quiz)) return;
    newState.add(quiz);
    emit(Add(newState));
  }

  void editQuiz(find, replace) {
    final List<QuizQuestion> newState = state.quiz.toList();
    final findIndex = newState.indexOf(find);
    newState[findIndex] = replace;
    emit(Edit(newState));
  }

  void deleteQuiz(find) {
    final List<QuizQuestion> newState = state.quiz.toList();
    newState.remove(find);
    emit(Delete(newState));
  }

  ///QuizCubit(int value):super(value);
}
