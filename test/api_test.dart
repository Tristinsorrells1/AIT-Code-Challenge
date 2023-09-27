import 'dart:convert';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_app_gallery/models/webimage.dart';
import 'package:flutter_app_gallery/network/imageService.dart';
import 'api_test.mocks.dart';


@GenerateMocks([http.Client])
void main() {
  group('fetch list of images', () {
    test('returns an array of image objects if the http call completes successfully', () async {
      final client = MockClient();

   
       when(client.get(Uri.parse('https://picsum.photos/v2/list')))
      .thenAnswer((_) async => http.Response('''
    [
        {
            "id": "0",
            "author": "Alejandro Escamilla",
            "width": 5616,
            "height": 3744,
            "url": "https://unsplash.com/...",
            "download_url": "https://picsum.photos/..."
        }
    ]
''', 200));

      final imageWebService = ImageWebService(client);
      final webImages = await imageWebService.fetchListOfWebImages();

      expect(webImages, isA<List<WebImage>>());
    });
  

    test('throws an exception if the http call completes with an error', () async {
      final client = MockClient();

 
      when(client.get(Uri.parse('https://picsum.photos/v2/list')))
          .thenAnswer((_) async => http.Response('', 500));

  
      final imageWebService = ImageWebService(client);
   

      expect(imageWebService.fetchListOfWebImages(), throwsException);
    });
  });
}