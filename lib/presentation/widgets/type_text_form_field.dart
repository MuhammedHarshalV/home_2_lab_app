import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:icon_infoware/controller/color_controller/color_controller.dart';
import 'package:icon_infoware/core/themes/colors.dart';

class TypeTextFormField extends ConsumerWidget {
  final String hintText;
  final TextEditingController textController;
  final bool isSuffix;
  final bool isPreffix;
  final bool isNumberInput;
  final bool isReadOnly;
  final bool isRequired;
  final List<String>? dropDown;
  final Function(String)? onChanged;
  final Function(Function)? onChangedFunction;

  const TypeTextFormField({
    super.key,
    required this.hintText,
    required this.textController,
    this.isRequired = true,
    this.isSuffix = false,
    this.isPreffix = false,
    this.isNumberInput = false,
    this.isReadOnly = false,
    this.onChanged,
    this.onChangedFunction,
    this.dropDown,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorState = ref.watch(colorProvider);

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
        validator: isRequired
            ? (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'This field is required';
                }
                return null;
              }
            : null,
        keyboardType: isNumberInput ? TextInputType.number : TextInputType.text,
        inputFormatters: isNumberInput
            ? [FilteringTextInputFormatter.digitsOnly]
            : null,
        decoration: InputDecoration(
          prefixIcon: isPreffix
              ? Icon(Icons.person_2_outlined, color: colorState.primaryColor)
              : null,
          suffixIcon: isSuffix
              ? GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      if (!context.mounted) return;

                      final RenderBox box =
                          context.findRenderObject() as RenderBox;
                      final Offset position = box.localToGlobal(Offset.zero);

                      showDropDown(
                        context,
                        Offset(position.dx, position.dy + box.size.height),
                        dropDown ?? [],
                      );
                    });
                  },
                  child: Icon(Icons.arrow_drop_down, color: AppColors.appBlack),
                )
              : null,
          border: InputBorder.none,
          hintText: hintText,
          hintStyle: TextStyle(color: AppColors.appBlack),
          labelText: null,

          labelStyle: TextStyle(color: colorState.primaryColor),
          floatingLabelStyle: TextStyle(color: colorState.primaryColor),

          filled: true,
          fillColor: colorState.secondaryColor,

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
    if (!context.mounted || items.isEmpty) return;

    final screenSize = MediaQuery.of(context).size;

    final selected = await showMenu<String>(
      context: context,
      color: AppColors.appWhite,
      position: RelativeRect.fromLTRB(
        tapPosition.dx,
        tapPosition.dy,
        screenSize.width - tapPosition.dx,
        screenSize.height - tapPosition.dy,
      ),
      items: items.map((item) {
        return PopupMenuItem<String>(value: item, child: Text(item));
      }).toList(),
      constraints: BoxConstraints(maxHeight: screenSize.height / 2),
    );

    if (!context.mounted || selected == null) return;

    textController.text = selected;

    onChanged?.call(selected);
  }
}
