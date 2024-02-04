import 'package:flutter/material.dart';
import '../../../../../config/style/app_colors.dart';

class GalleryTextWidget extends StatelessWidget {
  const GalleryTextWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          Container(
            margin: const EdgeInsets.only(right: 20),
            width: size.width/4,
            height: size.width * 0.18,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                border: Border.all(width: 0.1, color: AppColors().rectangle3),
                borderRadius: BorderRadius.circular(22)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Container(
                  height: size.width * 0.15,
                  decoration: BoxDecoration(
                      color:AppColors().rectangle1,
                      borderRadius: BorderRadius.circular(20)),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                       'gallery',
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          fontSize: 11
                        ),
                      ),
                    ),
                  )
              ),
            ),
          )
        ],
      ),
    );
  }
}
