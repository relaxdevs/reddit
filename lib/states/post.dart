
import './api/main.dart';

import '../models/feeditem.dart';
import '../models/comment.dart';
import '../models/user.dart';


class PostState {
  List<CommentModel>? data;
  Map<String, bool> objUsed = <String, bool>{};
  late FeedItemModel item;
  int offset = 0;
  int page = 0;
  bool loading = true;
  Function updateScreen;

  PostState(this.item, this.updateScreen) {
    offset = 4 + (item.link.isNotEmpty ? 1 : 0);
  }

  bool get isLinkFromReddit => item.link.length > 18 && item.link.substring(0, 18) == 'https://i.redd.it/';

  void getUser() {
    api('user', item.author.name, '', (bool err, Map obj) {
      if (err) return;

      item.author = UserModel.fromJson(obj['data']);
      
      updateScreen();
    });
  }

  void getComments() {
    loading = true;

    String id = item.id;

    api('comments', id, '', (bool err, Map item) {
      if (err) return;
      loading = false;

      data = item['data']?['children']?.map<CommentModel>((item) => CommentModel.fromJson(item['data']))?.toList();

      updateScreen();
    });
  }

  void checkMoreComments() {
    List<String> arr = <String>[];
    
    data?.forEach((item) {
      if (item.depth == 0 && item.children.isNotEmpty) {
        arr.addAll(item.children);
      }
    }); 

    if (arr.isNotEmpty) {
      arr = arr.skip(page).take(100).toList();
      page = page + 100;
      
      getMoreComments({'link_id': 't3_' + item.id, 'children': arr.take(100).join(',')});
    }
  }


  String makeFilter(Map obj) {
  List<String> arr = obj.keys.where((k) => obj[k] != null).map((k) {
    String v = obj[k];

    return k == 'page' ? 'after=t3_$v' 
                       : '$k=$v';
  }).toList();

  return arr.join('&');
}

  void getMoreComments(Map obj) {
    loading = true;
    updateScreen();
    
    String filter = obj.keys.map((k) => '$k=${obj[k]}').join('&');

    api('comments_more', '', filter, (bool err, Map item) {
      if (err) return;
      loading = false;
      
      List<CommentModel>? arr = item['json']?['data']?['things']?.map<CommentModel>((item) => CommentModel.fromJson(item['data']))?.toList();
      
      if (arr != null) data!.addAll(arr);

      updateScreen();
    });
  }

  

  void showReplies(CommentModel item, int i) {
    objUsed[item.id] = true;
    
    int index = i - offset + 1;

    if ((index < 0) || (index >= (data!.length))) {
      data!.addAll(item.replies);
    } else {
      data!.insertAll(index, item.replies);
    }

    updateScreen();
  }
}