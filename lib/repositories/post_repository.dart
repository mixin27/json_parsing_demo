import 'package:dio/dio.dart';
import 'package:generic_json_parser/generic_json_parser.dart';
import 'package:json_parsing/dio_client/dio_client.dart';
import 'package:json_parsing/models/post.dart';
import 'package:json_parsing/repositories/base_repository.dart';

abstract class PostRepository extends BaseRepository<Post> {}

class PostRepositoryImpl implements PostRepository {
  final Dio _dioClient;

  PostRepositoryImpl({Dio? dioClient})
      : _dioClient = dioClient ?? DioClient().instance;

  @override
  Future<List<Post>> getAll() async {
    final response = await _dioClient.get('/posts');

    return GenericJsonParser.computeParseJsonList(
      response.data,
      Post.fromJson,
      useDioPackage: true,
    );
  }

  @override
  Future<Post> findById<int>(int id) async {
    final response = await _dioClient.get('/posts/$id');

    return GenericJsonParser.computeParseJsonObject(
      response.data,
      Post.fromJson,
      useDioPackage: true,
    );
  }
}
