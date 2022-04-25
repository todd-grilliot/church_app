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
//   late VideoPlayerController _controller;
//   late Future<void> _initializeVideoPlayerFuture;

//   @override
//   void initState() {
//     super.initState();
//     String url;

//     _controller = VideoPlayerController.asset('assets/video1.mp4');
//     _initializeVideoPlayerFuture = _controller.initialize();

//     widget.dataFuture.then((value) => {
//           url = value[0]['interactive'],
//           _controller = VideoPlayerController.network(url),
//           // _controller = VideoPlayerController.network(
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
//                 // If the VideoPlayerController has finished initialization, use
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
