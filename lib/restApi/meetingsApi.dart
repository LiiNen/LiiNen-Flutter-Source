import 'dart:convert';
import 'package:http/http.dart' as http;

import 'restApi.dart';

getMeetings({int page=1, int limit=50}) async {
  var query = '?page=$page&limit=$limit';

  var response = await http.get(Uri.parse('$baseUrl$pathMeetings$query'));

  if(response.statusCode == 200) {
    var responseBody = json.decode(response.body);
    return responseBody;
  } else {
    return null;
  }
}

postMeetings({required String name, required String introduction, required String category, required String maxPerson}) async {
  var requestBody = Map();
  requestBody['name'] = name;
  requestBody['introduction'] = introduction;
  requestBody['category'] = category;
  requestBody['maxPerson'] = maxPerson;

  var response = await http.post(Uri.parse('$baseUrl$pathMeetings'),
    body: requestBody, headers: authToken);

  if(response.statusCode == 201) {
    return true;
  }
  else {
    return false;
  }
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

patchMeetings({required String meetingId}) async {
  var query = '/$meetingId';

  var response = await http.patch(Uri.parse('$baseUrl$pathMeetings$query'));


}