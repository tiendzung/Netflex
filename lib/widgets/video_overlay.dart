import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoOverlayWidget extends StatefulWidget {
  const VideoOverlayWidget({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final VideoPlayerController controller;

  @override
  State<VideoOverlayWidget> createState() => _VideoOverlayWidgetState();
}

class _VideoOverlayWidgetState extends State<VideoOverlayWidget> {
  static const allSpeeds = <double>[0.25, 0.5, 1, 1.5];
  double _currentSpeed = 1;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        buildPlay(),
        Positioned(
          bottom: MediaQuery.of(context).size.height * 0.2,
          left: MediaQuery.of(context).size.width * 0.02,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              buildIndicator(widget.controller),
              SizedBox(width: MediaQuery.of(context).size.width * 0.02),
              Text(
                getPosition(widget.controller),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: MediaQuery.of(context).size.height * 0.025,
          left: 0,
          right: 0,
          child: someButton(widget.controller),
        ),
      ],
    );
  }

  Widget buildIndicator(VideoPlayerController controller) => SizedBox(
        height: MediaQuery.of(context).size.height * 0.03,
        width: MediaQuery.of(context).size.width * 0.9,
        child: Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).size.height * 0.009,
          ),
          child: VideoProgressIndicator(
            widget.controller,
            allowScrubbing: true,
            colors: const VideoProgressColors(
              playedColor: Color.fromARGB(255, 255, 0, 0),
            ),
          ),
        ),
      );

  Widget buildPlay() {
    return Container(
      alignment: Alignment.center,
      color: Colors.black26,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            width: 80,
            height: 80,
            child: GestureDetector(
              onTap: () => {
                widget.controller.seekTo(
                  widget.controller.value.position -
                      const Duration(seconds: 10),
                )
              },
              child: const Icon(
                Icons.replay_10,
                color: Colors.white,
                size: 50,
              ),
            ),
          ),
          SizedBox(
            width: 80,
            height: 80,
            child: GestureDetector(
              onTap: () => widget.controller.value.isPlaying
                  ? widget.controller.pause()
                  : widget.controller.play(),
              child: widget.controller.value.isPlaying
                  ? const Icon(Icons.pause, color: Colors.white, size: 70)
                  : const Icon(
                      Icons.play_arrow,
                      color: Colors.white,
                      size: 70,
                    ),
            ),
          ),
          SizedBox(
            width: 80,
            height: 80,
            child: GestureDetector(
              onTap: () => {
                widget.controller.seekTo(
                  widget.controller.value.position +
                      const Duration(seconds: 10),
                )
              },
              child: const Icon(
                Icons.forward_10,
                color: Colors.white,
                size: 50,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String getPosition(VideoPlayerController controller) {
    final duration = Duration(
        milliseconds: controller.value.position.inMilliseconds.round());

    return [duration.inMinutes, duration.inSeconds]
        .map((seg) => seg.remainder(60).toString().padLeft(2, '0'))
        .join(':');
  }

  someButton(VideoPlayerController controller) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.03,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton.icon(
              icon: const Icon(
                Icons.speed,
                size: 22,
                color: Colors.white,
              ),
              label: Text(
                'Speed (${_currentSpeed}x)',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
              onPressed: () {
                _showDialog(context);
                widget.controller.pause();
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.transparent,
                elevation: 0,
              ),
            ),
            ElevatedButton.icon(
              icon: const Icon(
                Icons.lock_open,
                size: 22,
                color: Colors.white,
              ),
              label: const Text(
                'Lock',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                primary: Colors.transparent,
                elevation: 0,
              ),
            ),
            // ElevatedButton.icon(
            //   icon: const Icon(
            //     Icons.movie,
            //     size: 22,
            //     color: Colors.white,
            //   ),
            //   label: const Text(
            //     'Episodes',
            //     style: TextStyle(
            //       color: Colors.white,
            //       fontSize: 12,
            //       fontWeight: FontWeight.w400,
            //     ),
            //   ),
            //   onPressed: () {},
            //   style: ElevatedButton.styleFrom(
            //     primary: Colors.transparent,
            //     elevation: 0,
            //   ),
            // ),
            ElevatedButton.icon(
              icon: const Icon(
                Icons.subtitles,
                size: 22,
                color: Colors.white,
              ),
              label: const Text(
                'Audio & Subtitles',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                primary: Colors.transparent,
                elevation: 0,
              ),
            ),
            // ElevatedButton.icon(
            //   icon: const Icon(
            //     Icons.skip_next,
            //     size: 32,
            //     color: Colors.white,
            //   ),
            //   label: const Text(
            //     'Next Ep.',
            //     style: TextStyle(
            //       color: Colors.white,
            //       fontSize: 12,
            //       fontWeight: FontWeight.w400,
            //     ),
            //   ),
            //   onPressed: () {},
            //   style: ElevatedButton.styleFrom(
            //     primary: Colors.transparent,
            //     elevation: 0,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          // title: const Text("Speed"),
          backgroundColor: Colors.black,
          content: SizedBox(
            height: 250,
            width: 300,
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: allSpeeds.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          widget.controller.setPlaybackSpeed(allSpeeds[index]);
                          _currentSpeed = allSpeeds[index];
                        });
                        Navigator.of(context).pop();
                        widget.controller.play();
                      },
                      child: Text('${allSpeeds[index]}x'),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.transparent,
                        elevation: 0,
                      ),
                    ),
                  );
                }),
          ),
          actions: <Widget>[
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  widget.controller.play();
                },
                child: const Text("Close"))
          ],
        );
      },
    );
  }
}
