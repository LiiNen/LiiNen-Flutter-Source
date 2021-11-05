import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:my_flutter_source/navView/profileView/profileView.dart';

import 'imageApi.dart';
import 'restApi.dart';

getUsersById({required userId}) async {
  var query = '/$userId';

  var response = await http.get(Uri.parse('$baseUrl$pathUsers$query'));

  if(response.statusCode == 200) {
    var responseBody = json.decode(response.body);
    return responseBody;
  } else {
    return null;
  }
}

patchUsers({required userId, name='', intro='', File? profileImage}) async {
  var imageUrl = '';
  if(profileImage != null) {
    imageUrl = (await postImage(image: profileImage, type: 'users'))[0];
    print(imageUrl);
  }
  if(name == '') name = userProfile['name'];
  if(intro == '') intro = userProfile['introduce'];

  var query = '/$userId';
  var requestBody = Map();
  requestBody['name'] = name;
  requestBody['introduce'] = intro;
  if(imageUrl != '') requestBody['imageUrl'] = imageUrl;
  var requestBodyJson = json.encode(requestBody);

  var headers = authToken;
  headers['Content-type'] = 'application/json';
  var response = await http.patch(Uri.parse('$baseUrl$pathUsers$query'),
    body: requestBodyJson, headers: headers);

  print(response.body);
  if(response.statusCode == 200) {
    return json.decode(response.body)['_id'];
  }
  else return false;
}
