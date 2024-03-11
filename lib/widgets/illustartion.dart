import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class IllustrationWidget extends StatelessWidget {
  const IllustrationWidget(
    this.illustration, {
    super.key,
  });

  final String illustration;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SvgPicture.asset(
        illustration,
      ),
    );
  }
}
