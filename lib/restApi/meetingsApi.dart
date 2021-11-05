import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:my_flutter_source/restApi/imageApi.dart';

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

  var imageUrls = await postImage(image: clubImage, type: 'meetings');

  var temp = Map();
  temp['name'] = name;
  temp['introduction'] = introduction;
  temp['category'] = category;
  temp['maxPerson'] = maxPerson;
  temp['imageUrls'] = imageUrls;

  var requestBody = json.encode(temp);
  var headers = authToken;
  headers['Content-type'] = 'application/json';
  var response = await http.post(Uri.parse('$baseUrl$pathMeetings'),
    headers: headers, body: requestBody
  );

  print(response.statusCode);
  if(response.statusCode == 201) {
    print(true);
    return true;
  }
  else {
    print(false);
    print(response.body);
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

patchMeetings({required String meetingId, File? clubImage}) async {
  var imageUrls = [];
  if(clubImage != null) {
    imageUrls = await postImage(image: clubImage, type: 'meetings');
  }

  var query = '/$meetingId';

  var requestBody = Map();
  if(imageUrls != []) requestBody['imageUrls'] = imageUrls;

  var requestBodyJson = json.encode(requestBody);

  var headers = authToken;
  headers['Content-type'] = 'application/json';
  var response = await http.patch(Uri.parse('$baseUrl$pathMeetings$query'),
    body: requestBodyJson, headers: headers
  );
  if(response.statusCode == 200) {
    return true;
  }
  else return false;
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
