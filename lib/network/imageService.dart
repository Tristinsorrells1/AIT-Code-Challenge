import 'dart:convert';

import 'package:flutter_app_gallery/models/webImageList.dart';
import 'package:flutter_app_gallery/models/webimage.dart';
import 'package:flutter_app_gallery/network/endpoints.dart';
import 'package:http/http.dart' as http;

//Web service for calling picsum api
class ImageWebService {
  final http.Client _client;
  final EndPoints endPoints = EndPoints();

  ImageWebService(this._client);

  Future<List<WebImage>> fetchListOfWebImages() async {
    try {
      final response = await _client.get(Uri.parse(endPoints.getListOfImages()));
      if (response.statusCode == 200) {
        Iterable<dynamic> jsonList = jsonDecode(response.body);
        List<WebImage> webImages =
            List<WebImage>.from(jsonList.map((e) => WebImage.fromJson(e)));
        return webImages;
      } else {
        print(response.body);
        throw Exception(response.statusCode);
      }
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<WebImage> fetchWebImageInfo(int id) async {
    try {
      final response =
          await _client.get(Uri.parse(endPoints.getImageFromId(id)));
      if (response.statusCode == 200) {
        return WebImage.fromJson(jsonDecode(response.body));
      } else {
        print(response.body);
        throw Exception(response.statusCode);
      }
    } catch (e) {
      return Future.error(e);
    }
  }
}