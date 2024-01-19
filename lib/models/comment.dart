
import './user.dart';


class CommentModel {
  late String id;
  late String body;
  late String parent;
  late UserModel author;
  late int score;
  late int depth;
  late List<CommentModel> replies;
  late List<String> children;

  CommentModel.fromJson(Map item) {
    id = item['id'] ?? '';
    body = item['body'] ?? '';
    parent = item['link_id'] ?? '';
    author = UserModel.fromJson({'author': item['author'] ?? ''});
    score = item['score'] ?? 0;
    depth = item['depth'] ?? 0;

    children = item['children'] is List
      ? item['children'].cast<String>()
      : <String>[];

    replies = item['replies'] is Map && item['replies']['data'] is Map && item['replies']['data']['children'] is List
      ? item['replies']['data']['children'].map<CommentModel>((item) => CommentModel.fromJson(item['data'])).toList()
      : <CommentModel>[];
  }
}