import 'package:exammer/data/remote/model/quiz/question/question.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Quiz {
  final String name;
  final int totalTime;
  final int totalQuestions;
  final List<Question> questionList;

  Quiz({
    required this.name,
    required this.totalTime,
    required this.totalQuestions,
    required this.questionList,
  });
}
