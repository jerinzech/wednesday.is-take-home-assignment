import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiServices {
  getPosts() async {
    var client = http.Client();

    const url = 'https://jsonplaceholder.typicode.com/posts';
    var uri = Uri.parse(url);
    var response = await client.get(uri);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      print(json);
      return json;
    }
  }
}
