import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerSlide extends StatefulWidget {
  // final Future videoFuture;
  final VideoPlayerController controller;
  const VideoPlayerSlide({Key? key, required this.controller})
      : super(key: key);
  @override
  State<VideoPlayerSlide> createState() => _VideoPlayerSlide();
}

class _VideoPlayerSlide extends State<VideoPlayerSlide> {
  // late VideoPlayerController _controller;
  // late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();
    widget.controller.setVolume(0.0);
    widget.controller.setLooping(true);
  }

  @override
  void dispose() {
    super.dispose();
    widget.controller.seekTo(Duration.zero);
    widget.controller.pause();
  }

  @override
  Widget build(BuildContext context) {
    widget.controller.play();
    return Stack(
      children: [
        VideoPlayer(widget.controller),
      ],
    );

    // return Center(child: Center(child: Text('init ${widget.controller}')));
    // child: FutureBuilder(
    //     future: _initializeVideoPlayerFuture,
    //     builder: (context, snapshot) {
    //       if (snapshot.connectionState == ConnectionState.done) {
    //         // If the VideoPlayerController has finished initialization, use
    //         // the data it provides to limit the aspect ratio of the video.
    //         _controller.setVolume(0.0);
    //         _controller.play();
    //         _controller.setLooping(true);
    //         return Container(
    //           child: Stack(
    //             children: <Widget>[
    //               VideoPlayer(_controller),
    //               Center(
    //                 child: Text(
    //                   'Dummy',
    //                   style: TextStyle(color: Colors.white),
    //                 ),
    //               )
    //             ],
    //           ),
    //         );
    //       } else {
    //         return const Center(
    //           child: CircularProgressIndicator(),
    //         );
    //       }
    //     }));
  }
}
