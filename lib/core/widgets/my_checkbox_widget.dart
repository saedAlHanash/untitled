import 'package:collection/collection.dart';
import 'package:drawable_text/drawable_text.dart';
import 'package:fitness_storm/core/widgets/spinner_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:group_button/group_button.dart';

import '../strings/app_color_manager.dart';

class MyCheckboxWidget extends StatelessWidget {
  const MyCheckboxWidget({
    super.key,
    required this.items,
    this.buttonBuilder,
    this.onSelected,
    this.isRadio,
  });

  final List<SpinnerItem> items;
  final bool? isRadio;
  final GroupButtonValueBuilder<SpinnerItem>? buttonBuilder;
  final Function(SpinnerItem value, int index, bool isSelected)? onSelected;

  factory MyCheckboxWidget.btn({
    required List<SpinnerItem> items,
  }) {
    return MyCheckboxWidget(
      items: items,
      isRadio: true,
      buttonBuilder: (selected, value, context) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 3.0).r,
          decoration: BoxDecoration(
            color: selected ? AppColorManager.mainColor : AppColorManager.whit,
            borderRadius: BorderRadius.circular(3.r),
            border: Border.all(
              color: AppColorManager.mainColor,
              width: 1.3.spMin,
            ),
          ),
          child: DrawableText(
            text: value.name ?? '',
            maxLines: 1,
            color: selected ? AppColorManager.whit : AppColorManager.mainColor,
            size: 16.0.spMin,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    int? selected;
    items.forEachIndexed((i, e) {
      if (e.isSelected) selected = i;
    });
    return GroupButton<SpinnerItem>(
      buttons: items,
      controller: GroupButtonController(selectedIndex: selected),
      buttonBuilder: buttonBuilder ??
          (selected, value, context) {
            return InkWell(
              child: SizedBox(
                width: 0.4.sw,
                height: 35.0.h,
                child: DrawableText(
                  text: value.name ?? '',
                  maxLines: 1,
                  color: /*selected ? AppColorManager.mainColorLight : */
                      AppColorManager.textColor,
                  drawableStart: Checkbox(
                    value: selected,
                    side: BorderSide(width: 1.0.spMin, color: AppColorManager.gray),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(3.0.r),
                    ),
                    fillColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                      if (states.contains(MaterialState.selected)) {
                        return AppColorManager.mainColorLight;
                      }
                      return AppColorManager.lightGrayEd;
                    }),
                    onChanged: null,
                  ),
                ),
              ),
            );
          },
      onSelected: onSelected,
      enableDeselect: !(isRadio ?? false),
      options: const GroupButtonOptions(
        crossGroupAlignment: CrossGroupAlignment.start,
        mainGroupAlignment: MainGroupAlignment.start,
        // groupingType: GroupingType.column,
      ),
      isRadio: isRadio ?? false,
    );
  }
}
