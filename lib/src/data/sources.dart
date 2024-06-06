import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:jsonplaceholder_posts/app_messages.dart';
import 'package:jsonplaceholder_posts/src/data/models.dart';
import 'package:jsonplaceholder_posts/src/domain/entities.dart';
import 'package:jsonplaceholder_posts/src/domain/repositories.dart';

class PostApiRepository extends PostRepository {
  final Client client;

  PostApiRepository({required this.client});
  @override
  Future<List<Post>> getPosts() async {
    try {
      Response response = await client
          .get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
      if (response.statusCode != 200) {
        throw AppException(AppMessages.errorApiServiceFailed);
      }
      List data = jsonDecode(response.body);
      return data.map((el) => PostModel.fromJson(el)).toList();
    } on SocketException {
      throw AppException(AppMessages.errorApiConnectionFailed);
    } catch (e) {
      throw AppException(AppMessages.errorApiServerFailed);
    }
  }
}

class AppException implements Exception {
  final String message;

  AppException(this.message);
}
