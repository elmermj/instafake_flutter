import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class CaptionWidget extends StatelessWidget {
  final String username;
  final String caption;
  final void Function(String) onUsernameTap;

  const CaptionWidget({
    super.key,
    required this.username,
    required this.caption,
    required this.onUsernameTap,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      maxLines: 3,
      text: TextSpan(
        children: [
          TextSpan(
            text: '$username ',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
            recognizer: TapGestureRecognizer()..onTap = () => onUsernameTap(username),
          ),
          TextSpan(
            text: caption,
            style: const TextStyle(
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}