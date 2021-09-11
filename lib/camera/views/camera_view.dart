import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_faces/app/widgets/widgets.dart';
import 'package:flutter_faces/camera/bloc/bloc.dart';
import 'package:flutter_faces/camera/camera.dart';
import 'package:flutter_faces/camera/widgets/widgets.dart';
import 'package:flutter_faces/faces/widgets/widgets.dart';
import 'package:flutter_faces/services/services.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:permission_handler/permission_handler.dart';

class CameraView extends StatelessWidget {
  static Page page() => const MaterialPage<void>(child: CameraView());

  const CameraView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(
    BuildContext context,
  ) =>
      BlocProvider(
        create: (BuildContext context) => CameraBloc(),
        child: CameraViewPage(),
      );
}

class CameraViewPage extends StatefulWidget {
  const CameraViewPage({
    Key? key,
  }) : super(key: key);

  @override
  _CameraViewPageState createState() => _CameraViewPageState();
}

class _CameraViewPageState extends State<CameraViewPage>
    with WidgetsBindingObserver {
  CameraService _cameraService = CameraService();
  FaceNetService _faceNetService = FaceNetService();
  MLKitService _mlKitService = MLKitService();

  Future? _initializeControllerFuture;
  late CameraLensDirection _cameraLensDirection;

  bool _cameraInitializated = false;
  bool _detectingFaces = false;

  late Size _imageSize;

  List<Face>? _faces;

  @override
  void initState() {
    super.initState();
    _init();
    WidgetsBinding.instance!.addObserver(this);
  }

  @override
  void dispose() {
    _cameraService.dispose();
    super.dispose();
  }

  @override
  Widget build(
    BuildContext context,
  ) =>
      BlocListener<CameraBloc, CameraState>(
        listener: (
          BuildContext context,
          CameraState state,
        ) async =>
            await _blocListener(context, state),
        child: AppUiOverlayStyle(
          child: Scaffold(
            body: _buildContent(),
            extendBody: true,
            extendBodyBehindAppBar: true,
          ),
        ),
      );

  Future<void> _init() async {
    await [Permission.camera].request();

    List<CameraDescription> cameras = await availableCameras();
    CameraDescription cameraDescription = cameras.firstWhere(
        (CameraDescription camera) => (camera.lensDirection ==
            context.read<CameraBloc>().state.cameraLensDirection));

    // Start the services
    await _faceNetService.loadModel();
    _mlKitService.initialize();

    _initializeControllerFuture =
        _cameraService.startService(cameraDescription);

    await _initializeControllerFuture;

    setState(() {
      _cameraInitializated = true;
      _cameraLensDirection = cameraDescription.lensDirection;
    });

    await _frameFaces();
  }

  /// Draws rectangles when detects faces
  Future<void> _frameFaces() async {
    _imageSize = _cameraService.getImageSize();
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
          setState(() => _faces = faces);

          // TODO!
          // if (_saving) {
          //   _saving = false;
          //   _faceNetService.setCurrentPrediction(image, _face!);
          // }
        } else {
          setState(() => _faces = null);
        }

        _detectingFaces = false;
      } catch (e) {
        print(e);
        _detectingFaces = false;
      }
    });
  }

  Future<void> _blocListener(
    BuildContext context,
    CameraState state,
  ) async {
    if (state.cameraLensDirection != _cameraLensDirection) {
      setState(() {
        _faces = null;
        _cameraInitializated = false;
        _cameraLensDirection = state.cameraLensDirection;
      });

      _init();
    }
  }

  Widget _buildContent() {
    if (!_cameraInitializated || (_initializeControllerFuture == null)) {
      return AppLoader();
    }

    return Stack(
      children: [
        FutureBuilder<void>(
          future: _initializeControllerFuture,
          builder: (
            BuildContext context,
            AsyncSnapshot<void> snapshot,
          ) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Stack(
                children: [
                  buildCameraOrientationBox(
                    context: context,
                    controller: _cameraService.cameraController,
                    children: <Widget>[
                      CameraPreview(_cameraService.cameraController),
                    ]..addAll(_buildFaces()),
                  ),
                  Align(
                    alignment: FractionalOffset.bottomCenter,
                    child: CameraOptions(),
                  ),
                ],
              );
            }

            return AppLoader();
          },
        ),
      ],
    );
  }

  List<Widget> _buildFaces() {
    List<Widget> faces = <Widget>[];

    if (_faces != null) {
      CameraLensDirection cameraLensDirection =
          context.read<CameraBloc>().state.cameraLensDirection;

      for (Face face in _faces!) {
        faces
          ..add(FaceBorder(
            face: face,
            imageSize: _imageSize,
            cameraLensDirection: cameraLensDirection,
          ))
          ..add(GooglyEyes(
            face: face,
            imageSize: _imageSize,
            cameraLensDirection: cameraLensDirection,
          ));
      }
    }

    return faces;
  }
}
