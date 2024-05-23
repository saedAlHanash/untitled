import 'package:drawable_text/drawable_text.dart';
import 'package:fitness_storm/core/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../../Widgets/custom_button.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../core/widgets/my_text_form_widget.dart';
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
                              fontFamily: FontManager.cairoBold.name,
                              drawableAlin: DrawableAlin.between,
                              padding: const EdgeInsets.symmetric(horizontal: 10.0),
                              drawableEnd: DrawableText(
                                text: '${state.result.percentage}%',
                              ),
                            ),
                          DrawableText(
                            text: 'sup_total'.tr,
                            matchParent: true,
                            fontFamily: FontManager.cairoBold.name,
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
                              fontFamily: FontManager.cairoBold.name,
                              drawableAlin: DrawableAlin.between,
                              color: Get.theme.primaryColor,
                              padding: const EdgeInsets.symmetric(horizontal: 15.0),
                              drawableEnd: DrawableText(
                                fontFamily: FontManager.cairoBold.name,
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
                  MyTextFormWhiteWidget(
                    label: 'email'.tr,
                    controller: TextEditingController(text: request.email),
                    onChanged: (val) => request.email = val,
                  ),
                  const SizedBox(height: 10.0),
                  MyTextFormWhiteWidget(
                    label: 'name'.tr,
                    controller: TextEditingController(text: request.name),
                    onChanged: (val) => request.name = val,
                  ),
                  const SizedBox(height: 10.0),
                  MyTextFormWhiteWidget(
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
                                child: MyTextFormWhiteWidget(
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
