import 'package:flutter/material.dart';
import "dart:math" as math;
import "dart:ui" as ui;

import "../songs.dart";
import "song_container.dart";

class BottomSheetTransition extends StatefulWidget {
  const BottomSheetTransition({super.key});

  @override
  State<BottomSheetTransition> createState() => _BottomSheetTransitionState();
}

class _BottomSheetTransitionState extends State<BottomSheetTransition>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  double get maxheight => MediaQuery.of(context).size.height - 40;
  double songImgStartSize = 45;
  double songImgEndSize = 120;
  double songVerticalSpace = 25;
  double songHorizontalSpace = 15;
  lerp(double min, double max) {
    return ui.lerpDouble(min, max, _controller.value);
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  void toggle() {
    final bool isCompleted = _controller.status == AnimationStatus.completed;
    _controller.fling(velocity: isCompleted ? -1 : 1);
  }

  void verticalDragUpdate(DragUpdateDetails details) {
    _controller.value -= details.primaryDelta! / maxheight;
  }

  void verticalDragEnd(DragEndDetails details) {
    if (_controller.isAnimating ||
        _controller.status == AnimationStatus.completed) return;
    final double filingVelocity = details.velocity.pixelsPerSecond.dy / maxheight;

    if (filingVelocity < 0) {
      _controller.fling(velocity: math.max(1, -filingVelocity));
    } else if (filingVelocity > 0) {
      _controller.fling(velocity: math.min(-1, -filingVelocity));
    } else {
      _controller.fling(velocity: _controller.value < 0.5 ? -1 : 1);
    }
  }

  songTopMargin(int index) {
    return lerp(20, 10 + index * (songVerticalSpace + songImgEndSize));
  }

  songLeftMargin(int index) {
    return lerp(index * (songHorizontalSpace + songImgStartSize), 0);
  }

  Widget buildSongsContainer(Songs song) {
    int index = songs.indexOf(song);
    return SongsContainer(
      songs: song,
      imgSize: lerp(songImgStartSize, songImgEndSize),
      topMargin: songTopMargin(index),
      leftMargin: songLeftMargin(index),
      isCompleted: _controller.status == AnimationStatus.completed,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          height: lerp(120, maxheight),
          child: GestureDetector(
            onTap: toggle,
            onVerticalDragUpdate: verticalDragUpdate,
            onVerticalDragEnd: verticalDragEnd,
            child: Container(
              decoration: const BoxDecoration(
                color: Color(0xff920921),
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(30),
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Stack(
                children: [
                  Positioned(
                    left: 0,
                    right: 0,
                    top: lerp(20, 40),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Popular songs",
                          style: TextStyle(
                            fontSize: lerp(15, 20),
                          ),
                        ),
                        Icon(
                          _controller.status == AnimationStatus.completed
                              ? Icons.keyboard_arrow_down_outlined
                              : Icons.keyboard_arrow_up_outlined,
                          size: lerp(20, 40),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: lerp(35, 80),
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: SingleChildScrollView(
                      scrollDirection:
                          _controller.status == AnimationStatus.completed
                              ? Axis.vertical
                              : Axis.horizontal,
                      physics: const BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics(),
                      ),
                      child: SizedBox(
                        height:(songImgEndSize + songVerticalSpace) * songs.length,
                        width: (songImgStartSize + songHorizontalSpace) *songs.length,
                        child: Stack(
                          children: [
                            for (Songs song in songs) buildSongsContainer(song),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
