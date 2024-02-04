import 'package:flutter/material.dart';
class LoadingDialog extends StatelessWidget {


  const LoadingDialog({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.black54,
            borderRadius: BorderRadius.circular(8),
          ),
          child:Row(
            mainAxisSize: MainAxisSize.min,
            children: [
               const SizedBox(
                height: 15,
                  width: 15,
                  child: CircularProgressIndicator(color: Colors.white,)),
              const SizedBox(width: 10),
              Text(text,style: Theme.of(context).textTheme.titleSmall!.copyWith(
                color: Colors.white
              )),
            ],
          ),
        ),
      ),
    );
  }
}

void showLoadingDialog(BuildContext context,String text) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return LoadingDialog(text: text);
    },
  );
}

void hideLoadingDialog(BuildContext context) {
  Navigator.of(context).pop();
}
