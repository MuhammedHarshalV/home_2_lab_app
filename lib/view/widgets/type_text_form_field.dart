import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:icon_infoware/core/themes/colors.dart';

class TypeTextFormField extends StatelessWidget {
  final String hintText;
  final TextEditingController textController;
  final bool isSuffix;
  final bool isPreffix;
  final bool isNumberInput;
  final bool isReadOnly;
  final List<String>? dropDown;
  final Function(String)? onChanged;
  final Function(Function)? onChangedFunction;

  const TypeTextFormField({
    super.key,

    required this.hintText,
    required this.textController,
    this.isSuffix = false,
    this.isPreffix = false,
    this.isNumberInput = false,
    this.isReadOnly = false,
    this.onChanged,
    this.onChangedFunction,
    this.dropDown,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      child: TextFormField(
        readOnly: isReadOnly ? true : false,
        controller: textController,
        onChanged: onChanged,
        onTapOutside: (_) {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        // VALIDATION ONLY HERE
        validator: (value) {
          if (value == null || value.isEmpty) {
            return '$hintText is required';
          }
          return null;
        },
        keyboardType: isNumberInput ? TextInputType.number : TextInputType.text,
        inputFormatters: isNumberInput
            ? [FilteringTextInputFormatter.digitsOnly]
            : null,
        decoration: InputDecoration(
          prefixIcon: isPreffix
              ? Icon(Icons.person_2_outlined, color: AppColors.appPrimaryColor)
              : null,
          suffixIcon: isSuffix
              ? InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  onTapDown: (details) {
                    showDropDown(context, details.globalPosition, dropDown!);
                  },
                  child: Icon(Icons.arrow_drop_down, color: AppColors.appBlack),
                )
              : null,
          border: InputBorder.none,
          hintText: hintText,
          hintStyle: TextStyle(color: AppColors.appBlack),
          labelText: null,

          labelStyle: TextStyle(color: AppColors.appPrimaryColor),
          floatingLabelStyle: TextStyle(color: AppColors.appPrimaryColor),

          filled: true,
          fillColor: AppColors.appPrimaryColorLight,

          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none, // no visible border line
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.red),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.red),
          ),

          errorStyle: TextStyle(color: Colors.red),
        ),
      ),
    );
  }

  void showDropDown(
    BuildContext context,
    Offset tapPosition,
    List<String> items,
  ) async {
    final screenSize = MediaQuery.of(context).size;

    final selected = await showMenu<String>(
      context: context,
      color: AppColors.appWhite,
      position: RelativeRect.fromLTRB(
        tapPosition.dx,
        tapPosition.dy,
        screenSize.width,
        screenSize.height - tapPosition.dy,
      ),
      items: items.map((item) {
        return PopupMenuItem<String>(value: item, child: Text(item));
      }).toList(),
      constraints: BoxConstraints(maxHeight: screenSize.height / 2),
    );

    if (selected != null) {
      textController.text = selected;

      if (onChanged != null) {
        onChanged!(selected);
      }
    }
  }
}
