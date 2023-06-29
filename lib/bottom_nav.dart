import 'package:flutter/material.dart';

class BottomNav extends StatelessWidget {
  final Duration duration;
  final double bottom;
  BottomNav({super.key, required this.duration, required this.bottom});

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      bottom: bottom,
      left: 0,
      right: 0,
      duration: duration,
      child: BottomNavigationBar(
          backgroundColor: Color(0xffE9E4E1),
          currentIndex: 2,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.music_video_outlined,
                  color: Colors.grey.shade400,
                ),
                label: ""),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.library_music_rounded,
                  color: Colors.grey.shade400,
                ),
                label: ""),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.music_note_rounded,
                  color: Colors.grey.shade400,
                ),
                activeIcon: Icon(
                  Icons.music_note_rounded,
                  color: Colors.red,
                ),
                label: ""),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.favorite,
                  color: Colors.grey.shade400,
                ),
                label: ""),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.shopping_cart,
                  color: Colors.grey.shade400,
                ),
                label: ""),
          ]),
    );
  }
}
