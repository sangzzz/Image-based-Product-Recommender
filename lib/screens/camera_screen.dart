import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart';
import 'package:recommender/screens/preview_image_screen.dart';

class CameraScreen extends StatefulWidget {
  CameraScreen({this.camera});
  final CameraDescription camera;
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen>
    with SingleTickerProviderStateMixin {
  CameraController _controller;
  Future<void> _initializeControllerFuture;
  AnimationController animationController;
  Animation<Color> animation1;
  Animation<int> animation2;
  Color color = Colors.white;
  @override
  void initState() {
    SystemChrome.setEnabledSystemUIOverlays([]);

    super.initState();
    _controller = CameraController(
      widget.camera,
      ResolutionPreset.medium,
      enableAudio: false,
    );
    _initializeControllerFuture = _controller.initialize();
    animationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 2500));
    animation1 = ColorTween(begin: Colors.black87, end: Colors.black)
        .animate(animationController);
    animationController.forward();
    animationController.addListener(() {
      setState(() {});
    });
    animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        animationController.reverse(from: 1);
      } else if (status == AnimationStatus.dismissed) {
        animationController.forward(from: 0);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    FutureBuilder cameraBuilder = FutureBuilder(
      future: _initializeControllerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return CameraPreview(_controller);
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
    FloatingActionButton cameraCapture = FloatingActionButton(
      child: GestureDetector(
        child: Icon(
          Icons.camera,
          color: Colors.grey.shade200,
          size: 35 + 10 * animationController.value,
        ),
      ),
      onPressed: () async {
        try {
          await _initializeControllerFuture;
          final String path = join(
            (await getTemporaryDirectory()).path,
            '${DateTime.now()}.png',
          );
          await _controller.takePicture(path);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PreviewImageScreen(path: path),
            ),
          );
        } catch (e) {
          print(e);
        }
      },
    );
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 5,
            child: cameraBuilder,
          ),
          Expanded(
            flex: 1,
            child: Container(
              color: animation1.value,
              child: Center(
                child: cameraCapture,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    animationController.dispose();
    super.dispose();
  }
}
