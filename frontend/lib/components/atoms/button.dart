import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  const Button({
    super.key,
    required this.text,
    required this.onPressed,
    this.color,
    this.fit = false,
  });
  final String text;
  final void Function()? onPressed;
  final Color? color;
  final bool fit;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        backgroundColor: color ?? Theme.of(context).primaryColor,
        fixedSize: fit ? null : Size(double.maxFinite, 44),
      ),
      onPressed: onPressed,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Opacity(
            opacity: onPressed == null ? 0 : 1,
            child: Text(
              text,
              style: TextStyle(color: Colors.white, fontSize: 16),
              maxLines: 1,
            ),
          ),
          if (onPressed == null)
            Center(
              child: SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  color: color ?? Theme.of(context).primaryColor,
                  strokeWidth: 3,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
