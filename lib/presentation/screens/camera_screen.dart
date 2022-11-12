import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({Key? key}) : super(key: key);

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

enum WidgetState { none, loading, loaded, error }

class _CameraScreenState extends State<CameraScreen> {
  WidgetState _widgetState = WidgetState.none;
  List<CameraDescription>? _cameras;
  CameraController? _cameraController;

  @override
  void initState() {
    super.initState();
    initializeCamera();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final deviceRatio = size.width / size.height;

    switch (_widgetState) {
      case WidgetState.none:
      case WidgetState.loading:
        return buildScaffold(
            context, const Center(child: CircularProgressIndicator()));
      case WidgetState.loaded:
        return buildScaffold(
            context,
            Stack(
              children: [
                Transform.scale(
                    scale: _cameraController!.value.aspectRatio / deviceRatio,
                    child: AspectRatio(
                        aspectRatio: _cameraController!.value.aspectRatio,
                        child: CameraPreview(_cameraController!))),
              ],
            ));
      case WidgetState.error:
        return buildScaffold(
            context,
            const Center(
                child: Text(
                    "¡Ooops! Error al cargar la cámara 😩. Reinicia la apliación.")));
    }
    return Container();
  }

  Widget buildScaffold(BuildContext context, Widget body) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Cámara"),
        backgroundColor: Colors.green,
        elevation: 0,
      ),
      body: body,
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          try {
            final path = join(
              (await getTemporaryDirectory()).path,
              '${DateTime.now()}.png',
            );
            XFile picture = await _cameraController!.takePicture();
            picture.saveTo(path);
          } catch (e) {
            print(e);
          }
        },
        child: const Icon(Icons.camera),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Future<void> initializeCamera() async {
    _widgetState = WidgetState.loading;
    if (mounted) setState(() {});

    _cameras = await availableCameras();

    _cameraController = CameraController(_cameras![0], ResolutionPreset.medium);

    await _cameraController!.initialize();

    if (_cameraController!.value.hasError) {
      _widgetState = WidgetState.error;
      if (mounted) setState(() {});
    } else {
      _widgetState = WidgetState.loaded;
      if (mounted) setState(() {});
    }
  }
}
