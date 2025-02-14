import 'package:flutter/material.dart';

class RadioButtonWidget extends StatelessWidget {
  final bool value;
  final String title;
  final Function(bool) onChanged;

  const RadioButtonWidget(
      {super.key,
        required this.value,
        required this.title,
        required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        onChanged(!value);
      },
      child: Row(
        children: [
          Radio<bool>(
            value: value,
            groupValue: true,
            onChanged: (_) {
              onChanged(!value);
            },
          ),
          Text(title)
        ],
      ),
    );
  }
}
