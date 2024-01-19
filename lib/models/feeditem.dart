
import './user.dart';


class FeedItemModel {
  late String id;
  late String title;
  late String selftext;
  late String thumbnail;
  late String link;
  late int score;
  late int countComments;
  late UserModel author;
  late List<String> gallery;

  FeedItemModel.fromJson(Map item) {
    id = item['id'] ?? '';
    title = item['title'] ?? '';
    selftext = item['selftext'] ?? '';
    link = item['url_overridden_by_dest'] ?? '';
    score = item['score'] ?? 0;
    countComments = item['num_comments'] ?? 0;
    author = UserModel.fromJson({'author': item['author'] ?? ''});
    
    thumbnail = item['thumbnail'] is String && item['thumbnail'].contains('http') && !item['thumbnail'].contains('?')
      ? item['thumbnail'] 
      : ''; 

    gallery = item['gallery_data']?['items'] is List
      ? item['gallery_data']['items'].map((item) => 'http://i.redd.it/${item['media_id']}.jpg').toList().cast<String>()
      : <String>[];
  }
}