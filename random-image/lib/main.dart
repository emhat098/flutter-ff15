import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
  String imgUrl = 'https://source.unsplash.com/random/700×700/?cat';
  String image = '';
  final _random = Random();

  void _randomImage() {
    final number = 100 + _random.nextInt(900);
    setState(() {
      image = "https://source.unsplash.com/random/$number×$number/?cat";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Random cats 😺',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w300),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Image.network(
                image == '' ? imgUrl : image,
              ),
            ),
            const Padding(padding: EdgeInsets.all(10)),
            Padding(
              padding: const EdgeInsets.fromLTRB(100, 0, 100, 0),
              child: ElevatedButton(
                  onPressed: _randomImage,
                  style: TextButton.styleFrom(
                      shadowColor: Color.fromRGBO(37, 42, 52, 1),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      backgroundColor: Color.fromRGBO(37, 42, 52, 1)),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Get new image',
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
          ],
        ),
      ),
    );
  }
}
