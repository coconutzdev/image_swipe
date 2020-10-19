library image_swipe;

import 'package:flutter/material.dart';
import 'package:image_swipe/card_scroll_widget.dart';

class ImageSwipe extends StatefulWidget{
  List<String> images;
  bool reverseImages;

  ImageSwipe({@required this.images, this.reverseImages = true});

  @override
  _ImageSwipeState createState() => _ImageSwipeState();
}

class _ImageSwipeState extends State<ImageSwipe> {
  double currentPage;
  PageController pageController;

  _ImageSwipeState();

  @override
  void initState() {
    super.initState();
    currentPage = widget.images.length - 1.0;
    pageController = PageController(initialPage: widget.images.length - 1);
    pageController.addListener(() {
      setState(() {
        currentPage = pageController.page;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        CardScrollWidget(
            currentPage,
            widget.reverseImages ? widget.images.reversed.toList() : widget.images,
            12.0 / 16.0,
            (12.0 / 16.0) * 1.2
        ),
        Positioned.fill(
          child: PageView.builder(
            itemCount: widget.images.length,
            controller: pageController,
            reverse: true,
            itemBuilder: (context, index) {
              return Container();
            },
          ),
        )
      ],
    );
  }
}
