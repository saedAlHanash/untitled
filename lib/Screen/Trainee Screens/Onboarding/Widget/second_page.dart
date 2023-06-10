import 'package:flutter/material.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class SecondPage extends StatefulWidget {
  const SecondPage({Key? key}) : super(key: key);

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  String date = '';
  DateTime? _selectedDate = DateTime(1960);
  DateFormat dateFormat = DateFormat("dd MMM yyyy ");

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [_buildHeader(), _buildDatePickerV2()],
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        Text(
          'what_is_your_birthday?'.tr,
          style: TextStyle(fontSize: 30),
        ),
        const SizedBox(height: 30),
        Text(
          dateFormat.format(_selectedDate!),
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontSize: 30,
          ),
        ),
      ],
    );
  }

  Widget _buildDatePickerV2() {
    return Padding(
      padding: EdgeInsets.all(MediaQuery.of(context).size.width / 6),
      child: DatePickerWidget(
        looping: false,
        firstDate: DateTime(1960),
        lastDate: DateTime.now(),
        dateFormat: "dd/MMM/yyyy",
        onChange: (DateTime newDate, _) {
          setState(() {
            _selectedDate = newDate;
          });
        },
        initialDate: DateTime(1960),
        pickerTheme: DateTimePickerTheme(
          itemHeight: 50,
          titleHeight: 50,
          backgroundColor: Colors.white.withOpacity(0),
          itemTextStyle: const TextStyle(color: Colors.white, fontSize: 20),
          dividerColor: Colors.grey[500],
        ),
      ),
    );
  }
}
