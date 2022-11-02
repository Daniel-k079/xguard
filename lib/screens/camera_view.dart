// import 'dart:io';
// import 'dart:math';

// import 'package:camera/camera.dart';
// import 'package:flutter/material.dart';
// import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
// import 'package:flutter/foundation.dart';
// import 'package:image_picker/image_picker.dart';
// import '../main.dart';

// enum ScreenMode { liveFeed, gallery }

// class CameraView extends StatefulWidget {
//   CameraView(
//       {Key? key,
//       required this.title,
//       required this.customPaint,
//       this.text,
//       required this.onImage,
//       this.onScreenModeChanged,
//       this.initialDirection = CameraLensDirection.back,
//       required this.cameras})
//       : super(key: key);

//   final List<CameraDescription> cameras;
//   final String title;
//   final CustomPaint? customPaint;
//   final String? text;
//   final Function(InputImage inputImage) onImage;
//   final Function(ScreenMode mode)? onScreenModeChanged;
//   final CameraLensDirection initialDirection;

//   @override
//   _CameraViewState createState() => _CameraViewState();
// }

// class _CameraViewState extends State<CameraView> {
//   ScreenMode _mode = ScreenMode.liveFeed;
//   CameraController? _controller;
//   File? _image;
//   String? _path;
//   ImagePicker? _imagePicker;
//   int _cameraIndex = 0;
//   double zoomLevel = 0.0, minZoomLevel = 0.0, maxZoomLevel = 0.0;
//   final bool _allowPicker = true;
//   bool _changingCameraLens = false;

//   @override
//   void initState() {
//     super.initState();

//     _imagePicker = ImagePicker();
//     print(widget.cameras[0]);
//     if (widget.cameras.any(
//       (element) =>
//           element.lensDirection == widget.initialDirection &&
//           element.sensorOrientation == 90,
//     )) {
//       _cameraIndex = widget.cameras.indexOf(
//         widget.cameras.firstWhere((element) =>
//             element.lensDirection == widget.initialDirection &&
//             element.sensorOrientation == 90),
//       );
//     } else {
//       // _cameraIndex = widget.cameras.indexOf(
//       //   widget.cameras.firstWhere(
//       //     (element) => element.lensDirection == widget.initialDirection,
//       //   ),
//       // );
//     }

//     _startLiveFeed();
//   }

//   @override
//   void dispose() {
//     _stopLiveFeed();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//         actions: [
//           if (_allowPicker)
//             Padding(
//               padding: EdgeInsets.only(right: 20.0),
//               child: GestureDetector(
//                 onTap: _switchScreenMode,
//                 child: Icon(
//                   _mode == ScreenMode.liveFeed
//                       ? Icons.photo_library_outlined
//                       : (Platform.isIOS
//                           ? Icons.camera_alt_outlined
//                           : Icons.camera),
//                 ),
//               ),
//             ),
//         ],
//       ),
//       body: _body(),
//       floatingActionButton: _floatingActionButton(),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
//     );
//   }

//   Widget? _floatingActionButton() {
//     if (_mode == ScreenMode.gallery) return null;
//     if (widget.cameras.length == 1) return null;
//     return SizedBox(
//         height: 70.0,
//         width: 70.0,
//         child: FloatingActionButton(
//           child: Icon(
//             Platform.isIOS
//                 ? Icons.flip_camera_ios_outlined
//                 : Icons.flip_camera_android_outlined,
//             size: 40,
//           ),
//           onPressed: _switchLiveCamera,
//         ));
//   }

//   Widget _body() {
//     Widget body;
//     if (_mode == ScreenMode.liveFeed) {
//       body = _liveFeedBody();
//     } else {
//       body = _galleryBody();
//     }
//     return body;
//   }

//   Widget _liveFeedBody() {
//     if (_controller?.value.isInitialized == false) {
//       return Container();
//     }

//     final size = MediaQuery.of(context).size;
//     // calculate scale depending on screen and camera ratios
//     // this is actually size.aspectRatio / (1 / camera.aspectRatio)
//     // because camera preview size is received as landscape
//     // but we're calculating for portrait orientation
//     var scale = size.aspectRatio * _controller!.value.aspectRatio;

//     // to prevent scaling down, invert the value
//     if (scale < 1) scale = 1 / scale;

//     return Container(
//       color: Colors.black,
//       child: Stack(
//         fit: StackFit.expand,
//         children: <Widget>[
//           Transform.scale(
//             scale: scale,
//             child: Center(
//               child: _changingCameraLens
//                   ? Center(
//                       child: const Text('Changing camera lens'),
//                     )
//                   : CameraPreview(_controller!),
//             ),
//           ),
//           if (widget.customPaint != null) widget.customPaint!,
//           Positioned(
//             bottom: 100,
//             left: 50,
//             right: 50,
//             child: Slider(
//               value: zoomLevel,
//               min: minZoomLevel,
//               max: maxZoomLevel,
//               onChanged: (newSliderValue) {
//                 setState(() {
//                   zoomLevel = newSliderValue;
//                   _controller!.setZoomLevel(zoomLevel);
//                 });
//               },
//               divisions: (maxZoomLevel - 1).toInt() < 1
//                   ? null
//                   : (maxZoomLevel - 1).toInt(),
//             ),
//           )
//         ],
//       ),
//     );
//   }

//   Widget _galleryBody() {
//     return ListView(shrinkWrap: true, children: [
//       _image != null
//           ? SizedBox(
//               height: 400,
//               width: 400,
//               child: Stack(
//                 fit: StackFit.expand,
//                 children: <Widget>[
//                   Image.file(_image!),
//                   if (widget.customPaint != null) widget.customPaint!,
//                 ],
//               ),
//             )
//           : Icon(
//               Icons.image,
//               size: 200,
//             ),
//       Padding(
//         padding: EdgeInsets.symmetric(horizontal: 16),
//         child: ElevatedButton(
//           child: Text('From Gallery'),
//           onPressed: () => _getImage(ImageSource.gallery),
//         ),
//       ),
//       Padding(
//         padding: EdgeInsets.symmetric(horizontal: 16),
//         child: ElevatedButton(
//           child: Text('Take a picture'),
//           onPressed: () => _getImage(ImageSource.camera),
//         ),
//       ),
//       if (_image != null)
//         Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Text(
//               '${_path == null ? '' : 'Image path: $_path'}\n\n${widget.text ?? ''}'),
//         ),
//     ]);
//   }

//   Future _getImage(ImageSource source) async {
//     setState(() {
//       _image = null;
//       _path = null;
//     });
//     final pickedFile = await _imagePicker?.pickImage(source: source);
//     if (pickedFile != null) {
//       _processPickedFile(pickedFile);
//     }
//     setState(() {});
//   }

//   void _switchScreenMode() {
//     _image = null;
//     if (_mode == ScreenMode.liveFeed) {
//       _mode = ScreenMode.gallery;
//       _stopLiveFeed();
//     } else {
//       _mode = ScreenMode.liveFeed;
//       _startLiveFeed();
//     }
//     if (widget.onScreenModeChanged != null) {
//       widget.onScreenModeChanged!(_mode);
//     }
//     setState(() {});
//   }

//   Future _startLiveFeed() async {
//     final camera = cameras[_cameraIndex];
//     _controller = CameraController(
//       camera,
//       ResolutionPreset.high,
//       enableAudio: false,
//     );
//     _controller?.initialize().then((_) {
//       if (!mounted) {
//         return;
//       }
//       _controller?.getMinZoomLevel().then((value) {
//         zoomLevel = value;
//         minZoomLevel = value;
//       });
//       _controller?.getMaxZoomLevel().then((value) {
//         maxZoomLevel = value;
//       });
//       _controller?.startImageStream(_processCameraImage);
//       setState(() {});
//     });
//   }

//   Future _stopLiveFeed() async {
//     await _controller?.stopImageStream();
//     await _controller?.dispose();
//     _controller = null;
//   }

//   Future _switchLiveCamera() async {
//     setState(() => _changingCameraLens = true);
//     _cameraIndex = (_cameraIndex + 1) % cameras.length;

//     await _stopLiveFeed();
//     await _startLiveFeed();
//     setState(() => _changingCameraLens = false);
//   }

//   Future _processPickedFile(XFile? pickedFile) async {
//     final path = pickedFile?.path;
//     if (path == null) {
//       return;
//     }
//     setState(() {
//       _image = File(path);
//     });
//     _path = path;
//     final inputImage = InputImage.fromFilePath(path);
//     widget.onImage(inputImage);
//   }

//   Future _processCameraImage(CameraImage image) async {
//     final WriteBuffer allBytes = WriteBuffer();
//     for (final Plane plane in image.planes) {
//       allBytes.putUint8List(plane.bytes);
//     }
//     final bytes = allBytes.done().buffer.asUint8List();

//     final Size imageSize =
//         Size(image.width.toDouble(), image.height.toDouble());

//     final camera = widget.cameras[_cameraIndex];
//     final imageRotation =
//         InputImageRotationValue.fromRawValue(camera.sensorOrientation);
//     if (imageRotation == null) return;

//     final inputImageFormat =
//         InputImageFormatValue.fromRawValue(image.format.raw);
//     if (inputImageFormat == null) return;

//     final planeData = image.planes.map(
//       (Plane plane) {
//         return InputImagePlaneMetadata(
//           bytesPerRow: plane.bytesPerRow,
//           height: plane.height,
//           width: plane.width,
//         );
//       },
//     ).toList();

//     final inputImageData = InputImageData(
//       size: imageSize,
//       imageRotation: imageRotation,
//       inputImageFormat: inputImageFormat,
//       planeData: planeData,
//     );

//     final inputImage =
//         InputImage.fromBytes(bytes: bytes, inputImageData: inputImageData);

//     widget.onImage(inputImage);
//   }
// }

// class FaceDetectorView extends StatefulWidget {
//   FaceDetectorView({Key? key, required this.cameras}) : super(key: key);
//   final List<CameraDescription> cameras;
//   @override
//   _FaceDetectorViewState createState() => _FaceDetectorViewState();
// }

// class _FaceDetectorViewState extends State<FaceDetectorView> {
//   final FaceDetector _faceDetector = FaceDetector(
//     options: FaceDetectorOptions(
//       enableTracking: true,
//       enableContours: true,
//       enableClassification: true,
//     ),
//   );
//   bool _canProcess = true;
//   bool _isBusy = false;
//   CustomPaint? _customPaint;
//   String? _text;

//   @override
//   void dispose() {
//     _canProcess = false;
//     _faceDetector.close();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return CameraView(
//       cameras: widget.cameras,
//       title: 'Face Detector',
//       customPaint: _customPaint,
//       text: _text,
//       onImage: (inputImage) {
//         processImage(inputImage);
//       },
//       initialDirection: CameraLensDirection.front,
//     );
//   }

//   Future<void> processImage(InputImage inputImage) async {
//     if (!_canProcess) return;
//     if (_isBusy) return;
//     _isBusy = true;
//     setState(() {
//       _text = '';
//     });
//     final faces = await _faceDetector.processImage(inputImage);
//     if (inputImage.inputImageData?.size != null &&
//         inputImage.inputImageData?.imageRotation != null) {
//       final painter = FaceDetectorPainter(
//           faces,
//           inputImage.inputImageData!.size,
//           inputImage.inputImageData!.imageRotation);
//       _customPaint = CustomPaint(painter: painter);
//     } else {
//       String text = 'Faces found: ${faces.length}\n\n';
//       for (final face in faces) {
//         text += 'face: ${face.boundingBox}\n\n';
//       }
//       _text = text;
//       // TODO: set _customPaint to draw boundingRect on top of image
//       _customPaint = null;
//     }
//     _isBusy = false;
//     if (mounted) {
//       setState(() {});
//     }
//   }
// }

// double translateX(
//     double x, InputImageRotation rotation, Size size, Size absoluteImageSize) {
//   switch (rotation) {
//     case InputImageRotation.rotation90deg:
//       return x *
//           size.width /
//           (Platform.isIOS ? absoluteImageSize.width : absoluteImageSize.height);
//     case InputImageRotation.rotation270deg:
//       return size.width -
//           x *
//               size.width /
//               (Platform.isIOS
//                   ? absoluteImageSize.width
//                   : absoluteImageSize.height);
//     default:
//       return x * size.width / absoluteImageSize.width;
//   }
// }

// double translateY(
//     double y, InputImageRotation rotation, Size size, Size absoluteImageSize) {
//   switch (rotation) {
//     case InputImageRotation.rotation90deg:
//     case InputImageRotation.rotation270deg:
//       return y *
//           size.height /
//           (Platform.isIOS ? absoluteImageSize.height : absoluteImageSize.width);
//     default:
//       return y * size.height / absoluteImageSize.height;
//   }
// }

// class FaceDetectorPainter extends CustomPainter {
//   FaceDetectorPainter(this.faces, this.absoluteImageSize, this.rotation);

//   final List<Face> faces;
//   final Size absoluteImageSize;
//   final InputImageRotation rotation;

//   @override
//   void paint(Canvas canvas, Size size) {
//     final Paint paint = Paint()
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = 1.0
//       ..color = Colors.red;

//     for (final Face face in faces) {
//       canvas.drawRect(
//         Rect.fromLTRB(
//           translateX(face.boundingBox.left, rotation, size, absoluteImageSize),
//           translateY(face.boundingBox.top, rotation, size, absoluteImageSize),
//           translateX(face.boundingBox.right, rotation, size, absoluteImageSize),
//           translateY(
//               face.boundingBox.bottom, rotation, size, absoluteImageSize),
//         ),
//         paint,
//       );

//       void paintContour(FaceContourType type) {
//         final faceContour = face.contours[type];
//         if (faceContour?.points != null) {
//           for (final Point point in faceContour!.points) {
//             canvas.drawCircle(
//                 Offset(
//                   translateX(
//                       point.x.toDouble(), rotation, size, absoluteImageSize),
//                   translateY(
//                       point.y.toDouble(), rotation, size, absoluteImageSize),
//                 ),
//                 1,
//                 paint);
//           }
//         }
//       }

//       paintContour(FaceContourType.face);
//       paintContour(FaceContourType.leftEyebrowTop);
//       paintContour(FaceContourType.leftEyebrowBottom);
//       paintContour(FaceContourType.rightEyebrowTop);
//       paintContour(FaceContourType.rightEyebrowBottom);
//       paintContour(FaceContourType.leftEye);
//       paintContour(FaceContourType.rightEye);
//       paintContour(FaceContourType.upperLipTop);
//       paintContour(FaceContourType.upperLipBottom);
//       paintContour(FaceContourType.lowerLipTop);
//       paintContour(FaceContourType.lowerLipBottom);
//       paintContour(FaceContourType.noseBridge);
//       paintContour(FaceContourType.noseBottom);
//       paintContour(FaceContourType.leftCheek);
//       paintContour(FaceContourType.rightCheek);
//     }
//   }

//   @override
//   bool shouldRepaint(FaceDetectorPainter oldDelegate) {
//     return oldDelegate.absoluteImageSize != absoluteImageSize ||
//         oldDelegate.faces != faces;
//   }
// }
