import 'package:flutter/material.dart';
import 'package:ky_project/Commons/Colors/colors.dart';

class CheckboxCustom extends StatefulWidget {
  final ValueChanged<bool> onChanged;
  final String? title;
  final bool? isChecked;

  const CheckboxCustom(
      {super.key,
      required this.onChanged,
      this.isChecked = false,
      this.title = ""});

  @override
  State<CheckboxCustom> createState() => _CheckboxCustomState();
}

class _CheckboxCustomState extends State<CheckboxCustom> {
  late bool _isChecked;

  @override
  void initState() {
    _isChecked = widget.isChecked!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(unselectedWidgetColor: iGrey),
      child: ListTileTheme(
        horizontalTitleGap: 0,
        child: CheckboxListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(widget.title!,
              style: TextStyle(
                fontSize: 14,
                color: tGrey,
              )),
          activeColor: Colors.grey,
          controlAffinity: ListTileControlAffinity.leading,
          value: _isChecked,
          onChanged: (bool? value) {
            widget.onChanged.call(value!);
            setState(() {
              _isChecked = value;
            });
          },
        ),
      ),
    );
  }
}
