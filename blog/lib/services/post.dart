import 'dart:convert';

import 'package:http/http.dart' as http;

final baseUrl = "#api";

class Post {
  final String PostUrl = baseUrl + "posts?_embed";
  final CategoryUrl = baseUrl + "posts?_embed&categories=2";
  final Page = baseUrl + "pages?_embed";

  Future<List> getAllPost() async {
    return Common(PostUrl);
  }

  Future<List> getCategory() async {
    return Common(CategoryUrl);
  }

  Future<List> getPage() async {
    return Common(Page);
  }
}

Future<List> Common(String Url) async {
  try {
    var response = await http.get(Uri.parse(Url));
    print(response);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return Future.error("Server Error");
    }
  } catch (SocketExeption) {
    return Future.error("Error Fatching Data");
  }
}
