import 'package:http/http.dart';

// import 'video_player_slide.dart' show VideoPlayerSlide;
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:video_player/video_player.dart';
// import 'slide.dart' show Slide;

class FullScreenSlider extends StatefulWidget {
  final Future dataFuture;

  const FullScreenSlider({
    Key? key,
    required this.dataFuture,
  }) : super(key: key);
  @override
  State<FullScreenSlider> createState() => _FullScreenSliderState();
}

class _FullScreenSliderState extends State<FullScreenSlider> {
  // maps of both of these...
  // late VideoPlayerController _controller;
  // late Future<void> _initializeVideoPlayerFuture;
  // late List<VideoPlayerController> _controllers;
  // late List<Future> _initializeFutures;
  // late Future<List> VideoFutures;
  // late final data;
  late final List<NetworkImage> _gifs;
  // late final List<Future> _preCaches;

  late Future<List> _gifFutures;

  // gets data, awaits first image, concurrently precaches all of them and returns a future...
  Future<List> getGifFutures(dataFuture) async {
    List data = await dataFuture;

    _gifs = await data.map<NetworkImage>((item) {
      return NetworkImage(item['interactive']);
    }).toList();
    //wait for all of them.. takes longer.. but doesn't have that black background...
    for (var i = 0; i < _gifs.length; i++) {
      await precacheImage(NetworkImage(data[i]['interactive']), context);
    }
    // await precacheImage(NetworkImage(data[0]['interactive']), context);

    // _preCaches = _gifs.map((item) {
    //   return precacheImage(item, context);
    // }).toList();

    return _gifs;
  }

  Future<List> getData() async {
    return await widget.dataFuture;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _gifFutures = getGifFutures(getData());
  }

  @override
  void dispose() {
    super.dispose();
    // _controllers.forEach(
    //   (element) => {element.dispose()},
    // );

    print('disposing home slider');
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final double _fullHeight = MediaQuery.of(context).size.height;

        return FutureBuilder(
            future: _gifFutures,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                List snapData = snapshot.data as List;
                print('data $snapData');
                List gifs = snapData.map((item) {
                  int index = snapData.indexOf(item);
                  NetworkImage gif = _gifs[index];
                  return gif;
                }).toList();
                return CarouselSlider(
                  options: CarouselOptions(
                    height: _fullHeight,
                    viewportFraction: 1.0,
                    enlargeCenterPage: false,
                    enableInfiniteScroll: false,
                    autoPlay: true,
                  ),
                  items: snapData.map((item) {
                    int index = snapData.indexOf(item);
                    return Builder(builder: (BuildContext context) {
                      //i think just make a background or a ternary instead of the future builder...
                      print('item $item');

                      return Container(
                          padding: EdgeInsets.only(top: 500),
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: item,
                                  fit: BoxFit.cover,
                                  colorFilter: ColorFilter.mode(
                                    Colors.black54,
                                    BlendMode.darken,
                                  ))));
                      // return FutureBuilder(
                      //     future: _preCaches[index],
                      //     builder: (context, snapshot) {
                      //       if (snapshot.connectionState ==
                      //           ConnectionState.done) {
                      //         return Container(
                      //             padding: EdgeInsets.only(top: 500),
                      //             decoration: BoxDecoration(
                      //                 image: DecorationImage(
                      //                     image: item,
                      //                     fit: BoxFit.cover,
                      //                     colorFilter: ColorFilter.mode(
                      //                       Colors.black54,
                      //                       BlendMode.darken,
                      //                     ))));
                      //       } else {
                      //         return Container(
                      //           color: Colors.black87,
                      //           child: Center(
                      //             child: Text('image not ready'),
                      //           ),
                      //         );
                      //       }
                      //     });

                      // return VideoPlayerSlide(
                      //     // videoFuture: _initializeFutures[index],
                      //     controller: _controllers[index]);
                    });
                  }).toList(),
                );
              } else {
                return Center(
                  child: Text('not connecteed'),
                );
              }
            });
        // return Container(
        //     padding: EdgeInsets.only(top: 500),
        //     decoration: BoxDecoration(
        //         image: DecorationImage(
        //             image: AssetImage(),
        //             fit: BoxFit.cover,
        //             colorFilter: ColorFilter.mode(
        //               Colors.black54,
        //               BlendMode.darken,
        //             ))),

        //   child: // return FutureBuilder(
        //     future: VideoFutures,
        //     builder: (context, snapshot) {
        //       if (snapshot.connectionState == ConnectionState.done) {
        //         List snapData = snapshot.data as List;
        //         return CarouselSlider(
        //           items: snapData.map((item) {
        //             int index = snapData.indexOf(item);
        //             return Builder(
        //               builder: (BuildContext context) {
        //                 return Center(
        //                   child: Text('showing'),
        //                 );
        //                 // return VideoPlayerSlide(
        //                 //     // videoFuture: _initializeFutures[index],
        //                 //     controller: _controllers[index]);
        //               },
        //             );
        //           }).toList(),
        //           options: CarouselOptions(
        //             height: _fullHeight,
        //             viewportFraction: 1.0,
        //             enlargeCenterPage: false,
        //             enableInfiniteScroll: false,
        //             autoPlay: true,
        //           ),
        //         );
        //       } else {
        //         return Center(
        //           child: Text('not connected'),
        //         );
        //       }
        //     });

        // return FutureBuilder(
        //     future: widget.dataFuture,
        //     builder: (context, snapshot) {
        //       if (snapshot.connectionState == ConnectionState.done) {
        //         List data = (snapshot.data as List);
        //         return CarouselSlider(
        //             options: CarouselOptions(
        //               height: _fullHeight,
        //               viewportFraction: 1.0,
        //               enlargeCenterPage: false,
        //               enableInfiniteScroll: false,
        //               autoPlay: true,
        //             ),
        //             items: data.map((value) {
        //               return Builder(
        //                 builder: (BuildContext context) {
        //                   return VideoPlayerSlide(data: value);
        //                 },
        //               );
        //             }).toList());
        //       } else {
        //         return Center(
        //           child: CircularProgressIndicator(),
        //         );
        //       }
        //     });

        // return CarouselSlider(
        //     options: CarouselOptions(
        //       height: _fullHeight,
        //       viewportFraction: 1.0,
        //       enlargeCenterPage: false,
        //       enableInfiniteScroll: false,
        //       autoPlay: true,
        //     ),
        //     items: _isLoaded

        //         // ? _data.map((e) {Text(e)})

        //         ? _data
        //             .map<Widget>((e) => VideoPlayerSlide(data: _data))
        //             .toList()
        //         : defaultMap());
      },
      // ),
    );
  }
}
