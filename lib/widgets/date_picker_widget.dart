import 'package:flutter/material.dart';

import '../components/custom_drop_down.dart';
import '../components/custom_drop_down_item.dart';

class DatePickerWidget extends StatefulWidget {
  const DatePickerWidget({Key? key, required this.action}) : super(key: key);
  final Function(DateTime) action;

  @override
  State<DatePickerWidget> createState() => _DatePickerWidgetState();
}

class _DatePickerWidgetState extends State<DatePickerWidget> {
  List<String> _getMonthDateList(DateTime date) {
    return List<String>.generate(
        DateTime(date.year, date.month + 1, 1)
            .subtract(const Duration(days: 1))
            .day,
        (i) => DateTime(date.year, date.month, 1)
            .add(Duration(days: i))
            .day
            .toString());
  }

  @override
  Widget build(BuildContext context) {
    DateTime date = DateTime.now();
    final yearSettingNotifier = ValueNotifier<String>(date.year.toString());
    final monthSettingNotifier = ValueNotifier<String>(date.month.toString());
    final dateSettingNotifier = ValueNotifier<String>(date.day.toString());
    List<String> targetMonthDateList = _getMonthDateList(date);
    List<String> targetYearDateList = List.generate(10, (i) => (date.year + i).toString());
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 10),
          child: SizedBox(
            width: 100,
            child: CustomDropDown<String>(
              valueNotifier: yearSettingNotifier,
              itemWidgetBuilder: (int index, String item) =>
                  CustomDropDownItem(item: item),
              children: targetYearDateList,
              onChanged: (String value) {
                yearSettingNotifier.value = value;
                targetMonthDateList = _getMonthDateList(DateTime(
                    int.parse(yearSettingNotifier.value),
                    int.parse(monthSettingNotifier.value)));
                widget.action(DateTime(
                    int.parse(yearSettingNotifier.value),
                    int.parse(monthSettingNotifier.value),
                    int.parse(dateSettingNotifier.value)));
              },
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(top: 10, bottom: 10, right: 5, left: 5),
          child: Text(
            '年',
            style: TextStyle(fontSize: 15),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 10),
          child: SizedBox(
            width: 100,
            child: CustomDropDown<String>(
              valueNotifier: monthSettingNotifier,
              itemWidgetBuilder: (int index, String item) =>
                  CustomDropDownItem(item: item),
              children: List.generate(11, (i) => (i + 1).toString()),
              onChanged: (String value) {
                monthSettingNotifier.value = value;
                targetMonthDateList = _getMonthDateList(DateTime(
                    int.parse(yearSettingNotifier.value),
                    int.parse(monthSettingNotifier.value)));
                widget.action(DateTime(
                    int.parse(yearSettingNotifier.value),
                    int.parse(monthSettingNotifier.value),
                    int.parse(dateSettingNotifier.value)));
              },
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(top: 10, bottom: 10, right: 5, left: 5),
          child: Text(
            '月',
            style: TextStyle(fontSize: 15),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 10),
          child: SizedBox(
            width: 100,
            child: CustomDropDown<String>(
              valueNotifier: dateSettingNotifier,
              itemWidgetBuilder: (int index, String item) =>
                  CustomDropDownItem(item: item),
              children: targetMonthDateList,
              onChanged: (String value) {
                dateSettingNotifier.value = value;
                widget.action(DateTime(
                    int.parse(yearSettingNotifier.value),
                    int.parse(monthSettingNotifier.value),
                    int.parse(dateSettingNotifier.value)));
              },
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(top: 10, bottom: 10, right: 5, left: 5),
          child: Text(
            '日',
            style: TextStyle(fontSize: 15),
          ),
        ),
      ],
    );
  }
}
