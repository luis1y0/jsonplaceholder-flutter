import 'package:jsonplaceholder_posts/src/domain/entities.dart';

abstract class PostRepository {
  Future<List<Post>> getPosts();
}
