import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:jsonplaceholder_posts/src/data/models.dart';
import 'package:jsonplaceholder_posts/src/domain/entities.dart';
import 'package:jsonplaceholder_posts/src/domain/repositories.dart';

class PostApiRepository extends PostRepository {
  @override
  Future<List<Post>> getPosts() async {
    try {
      Response response =
          await get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
      if (response.statusCode != 200) {
        throw AppException('Server error: try again later');
      }
      List data = jsonDecode(response.body);
      return data.map((el) => PostModel.fromJson(el)).toList();
    } on SocketException {
      throw AppException('Your device isn\'t connected to internet.');
    } catch (e) {
      throw AppException('Server error: service isn\'t available');
    }
  }
}

class AppException implements Exception {
  final String message;

  AppException(this.message);
}
