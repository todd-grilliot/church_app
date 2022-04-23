import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoTest extends StatefulWidget {
  final Future dataFuture;
  const VideoTest({Key? key, required this.dataFuture}) : super(key: key);
  @override
  State<VideoTest> createState() => _VideoTestState();
}

class _VideoTestState extends State<VideoTest> {
  bool _isLoaded = false;
  List _data = [];
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();

    // _controller = VideoPlayerController.network(
    //   'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
    // );
    _controller = VideoPlayerController.asset('assets/video1.mp4');
    // _controller = VideoPlayerController.network(
    // 'https://wolvideos.firebaseapp.com/Test1.mp4');

    _initializeVideoPlayerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();

    print('disposing video_test');
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: FutureBuilder(
            future: _initializeVideoPlayerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                // If the VideoPlayerController has finished initialization, use
                // the data it provides to limit the aspect ratio of the video.
                _controller.play();
                _controller.setLooping(true);
                return Container(
                  child: Stack(
                    children: <Widget>[
                      // AspectRatio(aspectRatio: aspectRatio)
                      VideoPlayer(_controller),
                    ],
                  ),
                );
                // return AspectRatio(
                //   aspectRatio: _controller.value.aspectRatio,
                //   // Use the VideoPlayer widget to display the video.
                //   child: VideoPlayer(_controller),
                // );
              } else {
                // If the VideoPlayerController is still initializing, show a
                // loading spinner.
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }));
  }
}
