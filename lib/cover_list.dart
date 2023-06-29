import 'dart:ui';

import 'package:flutter/material.dart';

import 'cover.dart';
import 'cover_detail.dart';

class CoverList extends StatelessWidget {
  final Size size;

  final PageController pageController;

  final Duration duration;
  final ValueNotifier<bool> isNavigate;
  final ValueNotifier<double> currentIndexNotifier;

  CoverList({
    super.key,
    required this.size,
    required this.pageController,
    required this.duration,
    required this.isNavigate,
    required this.currentIndexNotifier,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<double>(
        valueListenable: currentIndexNotifier,
        builder: (context, value, _) {
          return Center(
            child: PageView.builder(
                itemCount: covers.length,
                controller: pageController,
                itemBuilder: (_, index) {
                  final inverted = index - 1;
                  final indexPlus = index + 1;
                  final percent = value - index;
                  final factorChanged = percent.abs();
                  final cover = covers[index];

                  return Center(
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 0),
                      height: lerpDouble(size.height * .4, 200, factorChanged),
                      child: GestureDetector(
                        onTap: () async {
                          isNavigate.value = true;
                          await Navigator.of(context).push(PageRouteBuilder(
                              transitionDuration: duration,
                              reverseTransitionDuration: duration,
                              pageBuilder: (context, anim, _) {
                                return FadeTransition(
                                  opacity: anim,
                                  child: CoverDetail(
                                    tag: "$index",
                                    cover: cover,
                                  ),
                                );
                              }));
                          isNavigate.value = false;
                        },
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            Positioned(
                              left: null,
                              child: Hero(
                                  tag: "disque-$index",
                                  child: Transform.rotate(
                                    angle: 0.0,
                                    child: Image.asset(cover.vinyl),
                                  )),
                            ),
                            Positioned(
                              left: null,
                              child: Hero(
                                tag: "cover-$index",
                                child: Image.asset(
                                  cover.img,
                                  height: size.height,
                                  width: size.width,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
          );
        });
  }
}
