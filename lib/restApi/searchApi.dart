import 'dart:convert';
import 'package:http/http.dart' as http;

import 'restApi.dart';

searchWithCategory({required String categoryId}) async {
  var query = '/$categoryId?page=1&limit=20';
  var response = await http.get(Uri.parse('$baseUrl$pathSearchCategory$query'));

  if(response.statusCode == 200) {
    var responseBody = json.decode(response.body);
    return responseBody;
  }
  else {
    print(response.statusCode);
    print(json.decode(response.body));
    print('error');
    return null;
  }
}

searchWithWord({required String word}) async {
  var query = '/$word?page=1';
  var response = await http.get(Uri.parse('$baseUrl$pathSearchWord$query'));

  if(response.statusCode == 200) {
    var responseBody = json.decode(response.body);
    return responseBody;
  }
  else {
    print('error');
    return null;
  }
}