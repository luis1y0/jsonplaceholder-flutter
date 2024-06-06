import 'package:bloc/bloc.dart';
import 'package:jsonplaceholder_posts/app_messages.dart';
import 'package:jsonplaceholder_posts/src/data/sources.dart';
import 'package:jsonplaceholder_posts/src/domain/entities.dart';
import 'package:jsonplaceholder_posts/src/domain/repositories.dart';

sealed class PostEvent {}

final class GetPost extends PostEvent {}

sealed class PostState {}

final class PostResult extends PostState {
  final List<Post> posts;

  PostResult(this.posts);
}

final class PostError extends PostState {
  final String message;

  PostError({required this.message});
}

class PostBloc extends Bloc<PostEvent, PostState> {
  final PostRepository repository;
  PostBloc(this.repository) : super(PostResult([])) {
    on<GetPost>(_loadPosts);
    add(GetPost());
  }

  void _loadPosts(GetPost event, Emitter<PostState> emit) async {
    try {
      List<Post> posts = await repository.getPosts();
      emit(PostResult(posts));
    } on AppException catch (e) {
      emit(PostError(message: e.message));
    } catch (e) {
      emit(PostError(message: AppMessages.errorUnexpected));
    }
  }
}
