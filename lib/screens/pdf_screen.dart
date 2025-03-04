import 'package:flutter/material.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class PdfScreen extends StatelessWidget {
  final String responseText;
  PdfScreen({required this.responseText});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Generate PDF")),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            final pdf = pw.Document();
            pdf.addPage(
              pw.Page(
                build: (pw.Context context) => pw.Center(
                  child:
                      pw.Text(responseText, style: pw.TextStyle(fontSize: 20)),
                ),
              ),
            );
            await Printing.layoutPdf(onLayout: (format) async => pdf.save());
          },
          child: Text("Create PDF"),
        ),
      ),
    );
  }
}
