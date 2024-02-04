import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fsociety/core/utiles/safe_tab.dart';
import '../../../../../config/style/app_colors.dart';

class PostFooterWidget extends StatelessWidget {
  final BuildContext context;
  final IconData icon;
  final int value;
  final fun;
  final Color color;

  const PostFooterWidget({
    super.key,
    required this.context,
    required this.icon,
    required this.value,
    this.fun,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 8.0,
        vertical: 4.0,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFE5E5E5).withOpacity(0.40),
        borderRadius: BorderRadius.circular(35.0),
      ),
      child: Row(
        children: [
          SafeOnTap(onSafeTap: fun, child: Icon(icon, color: color)),
          const SizedBox(width: 8.0),
          Text(
            '$value',
            style: Theme.of(context)
                .textTheme
                .labelSmall!
                .copyWith(color: AppColors().mainColor),
          ),
        ],
      ),
    );
  }
}
