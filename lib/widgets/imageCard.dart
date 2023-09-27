import 'dart:io';

import 'package:flutter/material.dart';

class ImageCard extends StatelessWidget {
  final String authorName;
  final String imageUrl;

  const ImageCard({required this.authorName, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            color: Color(0xFFDBD6FF), 
            height: 55,
            child: Center(
              child: Text(
                authorName,
                style: TextStyle(
                  color: Colors.grey.shade900, 
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold, 
                ),
              ),
            ),
          ),
          Expanded(
            child: Image.network(
              imageUrl,
              fit: BoxFit.fill,  
            ),
          ),
        ],
      ),
    );
  }
}