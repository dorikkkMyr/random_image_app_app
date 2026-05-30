import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const RandomImageApp());
}

class RandomImageApp extends StatelessWidget {
  const RandomImageApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Случайная картинка',
      theme: ThemeData(
        fontFamily: 'Gropled',
      ),
      home: const RandomImagePage(),
    );
  }
}

class RandomImagePage extends StatefulWidget {
  const RandomImagePage({super.key});

  @override
  State<RandomImagePage> createState() => _RandomImagePageState();
}

class _RandomImagePageState extends State<RandomImagePage> {
  int imageWidth = 400;
  int imageHeight = 300;

  int currentSizeIndex = 0;

  String imageUrl = '';

  final List<Map<String, int>> imageSizes = [
    {'width': 400, 'height': 300},
    {'width': 500, 'height': 350},
    {'width': 600, 'height': 400},
    {'width': 700, 'height': 500},
  ];

  @override
  void initState() {
    super.initState();
    loadRandomImage();
  }

  void loadRandomImage() {
    final randomSeed = Random().nextInt(100000);

    setState(() {
      imageUrl =
         'https://cataas.com/cat?width=$imageWidth&height=$imageHeight&random=$randomSeed';
    });
  }

  void changeImageSize() {
    setState(() {
      currentSizeIndex++;

      if (currentSizeIndex >= imageSizes.length) {
        currentSizeIndex = 0;
      }

      imageWidth = imageSizes[currentSizeIndex]['width']!;
      imageHeight = imageSizes[currentSizeIndex]['height']!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),

      appBar: AppBar(
        toolbarHeight: 90,
        backgroundColor: const Color(0xfffdcfd4),
        centerTitle: true,
        elevation: 0,

        title: const Text(
          'Случайная картинка\nкотиков',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: Center(
        child: Container(
          margin: const EdgeInsets.all(24),
          padding: const EdgeInsets.all(24),

          decoration: BoxDecoration(
            color: const Color(0xffedaab3),

            borderRadius: BorderRadius.circular(30),

            border: Border.all(
              color: Colors.black,
              width: 2,
            ),
          ),

          child: Column(
            mainAxisSize: MainAxisSize.min,

            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(25),

                child: Image.network(
                  imageUrl,

                  key: ValueKey(imageUrl),

                  width: imageWidth.toDouble(),
                  height: imageHeight.toDouble(),

                  fit: BoxFit.cover,

                  loadingBuilder:
                      (context, child, loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    }

                    return SizedBox(
                      width: imageWidth.toDouble(),
                      height: imageHeight.toDouble(),

                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 20),

              Text(
                'Размер: $imageWidth x $imageHeight px',

                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 25),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,

                children: [
                  customButton(
                    text: 'Обновить',
                    onPressed: loadRandomImage,
                  ),

                  const SizedBox(width: 16),

                  customButton(
                    text: 'Сменить размер',
                    onPressed: changeImageSize,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget customButton({
    required String text,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton(
      onPressed: onPressed,

      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xffafc28a),
        foregroundColor: Colors.black,

        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 15,
        ),

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),

          side: const BorderSide(
            color: Colors.black,
            width: 2,
          ),
        ),
      ),

      child: Text(
        text,

        style: const TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}