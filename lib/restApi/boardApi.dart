import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:my_flutter_source/restApi/imageApi.dart';
import 'restApi.dart';

getBoard({int page=1, int limit=50, postId=''}) async {
  var query = '?';
  if(postId != '') query = query + 'post_id=$postId';
  else query = query + 'page=$page&limit=$limit';

  var response = await http.get(Uri.parse('$baseUrl$pathBoard$query'));

  if(response.statusCode == 200) {
    var responseBody = json.decode(response.body);
    return responseBody;
  } else {
    return null;
  }
}

postBoard({required String meetingId, required String userId, required String title, required String content, List<File>? boardImageList}) async {
  var imageUrls = [];
  if(boardImageList != null) {
    for(File boardImage in boardImageList) {
      var tempUrl = (await postImage(image: boardImage, type: 'posts'))[0];
      imageUrls.add(tempUrl);
    }
  }

  var temp = Map();
  temp['meeting'] = meetingId;
  temp['author'] = userId;
  temp['title'] = title;
  temp['contents'] = content;
  temp['imageUrls'] = imageUrls;

  var requestBody = json.encode(temp);
  var headers = authToken;
  headers['Content-type'] = 'application/json';

  var response = await http.post(Uri.parse('$baseUrl$pathBoard'),
    headers: headers, body: requestBody
  );

  print(response.statusCode);
  if(response.statusCode == 201) {
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

getClubBoard({required String meetingId}) async {
  var response = await http.get(Uri.parse('$baseUrl$pathClubBoard/$meetingId'));

  print(response.statusCode);
  print(json.decode(response.body));
  if(response.statusCode == 200) {
    return json.decode(response.body);
  }
  else return null;
}