import 'package:flutter/material.dart';
import 'package:flutter_app_gallery/network/endpoints.dart';
import 'package:flutter_app_gallery/network/imageService.dart';
import 'package:flutter_app_gallery/widgets/imageCard.dart';
import 'package:flutter_app_gallery/models/webimage.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'My Gallery App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  EndPoints endPoints = EndPoints();
  List<WebImage> webImages = [];

  @override
  void initState() {
    super.initState();
    _fetchWebImages();
  }

  Future<void> _fetchWebImages() async {
    try {
      List<WebImage> images = await ImageWebService(http.Client()).fetchListOfWebImages();
      setState(() {
        webImages = images;
      });
    } catch (e) {
      // Handle errors
      print("Error fetching web images: $e");
    }
  }

   PageController _pageController = PageController(initialPage: 0);

  void _previousImage() {
    _pageController.previousPage(
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _nextImage() {
    _pageController.nextPage(
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: webImages.length,
              itemBuilder: (context, index) {
                return Center(
                  child: SizedBox(
                    height: 400,
                    child: ImageCard(
                      authorName: webImages[index].author,
                      imageUrl: webImages[index].download_url,
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            color: Colors.grey.shade900,
            padding: EdgeInsets.symmetric(horizontal: 90.0), // Adjust the padding here
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Text(
                    "<",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 40.0,
                    ),
                  ),
                  onPressed: _previousImage,
                ),
                IconButton(
                  icon: Text(
                    ">",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 40.0,
                    ),
                  ),
                  onPressed: _nextImage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}