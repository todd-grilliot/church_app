import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'slide.dart' show Slide;

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
  var timeStamp;
  late List<NetworkImage> _gifs;
  final List<Future> _gifPrecaches =
      List.filled(6, Future(() {})); // blank futures to initialize..
  late List<NetworkImage> _thumbnails;
  late List _dataMaps;
  late Future<List> _gifFutures;

  // gets data, awaits first image, concurrently precaches all of them and returns a future...
  Future<List> getGifFutures() async {
    _dataMaps = await widget.dataFuture;

    _gifs = _dataMaps.map<NetworkImage>((item) {
      return NetworkImage(item['interactive']);
    }).toList();
    _thumbnails = _dataMaps.map<NetworkImage>((item) {
      return NetworkImage(item['thumbnail']);
    }).toList();

    // wait for all of them.. takes longer.. but doesn't have that black background...
    for (var i = 0; i < _dataMaps.length; i++) {
      _gifPrecaches[i] = precacheImage(_gifs[i], context);
      await precacheImage(_thumbnails[i], context);
    }
    //we can get one image in about 2.7 seconds, but 5 images in 6.2 seconds
    // await precacheImage(NetworkImage(data[0]['interactive']), context);
    // _preCaches = _gifs.map((item) {  return precacheImage(item, context); }).toList();
    return _gifs;
  }

  @override
  void initState() {
    super.initState();
    timeStamp = DateTime.now().millisecondsSinceEpoch;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _gifFutures = getGifFutures();
  }

  @override
  void dispose() {
    super.dispose();
    // print('dispose home slider');
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
                timeStamp -= DateTime.now().millisecondsSinceEpoch;
                print('time to load $timeStamp');
                List snapData = snapshot.data as List;
                snapData.map((item) {
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
                  items: snapData.asMap().entries.map((item) {
                    int index = item.key;
                    return Builder(builder: (BuildContext context) {
                      // print('building slide');
                      return Slide(
                        gif: item.value,
                        thumbnail: _thumbnails[index],
                        slideData: _dataMaps[index],
                        slideIndex: index,
                        slidesLength: snapData.length,
                        precacheFuture: _gifPrecaches[index],
                      );
                    });
                  }).toList(),
                );
              } else {
                return Center(
                  child: Text('not connecteed'),
                );
              }
            });
      },
    );
  }
}
