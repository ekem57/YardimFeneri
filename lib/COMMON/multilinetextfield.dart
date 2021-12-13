import 'package:flutter/material.dart';
import 'package:yardimfeneri/extantion/size_extension.dart';

class MultilineTextField extends StatelessWidget {
  final String hintText;
  final String? errortext;
  final int? satir;
  final  TextEditingController controller;
  final  FocusNode? focusNode;
  final Widget icon;
  final FormFieldValidator<String>? validate;
  final FormFieldSetter<String>  onSaved;
  final ValueChanged<String>? onchange;
  final TextInputType keybordType;
  final bool passwordVisible;

  const MultilineTextField(
      {
        required this.hintText,
        this.errortext,
        this.satir,
        required this.controller,
        this.validate,
        required this.icon,
        required this.onSaved,
        this.focusNode,
        this.onchange,
        required this.keybordType,
        required this.passwordVisible
      })
      : assert(hintText != null, onSaved != null);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.all(16.0.w),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30.0.w),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.grey.withOpacity(0.8),
                offset: const Offset(4, 4),
                blurRadius: 8),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10.0.w),
          child: TextFormField(
            controller: controller,
            onChanged: onchange,
            validator: validate,
            style: TextStyle(
              fontSize: 16.0.spByWidth,
            ),
            cursorColor: Colors.blue,
            keyboardType: TextInputType.multiline,
            minLines: 4,
            maxLines: 4,
            decoration:InputDecoration(
                helperText: "   ",
                icon: Padding(
                  padding:  EdgeInsets.only(top: 13.0.h,left: 10.0.w),
                  child: icon,
                ),
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                border: InputBorder.none,
                contentPadding:  const EdgeInsets.only(top: 5),
                errorStyle: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
                hintText: hintText,hintStyle: TextStyle(color: Colors.black87)),
          ),
        ),
      ),
    );
  }
}
