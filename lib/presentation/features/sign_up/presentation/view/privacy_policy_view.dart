import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfViewerPage extends StatelessWidget {
  const PdfViewerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: true,
          title: const Text("Laxmii Privacy Policy")),
      body: SfPdfViewer.network('https://www.laxmiiapp.com/t&c.pdf'),
    );
  }
}
