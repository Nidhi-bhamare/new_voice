// import 'dart:convert';
// import 'dart:developer';

// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_tts/flutter_tts.dart';
// import 'package:http/http.dart' as http;
// import 'package:speech_to_text/speech_to_text.dart' as stt;

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   // ignore: library_private_types_in_public_api
//   _HomeScreenState createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   late stt.SpeechToText _speech;
//   bool _isListening = false;
//   String _spokenText = "";
//   String _responseText = "";
//   final FlutterTts _flutterTts = FlutterTts();

//   @override
//   void initState() {
//     super.initState();
//     _speech = stt.SpeechToText();

//     // Initialize TTS settings
//     _flutterTts.setLanguage("en-US");
//     _flutterTts.setSpeechRate(0.5);
//     _flutterTts.setVolume(1.0);
//     _flutterTts.setPitch(1.0);
//   }

//   Future<void> _startListening() async {
//     bool available = await _speech.initialize();
//     log("Available: $available");
//     if (available) {
//       setState(() => _isListening = true);
//       _speech.listen(onResult: (val) {
//         setState(() {
//           _spokenText = val.recognizedWords;
//           log(_spokenText);
//         });
//         _getAnswerFromAPI(_spokenText); // Send recognized speech to API
//         log(val.recognizedWords);
//       });
//     } else {
//       setState(() => _isListening = false);
//     }
//   }

//   void _stopListening() {
//     _speech.stop();
//     setState(() => _isListening = false);
//   }

//   Future<void> _speakText() async {
//     if (_responseText.isNotEmpty) {
//       var result = await _flutterTts.speak(_responseText);
//       if (kDebugMode) {
//         log("TTS Status: $result");
//       } // Debugging
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("No response to speak!")),
//       );
//     }
//   }

//   Future<void> _getAnswerFromAPI(String question) async {
//     final url = Uri.parse('http://ollama.merai.app:11434/api/generate');
//     if (kDebugMode) {
//       log("URL: $url");
//     } // Debugging
//     try {
//       final response = await http.post(
//         url,
//         headers: {'Content-Type': 'application/json'},
//         body: json.encode({
//           'model': 'llama3.2:latest', // Ensure correct model
//           'prompt': question, // Send spoken text as the prompt
//           'stream': false,
//         }),
//       );

//       if (response.statusCode == 200) {
//         final data = json.decode(response.body);
//         if (kDebugMode) {
//           log("Response: ${data['response']}");
//         } // Debugging (log the response

//         final answer = data['response']?.trim() ?? ""; // Handle null response
//         if (kDebugMode) {
//           log(answer);
//         } // Debugging
//         setState(() {
//           _responseText = answer;
//         });

//         _speakText(); // Speak the response
//       } else {
//         if (kDebugMode) {
//           log("Error: ${response.body}");
//         }
//         setState(() {
//           _responseText = "Sorry, I couldn't get the answer.";
//         });
//       }
//     } catch (error) {
//       if (kDebugMode) {
//         log("Exception: $error");
//       }
//       setState(() {
//         _responseText = "An error occurred. Please try again.";
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: [Color(0xFFA1FFCE), Color(0xFFFAFFD1)],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//         ),
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               Text(
//                 "Voice AI",
//                 style: TextStyle(
//                   fontSize: 28,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.black,
//                   letterSpacing: 2.0,
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//               SizedBox(height: 30),
//               Container(
//                 padding: EdgeInsets.all(16),
//                 decoration: BoxDecoration(
//                   color: Colors.white.withOpacity(0.8),
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: Column(
//                   children: [
//                     Text(
//                       "Spoken Text:",
//                       style: TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.black,
//                       ),
//                     ),
//                     SizedBox(height: 10),
//                     Text(
//                       _spokenText.isEmpty ? "Start speaking..." : _spokenText,
//                       style: TextStyle(fontSize: 16, color: Colors.black87),
//                       textAlign: TextAlign.center,
//                     ),
//                     SizedBox(height: 20),
//                     Text(
//                       "Response:",
//                       style: TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.black,
//                       ),
//                     ),
//                     SizedBox(height: 10),
//                     Text(
//                       _responseText.isEmpty
//                           ? "Response will appear here..."
//                           : _responseText,
//                       style: TextStyle(fontSize: 16, color: Colors.black87),
//                       textAlign: TextAlign.center,
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(height: 30),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   ElevatedButton(
//                     onPressed: _isListening ? _stopListening : _startListening,
//                     child: Text(_isListening ? "Stop" : "Listen"),
//                   ),
//                   ElevatedButton(
//                     onPressed: _speakText,
//                     child: Text("Speak"),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:http/http.dart' as http;
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:voice_ai_app/screens/edit_screen.dart';
import 'package:voice_ai_app/screens/pdf_screen.dart';
import 'package:voice_ai_app/screens/share_screen.dart';
import 'package:voice_ai_app/screens/summarize_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late stt.SpeechToText _speech;
  bool _isListening = false;
  String _spokenText = "";
  String _responseText = "";
  final FlutterTts _flutterTts = FlutterTts();

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
    _flutterTts.setLanguage("en-US");
    _flutterTts.setSpeechRate(0.5);
    _flutterTts.setVolume(1.0);
    _flutterTts.setPitch(1.0);
  }

  Future<void> _startListening() async {
    bool available = await _speech.initialize();
    log("Available: $available");
    if (available) {
      setState(() => _isListening = true);
      _speech.listen(onResult: (val) {
        setState(() {
          _spokenText = val.recognizedWords;
          log(_spokenText);
        });
        _getAnswerFromAPI(_spokenText);
        log(val.recognizedWords);
      });
    } else {
      setState(() => _isListening = false);
    }
  }

  void _stopListening() {
    _speech.stop();
    setState(() => _isListening = false);
  }

  Future<void> _speakText() async {
    if (_responseText.isNotEmpty) {
      var result = await _flutterTts.speak(_responseText);
      if (kDebugMode) {
        log("TTS Status: $result");
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("No response to speak!")),
      );
    }
  }

  Future<void> _getAnswerFromAPI(String question) async {
    final url = Uri.parse('http://ganga.merai.cloud:13551/  ');

    //              http://ollama.merai.app:11434/api/generate
    if (kDebugMode) {
      log("URL: $url");
    }
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'model': 'llama3.2:latest',
          'prompt': question,
          'stream': false,
        }),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (kDebugMode) {
          log("Response: ${data['response']}");
        }

        final answer = data['response']?.trim() ?? "";
        if (kDebugMode) {
          log(answer);
        }
        setState(() {
          _responseText = answer;
        });

        _speakText();
      } else {
        if (kDebugMode) {
          log("Error: ${response.body}");
        }
        setState(() {
          _responseText = "Sorry, I couldn't get the answer.";
        });
      }
    } catch (error) {
      if (kDebugMode) {
        log("Exception: $error");
      }
      setState(() {
        _responseText = "An error occurred. Please try again.";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Voice AI Assistant")),
      drawer: _buildDrawer(context),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFA1FFCE), Color(0xFFFAFFD1)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "Voice AI",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  letterSpacing: 2.0,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 30),
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Text(
                      "Spoken Text:",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      _spokenText.isEmpty ? "Start speaking..." : _spokenText,
                      style: TextStyle(fontSize: 16, color: Colors.black87),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20),
                    Text(
                      "Response:",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      _responseText.isEmpty
                          ? "Response will appear here..."
                          : _responseText,
                      style: TextStyle(fontSize: 16, color: Colors.black87),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: _isListening ? _stopListening : _startListening,
                    child: Text(_isListening ? "Stop" : "Listen"),
                  ),
                  ElevatedButton(
                    onPressed: _speakText,
                    child: Text("Speak"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            child: Text(
              "Options",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
          _buildMenuItem(Icons.picture_as_pdf, "Make PDF", () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        PdfScreen(responseText: _responseText)));
          }),
          _buildMenuItem(Icons.summarize, "Summarize", () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        SummarizeScreen(responseText: _responseText)));
          }),
          _buildMenuItem(Icons.edit, "Edit", () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        EditScreen(responseText: _responseText)));
          }),
          _buildMenuItem(Icons.share, "Share", () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        ShareScreen(responseText: _responseText)));
          }),
        ],
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.blue),
      title: Text(title),
      onTap: onTap,
    );
  }
}
