import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fsociety/config/style/icons_broken.dart';
import '../../../../core/utiles/app_colors.dart';
import '../../cubit/create_post_cubit.dart';

class dafaultImg extends StatefulWidget {
  const dafaultImg({super.key});

  @override
  State<dafaultImg> createState() => _dafaultImgState();
}

class _dafaultImgState extends State<dafaultImg> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          GestureDetector(
            onTap: (){
              CreatePostCubit.get(context).getPostImg();
            },
            child: Container(
              height: MediaQuery.of(context).size.height / 1.5,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.grey.withOpacity(0.15),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                 Icon(CupertinoIcons.cloud_upload,size: 120,color: Colors.black54,),
                  SizedBox(height: 10),
                  Text('Tap To Upload Image',style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: Colors.black54
                  ),)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
