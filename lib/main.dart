import 'package:flutter/material.dart';

import 'dart:async';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ImageFrameApp(),
    );
  }
}

class ImageFrameApp extends StatefulWidget {
  @override
  _ImageFrameAppState createState() => _ImageFrameAppState();
}

class _ImageFrameAppState extends State<ImageFrameApp> {
  final List<String> images = [
    'https://www.holidify.com/images/cmsuploads/compressed/phewa_20180710001256.jpeg',
    'https://www.holidify.com/images/cmsuploads/compressed/22043951124_08c344201f_h_20180710001301.jpg',
    'https://www.holidify.com/images/cmsuploads/compressed/Barun_Valley_-_Nghe_20180710001306.jpg',
    'https://www.planetware.com/wpimages/2019/12/nepal-in-pictures-beautiful-places-to-photograph-annapurna-range.jpg',
  ];

  int currentIndex = 0;
  bool isPaused = false;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    startSlideshow();
  }

  void startSlideshow() {
    _timer = Timer.periodic(Duration(seconds: 10), (timer) {
      if (!isPaused) {
        setState(() {
          currentIndex = (currentIndex + 1) % images.length;
        });
      }
    });
  }

  void togglePause() {
    setState(() {
      isPaused = !isPaused;
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(title: Text('Digital Picture Frame')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.brown, width: 10),
              borderRadius: BorderRadius.circular(15),
            ),
            padding: EdgeInsets.all(10),
            child: Image.network(
              images[currentIndex],
              width: 300,
              height: 300,
              fit: BoxFit.contain,
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: togglePause,
            child: Text(isPaused ? 'Resume' : 'Pause'),
          ),
        ],
      ),
    );
  }
}
