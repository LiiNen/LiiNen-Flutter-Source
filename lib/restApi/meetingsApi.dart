import 'dart:convert';
import 'package:http/http.dart' as http;

import 'restApi.dart';

getMeetings({int page=1, int limit=50}) async {
  var query = '?page=$page&limit=$limit';

  var response = await http.get(Uri.parse('$baseUrl$pathMeetings$query'));

  if(response.statusCode == 200) {
    var responseBody = json.decode(response.body);
    print(responseBody);
  } else {
    print('error');
    return null;
  }
}

postMeetings({required String name, required String introduction, required int category, required int maxPerson}) async {
  var requestBody = Map();
  requestBody['name'] = name;
  requestBody['introduction'] = introduction;
  requestBody['category'] = category.toString();
  requestBody['maxPerson'] = maxPerson.toString();

  var response = await http.post(Uri.parse('$baseUrl$pathMeetings'),
    body: requestBody, headers: authToken);

  print(response.statusCode);
}

getMeetingsText({required String text, int page=1, int limit=50}) async {
  var query = '/keyword/$text?page=$page&limit=$limit';

  var response = await http.get(Uri.parse('$baseUrl$pathMeetings$query'));

  if(response.statusCode == 200) {
    var responseBody = json.decode(response.body);
    print(responseBody);
  } else {
    print('error');
    return null;
  }
}