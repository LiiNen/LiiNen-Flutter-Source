import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'restApi.dart';

getBoard({int page=1, int limit=50, postId=''}) async {
  var query = '?';
  if(postId != '') query = query + 'post_id=$postId';
  else query = query + 'page=$page&limit=$limit';

  var response = await http.get(Uri.parse('$baseUrl$pathBoard$query'));

  if(response.statusCode == 200) {
    var responseBody = json.decode(response.body);
    return responseBody['imageUrls'];
  } else {
    return null;
  }
}

postBoard({required String meetingId, required String userId, required String title, required String content, required List<String> imageUrls}) async {
  var temp = Map();
  temp['meeting'] = meetingId;
  temp['author'] = userId;
  temp['title'] = title;
  temp['contents'] = content;
  temp['imageUrls'] = imageUrls;

  var requestBody = json.encode(temp);

  var response = await http.post(Uri.parse('$baseUrl$pathBoard'),
    headers: authToken, body: requestBody
  );

  if(response.statusCode == 200) {
    return true;
  }
  else return null;
}

patchBoardLike({required String postId, required String userId}) async {
  var requestBody = Map();
  requestBody['user_id'] = userId;

  var response = await http.patch(Uri.parse('$baseUrl/posts/$postId/likes'),
    headers: authToken, body: requestBody
  );

  if(response.statusCode == 200) {
    return true;
  }
  else return false;
}