import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:vinyl/top_app_bar.dart';

import 'bottom_nav.dart';
import 'cover.dart';
import 'cover_detail.dart';
import 'cover_list.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final duration = const Duration(milliseconds: 500);

  late PageController _pageController;

  final currentIndexNotifier = ValueNotifier<double>(0.0);
  final isNavigate = ValueNotifier<bool>(false);

  double itemPosition = 200;
  double coverHeight = 200;

  listener() {
    currentIndexNotifier.value = _pageController.page!;
  }

  @override
  void initState() {
    _pageController = PageController(viewportFraction: .7);
    _pageController.addListener(listener);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.removeListener(listener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _pageController.jumpToPage(((covers.length - 1) / 2).floor());
    });
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: ValueListenableBuilder<bool>(
          valueListenable: isNavigate,
          builder: (context, value, _) {
            return SafeArea(
              child: Stack(
                children: [
                  ListView(
                    children: [
                      const SizedBox(
                        height: kToolbarHeight + 40,
                      ),
                      // Cover disque--------------------------------
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 20,
                            child: Stack(
                              children: [
                                AnimatedPositioned(
                                  duration: duration,
                                  left: value ? -itemPosition : 0,
                                  child: const Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10.0),
                                    child: Text(
                                      "NEW ARRIVALS",
                                      style: TextStyle(
                                          color: Colors.black87,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 18),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                              height: size.height * .4,
                              child: CoverList(
                                  size: size,
                                  pageController: _pageController,
                                  duration: duration,
                                  isNavigate: isNavigate,
                                  currentIndexNotifier: currentIndexNotifier)),
                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            height: size.height * .1,
                            child: Stack(
                              children: [
                                AnimatedPositioned(
                                  duration: duration,
                                  left: value ? -itemPosition : 0,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: const [
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10.0),
                                        child: FittedBox(
                                          child: Text(
                                            "FLORENCE AND THE MACHINE",
                                            style: TextStyle(
                                                color: Colors.black87,
                                                fontWeight: FontWeight.w300,
                                                fontSize: 16),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10.0),
                                        child: FittedBox(
                                          child: Text(
                                            "Ceremonials",
                                            style: TextStyle(
                                                color: Colors.black87,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 30),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          //  Covers List
                          SizedBox(
                            height: size.height * .4,
                            width: size.width,
                            child:
                                LayoutBuilder(builder: (context, constraints) {
                              final height = constraints.maxHeight;

                              return Stack(
                                children: [
                                  AnimatedPositioned(
                                    duration: duration,
                                    left: value
                                        ? -itemPosition
                                        : (size.width / 2) - (coverHeight / 2),
                                    top: height / 4,
                                    child: Center(
                                      child: Stack(
                                        children: List.generate(
                                          covers.length,
                                          (index) {
                                            final cover = covers[index];
                                            final percent =
                                                index / covers.length;
                                            final position =
                                                (height - coverHeight) *
                                                    percent;
                                            return Transform(
                                              transform: Matrix4.identity()
                                                ..translate(
                                                    -position, -position, .0),
                                              alignment: Alignment.center,
                                              child: Center(
                                                child: Image.asset(
                                                  cover.img,
                                                  height: coverHeight,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            }),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: kBottomNavigationBarHeight + 40,
                      ),
                    ],
                  ),
                  // AppBar ----------------------------------------------------------------
                  TopAppBar(
                    duration: duration,
                    left: value ? -itemPosition : 10,
                  ),
                  // Bottom Navigation ----------------------------------------------------------------
                  BottomNav(
                    duration: duration,
                    bottom: value ? -itemPosition : 0,
                  ),
                ],
              ),
            );
          }),
    );
  }
}
