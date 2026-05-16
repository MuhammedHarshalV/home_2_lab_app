//otp
import 'package:flutter/material.dart';
import 'package:icon_infoware/core/themes/colors.dart';

class OtpPinField extends StatefulWidget {
  final TextEditingController pinController;
  final bool see;
  const OtpPinField({super.key, required this.pinController, this.see = false});

  @override
  State<OtpPinField> createState() => _OtpPinFieldState();
}

class _OtpPinFieldState extends State<OtpPinField> {
  final List<TextEditingController> controllers = List.generate(
    4,
    (index) => TextEditingController(),
  );

  final List<FocusNode> focusNodes = List.generate(4, (index) => FocusNode());

  @override
  void dispose() {
    for (var controller in controllers) {
      controller.dispose();
    }

    for (var node in focusNodes) {
      node.dispose();
    }

    super.dispose();
  }

  // combine all 4 digits
  void updateMainPin() {
    widget.pinController.text = controllers.map((e) => e.text).join();
  }

  Widget buildPinBox(int index) {
    return SizedBox(
      width: 60,
      height: 60,
      child: TextFormField(
        obscureText: widget.see == true ? false : true,
        obscuringCharacter: "∗",
        controller: controllers[index],
        focusNode: focusNodes[index],
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        maxLength: 1,

        decoration: InputDecoration(
          counterText: "",
          filled: true,
          fillColor: AppColors.appPrimaryColorLight,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: AppColors.appPrimaryColor, width: 2),
          ),
        ),

        onChanged: (value) {
          updateMainPin();
          if (value.isNotEmpty && index < 3) {
            FocusScope.of(context).requestFocus(focusNodes[index + 1]);
          }

          if (value.isEmpty && index > 0) {
            FocusScope.of(context).requestFocus(focusNodes[index - 1]);
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(4, (index) => buildPinBox(index)),
    );
  }
}
