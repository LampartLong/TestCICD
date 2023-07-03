import 'package:flutter/material.dart';
import 'package:ky_project/Commons/Colors/colors.dart';

class FormCustom extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final List<Widget> children;

  const FormCustom({super.key, required this.formKey, required this.children});

  @override
  State<StatefulWidget> createState() => _FormCustomState();
}

class _FormCustomState extends State<FormCustom> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Wrap(
        runSpacing: 16,
        verticalDirection: VerticalDirection.up,
        children: widget.children.reversed.toList(),
      ),
    );
  }
}

class TextFieldCustom extends StatefulWidget {
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;
  final String? label;
  final Widget? labelChild;
  final String? hintText;
  final bool? obscureText;
  final int? maxLength;
  final TextInputType? keyboardType;
  final InputDecoration? decoration;
  final ValueChanged<String>? onChanged;

  const TextFieldCustom(
      {super.key,
      required this.controller,
      this.validator,
      this.label = "",
      this.labelChild,
      this.hintText = "",
      this.obscureText = false,
      this.keyboardType = TextInputType.text,
      this.decoration,
      this.maxLength = TextField.noMaxLength,
      this.onChanged});

  @override
  State<StatefulWidget> createState() => _TextFieldCustomState();

  factory TextFieldCustom.blur({
    required TextEditingController controller,
    FormFieldValidator<String>? validator,
    String? label = "",
    String? hintText = "",
    bool? obscureText = false,
    TextInputType? keyboardType = TextInputType.text,
  }) {
    return TextFieldCustom(
      controller: controller,
      validator: validator,
      label: label,
      hintText: hintText,
      obscureText: obscureText,
      keyboardType: keyboardType,
      decoration: InputDecoration(
          hintText: hintText,
          filled: true,
          fillColor: Colors.white.withOpacity(0.2),
          counterText: "",
          hintStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
          errorMaxLines: 2,
          errorStyle: const TextStyle(height: 0),
          contentPadding: const EdgeInsets.symmetric(horizontal: 20),
          border: OutlineInputBorder(
              borderSide: const BorderSide(width: 0, style: BorderStyle.none),
              borderRadius: BorderRadius.circular(10.0))),
    );
  }
}

class _TextFieldCustomState extends State<TextFieldCustom> {
  final FocusNode _focusTextField = FocusNode();

  @override
  Widget build(BuildContext context) {
    Widget? label;

    if (widget.label!.isNotEmpty) {
      label =
          Text(widget.label!, style: TextStyle(fontSize: 16, color: tPurple));
    }

    if(widget.labelChild != null) {
      label = widget.labelChild;
    }

    return FormField<String>(
      validator: (value) => widget.validator?.call(value),
      builder: (builder) {
        return Wrap(
          runSpacing: 12,
          spacing: 10,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            label!,
            TextFormField(
              controller: widget.controller,
              focusNode: _focusTextField,
              keyboardType: widget.keyboardType,
              obscureText: widget.obscureText!,
              maxLength: widget.maxLength,
              onChanged: widget.onChanged,
              decoration: widget.decoration ??
                  InputDecoration(
                      hintText: widget.hintText,
                      filled: true,
                      fillColor: Colors.white,
                      counterText: "",
                      hintStyle: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w300),
                      errorMaxLines: 2,
                      errorStyle: const TextStyle(height: 0),
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 20),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0))),
              validator: (value) {
                if (builder.hasError) {
                  _focusTextField.requestFocus();
                  return "";
                }
                return null;
              },
            ),
            if (builder.hasError)
              Text(
                builder.errorText!,
                style: TextStyle(
                  fontSize: 12,
                  color: tError,
                ),
              )
          ],
        );
      },
    );
  }
}
