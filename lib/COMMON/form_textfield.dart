import 'package:etkinlik_kafasi/extensions/color_data.dart';
import 'package:flutter/material.dart';
import 'package:etkinlik_kafasi/extensions/size_extension.dart';
class FormTextFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType textInputType;
  final FormFieldValidator<String> validator;
  final Function onTap;
  // String onSave;
  final String label;
  final TextInputAction textInputAction;
  final bool obscureText;

  FormTextFieldWidget(
      {Key key, this.controller, this.onTap, this.obscureText = false,this.textInputType, this.validator, this.label, this.textInputAction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.0.h),
      child: Theme(
        data: new ThemeData(
        primaryColor: Colors.redAccent,
        primaryColorDark: Colors.red,
        ),
        child: Container(
          // width: 500.0.w,
          height: 50.0.h,
          child: TextFormField(
            controller: controller,
            keyboardType: textInputType,
            autocorrect: false,
            autovalidateMode: AutovalidateMode.disabled,
            validator:validator,
            textInputAction: textInputAction,
            // onSaved: (value) => onSave = value,
            obscureText: obscureText,
            style: TextStyle(fontSize: 15.0.spByWidth),
            decoration: new InputDecoration(
              border: new OutlineInputBorder(
                borderSide: BorderSide(style: BorderStyle.solid,color: Renkler.reddetButonColor,width: 2.0.w),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(30.0.w)),
                borderSide: BorderSide(width: 2,color: Colors.black),
              ),
              enabledBorder:OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(30.0.w)),
                borderSide: controller.text.isNotEmpty ? BorderSide(width: 2.0.w,color: Colors.black) :  BorderSide(width: 2,color: Colors.purple),
              ),
              labelText: label,
              focusColor: Colors.orange,
              errorStyle: Theme.of(context)
                  .textTheme
                  .caption
                  .copyWith(fontSize: 12.0.spByWidth, color: Colors.red),

            ),

          ),
        ),
      ),
    );
  }
}
