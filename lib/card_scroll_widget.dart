import 'dart:math';

import 'package:flutter/material.dart';
import 'package:image_swipe/image_swipe.dart';

class CardScrollWidget extends StatelessWidget {
  var currentPage;
  var padding = 20.0;
  var verticalInset = 20.0;
  double aspectRatio = (12.0 / 16.0) * 1.2;
  double cardAspectRatio = 12.0 / 16.0;
  List<String> images = [];
  List<String> titles = [];
  ImageSwipeItemBuilder builder;

  CardScrollWidget({@required this.currentPage, @required this.images,  this.titles, this.cardAspectRatio, this.aspectRatio, this.builder})
      :
        assert(currentPage!=null),
        assert(images.isNotEmpty),
        assert(titles.length > 0 ? titles.length == images.length : true)
  ;

  @override
  Widget build(BuildContext context) {
    return new AspectRatio(
      aspectRatio: aspectRatio,
      child: LayoutBuilder(builder: (context, contraints) {
        var width = contraints.maxWidth;
        var height = contraints.maxHeight;

        var safeWidth = width - 2 * padding;
        var safeHeight = height - 2 * padding;

        var heightOfPrimaryCard = safeHeight;
        var widthOfPrimaryCard = heightOfPrimaryCard * cardAspectRatio;

        var primaryCardLeft = safeWidth - widthOfPrimaryCard;
        var horizontalInset = primaryCardLeft / 2;

        List<Widget> cardList = new List();

        for (var i = 0; i < images.length; i++) {
          var delta = i - currentPage;
          bool isOnRight = delta > 0;

          var start = padding + max(primaryCardLeft - horizontalInset * -delta * (isOnRight ? 15 : 1), 0.0);
          var cardItem = Positioned.directional(
            top: padding + verticalInset * max(-delta, 0.0),
            bottom: padding + verticalInset * max(-delta, 0.0),
            start: start,
            textDirection: TextDirection.rtl,
            child: builder != null ?
              AspectRatio(
                  aspectRatio: cardAspectRatio,
                  child: builder(context, contraints, i, images[i], titles[i]) ,
              ) :
              ClipRRect(
              borderRadius: BorderRadius.circular(16.0),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          offset: Offset(3.0, 6.0),
                          blurRadius: 10.0
                      )
                    ]
                ),
                child: AspectRatio(
                  aspectRatio: cardAspectRatio,
                  child: Stack(
                    fit: StackFit.expand,
                    children: <Widget>[
                      Image.asset(images[i], fit: BoxFit.cover),
                      titles.length > 0 ?
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 8.0),
                          child: Text(
                              titles[i],
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 25.0,
                              )),
                        ),
                      ) : SizedBox()
                    ],
                  ),
                ),
              ),
            )
            ,
          );
          cardList.add(cardItem);
        }

        return Stack(
          children: cardList,
        );
      }),
    );
  }
}
