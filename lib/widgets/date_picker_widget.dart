import 'package:flutter/material.dart';
import 'package:si_proto/utils/constants_text.dart';

import '../components/custom_drop_down.dart';
import '../components/custom_drop_down_item.dart';

class DatePickerWidget extends StatefulWidget {
  const DatePickerWidget({Key? key, required this.dateTimeUpdateFunc}) : super(key: key);
  final Function(DateTime) dateTimeUpdateFunc;

  @override
  State<DatePickerWidget> createState() => _DatePickerWidgetState();
}

class _DatePickerWidgetState extends State<DatePickerWidget> {
  @override
  Widget build(BuildContext context) {
    DateTime date = DateTime.now();
    final yearSettingNotifier = ValueNotifier<String>(date.year.toString());
    final monthSettingNotifier = ValueNotifier<String>(date.month.toString());
    final dateSettingNotifier = ValueNotifier<String>(date.day.toString());
    List<String> targetMonthDateList = _getMonthDateList(date);
    List<String> targetYearDateList =
        List.generate(10, (i) => (date.year + i).toString());
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
                _updateDateTime(yearSettingNotifier, monthSettingNotifier,
                    dateSettingNotifier);
              },
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(top: 10, bottom: 10, right: 5, left: 5),
          child: Text(
            ConstantsText.year,
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
                _updateDateTime(yearSettingNotifier, monthSettingNotifier,
                    dateSettingNotifier);
              },
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(top: 10, bottom: 10, right: 5, left: 5),
          child: Text(
            ConstantsText.month,
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
                _updateDateTime(yearSettingNotifier, monthSettingNotifier,
                    dateSettingNotifier);
              },
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(top: 10, bottom: 10, right: 5, left: 5),
          child: Text(
            ConstantsText.date,
            style: TextStyle(fontSize: 15),
          ),
        ),
      ],
    );
  }

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

  void _updateDateTime(
      ValueNotifier<String> yearSettingNotifier,
      ValueNotifier<String> monthSettingNotifier,
      ValueNotifier<String> dateSettingNotifier) {
    widget.dateTimeUpdateFunc(DateTime(
        int.parse(yearSettingNotifier.value),
        int.parse(monthSettingNotifier.value),
        int.parse(dateSettingNotifier.value)));
  }
}
