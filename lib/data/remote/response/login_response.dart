import 'package:exammer/constants.dart';
import 'package:exammer/data/remote/response/base_response.dart';

class LoginResponse extends BaseResponse {
  late String token;

  LoginResponse.fromJson(Map<String, dynamic> json) : super(json) {
    token = data[keyToken] as String? ?? defaultString;
  }
}
