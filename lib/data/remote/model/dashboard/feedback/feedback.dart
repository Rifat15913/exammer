import 'package:exammer/constants.dart';
import 'package:json_annotation/json_annotation.dart';

part 'feedback.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Feedback {
  @JsonKey(defaultValue: defaultString)
  late String name;

  @JsonKey(defaultValue: defaultString)
  late String profilePicture;

  @JsonKey(defaultValue: defaultString)
  late String? content;

  Feedback();

  factory Feedback.fromJson(Map<String, dynamic> json) =>
      _$FeedbackFromJson(json);

  Map<String, dynamic> toJson() => _$FeedbackToJson(this);
}
