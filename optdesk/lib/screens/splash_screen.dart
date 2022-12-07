import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:optdesk/helpers/shared_preferences_helper.dart';
import 'package:video_player/video_player.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  VideoPlayerController _controller;

  @override
  void initState() {
    // TODO: implement initState
    _controller = VideoPlayerController.asset('assets/optdesk/vid_splash.mp4');
    _controller.addListener(() {
      setState(() {});
      checkAndPush();
    });
    _controller.setLooping(false);
    _controller.initialize().then((_) {
      setState(() {});
    });
    _controller.play();

    super.initState();

  }

  void checkAndPush() async{
    if(_controller.value.isInitialized){
      if (_controller.value.position == _controller.value.duration) {
        await SharedPreferencesHelper.getPrefBool(SharedPreferencesHelper.IS_LOGIN).then((isLoggedIn) {
          if (isLoggedIn) {
            Navigator.pushReplacementNamed(context, '/home');
          }else{
            Navigator.pushReplacementNamed(context, '/login');
          }
        });
      }
    }

//    if (_controller.value.position == _controller.value.duration) {
//      await SharedPreferencesHelper.getPrefBool(SharedPreferencesHelper.IS_LOGIN).then((isLoggedIn) {
//        if (isLoggedIn) {
//          Navigator.pushReplacementNamed(context, '/home');
//        }else{
//          Navigator.pushReplacementNamed(context, '/login');
//        }
//      });
//    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _controller.value.isInitialized
            ? AspectRatio(
          aspectRatio: _controller.value.aspectRatio,
          child: VideoPlayer(_controller),
        )
            : Container(),
      ),
    );
  }
}
