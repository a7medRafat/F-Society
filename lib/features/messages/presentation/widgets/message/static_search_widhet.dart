import 'package:flutter/material.dart';
import 'package:fsociety/core/navigation/navigation.dart';
import 'package:fsociety/features/messages/presentation/screens/search_screen.dart';
import '../../../../../config/style/icons_broken.dart';
import '../../../../../config/style/app_colors.dart';

class StaticSearchWidget extends StatelessWidget {
  const StaticSearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>
          Navigation().navigateTo(context, const SearchContactsScreen()),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
        child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              boxShadow: [
                BoxShadow(
                  offset: const Offset(4, 4),
                  blurRadius: 15,
                  color: AppColors().rectangle3.withOpacity(0.10),
                )
              ],
            ),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: Colors.white),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Row(
                  children: [
                    const Icon(IconBroken.Search),
                    const SizedBox(width: 15),
                    Text(
                      'search for contacts',
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall!
                          .copyWith(color: AppColors().hintColor),
                    ),
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
