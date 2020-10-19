import 'package:flutter/material.dart';
import 'package:image_swipe/image_swipe.dart';

class SampleScreen extends StatefulWidget{
  @override
  _SampleScreenState createState() => _SampleScreenState();
}

class _SampleScreenState extends State<SampleScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TesScreen'),
      ),
      body: ImageSwipe(
        images: [
          'assets/sample_01.jpg',
          'assets/sample_02.jpg',
          'assets/sample_03.jpg',
          'assets/sample_04.jpg',
        ],
      ),
    );
  }
}

