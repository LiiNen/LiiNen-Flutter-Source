import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'restApi.dart';

postImage({required File image, required String type}) async {
  var request = http.MultipartRequest('POST', Uri.parse('$baseUrl$pathImage?type=$type'))
    ..headers['Content-type'] = 'application/json'
    ..files.add(http.MultipartFile('images',
      image.readAsBytes().asStream(),
      image.lengthSync(),
      filename: 'image'
    ));
  print('1. request');
  print(request);

  http.Response response = await http.Response.fromStream(await request.send());
  print(response.body);
  if(response.statusCode == 201) return json.decode(response.body)['imageUrls'];
  else return null;
}