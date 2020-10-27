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
        titles: [
          'Sample Title 01',
          'Sample Title 02',
          'Sample Title 03',
          'Sample Title 04'
        ],
        reverseImages: false,
        onClickItem: (context, index, image, title){
          Scaffold.of(context).showSnackBar(new SnackBar(content: Text('Index : ${index} \nImage : ${image} \nTitle : ${title}')));
        },
        builder: (context, constrains, index, image, title){
          return Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(image, fit: BoxFit.cover),
              Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  child: Text(
                      title,
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 25.0,
                      )),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}

