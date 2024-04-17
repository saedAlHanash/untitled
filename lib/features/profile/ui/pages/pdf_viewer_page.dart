import 'package:drawable_text/drawable_text.dart';
import 'package:fitness_storm/core/api_manager/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';

import '../../../../core/widgets/app_bar/app_bar_widget.dart';

class PdfViewerWidget extends StatelessWidget {
  const PdfViewerWidget({super.key, required this.url, required this.title});

  final String url;
  final String title;

  @override
  Widget build(BuildContext context) {
    loggerObject.w(url);
    return Scaffold(
      appBar: AppBarWidget(
        titleText: title,
      ),
      body: const PDF(
        swipeHorizontal: true,
      ).cachedFromUrl(url),
    );
  }
}
