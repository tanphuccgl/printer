import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:printer/src/theme/colors.dart';
import 'package:printer/src/utils/helper/radius.dart';

class XInput extends StatefulWidget {
  const XInput({
    required this.value,
    Key? key,
    this.onChanged,
    this.readOnly = false,
    this.onTap,
    this.keyboardType,
    this.obscureText = false,
    this.hintText,
    this.textAlign = TextAlign.left,
    this.style,
    this.maxLength,
    this.autofocus = false,
    this.inputFormatters,
    this.prefixIcon,
    this.contentPadding,
    this.errorText,
    this.hintStyle,
    this.enabledBorder,
    this.focusedBorder,
    this.maxLines = 1,
    this.border,
    this.isAction = true,
    this.helperText = " ",
    this.isDense = false,
    this.onSubmitted,
    this.textCapitalization = TextCapitalization.none,
    this.enabled = true,
    this.hintMaxLines,
    this.counterText,
    this.errorBorder,
    this.cursorColor,
    this.fillColor,
    this.showArrowIcon = false,
  }) : super(key: key);

  final String value;
  final TextInputType? keyboardType;
  final bool obscureText;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onTap;
  final String? hintText;
  final int? maxLength;
  final bool autofocus;
  final bool readOnly;
  final Widget? prefixIcon;
  final String? errorText;
  final TextAlign textAlign;
  final TextStyle? style;
  final TextStyle? hintStyle;
  final List<TextInputFormatter>? inputFormatters;
  final EdgeInsetsGeometry? contentPadding;
  final InputBorder? enabledBorder;
  final InputBorder? focusedBorder;
  final InputBorder? border;
  final InputBorder? errorBorder;
  final int? maxLines;
  final bool isAction;
  final String? helperText;
  final bool isDense;
  final Function(String value)? onSubmitted;
  final TextCapitalization textCapitalization;
  final bool? enabled;
  final int? hintMaxLines;
  final String? counterText;
  final Color? cursorColor;
  final Color? fillColor;
  final bool showArrowIcon;

  @override
  State<XInput> createState() => _XInputState();
}

class _XInputState extends State<XInput> {
  late TextEditingController _controller;
  String get value => widget.value;
  bool obscureText = false;
  late FocusNode _focusNode;
  late bool filled;

  @override
  void initState() {
    super.initState();
    obscureText = widget.obscureText;
    filled = false;
    _controller = TextEditingController(text: widget.value);
    _focusNode = FocusNode();
    _focusNode.addListener(() {
      setState(() {
        filled = !filled;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(XInput oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (_controller.text != widget.value) {
      _controller.text = widget.value;
    }
  }

  Widget? _buildActions() {
    final List<Widget> actions = [];
    if (widget.obscureText && widget.isAction) {
      actions.add(
        IconButton(
          padding: EdgeInsets.zero,
          onPressed: () => setState(() {
            obscureText = !obscureText;
          }),
          icon: Icon(
            obscureText ? Icons.visibility : Icons.visibility_off,
            color: widget.errorText != null ? Colors.red : XColors.primary,
          ),
        ),
      );
    }

    if (widget.showArrowIcon) {
      actions.add(
        const Icon(Icons.arrow_drop_down_outlined),
      );
    }
    if (actions.isEmpty) {
      return null;
    }
    if (actions.length == 1) {
      return actions.first;
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: actions,
    );
  }

  @override
  Widget build(BuildContext context) {
    final enabledBorder = OutlineInputBorder(
      borderSide: const BorderSide(color: XColors.borderInput, width: 0),
      borderRadius: BorderHelper.r10,
    );
    final focusedBorder = OutlineInputBorder(
      borderSide: const BorderSide(color: XColors.primary, width: 0),
      borderRadius: BorderHelper.r10,
    );
    final errorBorder = OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.red, width: 0),
      borderRadius: BorderHelper.r10,
    );

    return TextField(
      controller: _controller,
      focusNode: _focusNode,
      decoration: InputDecoration(
        labelStyle: const TextStyle(color: Color(0xCC50555C)),
        hintText: widget.hintText,
        hintStyle: widget.hintStyle ?? Theme.of(context).textTheme.labelLarge,
        hintMaxLines: widget.hintMaxLines,
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        isDense: widget.isDense,
        contentPadding: widget.contentPadding ??
            const EdgeInsets.symmetric(vertical: 11, horizontal: 15),
        prefixIcon: widget.prefixIcon,
        suffixIcon: _buildActions(),
        counterStyle: const TextStyle(color: XColors.borderInput),
        filled: true,
        fillColor: XColors.primary2,
        errorBorder: widget.errorBorder ?? errorBorder,
        focusedBorder: widget.focusedBorder ?? focusedBorder,
        focusedErrorBorder: widget.focusedBorder ?? errorBorder,
        enabledBorder: widget.enabledBorder ?? enabledBorder,
        border: widget.border,
        helperText: "",
        counterText: "",
      ),
      onTapOutside: (e) => FocusScope.of(context).unfocus(),
      keyboardType: widget.keyboardType,
      textCapitalization: widget.textCapitalization,
      style: widget.style ??
          Theme.of(context).textTheme.labelLarge?.copyWith(
              fontSize: 18.sp,
              color: Colors.black,
              fontWeight: FontWeight.w500),
      textAlign: widget.textAlign,
      readOnly: widget.readOnly,
      autofocus: widget.autofocus,
      obscureText: obscureText,
      maxLines: widget.maxLines,
      maxLength: widget.maxLength,
      onChanged: widget.onChanged,
      onSubmitted: widget.onSubmitted,
      inputFormatters: widget.inputFormatters,
      enabled: widget.enabled,
      cursorColor: widget.cursorColor,
      onTap: widget.onTap,
      scrollPhysics: const ClampingScrollPhysics(),
    );
  }
}
