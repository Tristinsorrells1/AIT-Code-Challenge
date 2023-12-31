import 'package:flutter/material.dart';
import 'package:flutter_app_gallery/network/imageService.dart';
import 'package:flutter_app_gallery/widgets/imageCard.dart';
import 'package:flutter_app_gallery/models/webimage.dart';
import 'package:http/http.dart' as http;


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          titleTextStyle: const TextStyle(
            color: Colors.white,
          ),
        ),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Gallery App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<WebImage> webImages = [];
  final ImageWebService imageWebService = ImageWebService(http.Client());

  @override
  void initState() {
    super.initState();
    _fetchWebImages();
  }

  Future<void> _fetchWebImages() async {
    try {
      List<WebImage> images = await imageWebService.fetchListOfWebImages();
      setState(() {
        webImages = images;
      });
    } catch (e) {
      print("Error fetching web images: $e");
    }
  }

  PageController _pageController = PageController(initialPage: 0);

  void _previousImage() {
    _pageController.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _nextImage() {
    _pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF4240B1),
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
            padding: const EdgeInsets.symmetric(
                horizontal: 90.0), 
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Text(
                    "<",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 40.0,
                    ),
                  ),
                  onPressed: _previousImage,
                ),
                IconButton(
                  icon: const Text(
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
