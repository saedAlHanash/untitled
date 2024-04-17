// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:image_multi_type/circle_image_widget.dart';
// import 'package:image_multi_type/image_multi_type.dart';
// import 'package:fitness_storm/core/strings/app_color_manager.dart';
//
// import '../../../../generated/assets.dart';
//
//
// class NewNav extends StatefulWidget {
//   const NewNav({
//     Key? key,
//     required this.controller,
//     required this.onChange,
//   }) : super(key: key);
//
//   final PageController controller;
//   final Function(int) onChange;
//
//   @override
//   State<NewNav> createState() => _NewNavState();
// }
//
// class _NewNavState extends State<NewNav> {
//   int selectedIndex = 0;
//
//   @override
//   void initState() {
//     widget.controller.addListener(() {
//       setState(() {
//         selectedIndex = widget.controller.page!.toInt();
//       });
//     });
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       clipBehavior: Clip.hardEdge,
//       decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.all(
//             Radius.circular(18.0.r),
//           ),
//           boxShadow: [
//             BoxShadow(
//                 color: AppColorManager.black.withOpacity(0.09),
//                 blurRadius: 15,
//                 offset: const Offset(0, 5))
//           ]),
//       child: BottomNavigationBar(
//         backgroundColor: Colors.white,
//         showSelectedLabels: false,
//         showUnselectedLabels: false,
//         elevation: 0.0,
//         items: <BottomNavigationBarItem>[
//           BottomNavigationBarItem(
//             icon: ImageMultiType(
//               url: Assets.iconsHome,
//               color: Colors.grey,
//               height: 25.0.spMin,
//             ),
//             activeIcon: ImageMultiType(
//               url: Assets.iconsHome,
//               color: AppColorManager.mainColor,
//               height: 25.0.spMin,
//             ),
//             label: '',
//           ),
//           BottomNavigationBarItem(
//             icon: ImageMultiType(
//               url: Assets.iconsCart,
//               color: Colors.grey,
//               height: 25.0.spMin,
//             ),
//             activeIcon: ImageMultiType(
//               url: Assets.iconsCart,
//               color: AppColorManager.mainColor,
//               height: 25.0.spMin,
//             ),
//             label: '',
//           ),
//           BottomNavigationBarItem(
//             icon: ImageMultiType(
//               url: Assets.iconsReports,
//               color: Colors.grey,
//               height: 25.0.spMin,
//             ),
//             activeIcon: ImageMultiType(
//               url: Assets.iconsReports,
//               color: AppColorManager.mainColor,
//               height: 25.0.spMin,
//             ),
//             label: '',
//           ),
//           BottomNavigationBarItem(
//             icon: SizedBox(
//               height: 25.0.r,
//               width: 25.0.r,
//               child: BlocBuilder<ProfileCubit, ProfileInitial>(
//                 builder: (context, state) {
//                   return CircleImageWidget(
//                     url: AppProvider.myUser.logo,
//                     color: Colors.white,
//                     size: 25.0.spMin,
//                   );
//                 },
//               ),
//             ),
//             activeIcon: Container(
//               height: 25.0.r,
//               width: 25.0.r,
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 border: Border.all(color: AppColorManager.mainColor),
//               ),
//               alignment: Alignment.center,
//               child: CircleImageWidget(
//                 url: AppProvider.myUser.logo,
//                 color: Colors.white,
//                 size: 25.0.spMin,
//               ),
//             ),
//             label: '',
//           ),
//         ],
//         currentIndex: selectedIndex,
//         onTap: (value) {
//           // if (context.read<ProfileCubit>().state.statuses.loading) return;
//           widget.onChange.call(value);
//           setState(() => selectedIndex = value);
//         },
//         type: BottomNavigationBarType.fixed,
//       ),
//     );
//   }
// }
