import 'package:flutter/material.dart';

class TopAppBar extends StatelessWidget {
  const TopAppBar({super.key, required this.duration, required this.left});
  final Duration duration;
  final double left;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: MediaQuery.of(context).padding,
      height: kToolbarHeight,
      color: const Color(0xffE9E4E1),
      child: Stack(
        children: [
          AnimatedPositioned(
            left: left,
            duration: duration,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "THURSDAY, JULY 10",
                  style: TextStyle(
                    fontWeight: FontWeight.w300,
                  ),
                ),
                Text(
                  "Feed",
                  style: TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                      fontSize: 40),
                ),
              ],
            ),
          ),
          Positioned(
            right: 10,
            top: kToolbarHeight / 2 - 14,
            child: CircleAvatar(
              maxRadius: 14,
              backgroundColor: Colors.transparent,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(1000),
                  child: Image.asset("asset/profil.png")),
            ),
          ),
        ],
      ),
    );
  }
}
