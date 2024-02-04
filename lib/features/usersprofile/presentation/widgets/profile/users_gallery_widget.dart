import 'package:flutter/material.dart';
import 'package:fsociety/app/injuctoin_container.dart' as di;

import '../../../../profile/presentation/widget/profile/gride_widget.dart';

class UsersProfileGalleryWidget extends StatelessWidget {
  const UsersProfileGalleryWidget({super.key, required this.length, required this.gallery});
  final int length;
  final List<String> gallery;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top:10 ),
      child: Column(
        children: [
          GridWidget(
              length: length,
              listName: gallery)
        ],
      ),
    );
  }
}
