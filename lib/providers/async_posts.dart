import 'package:json_parsing/models/post.dart';
import 'package:json_parsing/repositories/post_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'async_posts.g.dart';

@riverpod
class AsyncPosts extends _$AsyncPosts {
  Future<List<Post>> _fetchPosts() async {
    final repository = PostRepositoryImpl();
    return await repository.getAll();
  }

  @override
  FutureOr<List<Post>> build() {
    return _fetchPosts();
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      return _fetchPosts();
    });
  }
}

@riverpod
Future<Post> fetchPostById(FetchPostByIdRef ref, int id) async {
  final repository = PostRepositoryImpl();
  return await repository.findById(id);
}
