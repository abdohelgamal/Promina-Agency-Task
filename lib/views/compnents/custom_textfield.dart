import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:promina_agency_task/shared/constants.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {super.key,
      required this.label,
      required this.controller,
      required this.formKey});
  final GlobalKey<FormState> formKey;
  final String label;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 25.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(label, style: TextStyle(color: primaryColor, fontSize: 17.sp)),
            TextFormField(style: TextStyle(fontSize: 20.sp),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please Enter This Field';
                } else {
                  return null;
                }
              },
              onChanged: (value) {
                formKey.currentState!.validate();
              },
              controller: controller,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: primaryColor, style: BorderStyle.none)),
              ),
            ),
          ],
        ));
  }
}
