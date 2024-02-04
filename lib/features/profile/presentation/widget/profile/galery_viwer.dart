import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GalleryViewer {
  view(context, {required String img}) => showDialog(
      context: context,
      builder: (context) {
        return Center(
            child: Container(
          height: MediaQuery.of(context).size.height / 1.5,
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.all(20),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              image: DecorationImage(image: NetworkImage(img),fit: BoxFit.cover)),
        ));
      });
}
