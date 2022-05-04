import 'package:church_app/screens/video_experience_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/services.dart';

class Slide extends StatefulWidget {
  final NetworkImage gif;
  final NetworkImage thumbnail;
  final Map slideData;
  final int slideIndex;
  final int slidesLength;
  final Future precacheFuture;
  bool isLiked;
  Slide({
    Key? key,
    required this.gif,
    required this.thumbnail,
    required this.slideData,
    required this.slideIndex,
    required this.slidesLength,
    // required this.gifsList,
    required this.precacheFuture,
    this.isLiked = false,
  }) : super(key: key);

  @override
  _SlideState createState() => _SlideState();
}

// when you get the future, then set state.. gifIsLoaded = true;
// also what's going on with that button thing.../?

class _SlideState extends State<Slide> {
  bool _gifIsLoaded = false;

  void setPrecacheState() async {
    await widget.precacheFuture;
    if (!mounted) return;
    setState(() {
      _gifIsLoaded = true;
    });
  }

  void handleVideoButton() {
    print('video');
    String _title = widget.slideData['name'];
    String _url = widget.slideData['video_link'];
    // Navigator.pushNamed(context, VideoExperienceScreen.routeName,
    // arguments: ScreenArguments(_title, _url));
    Navigator.push(
        context,
        MaterialPageRoute(
            settings: RouteSettings(name: VideoExperienceScreen.routeName),
            builder: (context) =>
                VideoExperienceScreen(url: _url, title: _title)));
  }

  void handleLike() {
    setState(() {
      widget.isLiked = !widget.isLiked;
    });
  }

  void handleShare() {
    String _link = widget.slideData['share_link'];
    Clipboard.setData(ClipboardData(text: _link)).then((value) =>
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("copied to clipboard"))));
  }

  @override
  void initState() {
    super.initState();
    setPrecacheState();
  }

  @override
  void dispose() {
    super.dispose();
    // print('dispose slide');
  }

  @override
  Widget build(BuildContext context) {
    List _lengthList = List.filled(widget.slidesLength, null);

    return Container(
      padding: EdgeInsets.only(top: 500),
      decoration: BoxDecoration(
          image: DecorationImage(
              image: _gifIsLoaded ? widget.gif : widget.thumbnail,
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                Colors.black54,
                BlendMode.darken,
              ))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
              flex: 2,
              child: IconButton(
                  constraints: BoxConstraints(),
                  padding: EdgeInsets.all(16.0),
                  onPressed: handleShare,
                  icon: SvgPicture.asset(
                    'assets/icons/Share.svg',
                  ))),
          Expanded(
            flex: 8,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(widget.slideData['date'],
                    style: TextStyle(
                        color: Colors.white54,
                        fontWeight: FontWeight.w300,
                        fontSize: 18.0)),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 6.0),
                  child: Text(widget.slideData['name'],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        fontSize: 24.0,
                      )),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        onPressed: handleVideoButton,
                        child: Row(children: [
                          Text('Experience'),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(4.0, 2.0, 0, 0),
                            child: SvgPicture.asset(
                              "assets/icons/Watch.svg",
                            ),
                          ),
                        ]),
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.white),
                            foregroundColor:
                                MaterialStateProperty.all(Colors.black87),
                            padding: MaterialStateProperty.all(
                                EdgeInsets.symmetric(
                                    vertical: 3, horizontal: 15.0)),
                            minimumSize: MaterialStateProperty.all(Size.zero)))
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _lengthList.asMap().entries.map((entry) {
                    int index = entry.key;
                    return Container(
                        width: 8.0,
                        height: 8.0,
                        margin: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 2.0),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border:
                                Border.all(width: 1.2, color: Colors.white)),
                        child: widget.slideIndex == index
                            ? Container(
                                decoration: BoxDecoration(
                                border: Border.all(
                                    width: 1.2,
                                    color: Color.fromARGB(255, 120, 120, 120)),
                                shape: BoxShape.circle,
                                color: Color.fromARGB(255, 220, 220, 220),
                              ))
                            : null);
                  }).toList(),
                )
              ],
            ),
          ),
          Expanded(
              flex: 2,
              child: widget.isLiked
                  ? AvatarGlow(
                      endRadius: 40.0,
                      repeat: false,
                      duration: Duration(milliseconds: 1000),
                      // repeatPauseDuration: Duration.zero,
                      child: IconButton(
                          constraints: BoxConstraints(),
                          padding: EdgeInsets.all(16.0),
                          onPressed: handleLike,
                          icon: SvgPicture.asset(
                            'assets/icons/Like-filled.svg',
                            color: Colors.white,
                          )))
                  : IconButton(
                      constraints: BoxConstraints(),
                      padding: EdgeInsets.all(16.0),
                      onPressed: handleLike,
                      icon: SvgPicture.asset(
                        'assets/icons/Like.svg',
                      )))
        ],
      ),
    );
  }
}
