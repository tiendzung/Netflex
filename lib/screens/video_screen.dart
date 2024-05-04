import 'dart:async';

import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';
import 'package:wakelock/wakelock.dart';

import '../widgets/widgets.dart';

class VideoApp extends StatefulWidget {
  const VideoApp({
    Key? key,
    required this.movieUrl,
  }) : super(key: key);

  final String movieUrl;

  @override
  _VideoAppState createState() => _VideoAppState();
}

class _VideoAppState extends State<VideoApp> {
  late VideoPlayerController _controller;
  bool visible = true;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.movieUrl)
      ..addListener(() => setState(() {}))
      ..initialize().then((_) {
        _controller.play();
        setTime();
      });

    setLandscape();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: visible && _controller.value.isInitialized
          ? AppBar(
              centerTitle: true,
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: BackButton(
                color: Colors.white,
                onPressed: () {
                  _controller.pause();
                  Navigator.pop(context);
                },
              ),
              title: const Text(
                'Movie',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            )
          : PreferredSize(
              child: Container(),
              preferredSize: const Size(0, 0),
            ),
      body: Center(
        child: _controller.value.isInitialized
            ? buildVideo()
            : SizedBox(
                height: 200,
                width: 200,
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: const [
                      CircularProgressIndicator(
                        color: Color.fromARGB(255, 255, 0, 0),
                      ),
                      Text(
                        'Loading...',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  Widget buildVideo() {
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: [],
    );
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        // print("Tap tap tap tap");
        setVisiable();
      },
      child: Stack(
        children: <Widget>[
          SizedBox.expand(
            child: FittedBox(
              fit: BoxFit.contain,
              child: SizedBox(
                width: _controller.value.size.width,
                height: _controller.value.size.height,
                child: VideoPlayer(_controller),
              ),
            ),
          ),
          Positioned.fill(
            child: visible
                ? VideoOverlayWidget(
                    controller: _controller,
                  )
                : Container(),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    setAllOrientation();
    timer?.cancel();
    super.dispose();
  }

  Future setLandscape() async {
    await SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: [],
    );
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    await Wakelock.enable();
  }

  Future setAllOrientation() async {
    await SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: [
        SystemUiOverlay.top,
        SystemUiOverlay.bottom,
      ],
    );
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    await Wakelock.disable();
  }

  setVisiable() {
    setState(() {
      visible = !visible;
    });

    setTime();
  }

  void setTime() {
    if (visible) {
      timer?.cancel();
      timer = Timer.periodic(const Duration(seconds: 5), (Timer t) async {
        if (mounted) {
          setState(() {
            visible = false;
          });
        }
      });
    }
  }
}
