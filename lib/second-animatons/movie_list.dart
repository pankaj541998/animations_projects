import 'package:first_projects/second-animatons/data.dart';
import 'package:flutter/material.dart';

import 'movies_list_view.dart';

class MovieListAnimation extends StatefulWidget {
  const MovieListAnimation({super.key});

  @override
  State<MovieListAnimation> createState() => _MovieListAnimationState();
}

class _MovieListAnimationState extends State<MovieListAnimation> {
  final ScrollController _scrollController1 = ScrollController();
  final ScrollController _scrollController2 = ScrollController();
  final ScrollController _scrollController3 = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      double minScrollExtent1 = _scrollController1.position.minScrollExtent;
      double maxScrollExtent1 = _scrollController1.position.maxScrollExtent;

      double minScrollExtent2 = _scrollController2.position.minScrollExtent;
      double maxScrollExtent2 = _scrollController2.position.maxScrollExtent;

      double minScrollExtent3 = _scrollController3.position.minScrollExtent;
      double maxScrollExtent3 = _scrollController3.position.maxScrollExtent;

      animateToMaxMin(maxScrollExtent1, minScrollExtent1, 25, maxScrollExtent1,_scrollController1);
      animateToMaxMin(maxScrollExtent2, minScrollExtent2, 15, maxScrollExtent2,_scrollController2);
      animateToMaxMin(maxScrollExtent3, minScrollExtent3, 20, maxScrollExtent3,_scrollController3);
    });
  }

  animateToMaxMin(double min, double max, int seconds, double direction,
      ScrollController scrollController) {
    scrollController
        .animateTo(direction,
            duration: Duration(seconds: seconds), curve: Curves.linear)
        .then((value) {
      direction = direction == max ? min : max;
      animateToMaxMin(min, max, seconds, direction, scrollController);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            MovieAnimation(
              scrollController: _scrollController1,
              images: movies1,
            ),
            MovieAnimation(
              scrollController: _scrollController2,
              images: movies2,
            ),
            MovieAnimation(
              scrollController: _scrollController3,
              images: movies3,
            ),
          ],
        ),
      ),
    );
  }
}
