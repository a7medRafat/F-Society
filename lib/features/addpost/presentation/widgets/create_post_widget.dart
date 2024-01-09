import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fsociety/features/addpost/cubit/create_post_cubit.dart';
import '../../../../core/utiles/app_colors.dart';

class CreatePostWidget extends StatelessWidget {
  final ImageProvider img;

  const CreatePostWidget({super.key, required this.img});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 1.5,
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(image: img, fit: BoxFit.cover)),
          ),
          IconButton(
              onPressed: () {
                CreatePostCubit.get(context).clearPostImg();
              },
              icon: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.black38,
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(5),
                    child: Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 15,
                    ),
                  ))),

        ],
      ),
    );
  }
}
