import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nivaas/core/constants/colors.dart';
import 'package:nivaas/core/constants/img_consts.dart';
import 'package:nivaas/core/constants/text_styles.dart';
import 'package:nivaas/widgets/elements/CustomSnackbarWidget.dart';

class Flatprevreadingcard extends StatefulWidget {
  final String flatNumber;
  final String initialValue;
  final String readingValue;
  final String previousReading;
  final ValueChanged<String> onChanged;
  final ValueChanged<bool> onValidation;
  final bool? isReadOnly;

  const Flatprevreadingcard({
    super.key,
    required this.flatNumber,
    required this.initialValue,
    required this.onChanged,
    required this.readingValue,
    required this.onValidation,
    required this.previousReading,
    this.isReadOnly = false,
  });

  @override
  State<Flatprevreadingcard> createState() => _FlatprevreadingcardState();
}

class _FlatprevreadingcardState extends State<Flatprevreadingcard> {
  late TextEditingController _controller;
  late FocusNode _focusNode;
  bool _isError = false;

  OverlayEntry? _overlayEntry;
  static OverlayEntry? _activeOverlayEntry;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.readingValue);
    _focusNode = FocusNode();
    _focusNode.addListener(_validateInput);
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    _removeTooltip();
    super.dispose();
  }

  void _validateInput() {
    if (!_focusNode.hasFocus) {
      String inputValue = _controller.text.trim();
      double readingValue = double.tryParse(widget.readingValue) ?? 0;
      double currentReading = double.tryParse(inputValue) ?? readingValue;
      if (inputValue.isEmpty) {
        _controller.text = widget.readingValue;
      }

      if (currentReading <= readingValue) {
        setState(() {
          _isError = true;
        });
        widget.onValidation(false);
        CustomSnackbarWidget(
          context: context,
          title: 'Current reading must be greater than previous reading!',
          backgroundColor: AppColor.red,
        );
      } else {
        setState(() {
          _isError = false;
        });
        widget.onValidation(true);
      }
    }
  }

  void _showTooltip(BuildContext context, GlobalKey key) {
    _removeTooltip();

    RenderBox renderBox = key.currentContext!.findRenderObject() as RenderBox;
    Offset position = renderBox.localToGlobal(Offset.zero);

    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        left: position.dx - 60,
        top: position.dy - 40,
        child: Material(
          color: Colors.transparent,
          child: Column(
            children: [
              CustomPaint(
                painter: TrianglePainter(),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColor.white,
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Text(
                  'Previous Reading: ${widget.previousReading}',
                  style: txt_14_500.copyWith(color: Colors.black),
                ),
              ),
            ],
          ),
        ),
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
    _activeOverlayEntry = _overlayEntry;
  }

  void _removeTooltip() {
    _activeOverlayEntry?.remove();
    _activeOverlayEntry = null;
  }

  final GlobalKey _iconKey = GlobalKey(); 

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: _removeTooltip,
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 5),
        elevation: 0,
        color: AppColor.blueShade,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: screenWidth * 0.25,
                child: Text(
                  widget.flatNumber,
                  style: txt_14_600.copyWith(color: AppColor.blue),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(
                width: screenWidth * 0.25,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: screenWidth * 0.18,
                      child: Text(
                        widget.readingValue,
                        style: txt_14_500.copyWith(color: AppColor.blue),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    GestureDetector(
                      key: _iconKey,
                      onTap: () => _showTooltip(context, _iconKey),
                      child: Image.asset(
                        iIcon,
                        color: AppColor.blue,
                        height: 25,
                        width: 25,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: screenWidth * 0.25,
                height: 40,
                child: TextField(
                  keyboardType: TextInputType.number,
                  readOnly: widget.isReadOnly ?? false,
                  enabled: !widget.isReadOnly!, 
                  controller: _controller,
                  focusNode: _focusNode,
                  onChanged: widget.onChanged,
                  style: const TextStyle(fontSize: 14),
                  textAlign: TextAlign.center,
                  onTap: () {
                    _controller.clear();
                  },
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 10,
                    ),
                    hintText: 'Enter',
                    hintStyle: const TextStyle(fontSize: 12),
                    filled: true,
                    fillColor: AppColor.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide.none,
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(color: AppColor.red, width: 2),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(
                          color: _isError ? AppColor.red : AppColor.blue,
                          width: 2),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(
                          color: _isError ? AppColor.red : Colors.transparent),
                    ),
                  ),
                  enableInteractiveSelection: false,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}$')),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TrianglePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = AppColor.white
      ..style = PaintingStyle.fill;

    var path = Path();
    path.moveTo(10, 0);
    path.lineTo(20, 10);
    path.lineTo(0, 10);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}