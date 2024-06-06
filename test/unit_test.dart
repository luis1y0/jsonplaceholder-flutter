import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:jsonplaceholder_posts/src/data/models.dart';
import 'package:jsonplaceholder_posts/src/domain/entities.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:jsonplaceholder_posts/src/data/sources.dart';
@GenerateMocks([http.Client])
import 'unit_test.mocks.dart';

void main() {
  group('PostRepository', () {
    MockClient? mockClient;
    PostApiRepository? postRepository;
    const endpoint = 'https://jsonplaceholder.typicode.com/posts';

    setUp(() {
      mockClient = MockClient();
      postRepository = PostApiRepository(client: mockClient!);
    });

    test('throws exception when api returns status code different than 200',
        () async {
      when(mockClient!.get(Uri.parse(endpoint)))
          .thenAnswer((_) async => http.Response('Server Error', 500));

      expect(postRepository!.getPosts(), throwsException);
      expect(postRepository!.getPosts(), throwsA(isA<AppException>()));
    });

    test('parse empty list from API', () async {
      when(mockClient!.get(Uri.parse(endpoint)))
          .thenAnswer((_) async => http.Response('[]', 200));

      expect(await postRepository!.getPosts(), []);
    });

    test('parse post fields succesfully', () async {
      when(mockClient!.get(Uri.parse(endpoint))).thenAnswer((_) async =>
          http.Response(
              '[{"userId": 1,"id": 1,"title": "mockTitle","body": "mockBody"}]',
              200));

      expect(await postRepository!.getPosts(),
          [Post(title: 'mockTitle', body: 'mockBody')]);
    });
  });
}
