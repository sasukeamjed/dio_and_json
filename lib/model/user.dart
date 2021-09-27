import 'package:json_annotation/json_annotation.dart';

class User{
  @JsonKey(name : "id")
  int id;

  @JsonKey(name : "email")
  String email;

  @JsonKey(name : "first_name")
  String firstName;

  @JsonKey(name : "last_name")
  String lastName;

  @JsonKey(name : "avatar")
  String avatar;
}