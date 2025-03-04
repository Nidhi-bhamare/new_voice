import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class ShareScreen extends StatelessWidget {
  final String responseText;
  ShareScreen({required this.responseText});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Share Response")),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Share.share(responseText);
          },
          child: Text("Share Response"),
        ),
      ),
    );
  }
}
