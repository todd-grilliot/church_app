import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

class ScreenArguments {
  final String title;
  final String url;

  ScreenArguments(this.title, this.url);
}

class VideoExperienceScreen extends StatefulWidget {
  const VideoExperienceScreen({Key? key}) : super(key: key);
  static const routeName = '/experience-video';
  @override
  State<VideoExperienceScreen> createState() => _VideoExperienceScreenState();
}

class _VideoExperienceScreenState extends State<VideoExperienceScreen> {
  late VideoPlayerController _controller;
  late ChewieController _chewieController;
  bool _isLoaded = false;

  @override
  void initState() {
    super.initState();
    // final args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;
    // _controller = VideoPlayerController.network(args.url);
    // _controller.initialize().then((_) {
    // setState(() {
    // _isLoaded = true;
    // });
    // });
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;
    _controller = VideoPlayerController.network(args.url);
    _chewieController = ChewieController(
      videoPlayerController: _controller,
      aspectRatio: 3 / 2,
      autoPlay: true,
      looping: true,
    );
    _controller.initialize().then((_) {
      setState(() {
        _isLoaded = true;
        // _controller.play();
        // _controller.setLooping(true);
      });
    });
    return Scaffold(
      appBar: AppBar(
        title: Text(args.title),
      ),
      body: Center(
        child: _isLoaded
            ? Chewie(controller: _chewieController)
            : CircularProgressIndicator(),
      ),
    );
  }
}
