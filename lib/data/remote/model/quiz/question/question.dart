import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Question {
  final String question;

  final List<String> answers;

  final int rightAnswerIndex;

  Question({
    required this.question,
    required this.answers,
    required this.rightAnswerIndex,
  });

  Map<String, dynamic> toJson() => <String, dynamic>{
        'question': this.question,
        'answers': this.answers,
        'right_answer_index': this.rightAnswerIndex,
      };
}
