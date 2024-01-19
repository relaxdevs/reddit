
import './fetch.dart';
import './limiter.dart';
import './cache.dart';


String webUrl = 'https://www.reddit.com';
String webApi = 'https://api.reddit.com/api';

int limiterInterval = 300; //ms
int cacheInterval = 1000 * 60 * 60; //5 min


void fetch(String query, Function cb) {
  Map? item = getCache(query, cacheInterval);

  if (item != null) {
    cb(false, item);
  } else {
    addLimiter(limiterInterval, () => fetchUrl(query, (bool err, Map item) {
      if (!err && !query.contains('r/Random')) addCache(query, item); 
      cb(err, item);
    }));
  }
}

void api(String id, String path, String filter, Function cb) {
  String query = id == 'feed'          ? '$webUrl/$path/.json?$filter'
               : id == 'comments'      ? '$webUrl/comments/$path/.json' 
               : id == 'comments_more' ? '$webUrl/api/morechildren.json?$filter&api_type=json'
               : id == 'user'          ? '$webUrl/user/$path/about.json'
               : id == 'user_comments' ? '$webUrl/user/$path/comments.json?$filter' 
               : id == 'post'          ? '$webApi/info/?id=$path' : '';

  fetch(query, cb);
}
