import 'package:flutter/material.dart';

class MyButtonSheet {
  Future<void> showButtonSheet(context, Widget child) =>
      showModalBottomSheet(
          backgroundColor: Colors.transparent,
          context: context,
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width - 40,
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
          builder: (context) {
            return SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.only(bottom: 20, left: 10, right: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Padding(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom),
                      child: child
                  ),
                ),
              ),
            );
          });
}
