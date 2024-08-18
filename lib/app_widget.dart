import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';

import 'generated/assets.dart';
import 'go_route_pages.dart';
import 'injection/injection_container.dart';

const mainColor = Color(0xff3D5CFF);
const mainColorDark = Color(0xff001eb7);

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(1080,1920),
      // designSize: MediaQuery.sizeOf(context),
      minTextAdapt: true,
      builder: (context, child) {
        DrawableText.initial(
          headerSizeText: 28.0.sp,
          initialHeightText: 1.h,
          titleSizeText: 20.0.sp,
          initialSize: 14.0.sp,
          selectable: false,
          initialColor: Colors.black,
        );
        return MaterialApp.router(
          scrollBehavior: MyCustomScrollBehavior(),
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: mainColor),
            useMaterial3: true,
          ),
          builder: (context, child) {
            setImageMultiTypeErrorImage(const ImageMultiType(url: Assets.assetsAvatar));
            DrawableText.initial(
              initialColor: Colors.black,
              titleSizeText: 28.0,
              headerSizeText: 30.0,
              initialSize: 22.0,
              initialHeightText: 2.0,
              selectable: true,
              renderHtml: true,
              // textDirection: TextDirection.ltr,
            );
            return child!;
          },
          routerConfig: appGoRouter,
        );
      },
    );
  }
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}

BuildContext? get ctx => sl<GlobalKey<NavigatorState>>().currentContext;
