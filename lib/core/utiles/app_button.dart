import 'package:flutter/material.dart';
import '../../config/style/app_colors.dart';

class AppButton extends StatelessWidget {
  final String text;
  final fun;
  final Color? btnColor;

   AppButton({super.key, required this.text,required this.fun,this.btnColor});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
      splashColor: Colors.transparent,
      onTap: fun,
      child: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            Container(
              height: size.width * 0.18,
              width: double.infinity,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  border: Border.all(width: 0.1, color: AppColors().rectangle3),
                  borderRadius: BorderRadius.circular(22)),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Container(
                  height: size.width * 0.15,
                  decoration: BoxDecoration(
                      color:btnColor?? AppColors().rectangle4,
                      borderRadius: BorderRadius.circular(20)),
                  child: Center(
                    child: Text(
                      text,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  )
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
