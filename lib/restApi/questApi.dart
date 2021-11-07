import 'dart:convert';
import 'package:http/http.dart' as http;

import 'restApi.dart';

getQuestById({required questId}) async {
  var query = '/$questId';

  var response = await http.get(Uri.parse('$baseUrl$pathQuest$query'));
  if(response.statusCode == 200) {
    return json.decode(response.body);
  }
  else return null;
}

postQuest({required String meetingId, required String title, required String contents}) async {
  var requestBody = Map();
  requestBody['meeting'] = meetingId;
  requestBody['title'] = title;
  requestBody['contents'] = contents;
  var requestBodyJson = json.encode(requestBody);

  var headers = authToken;
  headers['Content-type'] = 'application/json';

  var response = await http.post(Uri.parse('$baseUrl$pathQuest'),
    body: requestBodyJson, headers: headers
  );

  if(response.statusCode == 201) {
    return true;
  }
  else return false;
}

deleteQuest({required String questId}) async {
  var query = '/$questId';
  var headers = authToken;
  var response = await http.delete(Uri.parse('$baseUrl$pathQuest$query'), headers: headers);

  if(response.statusCode == 200) {
    return true;
  }
  else return false;
}

getMeetingQuest({required String meetingId}) async {
  var query = '/$meetingId';

  var response = await http.get(Uri.parse('$baseUrl$pathMeetingQuest$query'));

  if(response.statusCode == 200) {
    var responseBody = json.decode(response.body);
    print(responseBody);
    return responseBody;
  }
  else return null;
}

patchQuest({required String questId, required bool isActive}) async {
  var query = '/$questId';
  var requestBody = Map();
  requestBody['isActive'] = isActive;
  var requestBodyJson = json.encode(requestBody);

  var headers = authToken;
  headers['Content-type'] = 'application/json';

  var response = await http.patch(Uri.parse('$baseUrl$pathQuest$query'),
    body: requestBodyJson, headers: headers
  );
  if(response.statusCode == 200) {
    return true;
  }
  else return false;
}

patchQuestUser({required String questId, required String userId}) async {
  var query = '/$questId/completion';

  var requestBody = Map();
  requestBody['user_id'] = userId;
  var requestBodyJson = json.encode(requestBody);

  var headers = authToken;
  headers['Content-type'] = 'application/json';

  var response = await http.patch(Uri.parse('$baseUrl$pathQuest$query'),
    body: requestBodyJson, headers: headers
  );

  if(response.statusCode == 200) {
    return true;
  }
  else return false;
}