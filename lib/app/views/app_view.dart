import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_faces/app/bloc/bloc.dart';
import 'package:flutter_faces/app/widgets/widgets.dart';
import 'package:flutter_faces/faces/widgets/widgets.dart';
import 'package:flutter_faces/services/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
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
        localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          Locale('en', ''),
        ],
        home: BlocProvider(
          create: (BuildContext context) => AppBloc(),
          child: AppView(),
        ),
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
  late CameraLensDirection _cameraLensDirection;

  bool _cameraInitializated = false;
  bool _detectingFaces = false;

  late Size _imageSize;

  List<Face>? _faces;
  // bool _saving = false;

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
      BlocListener<AppBloc, AppState>(
        listener: (
          BuildContext context,
          AppState state,
        ) async =>
            await _blocListener(context, state),
        child: Scaffold(
          body: _buildContent(),
          floatingActionButton: CameraToggle(),
        ),
      );

  Future<void> _init() async {
    await [Permission.camera].request();

    List<CameraDescription> cameras = await availableCameras();
    CameraDescription cameraDescription = cameras.firstWhere(
        (CameraDescription camera) => (camera.lensDirection ==
            context.read<AppBloc>().state.cameraLensDirection));

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
    AppState state,
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
    if (!_cameraInitializated) {
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
                          ]..addAll(_buildFaces()),
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
        // SafeArea(
        //   child: Padding(
        //     padding: const EdgeInsets.all(16.0),
        //     child: Icon(
        //       Icons.menu,
        //       size: 40.0,
        //     ),
        //   ),
        // ),
      ],
    );
  }

  List<Widget> _buildFaces() {
    CameraLensDirection cameraLensDirection =
        context.read<AppBloc>().state.cameraLensDirection;

    List<Widget> faces = <Widget>[];

    if (_faces != null) {
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
