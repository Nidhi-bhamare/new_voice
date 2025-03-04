import 'package:flutter/material.dart';
import 'package:voice_ai_app/splash_screen.dart';

void main() {
  runApp(SpeechToTextApp());
}

class SpeechToTextApp extends StatelessWidget {
  const SpeechToTextApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Voice Ai',
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      home: SplashScreen(),
    );
  }
}
