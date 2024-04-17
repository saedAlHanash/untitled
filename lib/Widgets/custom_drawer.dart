// import 'package:fitness_storm/Utils/Routes/app_pages.dart';
// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:get/get.dart';
// import 'package:url_launcher/url_launcher.dart';
//
// import '../Utils/utils.dart';
//
// class CustomDrawer extends StatelessWidget {
//   const CustomDrawer({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     // final AuthRepository authRepository = AuthRepository();
//     return Drawer(
//       child: Column(
//         children: [
//           DrawerHeader(child: Image.asset('asset/Images/logo2.png')),
//           ListTile(
//             leading: Icon(FontAwesomeIcons.user),
//             title: Text('profile'.tr),
//           ),
//           ListTile(
//             leading: Icon(FontAwesomeIcons.personCircleCheck),
//             title: Text('term_and_condition'.tr),
//           ),
//           GestureDetector(
//             onTap: () =>
//                 _launchUrl('https://www.fitnessstorm.org/PrivacyPolicy'),
//             child: ListTile(
//               leading: Icon(FontAwesomeIcons.lock),
//               title: Text('privacy_policy'.tr),
//             ),
//           ),
//           ListTile(
//             leading: Icon(FontAwesomeIcons.circleQuestion),
//             title: Text('FAQ'.tr),
//           ),
//           GestureDetector(
//             onTap: () async {
//               Utils.openLoadingDialog();
//               // await authRepository.logout();
//
//
//               ////   print(object)
//               Get.back();
//               Get.offAllNamed(AppRoutes.signIn);
//             },
//             child: ListTile(
//               leading: Icon(Icons.logout),
//               title: Text('Logout'.tr),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Future<void> _launchUrl(String url) async {
//     if (!await launchUrl(Uri.parse(url))) {
//       throw 'Could not launch $url';
//     }
//   }
// }
