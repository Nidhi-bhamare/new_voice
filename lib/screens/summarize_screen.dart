// TODO Implement this library.
import 'package:flutter/material.dart';

class SummarizeScreen extends StatefulWidget {
  final String responseText;
  SummarizeScreen({required this.responseText});

  @override
  _SummarizeScreenState createState() => _SummarizeScreenState();
}

class _SummarizeScreenState extends State<SummarizeScreen> {
  String _summarizedText = "Summarized text will appear here.";

  void _summarizeText() {
    setState(() {
      _summarizedText =
          "Summarized: ${widget.responseText.substring(0, widget.responseText.length ~/ 2)}...";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Summarize Text")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_summarizedText, style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),
            ElevatedButton(onPressed: _summarizeText, child: Text("Summarize")),
          ],
        ),
      ),
    );
  }
}
