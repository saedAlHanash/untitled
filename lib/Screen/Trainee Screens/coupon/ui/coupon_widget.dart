import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:image_multi_type/image_multi_type.dart';

import '../../../../Widgets/custom_button.dart';
import '../coupon_cubit/coupon_cubit.dart';
import '../data/request/pay_request.dart';

class CouponWidget extends StatefulWidget {
  const CouponWidget({super.key, required this.total, required this.subscriptionId});

  final String total;
  final String subscriptionId;

  @override
  State<CouponWidget> createState() => _CouponWidgetState();
}

class _CouponWidgetState extends State<CouponWidget> {
  final request = PayRequest();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CouponCubit(),
      child: Container(
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
        child: Scaffold(
          backgroundColor: Colors.transparent,
          bottomNavigationBar: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Transform.translate(
                offset: const Offset(0, -20.0),
                child: BlocBuilder<CouponCubit, CouponInitial>(
                  builder: (context, state) {
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 0.1,
                            blurRadius: 8,
                            offset: const Offset(0, 10), // changes position of shadow
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          if (state.result.percentage != 0)
                            DrawableText(
                              text: 'voucher'.tr,
                              matchParent: true,
                              fontFamily: FontManager.cairoBold,
                              drawableAlin: DrawableAlin.between,
                              padding: const EdgeInsets.symmetric(horizontal: 10.0),
                              drawableEnd: DrawableText(
                                text: '${state.result.percentage}%',
                              ),
                            ),
                          DrawableText(
                            text: 'sup_total'.tr,
                            matchParent: true,
                            fontFamily: FontManager.cairoBold,
                            drawableAlin: DrawableAlin.between,
                            padding: const EdgeInsets.symmetric(horizontal: 10.0),
                            drawableEnd: DrawableText(
                              text: (widget.total),
                            ),
                          ),
                          if (state.result.percentage != 0) const Divider(),
                          if (state.result.percentage != 0)
                            DrawableText(
                              text: 'net_total'.tr,
                              matchParent: true,
                              fontFamily: FontManager.cairoBold,
                              drawableAlin: DrawableAlin.between,
                              color: Get.theme.primaryColor,
                              padding: const EdgeInsets.symmetric(horizontal: 15.0),
                              drawableEnd: DrawableText(
                                fontFamily: FontManager.cairoBold,
                                text: ((num.tryParse(widget.total) ?? 0) -
                                        (((num.tryParse(widget.total) ?? 0) *
                                                state.result.percentage) /
                                            100))
                                    .toString(),
                                color: Get.theme.primaryColor,
                              ),
                            ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              CustomButton(
                onTapFunction: () => Navigator.pop(context, request),
                textColor: Get.theme.colorScheme.primary,
                buttonColor: Colors.white,
                fontSize: 16,
                text: 'continue'.tr,
              )
            ],
          ),
          appBar: AppBar(
            title: Text('coupon'.tr,
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
              onPressed: () => Get.back(),
            ),
          ),
          body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  MyTextFormNoLabelWidget(
                    label: 'email'.tr,
                    controller: TextEditingController(text: request.email),
                    onChanged: (val) => request.email = val,
                  ),
                  const SizedBox(height: 10.0),
                  MyTextFormNoLabelWidget(
                    label: 'name'.tr,
                    controller: TextEditingController(text: request.name),
                    onChanged: (val) => request.name = val,
                  ),
                  const SizedBox(height: 10.0),
                  MyTextFormNoLabelWidget(
                    label: 'phone'.tr,
                    controller: TextEditingController(text: request.phone),
                    onChanged: (val) => request.phone = val,
                  ),
                  const SizedBox(height: 10.0),
                  BlocBuilder<CouponCubit, CouponInitial>(
                    builder: (context, state) {
                      return Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: MyTextFormNoLabelWidget(
                                  label: 'coupon'.tr,
                                  color: (state.statuses == CubitStatuses.done &&
                                          state.result.percentage == 0)
                                      ? Colors.red
                                      : (state.statuses == CubitStatuses.done &&
                                              state.result.percentage != 0)
                                          ? Colors.green
                                          : null,
                                  onChanged: (val) => request.code = val,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                child: Center(
                                  child: Builder(
                                    builder: (context) {
                                      if (state.statuses.loading) {
                                        return const CircularProgressIndicator.adaptive();
                                      }
                                      return Padding(
                                        padding:
                                            const EdgeInsets.only(top: 10.0, left: 10.0),
                                        child: ElevatedButton(
                                          onPressed: () {
                                            context.read<CouponCubit>().checkCoupon(
                                                  context,
                                                  subscriptionId: widget.subscriptionId,
                                                  couponCode: request.code,
                                                );
                                          },
                                          child: Text('apply'.tr),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: 10.0),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MyTextFormNoLabelWidget extends StatelessWidget {
  const MyTextFormNoLabelWidget({
    Key? key,
    this.label = '',
    this.hint = '',
    this.maxLines = 1,
    this.obscureText = false,
    this.textAlign = TextAlign.start,
    this.maxLength = 1000,
    this.onChanged,
    this.controller,
    this.keyBordType,
    this.innerPadding,
    this.enable,
    this.icon,
    this.color,
    this.labelColor,
    this.initialValue,
    this.textDirection,
  }) : super(key: key);
  final bool? enable;
  final String label;
  final String hint;
  final String? icon;
  final Color? color;
  final Color? labelColor;
  final int maxLines;
  final int maxLength;
  final bool obscureText;
  final TextAlign textAlign;
  final Function(String val)? onChanged;
  final TextEditingController? controller;
  final TextInputType? keyBordType;
  final EdgeInsets? innerPadding;
  final String? initialValue;
  final TextDirection? textDirection;

  @override
  Widget build(BuildContext context) {
    final padding = innerPadding ?? const EdgeInsets.symmetric(horizontal: 10.0);

    bool obscureText = this.obscureText;
    Widget? suffixIcon;
    VoidCallback? onChangeObscure;

    if (icon != null) {
      suffixIcon = Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: ImageMultiType(url: icon!, height: 23.0, width: 40.0),
      );
    }

    if (obscureText) {
      suffixIcon = StatefulBuilder(builder: (context, state) {
        return IconButton(
            splashRadius: 0.01,
            onPressed: () {
              state(() => obscureText = !obscureText);
              if (onChangeObscure != null) onChangeObscure!();
            },
            icon: Icon(obscureText ? Icons.visibility : Icons.visibility_off));
      });
    }
    final border = OutlineInputBorder(
        borderSide: BorderSide(
          color: color ?? Colors.white,
        ),
        borderRadius: BorderRadius.circular(10.0));

    final inputDecoration = InputDecoration(
      contentPadding: padding,
      errorBorder: InputBorder.none,
      border: border,
      focusedErrorBorder: border,
      focusedBorder: border,
      enabledBorder: border,
      counter: const SizedBox(),
      alignLabelWithHint: true,
      labelStyle: TextStyle(color: color ?? Colors.white),
      suffixIcon: suffixIcon,
      filled: true,
      fillColor: Colors.white,
      enabled: enable ?? true,
    );

    final textStyle = TextStyle(
      fontFamily: FontManager.cairoBold.name,
      fontSize: 18.0,
      color: color ?? Colors.black,
    );

    return StatefulBuilder(builder: (context, state) {
      onChangeObscure = () => state(() {});
      return Column(
        children: [
          DrawableText(
            text: label,
            matchParent: true,
            color: labelColor ?? Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            size: 16.0,
          ),
          const SizedBox(height: 3.0),
          TextFormField(
            decoration: inputDecoration,
            maxLines: maxLines,
            initialValue: initialValue,
            obscureText: obscureText,
            textAlign: textAlign,
            onChanged: onChanged,
            style: textStyle,
            textDirection: textDirection,
            maxLength: maxLength,
            controller: controller,
            keyboardType: keyBordType,
          ),
          const SizedBox(height: 3.0),
        ],
      );
    });
  }
}

Future<dynamic> showCustomBottomSheet(BuildContext context,
    {required Widget child, Function(dynamic result)? onCancel}) async {
  final result = await showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(16.0),
        topRight: Radius.circular(16.0),
      ),
    ),
    isScrollControlled: true,
    builder: (builder) => ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(16.0),
        topRight: Radius.circular(16.0),
      ),
      child: Container(
        width: double.infinity,
        height: Get.height - (Get.height / 10),
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        padding: const EdgeInsets.all(30.0),
        child: child,
      ),
    ),
  );

  onCancel?.call(result);
}
