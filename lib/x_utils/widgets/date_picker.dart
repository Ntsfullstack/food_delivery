import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../base/base_controller.dart';

class DatePicker extends StatefulWidget {
  final Function(DateTime) onChange;
  final DateTime? initialDateTime;
  final DateTime? maximumDate;
  final DateTime? minimumDate;
  final int? maximumYear;

  const DatePicker({
    Key? key,
    required this.onChange,
    this.initialDateTime,
    this.maximumDate,
    this.maximumYear,
    this.minimumDate,
  }) : super(key: key);

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  var dateSelect = DateTime.now();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dateSelect = widget.initialDateTime ?? DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * 0.33,
      color: Colors.white,
      child: Column(
        children: [
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                CupertinoButton(
                  child: Text(XR().string.cancel),
                  onPressed: () {
                    Get.back();
                  },
                ),
                CupertinoButton(
                  child: Text("Confirm"),
                  onPressed: () {
                    widget.onChange(dateSelect);
                    Get.back();
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              dateOrder: DatePickerDateOrder.dmy,
              onDateTimeChanged: (dateSelect) => this.dateSelect = dateSelect,
              maximumYear: widget.maximumYear ?? DateTime.now().year,
              maximumDate: widget.maximumDate,
              minimumDate: widget.minimumDate,
              initialDateTime: widget.initialDateTime,
            ),
          ),
        ],
      ),
    );
  }
}
