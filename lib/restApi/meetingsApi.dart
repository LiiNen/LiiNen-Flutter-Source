import 'dart:convert';
import 'dart:io';
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

getMeetingById(String id) async {
  var query = '/$id';
  var response = await http.get(Uri.parse('$baseUrl$pathMeetings$query'));

  if(response.statusCode == 200) {
    var responseBody = json.decode(response.body);
    return responseBody;
  }
  else return null;
}

postMeetings({required String name, required String introduction, required String category, required String maxPerson, required File clubImage}) async {
  var requestBody = Map();
  requestBody['name'] = name;
  requestBody['introduction'] = introduction;
  requestBody['category'] = category;
  requestBody['maxPerson'] = maxPerson;

  var request = http.MultipartRequest('POST', Uri.parse('$baseUrl$pathMeetings'))
    ..headers['Content-type'] = 'application/json'
    ..headers['Authorization'] = authToken['Authorization']!
    ..fields['name'] = name
    ..fields['introduction'] = introduction
    ..fields['category'] = category
    ..fields['maxPerson'] = maxPerson
    ..files.add(http.MultipartFile('images',
      clubImage.readAsBytes().asStream(),
      clubImage.lengthSync(),
      filename: 'image'
    ));

  var response = await request.send();
  print(response.statusCode);
  if(response.statusCode == 201) {
    response.stream.transform(utf8.decoder).listen((value) {
      print(value);
    });
    return true;
  }
  else {
    response.stream.transform(utf8.decoder).listen((value) {
      print(value);
    });
    return false;
  }
}

getMeetingsText({required String text, int page=1, int limit=50}) async {
  var query = '/keyword/$text?page=$page&limit=$limit';

  var response = await http.get(Uri.parse('$baseUrl$pathMeetings$query'));

  if(response.statusCode == 200) {
    var responseBody = json.decode(response.body);
  } else {
    print('error');
    return null;
  }
}

patchMeetings({required String meetingId}) async {
  var query = '/$meetingId';

  var response = await http.patch(Uri.parse('$baseUrl$pathMeetings$query'));


}

quitMeeting({required String meetingId, isPresident=false}) async {
  var query = '/$meetingId';
  if(!isPresident) query = query + '/quit';

  var response = await (isPresident
    ? http.delete(Uri.parse('$baseUrl$pathMeetings$query'), headers: authToken)
    : http.patch(Uri.parse('$baseUrl$pathMeetings$query'), headers: authToken)
  );

  if(response.statusCode == 200) {
    print('success');
    return true;
  }
  else {
    return null;
  }
}

actionMeeting({required String meetingId, required String userId, required String type}) async {
  var query = '/$meetingId/$type';
  var requestBody = Map();
  requestBody['user_id'] = userId;
  var response = await http.patch(Uri.parse('$baseUrl$pathMeetings$query'), body: requestBody, headers: authToken);
  print('$baseUrl$pathMeetings$query');
  print(response.body);
  if(response.statusCode == 200) {
    return true;
  }
  return false;
}
