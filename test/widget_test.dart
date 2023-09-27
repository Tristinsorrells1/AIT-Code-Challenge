import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_app_gallery/widgets/imageCard.dart';
import 'package:flutter_app_gallery/main.dart';
import 'package:flutter_app_gallery/models/webimage.dart';
import 'package:flutter_app_gallery/models/webimageList.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';

void main() {
  testWidgets('Card Widget Test', (WidgetTester tester) async {
    await mockNetworkImagesFor(() async {
      await tester.pumpWidget(
        const Directionality(
          textDirection: TextDirection.ltr,
          child: ImageCard(
            authorName: 'John Doe',
            imageUrl: 'https://example.com/image.jpg',
          ),
        ),
      );
    });

    // Verify that our card and its contents exist
    expect(find.byType(Card), findsOneWidget);
    expect(find.text("John Doe"), findsOneWidget);
    expect(find.byType(Image), findsOneWidget);
  });

  testWidgets('Next and Previous Image Navigation',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    final List<WebImage> webImages = [
      WebImage(
        id: '1',
        author: 'John Doe',
        download_url: 'url1',
        width: 400,
        height: 400,
        url: "https://example.com/image1.jpg",
      ),
      WebImage(
        id: '2',
        author: 'Jane Smith',
        download_url: 'url2',
        width: 400,
        height: 400,
        url: "https://example.com/image2.jpg",
      ),
      // Add more WebImage instances as needed
    ];

    await tester.pumpWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        child: MyApp(webImages: webImages),
      ),
    );

    // Verify if the first image card is displayed
    expect(find.text("John Doe"), findsOneWidget);
    expect(find.byType(Image), findsOneWidget);

    // Find the next arrow button by the ">" text
    final nextArrowFinder = find.text(">");

    // Tap the next arrow button
    await tester.tap(nextArrowFinder);
    await tester.pumpAndSettle();

    // Verify if the next image card is displayed
    expect(find.text("Jane Smith"), findsOneWidget);
    })
}