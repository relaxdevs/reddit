
import 'package:http/http.dart' as http;
import 'dart:convert';


Future fetchUrl(String query, Function cb) async {
  try {
    final response = await http.read(Uri.parse(query), headers: {'User-Agent': 'Flutter_Reddit 1.0'});
    
    var obj = json.decode(response);
    var item = obj is List ? obj.last : obj;

    cb(false, item);
  } catch (err) {
    cb(true, {});
  }
}
