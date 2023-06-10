import 'package:fitness_storm/Screen/Trainee%20Screens/BookPrivateSession/Widget/book_private_session_header.dart';
import 'package:fitness_storm/Screen/Trainee%20Screens/BookPrivateSession/Widget/date_sheet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import 'book_private_session_controller.dart';

class BookPrivateSessionScreen extends StatefulWidget {
  const BookPrivateSessionScreen({super.key});

  @override
  State<BookPrivateSessionScreen> createState() =>
      _BookPrivateSessionScreenState();
}

class _BookPrivateSessionScreenState extends State<BookPrivateSessionScreen> {
  double _panelHeightOpen = 800;
  double _panelHeightClosed = 400.0;

  @override
  void initState() {
    super.initState();
    Get.lazyPut(() => BookPrivateSessionController());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () => Get.back()),
        title: Text('available_sessions'.tr),
        titleTextStyle:
            const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
      body: SlidingUpPanel(
          maxHeight: _panelHeightOpen,
          minHeight: _panelHeightClosed,
          // parallaxEnabled: true,
          // parallaxOffset: .5,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(18.0), topRight: Radius.circular(18.0)),
          body: Container(
            width: Get.width,
            height: Get.height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Get.theme.primaryColor,
                  Get.theme.colorScheme.secondary,
                ],
              ),
            ),
            child: const BookPrivateSessionHeader(),
          ),
          panel: const DateSheet()),
    );
  }
}
