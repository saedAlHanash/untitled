import 'package:fitness_storm/core/extensions/extensions.dart';
import 'package:fitness_storm/core/widgets/app_bar/app_bar_widget.dart';
import 'package:fitness_storm/features/welcome_message/ui/widget/item_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/util/my_style.dart';
import '../../../../generated/l10n.dart';
import '../../bloc/welcome_messages_cubit/welcome_messages_cubit.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(titleText: S.of(context).welcomeMessage),
      body: BlocBuilder<WelcomeMessagesCubit, WelcomeMessagesInitial>(
        builder: (context, state) {
          if (state.statuses.loading) {
            return MyStyle.loadingWidget();
          }
          return ListView.builder(
            itemCount: state.result.length,
            itemBuilder: (context, i) {
              return ItemMessage(item: state.result[i]);
            },
          );
        },
      ),
    );
  }
}
