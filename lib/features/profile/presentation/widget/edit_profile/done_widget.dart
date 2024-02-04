// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:fsociety/features/profile/cubit/profile_cubit.dart';
// import 'package:bootstrap_icons/bootstrap_icons.dart';
// import '../../../../../core/utiles/app_colors.dart';
// import 'package:fsociety/injuctoin_container.dart' as di;
//
// class DoneWidget extends StatelessWidget {
//   const DoneWidget({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<ProfileCubit, ProfileState>(
//       listener: (context, state) {},
//       builder: (context, state) {
//         return Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             IconButton(
//                 onPressed: () {
//                   di.sl<ProfileCubit>()
//                     ..uploadProfileImg()
//                     ..uploadTaped = true;
//                 },
//                 icon: Container(
//                     decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(20),
//                         color: AppColors().mainColor),
//                     child: const Padding(
//                       padding: EdgeInsets.all(8.0),
//                       child: Icon(BootstrapIcons.check),
//                     ))),
//             const SizedBox(width: 10),
//             IconButton(
//                 onPressed: () {
//                   di.sl<ProfileCubit>().uploadTaped == true
//                       ? null
//                       : di.sl<ProfileCubit>().clearProfileImg();
//                 },
//                 icon: Container(
//                     decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(20),
//                         color: di.sl<ProfileCubit>().uploadTaped
//                             ? AppColors().rectangle3
//                             : AppColors().mainColor),
//                     child: const Padding(
//                       padding: EdgeInsets.all(8.0),
//                       child: Icon(BootstrapIcons.x),
//                     ))),
//           ],
//         );
//       },
//     );
//   }
// }
