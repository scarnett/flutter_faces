import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_faces/faces/googly_eyes/widgets/widgets.dart';
import 'package:flutter_faces/faces/widgets/widgets.dart';
import 'package:flutter_faces/services/services.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:permission_handler/permission_handler.dart';

class App extends StatelessWidget {
  @override
  Widget build(
    BuildContext context,
  ) =>
      MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: AppView(),
      );
}

class AppView extends StatefulWidget {
  AppView({
    Key? key,
  }) : super(key: key);

  @override
  _AppViewState createState() => _AppViewState();
}

class _AppViewState extends State<AppView> with WidgetsBindingObserver {
  CameraService _cameraService = CameraService();
  FaceNetService _faceNetService = FaceNetService();
  MLKitService _mlKitService = MLKitService();

  late Future _initializeControllerFuture;

  bool cameraInitializated = false;
  bool _detectingFaces = false;

  late String imagePath;
  late Size imageSize;

  Face? face;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _init();
    WidgetsBinding.instance!.addObserver(this);
  }

  @override
  Widget build(
    BuildContext context,
  ) =>
      MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: _buildContent(),
      );

  Future<void> _init() async {
    await [Permission.camera].request();

    List<CameraDescription> cameras = await availableCameras();
    CameraDescription cameraDescription = cameras.firstWhere(
        (CameraDescription camera) =>
            camera.lensDirection == CameraLensDirection.front);

    // Start the services
    await _faceNetService.loadModel();
    _mlKitService.initialize();

    _initializeControllerFuture =
        _cameraService.startService(cameraDescription);

    await _initializeControllerFuture;
    setState(() => cameraInitializated = true);
    _frameFaces();
  }

  /// Draws rectangles when detects faces
  _frameFaces() {
    imageSize = _cameraService.getImageSize();
    _cameraService.cameraController.startImageStream((CameraImage image) async {
      // If it's currently busy, avoids overprocessing
      if (_detectingFaces) {
        return;
      }

      _detectingFaces = true;

      try {
        List<Face> faces = await _mlKitService.getFacesFromImage(image);
        if (faces.length > 0) {
          // Preprocessing the image
          setState(() => face = faces[0]);

          if (_saving) {
            _saving = false;
            _faceNetService.setCurrentPrediction(image, face!);
          }
        } else {
          setState(() => face = null);
        }

        _detectingFaces = false;
      } catch (e) {
        print(e);
        _detectingFaces = false;
      }
    });
  }

  Widget _buildContent() {
    if (!cameraInitializated) {
      return Center(child: CircularProgressIndicator());
    }

    final double width = MediaQuery.of(context).size.width;

    return Stack(
      children: [
        FutureBuilder<void>(
          future: _initializeControllerFuture,
          builder: (
            BuildContext context,
            AsyncSnapshot<void> snapshot,
          ) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Transform.scale(
                scale: 1.0,
                child: AspectRatio(
                  aspectRatio: MediaQuery.of(context).size.aspectRatio,
                  child: OverflowBox(
                    alignment: Alignment.center,
                    child: FittedBox(
                      fit: BoxFit.fitHeight,
                      child: Container(
                        width: width,
                        height: (width *
                            _cameraService.cameraController.value.aspectRatio),
                        child: Stack(
                          fit: StackFit.expand,
                          children: <Widget>[
                            CameraPreview(_cameraService.cameraController),
                            FaceBorder(
                              face: face,
                              imageSize: imageSize,
                            ),
                            GooglyEyes(
                              face: face,
                              imageSize: imageSize,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }

            return Center(child: CircularProgressIndicator());
          },
        ),
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Icon(
              Icons.menu,
              size: 40.0,
            ),
          ),
        ),
      ],
    );
  }
}
