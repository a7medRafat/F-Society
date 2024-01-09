import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../core/local_storage/hive_keys.dart';
import '../../../../core/local_storage/user_storage.dart';
import '../../../../core/navigation/navigation.dart';
import '../../../../core/shared_preferances/cache_helper.dart';
import '../../../../core/utiles/dialog.dart';
import '../../../authentication/cubit/login_cubit/login_cubit.dart';
import '../../../authentication/presentation/screens/login_screen/login_screen.dart';
import 'package:fsociety/injuctoin_container.dart' as di;

class Favourite extends StatefulWidget {
  Favourite({super.key});

  @override
  State<Favourite> createState() => _FavouriteState();
}

class _FavouriteState extends State<Favourite> with TickerProviderStateMixin {
  bool singleTap = false;

  late AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    ); // Adjust duration as nee
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: Column(
        children: [
          InkWell(
            onTap: (){
              if (_animationController.isDismissed) {
                _animationController.forward();
              } else {
                _animationController.reverse();
              }
            },
            child: AnimatedIcon(
                icon: AnimatedIcons.search_ellipsis,
                progress: _animationController),
          ),
        ],
      )

    );
  }

  _appBar(context) => AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          TextButton(
              onPressed: () {
                MyDialog().show(context, () {
                  di.sl<LoginCubit>().signOut().then((value) {
                    CacheHelper.removeData(key: 'uid');
                    di.sl<UserStorage>().deleteData(id: HiveKeys.currentUser);
                    Navigation().navigateTo(context, LoginScreen());
                  });
                });
              },
              child: Text('Sign out')),
        ],
      );
}
