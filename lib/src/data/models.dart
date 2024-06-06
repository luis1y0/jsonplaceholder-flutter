import 'package:jsonplaceholder_posts/src/domain/entities.dart';

class PostModel extends Post {
  PostModel({required super.title, required super.body});

  PostModel.fromJson(Map<String, dynamic> json)
      : super(
          title: json['title'],
          body: json['body'],
        );
}
