import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FourthPage extends StatefulWidget {
  const FourthPage({Key? key}) : super(key: key);

  @override
  State<FourthPage> createState() => _FourthPageState();
}

class _FourthPageState extends State<FourthPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'all_finished!'.tr,
          style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 30),
        ),
        const SizedBox(height: 20),
        Text(
          'that\'s_all_we_need_for_now'.tr,
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'now_go_crush_it'.tr,
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            SizedBox(
                width: MediaQuery.of(context).size.width / 15,
                child: Image.asset('asset/Images/punch.png'))
          ],
        ),
      ],
    );
  }
}
