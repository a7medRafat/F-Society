// import 'package:flutter/material.dart';
// import '../../../../../config/style/app_colors.dart';
// import '../../../../../config/style/icons_broken.dart';
//
// class SearchContactsWidget extends StatelessWidget {
//
//   const SearchContactsWidget({super.key});
//
//   f
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(15.0),
//         boxShadow: [
//           BoxShadow(
//             offset: const Offset(4, 4),
//             blurRadius: 15,
//             color: AppColors().rectangle3.withOpacity(0.10),
//           )
//         ],
//       ),
//       child: TextField(
//         style: Theme
//             .of(context)
//             .textTheme
//             .bodySmall!
//             .copyWith(color: AppColors().hintColor),
//         onChanged: onChaged(),
//         decoration: InputDecoration(
//             border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(15),
//                 borderSide: BorderSide.none),
//             contentPadding:
//             const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
//             filled: true,
//             fillColor: AppColors().mainColor,
//             hintText: 'Search for contacts',
//             hintStyle: Theme
//                 .of(context)
//                 .textTheme
//                 .titleSmall!
//                 .copyWith(color: AppColors().hintColor),
//             prefixIcon: const Icon(
//               IconBroken.Search,
//               color: Colors.grey,
//             )),
//       ),
//     );
//   }
// }
//
//
