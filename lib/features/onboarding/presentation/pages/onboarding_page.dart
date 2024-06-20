import 'package:flutter/material.dart';
import 'package:onboarding/index.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({
    required this.backgroundColor,
    required this.title,
    required this.text,
    required this.image,
    super.key,
  });

  final Color backgroundColor;
  final String title;
  final String text;
  final ImageProvider image;

  static const _contentPadding = EdgeInsets.fromLTRB(23, 83, 23, 42);
  static const _imagePadding = EdgeInsets.only(bottom: 103);
  static const _smallSpacing = 12.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Padding(
        padding: _imagePadding,
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: image,
              fit: BoxFit.contain,
              alignment: Alignment.bottomCenter,
            ),
          ),
          child: Padding(
            padding: _contentPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTextStyles.titleStyle),
                const SizedBox(height: _smallSpacing),
                Text(text, style: AppTextStyles.textStyle),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
