import 'package:flutter/cupertino.dart';
import '../../../../config/style/icons_broken.dart';
import '../../../../core/utiles/app_colors.dart';
import '../../../../core/utiles/text_field.dart';

class SearchWidget extends StatelessWidget {
  TextEditingController searchController = TextEditingController();

  SearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
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
        child: DefaultField(
            controller: searchController,
            hint: 'search for contacts',
            isPassword: false,
            borderSide: false,
            prefixIcon: const Icon(IconBroken.Search),
            filled: true,
            filledColor: AppColors().mainColor,
            textInputType: TextInputType.text,
            validation: (value) {
              if (value.isEmpty) {
                return 'no search found';
              }
            }),
      ),
    );
  }
}
