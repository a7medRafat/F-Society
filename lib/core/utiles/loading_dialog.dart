import 'package:flutter/material.dart';
import 'package:fsociety/core/utiles/loading_widget.dart';

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
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child:  Column(
            mainAxisSize: MainAxisSize.min,
            children: [
               SizedBox(
                height: 30,
                  width: 30,
                  child: LoadingWidget()),
              const SizedBox(height: 16),
              Text(text,style: Theme.of(context).textTheme.titleSmall),
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
