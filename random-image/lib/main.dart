import 'dart:io';
import 'dart:math';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo - Random cats image',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Random cats image'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late String imageFile = '';

  @override
  void initState() {
    super.initState();
    getImage('https://source.unsplash.com/random/700x700/?cat', 'cat-700.jpg');
  }

  Future<void> getImage(String imageURL, String savePathFile) async {
    setState(() {
      imageFile = '';
    });
    final tempDir = await getTemporaryDirectory();
    final savePath = '${tempDir.path}/$savePathFile';
    await Dio().download(imageURL, savePath);
    setState(() {
      imageFile = savePath;
    });
  }

  Future<void> deleteImage(String deletePathFile) async {
    try {
      // Delete the previous image before saved new image.
      final file = File(imageFile);
      await file.delete();
    } catch (e) {
      print(e);
    }
  }

  Future<void> _randomImage() async {
    final number = 100 + Random().nextInt(900);
    final savePathFile = 'cat-$number.jpg';
    await getImage(
        'https://source.unsplash.com/random/${number}x${number}/?cat',
        savePathFile);
  }

  Future<void> _handleDownload(context) async {
    await GallerySaver.saveImage(imageFile, toDcim: true);
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Downloaded to Gallery!')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Random Meowww 😺',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w300),
            ),
            Padding(
              padding: const EdgeInsets.all(40),
              child: imageFile != ''
                  ? Image.file(File(imageFile))
                  : Image.asset(
                      'assets/images/loading-image.png',
                      height: 40,
                      width: 40,
                    ),
            ),
            const Padding(padding: EdgeInsets.all(10)),
            Padding(
              padding: const EdgeInsets.fromLTRB(100, 0, 100, 0),
              child: ElevatedButton(
                  onPressed: _randomImage,
                  style: TextButton.styleFrom(
                      shadowColor: const Color.fromRGBO(37, 42, 52, 1),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      backgroundColor: const Color.fromRGBO(37, 42, 52, 1)),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'More cat',
                        style: TextStyle(
                            color: Color.fromRGBO(255, 255, 255, 1),
                            fontWeight: FontWeight.w300),
                      ),
                      Padding(padding: EdgeInsets.all(2)),
                      Icon(
                        Icons.refresh_sharp,
                        color: Color.fromRGBO(255, 255, 255, 1),
                      )
                    ],
                  )),
            ),
            IconButton(
              icon: const Icon(Icons.file_download),
              onPressed: () => _handleDownload(context),
            )
          ],
        ),
      ),
    );
  }
}
