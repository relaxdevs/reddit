
bool isDeleted(String s) => s.contains('[deleted]') || s.contains('[removed]');

class UserModel {
  String? avatar;
  late String name;
  late int score;
  late bool banned;

  UserModel.fromJson(Map item) {
    avatar = item['avatar'] ?? item['subreddit']?['icon_img']?.split('?')?.first;
    name = item['author'] ?? item['name'] ?? '';
    score = item['total_karma'] ?? 0;
    banned = item['is_suspended'] == true || item['is_blocked'] == true || isDeleted(name);
  }
}