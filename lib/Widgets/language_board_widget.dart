import 'package:fitness_storm/common/assets.gen.dart';
import 'package:fitness_storm/extensions/widget_extensions.dart';
import 'package:fitness_storm/helper/lang_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class LanguageBoardWidget extends StatefulWidget {
  const LanguageBoardWidget({super.key, this.fromAuthPage = false});

  final bool fromAuthPage;

  @override
  State<LanguageBoardWidget> createState() => _LanguageBoardWidgetState();
}

class _LanguageBoardWidgetState extends State<LanguageBoardWidget> {
  LanguagesController languagesController = Get.find<LanguagesController>();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LangWidget(
            title: 'عربي',
            ontap: () async => await languagesController.setLanguage('ar',
                fromAuthPage: widget.fromAuthPage),
          ).padding(EdgeInsets.symmetric(vertical: 8)),
          LangWidget(
            title: 'English',
            ontap: () async => await languagesController.setLanguage('en',
                fromAuthPage: widget.fromAuthPage),
          ),
        ],
      ).padding(
        EdgeInsets.symmetric(
          horizontal: 30,
        ),
      ),
    );
  }
}

class LangWidget extends StatelessWidget {
  const LangWidget({
    super.key,
    required this.title,
    required this.ontap,
  });

  final String title;
  final VoidCallback ontap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
          color: Color(0xFF565C63).withOpacity(0.5),
          borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: SvgPicture.asset(
              Assets.images.language,
              color: Color(0xFF565C63),
              height: 30,
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              title,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          )
        ],
      ),
    ).onTap(
      () {
        ontap.call();
        Get.back();
      },
    );
  }
}
