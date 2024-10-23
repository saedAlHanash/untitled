import 'package:drawable_text/drawable_text.dart';
import 'package:fitness_storm/core/app/app_provider.dart';
import 'package:fitness_storm/core/strings/enum_manager.dart';
import 'package:fitness_storm/core/widgets/my_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:m_cubit/abstraction.dart';

import '../../../core/app/app_widget.dart';
import '../../../core/strings/app_color_manager.dart';
import '../../../core/util/my_style.dart';
import '../../../core/widgets/app_bar/app_bar_widget.dart';
import '../../../core/widgets/my_text_form_widget.dart';
import '../../../custome_web_page_view.dart';
import '../../../generated/assets.dart';
import '../../../generated/l10n.dart';
import '../../payments/bloc/create_subscription_cubit/create_subscription_cubit.dart';
import '../../payments/bloc/subscriptions_cubit/subscriptions_cubit.dart';
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
  final request = CreateSubscriptionRequest(
    email: AppProvider.profile.email,
    name: AppProvider.profile.name,
    phone: AppProvider.profile.mobile,
  );

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<CreateSubscriptionCubit, CreateSubscriptionInitial>(
          listenWhen: (p, c) => c.done,
          listener: (context, state) {
            if (state.result.isEmpty) return;
            {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => MyCustomWebPage(urlWebPage: state.result),
                ),
              ).then((value) async {
                ctx!.read<SubscriptionsCubit>().getSubscriptions(newData: true);
              });
              // kholoud.elsayed@hotmail.com
            }
          },
        ),
      ],
      child: Container(
        decoration: BoxDecoration(gradient: MyStyle.gradient),
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
                        borderRadius: BorderRadius.circular(8.0.r),
                      ),
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          if (state.result.percentage != 0)
                            DrawableText(
                              text: S.of(context).voucher,
                              matchParent: true,
                              fontFamily: FontManager.bold.name,
                              drawableAlin: DrawableAlin.between,
                              padding: const EdgeInsets.symmetric(horizontal: 10.0),
                              drawableEnd: DrawableText(
                                text: '${state.result.percentage}%',
                              ),
                            ),
                          DrawableText(
                            text: S.of(context).supTotal,
                            matchParent: true,
                            fontFamily: FontManager.bold.name,
                            drawableAlin: DrawableAlin.between,
                            padding: const EdgeInsets.symmetric(horizontal: 10.0),
                            drawableEnd: DrawableText(
                              text: (widget.total),
                            ),
                          ),
                          if (state.result.percentage != 0) const Divider(),
                          if (state.result.percentage != 0)
                            DrawableText(
                              text: S.of(context).netTotal,
                              matchParent: true,
                              fontFamily: FontManager.bold.name,
                              drawableAlin: DrawableAlin.between,
                              color: Get.theme.primaryColor,
                              padding: const EdgeInsets.symmetric(horizontal: 15.0),
                              drawableEnd: DrawableText(
                                fontFamily: FontManager.bold.name,
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
              BlocBuilder<CreateSubscriptionCubit, CreateSubscriptionInitial>(
                builder: (context, state) {
                  return MyButton(
                    loading: state.loading,
                    text: S.of(context).continueTo,
                    color: AppColorManager.mainColor,
                    onTap: () {
                      if (!_formKey.currentState!.validate()) return;
                      request.subscriptionId = widget.subscriptionId;

                      if (mounted) {
                        context
                            .read<CreateSubscriptionCubit>()
                            .createSubscription(request: request);
                      }
                    },
                  );
                },
              ),
              30.0.verticalSpace,
            ],
          ),
          body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    SafeArea(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          BackBtnWidget(appBarColor: AppColorManager.mainColor),
                          ImageMultiType(
                            url: Assets.imagesWhiteLogo,
                            width: 0.5.sw,
                          ),
                          50.0.horizontalSpace,
                        ],
                      ),
                    ),
                    MyTextFormWhiteWidget(
                      label: S.of(context).email,
                      textAlign: TextAlign.left,
                      controller: TextEditingController(text: request.email),
                      onChanged: (val) => request.email = val,
                      validator: (p0) => p0!.isEmpty ? '' : null,
                    ),
                    10.0.verticalSpace,
                    MyTextFormWhiteWidget(
                      label: S.of(context).name,
                      controller: TextEditingController(text: request.name),
                      onChanged: (val) => request.name = val,
                      validator: (p0) => p0!.isEmpty ? '' : null,
                    ),
                    10.0.verticalSpace,
                    MyTextFormWhiteWidget(
                      label: S.of(context).phone,
                      textAlign: TextAlign.left,
                      keyBordType: TextInputType.phone,
                      controller: TextEditingController(text: request.phone),
                      onChanged: (val) => request.phone = val,
                      validator: (p0) => p0!.isEmpty ? '' : null,
                    ),
                    10.0.verticalSpace,
                    BlocBuilder<CouponCubit, CouponInitial>(
                      builder: (context, state) {
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Expanded(
                              flex: 3,
                              child: MyTextFormWhiteWidget(
                                validator: (p0) => null,
                                label:
                                    '${S.of(context).coupon} (${S.of(context).optional})',
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
                            10.0.horizontalSpace,
                            Expanded(
                              child: BlocBuilder<CouponCubit, CouponInitial>(
                                builder: (context, state) {
                                  return MyButton(
                                    color: Colors.white,
                                    textColor: AppColorManager.mainColor,
                                    loading: state.loading,
                                    onTap: () {
                                      context.read<CouponCubit>().checkCoupon(
                                            context,
                                            subscriptionId: widget.subscriptionId,
                                            couponCode: request.code,
                                          );
                                    },
                                    text: S.of(context).apply,
                                  );
                                },
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                    10.0.verticalSpace,
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
