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

class _CameraScreenState extends State<CameraScreen> {
  CameraController _controller;
  Future<void> _initializeControllerFuture;
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
      child: Icon(Icons.camera),
      backgroundColor: Colors.grey.withAlpha(100),
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
              color: Colors.black87,
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
    super.dispose();
  }
}
