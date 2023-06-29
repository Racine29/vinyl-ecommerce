import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

import 'cover.dart';
import 'cover_desc.dart';

class CoverDetail extends StatefulWidget {
  CoverDetail({super.key, required this.tag, required this.cover});
  final String tag;
  final Cover cover;

  @override
  State<CoverDetail> createState() => _CoverDetailState();
}

class _CoverDetailState extends State<CoverDetail>
    with TickerProviderStateMixin {
  final enterScreenAnimationNotifier = ValueNotifier<bool>(false);

  final descAnimationNotifier = ValueNotifier<bool>(false);
  final coverOutAnimationNotifier = ValueNotifier<bool>(false);

  late AnimationController _animationController;
  late Animation<double> disqueOutAnimation;
  late Animation<double> coverOutAnimation;

  animateDescNotifier() async {
    await Future.delayed(const Duration(milliseconds: 500));
    descAnimationNotifier.value = true;
  }

  @override
  void initState() {
    animateDescNotifier();
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 800));
    disqueOutAnimation = CurvedAnimation(
        parent: _animationController,
        curve: Interval(0.0, 1.0, curve: Curves.fastOutSlowIn));
    coverOutAnimation = CurvedAnimation(
        parent: _animationController,
        curve: Interval(0.1, 1.0, curve: Curves.fastOutSlowIn));

    super.initState();
  }

  animated() {
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  double animateBackButton(bool value) {
    if (value) {
      if (_animationController.value > .8) {
        return -150;
      }
      return 0;
    }
    return 100;
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      enterScreenAnimationNotifier.value = true;
    });
    final size = MediaQuery.of(context).size;
    double coverImageHeight = size.height * .5;
    int secondCoverIndex = int.parse(widget.tag) + 1;
    final secondCover = covers.length == secondCoverIndex;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  height: kToolbarHeight,
                  color: Colors.transparent,
                  child: Stack(
                    children: [
                      AnimatedBuilder(
                          animation: _animationController,
                          builder: (context, _) {
                            return ValueListenableBuilder(
                                valueListenable: enterScreenAnimationNotifier,
                                builder: (context, value, _) {
                                  int milliseconds = 280;
                                  return AnimatedPositioned(
                                    left: animateBackButton(value),
                                    duration:
                                        Duration(milliseconds: milliseconds),
                                    child: AnimatedOpacity(
                                      duration:
                                          Duration(milliseconds: milliseconds),
                                      opacity: value ? 1.0 : 0.0,
                                      child: Row(
                                        // crossAxisAlignment: CrossAxisAlignment.start,
                                        children: const [
                                          BackButton(),
                                          Text(
                                            "Vinyls",
                                            style: TextStyle(
                                              // fontWeight: FontWeight.w300,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                });
                          }),
                      const Positioned(
                        right: 10,
                        top: kToolbarHeight / 2 - (14),
                        child: CircleAvatar(
                          maxRadius: 14,
                          backgroundColor: Colors.white,
                          child: Icon(
                            Icons.favorite,
                            size: 18,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: size.height * .52,
                  width: size.width,
                  child: Stack(
                    children: [
                      // Second cover ----------------------------------------------------------------

                      if (secondCover == false) ...{
                        Positioned(
                          bottom:
                              (size.height * .65 / 2) - (coverImageHeight / 2),
                          right: -coverImageHeight * 2,
                          child: Hero(
                            tag: "disque-$secondCoverIndex",
                            child: Image.asset(
                              covers[secondCoverIndex].vinyl,
                              height: coverImageHeight,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom:
                              (size.height * .65 / 2) - (coverImageHeight / 2),
                          right: -coverImageHeight,
                          child: Hero(
                            tag: "cover-$secondCoverIndex",
                            child: Image.asset(
                              covers[secondCoverIndex].img,
                              height: coverImageHeight / 2,
                            ),
                          ),
                        ),
                      },

                      //Fin  Second cover ----------------------------------------------------------------

                      // Principal cover ----------------------------------------------------------------

                      AnimatedBuilder(
                          animation: _animationController,
                          builder: (context, _) {
                            final disqueOutValue = disqueOutAnimation.value;
                            final coverOutValue = coverOutAnimation.value;
                            return Stack(
                              children: [
                                Positioned(
                                  bottom: 0,
                                  left: lerpDouble(
                                      -20, -size.width, disqueOutValue),
                                  child: Hero(
                                    tag: "disque-${widget.tag}",
                                    child: Transform.rotate(
                                      angle: pi,
                                      child: Image.asset(
                                        widget.cover.vinyl,
                                        height: coverImageHeight,
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  left: lerpDouble(-coverImageHeight / 2,
                                      -size.width, coverOutValue),
                                  child: Hero(
                                    tag: "cover-${widget.tag}",
                                    child: Image.asset(
                                      widget.cover.img,
                                      height: coverImageHeight,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }),
                    ],
                  ),
                ),
              ],
            ),

            // Desc ----------------------------------------------------------------
            CoverDesc(
              cover: widget.cover,
              size: size,
              descAnimationNotifier: descAnimationNotifier,
              onTap: animated,
              AnimationValue: _animationController,
            ),

            ValueListenableBuilder<bool>(
                valueListenable: descAnimationNotifier,
                builder: (context, value, _) {
                  return AnimatedPositioned(
                    duration: const Duration(milliseconds: 220),
                    curve: Curves.easeInOut,
                    bottom: value ? 20 : -20,
                    left: 0,
                    right: 0,
                    child: AnimatedBuilder(
                        animation: _animationController,
                        builder: (context, _) {
                          return Opacity(
                            opacity:
                                lerpDouble(1, 0, _animationController.value)!,
                            child: InkWell(
                              onTap: animated,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: const [
                                  Text(
                                    "MORE",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w300,
                                      fontSize: 16,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 2,
                                  ),
                                  Icon(
                                    Icons.keyboard_arrow_down,
                                    color: Colors.grey,
                                    size: 16,
                                  )
                                ],
                              ),
                            ),
                          );
                        }),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
