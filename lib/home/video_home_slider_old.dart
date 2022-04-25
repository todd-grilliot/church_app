// import 'package:http/http.dart';

// import 'video_player_slide.dart' show VideoPlayerSlide;
// import 'package:flutter/material.dart';
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:video_player/video_player.dart';

// class FullScreenSlider extends StatefulWidget {
//   final Future dataFuture;

//   const FullScreenSlider({
//     Key? key,
//     required this.dataFuture,
//   }) : super(key: key);
//   @override
//   State<FullScreenSlider> createState() => _FullScreenSliderState();
// }

// class _FullScreenSliderState extends State<FullScreenSlider> {
//   // maps of both of these...
//   // late VideoPlayerController _controller;
//   // late Future<void> _initializeVideoPlayerFuture;
//   late List<VideoPlayerController> _controllers;
//   late List<Future> _initializeFutures;
//   late Future<List> VideoFutures;

//   // videoFutures wants to be assigned to a future that resolves to a list of futures...
//   // the dataFuture resolves to the whole data set... not a list...
//   // the problem is that Video futures was never initialized... so i'm trying to initialize it on the first line
//   //
//   Future<List> getVideoFutures(dataFuture) async {
//     List data = await dataFuture;

//     _controllers = await data.map<VideoPlayerController>((item) {
//       return VideoPlayerController.network(item['interactive']);
//     }).toList();
//     _initializeFutures = await _controllers.map<Future>((item) {
//       return item.initialize();
//     }).toList();
//     return _initializeFutures;
//   }

//   Future<List> getData() async {
//     return await widget.dataFuture;
//   }

//   @override
//   void initState() {
//     super.initState();

//     // print('abcd future ${getData()}');
//     VideoFutures = getVideoFutures(getData());
//     // VideoFutures = assignFuture();
//     // getData();
//     // VideoFutures = await widget.dataFuture.then((value) => {
//     //  return getVideoFutures(value)
//     // });
//     //once we get videofutures, use the value to getVideoFutures...
//     // widget.dataFuture.then((value) => {VideoFutures = getVideoFutures(value)});
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     _controllers.forEach(
//       (element) => {element.dispose()},
//     );

//     print('disposing video_test');
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Builder(
//       builder: (context) {
//         final double _fullHeight = MediaQuery.of(context).size.height;

//         return FutureBuilder(
//             future: VideoFutures,
//             builder: (context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.done) {
//                 List snapData = snapshot.data as List;
//                 return CarouselSlider(
//                   items: snapData.map((item) {
//                     int index = snapData.indexOf(item);
//                     return Builder(
//                       builder: (BuildContext context) {
//                         return VideoPlayerSlide(
//                             // videoFuture: _initializeFutures[index],
//                             controller: _controllers[index]);
//                       },
//                     );
//                   }).toList(),
//                   options: CarouselOptions(
//                     height: _fullHeight,
//                     viewportFraction: 1.0,
//                     enlargeCenterPage: false,
//                     enableInfiniteScroll: false,
//                     autoPlay: true,
//                   ),
//                 );
//               } else {
//                 return Center(
//                   child: Text('not connected'),
//                 );
//               }
//             });

//         // return FutureBuilder(
//         //     future: widget.dataFuture,
//         //     builder: (context, snapshot) {
//         //       if (snapshot.connectionState == ConnectionState.done) {
//         //         List data = (snapshot.data as List);
//         //         return CarouselSlider(
//         //             options: CarouselOptions(
//         //               height: _fullHeight,
//         //               viewportFraction: 1.0,
//         //               enlargeCenterPage: false,
//         //               enableInfiniteScroll: false,
//         //               autoPlay: true,
//         //             ),
//         //             items: data.map((value) {
//         //               return Builder(
//         //                 builder: (BuildContext context) {
//         //                   return VideoPlayerSlide(data: value);
//         //                 },
//         //               );
//         //             }).toList());
//         //       } else {
//         //         return Center(
//         //           child: CircularProgressIndicator(),
//         //         );
//         //       }
//         //     });

//         // return CarouselSlider(
//         //     options: CarouselOptions(
//         //       height: _fullHeight,
//         //       viewportFraction: 1.0,
//         //       enlargeCenterPage: false,
//         //       enableInfiniteScroll: false,
//         //       autoPlay: true,
//         //     ),
//         //     items: _isLoaded

//         //         // ? _data.map((e) {Text(e)})

//         //         ? _data
//         //             .map<Widget>((e) => VideoPlayerSlide(data: _data))
//         //             .toList()
//         //         : defaultMap());
//       },
//       // ),
//     );
//   }
// }
