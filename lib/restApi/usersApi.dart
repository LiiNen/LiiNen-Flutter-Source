import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:my_flutter_source/navView/profileView/profileView.dart';

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

patchUsers({required userId, name='', intro=''}) async {
  if(name == '') name = userProfile['name'];
  if(intro == '') intro = userProfile['introduce'];

  var query = '/$userId';
  var requestBody = Map();
  requestBody['name'] = name;
  requestBody['introduce'] = intro;

  var response = await http.patch(Uri.parse('$baseUrl$pathUsers$query'),
      body: requestBody, headers: authToken);
  if(response.statusCode == 200) {
    return json.decode(response.body)['_id'];
  }
  else return false;
}

patchUsersImage({required userId, required File profileImage}) async {
  var query = '/$userId/image';
  var request = http.MultipartRequest('PATCH', Uri.parse('$baseUrl$pathUsers$query'))
    ..headers['Content-type'] = 'application/json'
    ..headers['Authorization'] = authToken['Authorization']!
    ..files.add(http.MultipartFile('image',
      profileImage.readAsBytes().asStream(),
      profileImage.lengthSync(),
      filename: 'image'
    ));

  var response = await request.send();
  print(response.statusCode);

  if(response.statusCode == 200) {
    return true;
  }
  else return false;
}