// To parse this JSON data, do
//
//     final listOfPost = listOfPostFromJson(jsonString);

import 'dart:convert';

List<ItemOfPost> listOfPostFromJson(String str) => List<ItemOfPost>.from(json.decode(str).map((x) => ItemOfPost.fromJson(x)));

String listOfPostToJson(List<ItemOfPost> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ItemOfPost {
    int? userId;
    int? id;
    String? title;
    String? body;

    ItemOfPost({
        this.userId,
        this.id,
        this.title,
        this.body,
    });

    factory ItemOfPost.fromJson(Map<String, dynamic> json) => ItemOfPost(
        userId: json["userId"],
        id: json["id"],
        title: json["title"],
        body: json["body"],
    );

    Map<String, dynamic> toJson() => {
        "userId": userId,
        "id": id,
        "title": title,
        "body": body,
    };
}
