import 'package:flutter/material.dart';

import '../songs.dart';

class SongsContainer extends StatelessWidget {
  final Songs? songs;
  final double? leftMargin;
  final double? topMargin;
  final double? imgSize;
  final bool? isCompleted;

  const SongsContainer({
    super.key,
    this.songs,
    this.leftMargin,
    this.topMargin,
    this.isCompleted,
    this.imgSize,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: topMargin,
      left: leftMargin,
      right: 0,
      child: Row(
        children: [
          SizedBox(
            height: imgSize,
            width: imgSize,
            child: Image.asset(
              songs!.image,
              fit: BoxFit.cover,
              width: 100,
              height: 100,
            ),
          ),
          Expanded(
            child: isCompleted!
                ? Container(
                    color: Colors.transparent,
                    padding: const EdgeInsets.only(left: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          songs!.title,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 22),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          songs!.year,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 22),
                        ),
                      ],
                    ),
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}
