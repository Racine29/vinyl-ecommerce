import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';
// import 'package:flutter_cube/flutter_cube.dart';
import 'package:vinyl/turntable.dart';

class CoverDisqueTurnTable extends StatefulWidget {
  const CoverDisqueTurnTable(
      {super.key, required this.turntable, required this.tag});
  final Turntable turntable;
  final String tag;

  @override
  State<CoverDisqueTurnTable> createState() => _CoverDisqueTurnTableState();
}

class _CoverDisqueTurnTableState extends State<CoverDisqueTurnTable> {
  Offset _offset = Offset.zero;

  // late Object img;
  late ModelViewer modelViewer;
  @override
  void initState() {
    // img = Object(fileName: "asset/test/turntable.obj");
    modelViewer = ModelViewer(
      src: "asset/turntable.glb",
      // autoRotate: true,
      autoPlay: true,
      disableZoom: true,
    );
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (details) {
        setState(() {
          _offset += details.delta;
        });
      },
      child: Scaffold(
        body: Column(
          // fit: StackFit.expand,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * .6,
              child: modelViewer,
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "EXCLUSIVE",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Offstage(
                offstage: false,
                child: Hero(
                  tag: "turnable-title-${widget.tag}",
                  child: Material(
                    color: Colors.transparent,
                    child: Text(
                      widget.turntable.name,
                      style: const TextStyle(
                          fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
