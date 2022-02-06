import 'package:flutter/material.dart';

class AButton extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  final bool isEnabled;
  final bool isLoading;

  const AButton(
      {Key? key,
      required this.onTap,
      required this.text,
      this.isEnabled = true,
      this.isLoading = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    late final Widget child;

    if (isLoading) {
      child = const Center(child: CircularProgressIndicator());
    } else {
      child = ElevatedButton(
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(26))),
          onPressed: isEnabled ? onTap : null,
          child: Text(text,
              style:
                  const TextStyle(fontSize: 14, fontWeight: FontWeight.w700)));
    }
    return Row(
      children: [
        Expanded(
            child: SizedBox(
          height: 52,
          child: child,
        ))
      ],
    );
  }
}
