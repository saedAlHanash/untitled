import 'package:fitness_storm/core/util/my_style.dart';
import 'package:fitness_storm/core/widgets/refresh_widget/refresh_widget.dart';
import 'package:fitness_storm/features/payments/ui/widget/payment_card.dart';
import 'package:fitness_storm/features/payments/ui/widget/without_subscribed.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../../core/app/app_provider.dart';
import '../../../../core/app/app_widget.dart';
import '../../../../custome_web_page_view.dart';
import '../../../coupon/data/request/pay_request.dart';
import '../../../coupon/ui/coupon_widget.dart';
import '../../bloc/cancel_subscription_cubit/cancel_subscription_cubit.dart';
import '../../bloc/create_subscription_cubit/create_subscription_cubit.dart';
import '../../bloc/subscriptions_cubit/subscriptions_cubit.dart';
import '../../data/response/subscription_response.dart';
import '../widget/current_payment_card.dart';

class SubscriptionScreen extends StatefulWidget {
  const SubscriptionScreen({super.key});

  @override
  State<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<CreateSubscriptionCubit, CreateSubscriptionInitial>(
          listenWhen: (p, c) => c.done,
          listener: (context, state) {
            if (state.result.isEmpty) return;
            {
              Navigator.push(
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
        BlocListener<CancelSubscriptionCubit, CancelSubscriptionInitial>(
          listenWhen: (p, c) => c.done,
          listener: (context, state) {
            ctx!.read<SubscriptionsCubit>().getSubscriptions(newData: true);
          },
        ),
      ],
      child: Container(
        decoration: BoxDecoration(gradient: MyStyle.gradient),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: BlocBuilder<SubscriptionsCubit, SubscriptionsInitial>(
            builder: (context, state) {
              return RefreshWidget(
                isLoading: state.loading,
                onRefresh: () {
                  ctx!.read<SubscriptionsCubit>().getSubscriptions(newData: true);
                },
                child: SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: Get.width / 18.75, vertical: Get.height / 20.3),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        WithoutSubscribed(isSubscirbe: state.isSubscribe),
                        GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: state.result.length,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 20.0,
                            mainAxisSpacing: 15.0,
                            childAspectRatio: 1,
                          ),
                          itemBuilder: (_, i) {
                            final item = state.result[i];
                            if (item.currentSubscription) {
                              return CurrentPaymentCardWidget(subscription: item);
                            }

                            return PaymentCardWidget(
                              subscription: item,
                              onTapFunction: () => onTapSubscribe(item),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  void onTapSubscribe(Subscription item) async {
    if (AppProvider.isGuest) {
      AppProvider.showLoginDialog();
      return;
    }

    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return CouponWidget(
            subscriptionId: item.id,
            total: item.price.toString(),
          );
        },
      ),
    );

    if (result == null) return;

    var request = result as CreateSubscriptionRequest;

    request.subscriptionId = item.id;

    if (mounted) {
      context.read<CreateSubscriptionCubit>().createSubscription(request: request);
    }
  }
}
