import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'gender_widget.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  State<FirstPage> createState() => FirstPageState();
}

class FirstPageState extends State<FirstPage> {
  bool _isMale = true;
  bool _isFemale = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: _buildGenders(),
    );
  }

  Widget _buildGenders() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'what_is_your_gender'.tr,
          style: TextStyle(color: Colors.white, fontSize: 30),
        ),
        _buildGendersRow(),
      ],
    );
  }

  Widget _buildGendersRow() {
    return Padding(
      padding: const EdgeInsets.all(70.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                _isFemale = false;
                _isMale = true;
              });
            },
            child: GenderWidget(
              coloredImagePath: 'asset/Images/male1.png',
              grayedImagePath: 'asset/Images/gray_male.png',
              gender: 'Male',
              isTapped: _isMale,
            ),
          ),
          SizedBox(width: MediaQuery.of(context).size.width / 10),
          GestureDetector(
            onTap: () {
              setState(() {
                _isMale = false;
                _isFemale = true;
              });
            },
            child: GenderWidget(
              coloredImagePath: 'asset/Images/female.png',
              grayedImagePath: 'asset/Images/gray_female.png',
              gender: 'female'.tr,
              isTapped: _isFemale,
            ),
          ),
        ],
      ),
    );
  }
}
