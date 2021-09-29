import 'package:dio_and_json/model/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'list_user_response.g.dart';

@JsonSerializable()
class ListUserResponse{

  @JsonKey(name : "page")
  late int page;

  @JsonKey(name : "per_page")
  late int perPage;

  @JsonKey(name : "total")
  late int total;

  @JsonKey(name : "total_pages")
  late int totalPages;

  @JsonKey(name : "data")
  late List<User> users;

  ListUserResponse();
  factory ListUserResponse.fromJson(Map<String, dynamic> json) => _$ListUserResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ListUserResponseToJson(this);
}