
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User {
  const User._();
  const factory User({
    required Map<String, dynamic> userInfoData,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  String get id => userInfoData['id'].toString();
  String get surname => userInfoData['surname'].toString();
  String get name => userInfoData['name'].toString();
  String get patronymic => userInfoData['patronymic'].toString();
  String get login => userInfoData['login'].toString();
  String get password => userInfoData['password'].toString();
  String get position => userInfoData['position'].toString();
  String get department => userInfoData['department'].toString();

}