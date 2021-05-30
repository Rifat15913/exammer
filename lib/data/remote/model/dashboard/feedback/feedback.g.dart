// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feedback.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Feedback _$FeedbackFromJson(Map<String, dynamic> json) {
  return Feedback()
    ..name = json['name'] as String? ?? ''
    ..profilePicture = json['profile_picture'] as String? ?? ''
    ..content = json['content'] as String? ?? '';
}

Map<String, dynamic> _$FeedbackToJson(Feedback instance) => <String, dynamic>{
      'name': instance.name,
      'profile_picture': instance.profilePicture,
      'content': instance.content,
    };
