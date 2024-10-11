import 'package:fitness_storm/core/strings/app_color_manager.dart';
import 'package:fitness_storm/core/widgets/my_text_form_widget.dart';
import 'package:fitness_storm/features/search/ui/widget/term_and_condition_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';

import '../../../../generated/assets.dart';
import '../../../../generated/l10n.dart';
import '../../../../router/app_router.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1.0.sh,
      width: 1.0.sw,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            AppColorManager.mainColor,
            AppColorManager.secondColor,
          ],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Spacer(),
          SizedBox(
            width: 0.6.sw,
            child: ImageMultiType(url: Assets.imagesWhiteLogo),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.all(40.0),
            child: MyTextFormOutLineWidget1(
              controller: controller,
              color: Colors.white,
              hint: S.of(context).whatAreYouSearchingFor,
              titleLabel: S.of(context).whatAreYouSearchingFor,
              lableColor: Colors.white,
              onFieldSubmitted: (p0) {
                if (p0.isEmpty) return;
                startSearchResultPage(p0);
              },
              iconWidgetLift: GestureDetector(
                onTap: () {
                  if (controller.text.isEmpty) return;
                  startSearchResultPage(controller.text);
                },
                child: _SearchIcon(),
              ),
            ),
          ),
          Spacer(),
          TermAndConditionWidget(),
          Spacer(),
          // const TermAndConditionWidget(),
        ],
      ),
    );
  }
}

class _SearchIcon extends StatelessWidget {
  const _SearchIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColorManager.secondColor.withOpacity(0.2),
      ),
      padding: const EdgeInsets.all(5.0),
      margin: const EdgeInsets.all(5.0),
      child: const ImageMultiType(
        url: Assets.imagesSearch,
        color: AppColorManager.secondColor,
      ),
    );
  }
}
