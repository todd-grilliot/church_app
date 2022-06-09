import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';

class VideoTest extends StatefulWidget {
  const VideoTest({Key? key}) : super(key: key);

  @override
  State<VideoTest> createState() => _VideoTestState();
}

final String _url =
    'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4';
final String _url2 =
    'https://player.vimeo.com/external/656370948.m3u8?s=e50ca2b440798886646ba88a07e9c46a90c9df11';
final _videoPlayerController = VideoPlayerController.network(_url2);

_initialize() async {
  print('here we go');
  await _videoPlayerController.initialize();
  print('initialized');
  _videoPlayerController.play();
}

class _VideoTestState extends State<VideoTest> {
  @override
  void initState() {
    super.initState();
    print('init state');
    _initialize(); // then setSTate...

    // () async {
    //   print('here we go');
    //   await _videoPlayerController.initialize();
    //   print('initialized');
    // }
  }

  // @override
  // void dispose() {
  //   super.dispose();
  //   _videoPlayerController.dispose();
  //   _chewieController.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Center(
            child: _videoPlayerController.value.isInitialized
                ? AspectRatio(
                    aspectRatio: _videoPlayerController.value.aspectRatio,
                    child: VideoPlayer(_videoPlayerController),
                  )
                : Center(
                    child: Text('initializing'),
                  )));
  }
}


// final String _url =
//     'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4';
// final String _url2 =
//     'https://player.vimeo.com/external/656370948.m3u8?s=e50ca2b440798886646ba88a07e9c46a90c9df11';
// final _videoPlayerController = VideoPlayerController.network(_url2);
// final _chewieController = ChewieController(
//     videoPlayerController: _videoPlayerController,
//     autoPlay: true,
//     looping: true);
// final playerWidget = Chewie(
//   controller: _chewieController,
// );

// class _VideoTestState extends State<VideoTest> {
//   @override
//   void initState() {
//     super.initState();

//     () async {
//       await _videoPlayerController.initialize();
//     };
//   }

//   // @override
//   // void dispose() {
//   //   super.dispose();
//   //   _videoPlayerController.dispose();
//   //   _chewieController.dispose();
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return Container(child: Center(child: playerWidget));
//   }
// }

















// import 'package:flutter/material.dart';
// import 'package:video_player/video_player.dart';

// class VideoTest extends StatefulWidget {
//   final Future dataFuture;
//   const VideoTest({Key? key, required this.dataFuture}) : super(key: key);
//   @override
//   State<VideoTest> createState() => _VideoTestState();
// }

// class _VideoTestState extends State<VideoTest> {
//   // late String url;
//   bool _isLoaded = false;
//   List _data = [];
//   late _VideoPlayerController _controller;
//   late Future<void> _initializeVideoPlayerFuture;

//   @override
//   void initState() {
//     super.initState();
//     String url;

//     _controller = _VideoPlayerController.asset('assets/video1.mp4');
//     _initializeVideoPlayerFuture = _controller.initialize();

//     widget.dataFuture.then((value) => {
//           url = value[0]['interactive'],
//           _controller = _VideoPlayerController.network(url),
//           // _controller = _VideoPlayerController.network(
//           // 'https://cdn.glitch.global/0890cab9-4b9c-4df1-8c3a-63e3f76d9a4d/Test1-play.mp4?v=1650740211663'),
//           _initializeVideoPlayerFuture = _controller.initialize(),
//         });
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     _controller.dispose();

//     print('disposing video_test');
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//         child: FutureBuilder(
//             future: _initializeVideoPlayerFuture,
//             builder: (context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.done) {
//                 // If the _VideoPlayerController has finished initialization, use
//                 // the data it provides to limit the aspect ratio of the video.
//                 _controller.play();
//                 _controller.setLooping(true);
//                 return Container(
//                   child: Stack(
//                     children: <Widget>[
//                       VideoPlayer(_controller),
//                       Center(
//                         child: Text(
//                           'Dummy',
//                           style: TextStyle(color: Colors.white),
//                         ),
//                       )
//                     ],
//                   ),
//                 );
//               } else {
//                 return const Center(
//                   child: CircularProgressIndicator(),
//                 );
//               }
//             }));
//   }
// }
