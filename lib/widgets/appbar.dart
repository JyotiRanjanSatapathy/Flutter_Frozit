import 'package:flutter/material.dart';
import 'package:frozit/common/colors.dart';

class FrozitAppbar extends StatelessWidget implements PreferredSizeWidget {
  const FrozitAppbar({
    super.key,
    required this.title,
    this.backgroundColor,
  });

  final String title;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor ?? Colors.white,
      surfaceTintColor: kContainerColorLight,
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.w700,
          color: kPrimaryColor,
          fontSize: 26,
        ),
      ),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
