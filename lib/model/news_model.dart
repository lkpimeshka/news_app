import 'dart:convert';

NewsModel newsModelFromJson(String str) => NewsModel.fromJson(json.decode(str));
String newsModelToJson(NewsModel data) => json.encode(data.toJson());
class NewsModel {
  String status;
  List<Datum> data;
  NewsModel({
  required this.status,
  required this.data,
  });
  factory NewsModel.fromJson(Map<String, dynamic> json) => NewsModel(
    status: json["status"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );
  Map<String, dynamic> toJson() => {
    "status": status,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}
class Datum {
  int id;
  String email;
  String firstName;
  String lastName;
  String avatar;
  Datum({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.avatar,
  });
  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    email: json["email"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    avatar: json["avatar"],
  );
  Map<String, dynamic> toJson() => {
    "id": id,
    "email": email,
    "first_name": firstName,
    "last_name": lastName,
    "avatar": avatar,
  };
}