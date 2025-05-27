import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:video_player/video_player.dart';

import 'main.dart'; // So it can access `passedLessons`

class VideoEvaluationPage extends StatefulWidget {
  final String lessonTitle;

  VideoEvaluationPage({required this.lessonTitle});

  @override
  _VideoEvaluationPageState createState() => _VideoEvaluationPageState();
}


class _VideoEvaluationPageState extends State<VideoEvaluationPage> {
  File? _videoFile;
  VideoPlayerController? _controller;
  String? _result;

  Future<void> pickVideo() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.video);
    if (result != null && result.files.single.path != null) {
      final passed = Random().nextBool();
      setState(() {
        _videoFile = File(result.files.single.path!);
        _result = passed ? 'Passed ✅' : 'Fail ❌';
        if (passed) passedLessons.add(widget.lessonTitle);
      });

      _controller = VideoPlayerController.file(_videoFile!)
        ..initialize().then((_) {
          setState(() {});
          _controller!.play();
        });
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.lessonTitle} – Upload Video'),
        backgroundColor: Colors.indigo,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            ElevatedButton.icon(
              onPressed: pickVideo,
              icon: Icon(Icons.upload),
              label: Text("Upload Training Video"),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.indigo),
            ),
            SizedBox(height: 20),
            if (_videoFile != null && _controller != null && _controller!.value.isInitialized) ...[
              AspectRatio(
                aspectRatio: _controller!.value.aspectRatio,
                child: VideoPlayer(_controller!),
              ),
              SizedBox(height: 20),
              Text(
                _result ?? '',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: _result == "Passed ✅" ? Colors.green : Colors.red,
                ),
              ),
            ]
          ],
        ),
      ),
    );
  }
  
}


