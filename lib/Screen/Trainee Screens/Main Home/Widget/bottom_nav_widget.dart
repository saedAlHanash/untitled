import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';

import '../../../../core/strings/app_color_manager.dart';
import '../../../../generated/assets.dart';

class Navbar extends StatefulWidget {
  const Navbar({
    super.key,
    required this.onChange,
    required this.controller,
  });

  final Function(int) onChange;

  final PageController controller;

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  int selectedIndex = 0;

  @override
  void initState() {
    widget.controller.addListener(() {
      setState(() => selectedIndex = widget.controller.page!.toInt());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      animationDuration: const Duration(milliseconds: 300),
      backgroundColor: Colors.transparent,
      maxWidth: 1.0.sw,
      height: 60.h,
      color: AppColorManager.mainColor,
      buttonBackgroundColor: AppColorManager.mainColor,
      items: <Widget>[
        ImageMultiType(
          url: Assets.imagesHome,
          color: Colors.white,
          height: 30.0.r,
          width: 30.0.r,
        ),
        ImageMultiType(
          url: Assets.imagesSearch,
          color: Colors.white,
          height: 30.0.r,
          width: 30.0.r,
        ),
        ImageMultiType(
          url: Assets.imagesMenu,
          color: Colors.white,
          height: 30.0.r,
          width: 30.0.r,
        ),
      ],
      onTap: (index) {
        selectedIndex = index;
        widget.onChange.call(index);
      },
    );
  }
}
