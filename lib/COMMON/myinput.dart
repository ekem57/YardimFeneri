import 'package:flutter/material.dart';
import 'package:yardimfeneri/extantion/size_extension.dart';
import 'package:yardimfeneri/extantion/size_extension.dart';

class Myinput extends StatelessWidget {
  final String hintText;
  final String errortext;
  final int satir;
  final TextEditingController controller;
  final FocusNode focusNode;
  final Widget icon;
  final FormFieldValidator<String> validate;
  final FormFieldSetter<String>  onSaved;
  final ValueChanged<String> onchange;
  final TextInputType keybordType;
  final bool passwordVisible;

  const Myinput(
      {
        Key key,
        this.hintText,
        this.errortext,
        this.satir,
        this.controller,
        this.validate,
        this.icon,
        this.onSaved,
        this.focusNode,
        this.onchange,
        this.keybordType,
        this.passwordVisible
      })
      : assert(hintText != null, onSaved != null),
        super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.all(16.0.h),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(40.0.w),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.grey.withOpacity(0.8),
                offset: const Offset(4, 4),
                blurRadius: 8),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20.0.w),
          child: SizedBox(
            height: 55.0.h,
            child: TextFormField(
              key: key,
              controller: controller,
              onChanged: onchange,
              validator: validate,
              style: TextStyle(
                fontSize: 16.0.spByWidth,
              ),
              cursorColor: Colors.blue,
              obscureText: passwordVisible,
              keyboardType: keybordType,
              decoration:InputDecoration(
                  helperText: "   ",
                  icon: Padding(
                    padding:  EdgeInsets.only(top: 15.0.h,left: 10.0.w),
                    child: icon,
                  ),
                  focusedBorder: InputBorder.none,
                  focusedErrorBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  border: InputBorder.none,
                  contentPadding:   EdgeInsets.only(top: 15.0.h),
                  errorStyle: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
                  hintText: hintText,hintStyle: TextStyle(color: Colors.black87,)),
            ),
          ),
        ),
      ),
    );
  }


}
