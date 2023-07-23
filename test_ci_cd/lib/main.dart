import 'package:cached_network_image/cached_network_image.dart';
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
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key? key}) : super(key: key);

  final controller = Get.put(ViewerController());

  @override
  Widget build(BuildContext context) {
    print("build");
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter Interactive Viewer"),
      ),
      body: Stack(
        children: [
          RepaintBoundary(
              key: controller.globalKey,
              child: InteractiveViewer(
                transformationController: controller.transformationController,
                minScale: 1,
                maxScale: 4.0,
                onInteractionStart: (details) {
                  print("onInteractionStart");
                  controller.showBox = false;
                },
                child: CachedNetworkImage(
                  imageUrl: controller.photoA!.url!,
                  placeholder: (context, child) => SizedBox(
                      width: controller.width,
                      height: controller.height,
                      child: const Center(
                        child: CircularProgressIndicator(),
                      )),
                  errorWidget: (context, url, error) => SizedBox(
                      width: controller.width,
                      height: controller.height,
                      child: const Center(
                        child: Icon(Icons.error),
                      )),
                  fit: BoxFit.cover,
                  width: controller.width,
                  height: controller.height,
                  imageBuilder: (context, imageProvider) {
                    print("imageBuilder");
                    Future.delayed(const Duration(milliseconds: 200), () {
                      controller.capturePng();
                    });
                    return Image(image: imageProvider, fit: BoxFit.cover);
                  },
                ),
              )),
          IgnorePointer(
              ignoring: true,
              child: Obx(
                () => AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: controller.width,
                  height: controller.showBox
                      ? controller.photoA?.box1.height ?? 0
                      : 0,
                  color: controller.showBox ? Colors.black : Colors.transparent,
                ),
              )),
          Positioned(
            bottom: 0, // Position at the bottom
            child: IgnorePointer(
              ignoring: true,
              child: Obx(
                () => AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: controller.width,
                  height: controller.showBox
                      ? controller.photoA?.box2.height ?? 0
                      : 0,
                  color: controller.showBox ? Colors.black : Colors.transparent,
                ),
              ),
            ),
          )
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              controller.capturePng();
            },
            child: const Icon(Icons.camera),
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            onPressed: () async {
              await controller.animateZoomToMouthPosition();
              Future.delayed(const Duration(milliseconds: 300), () {
                controller.showBox = true;
              });
            },
            child: const Icon(Icons.mouse),
          ),
          const SizedBox(height: 10), // Optional space between FABs
          FloatingActionButton(
            onPressed: () async {
              await controller.animateZoomToEyePosition();
              Future.delayed(const Duration(milliseconds: 300), () {
                controller.showBox = true;
              });
            },
            child: const Icon(Icons.remove_red_eye_outlined),
          ),
          const SizedBox(height: 10), // Optional space between FABs
          FloatingActionButton(
            onPressed: () async {
              await controller.animateZoomToNosePosition();
              Future.delayed(const Duration(milliseconds: 300), () {
                controller.showBox = true;
              });
            },
            child: const Icon(Icons.noise_aware_outlined),
          ),
          const SizedBox(height: 10), // Optional space between FABs
          FloatingActionButton(
            onPressed: () async {
              await controller.animateZoomToFacePosition();
              Future.delayed(const Duration(milliseconds: 300), () {
                controller.showBox = true;
              });
            },
            child: const Icon(Icons.face),
          ),
        ],
      ),
    );
  }
}
