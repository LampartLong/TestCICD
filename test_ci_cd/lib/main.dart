import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_ci_cd/page/viewer_controller.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Interactive Viewer Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ViewerController());

    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter Interactive Viewer"),
      ),
      body: InteractiveViewer(
        transformationController: controller.transformationController,
        minScale: 1,
        maxScale: 4,
        child: Image.network(
          'https://tophinhanhdep.com/wp-content/uploads/2021/10/Beautiful-HD-Wallpapers.jpg',
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: controller.animateZoomToPosition,
        child: const Icon(Icons.home),
      ),
    );
  }
}
