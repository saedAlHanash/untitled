import 'package:bottom_picker/bottom_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThirdPage extends StatefulWidget {
  const ThirdPage({Key? key}) : super(key: key);

  @override
  State<ThirdPage> createState() => _ThirdPageState();
}

class _ThirdPageState extends State<ThirdPage> {
  bool isMetric = true;
  int currentValue = 3;
  String height = '';
  String weight = '';
  final heightController = TextEditingController(text: '');
  final weightController = TextEditingController(text: '');
  List<Text> heightCM = [];
  List<Text> heightFEET = [];
  List<Text> heightINCH = [];
  List<Text> weightKG = [];
  List<Text> weightlbs = [];

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < 500; i++) {
      if (i >= 0 && i <= 7) {
        heightFEET.add(Text(i.toString()));
      }
      if (i >= 0 && i <= 11) {
        heightINCH.add(Text(i.toString()));
      }
      if (i >= 20 && i <= 200) {
        weightKG.add(Text('$i kg'));
      }
      if (i >= 50 && i <= 500) {
        weightlbs.add(Text('$i lbs'));
      }
      if (i >= 100 && i <= 250) {
        heightCM.add(Text('$i cm'));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildQuestionTitile(),
        _buildHeader(),
        _buildTextField('Height', "Enter Your Height", heightCM, true),
        _buildTextField('Weight', "Enter Your Weight", weightKG, false),
      ],
    );
  }

  Widget _buildTextField(
      String title, String bottomTitle, List<Text> items, bool isHeight) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 50),
      child: InkWell(
        onTap: () {
          _buildNumberPicker(items, bottomTitle, isHeight);
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: const TextStyle(color: Colors.white, fontSize: 20),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: MediaQuery.of(context).size.width / 3,
              child: Center(
                child: Column(
                  children: [
                    Text(
                      isHeight ? height : weight,
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Divider(
                        height: 10,
                        thickness: 1,
                        color:
                            // _isEmpty(isHeight)
                            Colors.white
                        // : Theme.of(context).primaryColor,
                        )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // bool _isEmpty(bool isHeight) {
  //   if (isHeight && height.isEmpty) {
  //     return true;
  //   } else if (!isHeight && weight.isEmpty) {
  //     return true;
  //   } else {
  //     return false;
  //   }
  // }

  Widget _buildQuestionTitile() {
    return Text(
      'what_is_your_height/weight?'.tr,
      style: TextStyle(color: Colors.white, fontSize: 30),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width / 3,
        height: MediaQuery.of(context).size.height / 20,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Row(
            children: [
              // _buildSystemItem('Imperial', Colors.grey, Colors.green, false),
              _buildSystemItem(
                  'Metric', Theme.of(context).primaryColor, Colors.grey, true),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSystemItem(String systemName, Color firstColor,
      Color secondColor, bool changedSystemvalue) {
    return Expanded(
      flex: 1,
      child: GestureDetector(
        child: Container(
          color: isMetric ? firstColor : secondColor,
          child: Center(
            child: Text(
              systemName,
              style: const TextStyle(fontSize: 15),
            ),
          ),
        ),
        onTap: () => changeSystem(changedSystemvalue),
      ),
    );
  }

  void changeSystem(bool newSystem) {
    setState(() {
      isMetric = newSystem;
    });
    if (heightController.text.isNotEmpty) {}
  }

  void _buildNumberPicker(List<Text> items, String title, bool isheight) {
    Color color = Theme.of(context).primaryColor;
    Color color2 = Theme.of(context).colorScheme.secondary;
    BottomPicker(
      items: items,
      title: title,
      closeIconColor: color,
      iconColor: Theme.of(context).colorScheme.background,
      gradientColors: [color2, color],
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      height: MediaQuery.of(context).size.height / 2,
      pickerTextStyle: TextStyle(
        color: color,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
      onSubmit: (index) {
        if (isheight) {
          if (isMetric) {
            setState(() {
              height = heightCM[index].data!;
            });
          }
        } else {
          if (isMetric) {
            setState(() {
              weight = weightKG[index].data!;
            });
          }
        }
      },
    ).show(context);
  }
}
// TextField(
//   controller: controller,
//   keyboardType: TextInputType.number,
//   cursorColor: Colors.green,
//   decoration: InputDecoration(
//     border: UnderlineInputBorder(),
//     suffix: controller.text.isEmpty
//         ? const SizedBox()
//         : Text(
//             suffix,
//             style: const TextStyle(
//                 fontSize: 20, color: Colors.green),
//           ),
//   ),
//   style: const TextStyle(color: Colors.green, fontSize: 30),
//   textAlign: TextAlign.center,
//   onChanged: (value) => _onTextChanged(value, suffix, controller),
// ),
