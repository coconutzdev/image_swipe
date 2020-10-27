library image_swipe;

import 'package:flutter/material.dart';
import 'package:image_swipe/card_scroll_widget.dart';

typedef OnClickItem = void Function(BuildContext context, int index, String image, String title);
typedef ImageSwipeItemBuilder = Widget Function(BuildContext context, BoxConstraints constraints, int index, String image, String title);

class ImageSwipe extends StatefulWidget{
  List<String> images;
  List<String> titles;
  bool reverseImages;
  OnClickItem onClickItem;
  ImageSwipeItemBuilder builder;

  ImageSwipe({@required this.images, this.reverseImages = true, this.titles, this.onClickItem, this.builder});

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
          currentPage: currentPage,
          images: widget.reverseImages ? widget.images.reversed.toList() : widget.images,
          titles: widget.titles ?? [],
          cardAspectRatio: 12.0 / 16.0,
          aspectRatio: (12.0 / 16.0) * 1.2,
          builder: widget.builder,
        ),
        Positioned.fill(
          child: PageView.builder(
            itemCount: widget.images.length,
            controller: pageController,
            reverse: true,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: (){
                  if(widget.onClickItem!=null){
                    widget.onClickItem(context, index, widget.images[index], widget.titles[index]);
                  }
                },
                child: Container(
                  color: Colors.transparent,
                )
              );
            },
          ),
        )
      ],
    );
  }
}
