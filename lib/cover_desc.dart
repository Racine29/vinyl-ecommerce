import 'dart:math';

import 'package:flutter/material.dart';
import 'package:vinyl/turntable.dart';

import 'cover.dart';
import 'cover_disque_turntable.dart';

class CoverDesc extends StatelessWidget {
  CoverDesc({
    super.key,
    required this.cover,
    required this.size,
    required this.descAnimationNotifier,
    required this.onTap,
    required this.AnimationValue,
  });
  final Size size;
  final Cover cover;
  final ValueNotifier<bool> descAnimationNotifier;
  final VoidCallback onTap;

  final Animation AnimationValue;

  Widget labelSection(String label, String titre) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Row(
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 16,
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Text(
            titre,
            style: const TextStyle(
              color: Color.fromARGB(221, 29, 21, 9),
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  double bottomAnimation(bool value, double AnimationValue) {
    if (value) {
      if (AnimationValue > .5) {
        return -20.0;
      }
      return -size.height * .6 - (kToolbarHeight);
    }
    return -size.height * .62 - (kToolbarHeight);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: AnimationValue,
        builder: (context, _) {
          return ValueListenableBuilder<bool>(
              valueListenable: descAnimationNotifier,
              builder: (context, value, _) {
                int milliseconds = 280;
                return AnimatedPositioned(
                  duration: Duration(
                      milliseconds:
                          AnimationValue.value > .5 ? 600 : milliseconds),
                  curve: Curves.easeInOut,
                  bottom: bottomAnimation(value, AnimationValue.value),
                  child: AnimatedOpacity(
                    duration: Duration(milliseconds: milliseconds),
                    opacity: value ? 1.0 : 0.0,
                    child: Container(
                      width: size.width,
                      height: size.height - kToolbarHeight / 2,
                      child: ListView(
                        children: [
                          SizedBox(
                            height: AnimationValue.value * 20,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 12.0),
                            child: Container(
                              // color: Colors.amber,
                              height: AnimationValue.value != 0
                                  ? null
                                  : size.height * .16,
                              width: size.width,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Text(
                                    cover.name,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w300,
                                      fontSize: 20,
                                    ),
                                  ),
                                  Text(
                                    cover.name,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 35,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          if (AnimationValue.value > .5) ...{
                            Container(
                              height: size.height * .35,
                              child: Stack(
                                children: [
                                  AnimatedPositioned(
                                    duration: const Duration(milliseconds: 400),
                                    top: AnimationValue.value > .7 ? 0 : 180,
                                    left: 0,
                                    right: 0,
                                    child: AnimatedOpacity(
                                      opacity:
                                          AnimationValue.value > .7 ? 1 : 0,
                                      duration: Duration(milliseconds: 600),
                                      child: Column(
                                        children: [
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 12.0),
                                            child: Text(
                                              cover.description,
                                              style: const TextStyle(
                                                color: Colors.grey,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 40,
                                          ),
                                          labelSection("Label:", cover.label),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          labelSection(
                                              "Country:", cover.country),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          labelSection("Genre:", cover.genre),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          },
                          SizedBox(
                            height: size.height * .02,
                          ),
                          if (AnimationValue.value > 0.7) ...{
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 400),
                              height: AnimationValue.value == 1
                                  ? size.height * .25
                                  : size.height * .6,
                              width: size.width,
                              child: Stack(
                                children: [
                                  AnimatedPositioned(
                                    duration: const Duration(milliseconds: 500),
                                    top: AnimationValue.value > .8
                                        ? 0
                                        : size.height * .6,
                                    left: 0,
                                    right: 0,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 12.0),
                                          child: Text(
                                            "IT'S BEST TO SOUND ON",
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: size.height * .02,
                                        ),
                                        SizedBox(
                                          height: (size.height * .25) / 1.2,
                                          child: PageView.builder(
                                              itemCount: turntables.length,
                                              padEnds: false,
                                              controller: PageController(
                                                  viewportFraction: .4),
                                              itemBuilder: (context, index) {
                                                final turntable =
                                                    turntables[index];
                                                return GestureDetector(
                                                  onTap: () async {
                                                    Navigator.of(context).push(
                                                        PageRouteBuilder(
                                                            transitionDuration:
                                                                const Duration(
                                                                    milliseconds:
                                                                        600),
                                                            reverseTransitionDuration:
                                                                const Duration(
                                                                    milliseconds:
                                                                        600),
                                                            pageBuilder:
                                                                (context, anim,
                                                                    _) {
                                                              return FadeTransition(
                                                                opacity: anim,
                                                                child:
                                                                    CoverDisqueTurnTable(
                                                                  turntable:
                                                                      turntable,
                                                                  tag: "$index",
                                                                ),
                                                              );
                                                            }));
                                                  },
                                                  child: Container(
                                                    margin:
                                                        const EdgeInsets.all(
                                                            10),
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10),
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                    ),
                                                    child: Image.asset(
                                                      turntable.img,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                );
                                              }),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Stack(children: [
                              for (int index = 0;
                                  index < turntables.length;
                                  index++) ...{
                                Offstage(
                                  offstage: true,
                                  child: Hero(
                                    tag: "turnable-title-$index",
                                    child: Material(
                                      color: Colors.transparent,
                                      child: Text(
                                        turntables[index].name,
                                        style: const TextStyle(
                                            fontSize: 30,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                )
                              }
                            ]),
                            SizedBox(
                              height: size.height * .07,
                            ),
                            Container(
                              width: size.width,
                              margin: EdgeInsets.symmetric(horizontal: 12),
                              child: ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.all(18),
                                  backgroundColor:
                                      Color.fromARGB(255, 200, 149, 130),
                                ),
                                child: Text("\$${cover.price} - ADD TO CART"),
                              ),
                            ),
                          },
                        ],
                      ),
                    ),
                  ),
                );
              });
        });
  }
}
