// import 'package:flutter/material.dart';

// class ZoomableImageView extends StatefulWidget {
//   const ZoomableImageView({super.key});

//   @override
//   _ZoomableImageViewState createState() => _ZoomableImageViewState();
// }

// class _ZoomableImageViewState extends State<ZoomableImageView> with SingleTickerProviderStateMixin {
//   late AnimationController _animationController;
//   double _scale = 1.0;
//   double _previousScale = 1.0;
//   final double _desiredScale = 2.0; // Giá trị zoom mong muốn

//   @override
//   void initState() {
//     super.initState();
//     _animationController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 200), // Thời gian hoạt động zoom
//     );
//   }

//   @override
//   void dispose() {
//     _animationController.dispose();
//     super.dispose();
//   }

//   void _onScaleStart(ScaleStartDetails details) {
//     _previousScale = _scale;
//   }

//   void _onScaleUpdate(ScaleUpdateDetails details) {
//     setState(() {
//       _scale = _previousScale * details.scale;
//     });
//   }

//   void _onScaleEnd(ScaleEndDetails details) {
//     if (_scale < 1.0) {
//       _scale = 1.0;
//     } else if (_scale > _desiredScale) {
//       _scale = _desiredScale;
//     }

//     _animationController.animateTo(_scale, curve: Curves.easeOut);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return InteractiveViewer(
//       minScale: 1.0,
//       maxScale: _desiredScale,
//       scaleEnabled: false, // Vô hiệu hóa chế độ zoom mặc định để sử dụng zoom tùy chỉnh của chúng ta
//       onInteractionStart: _onScaleStart,
//       onInteractionUpdate: _onScaleUpdate,
//       onInteractionEnd: _onScaleEnd,
//       transformationController: Matrix4TransformController(_animationController),
//       child: Image.network('https://example.com/image.jpg'), // Thay thế bằng đường dẫn ảnh thực tế của bạn
//     );
//   }
// }

// class Matrix4TransformController extends TransformationController {
//   final Animation<double> _animation;

//   Matrix4TransformController(this._animation) : super(animation: _animation) {
//     _animation.addStatusListener((status) {
//       if (status == AnimationStatus.completed) {
//         _animation.value = 1.0;
//       }
//     });
//   }
// }
