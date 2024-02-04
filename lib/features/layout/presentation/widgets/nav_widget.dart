import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fsociety/config/style/icons_broken.dart';
import 'package:fsociety/core/navigation/navigation.dart';
import 'package:fsociety/config/style/app_colors.dart';
import 'package:fsociety/features/addpost/presentation/scereens/add_post.dart';
import 'package:fsociety/features/layout/cubit/feeds_cubit.dart';
import 'package:fsociety/features/profile/presentation/screens/profile.dart';
import '../../../../core/local_storage/hive_keys.dart';
import '../../../../core/local_storage/user_storage.dart';
import '../../../../core/utiles/custom_btn.dart';
import '../../../../core/utiles/loading_widget.dart';
import '../../../favourites/presentation/screens/fav.dart';
import '../screens/feeds_screen.dart';
import '../../../messages/presentation/screens/messages.dart';
import 'package:fsociety/app/injuctoin_container.dart' as di;

class Nav extends StatefulWidget {
  const Nav({super.key});

  @override
  State<Nav> createState() => _NavState();
}

class _NavState extends State<Nav> {
  int _selectedIndex = 0;
  final pages = [const FeedsScreen(), Messages(),  FavouritesScreen()];

  void _changePageTo(int index) {
    setState(() => _selectedIndex = index);
  }

  double iconSize = 23;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: pages,
      ),
      floatingActionButton: _selectedIndex == 1
          ? null
          : CustomButton(
              child: Icon(
                Icons.add,
                size: 25,
                color: AppColors().mainColor,
              ),
              onTap: () {
                Navigation().navigateTo(context, const AddPostScreen());
              },
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: _selectedIndex == 1
          ? null
          : BlocBuilder<FeedsCubit, FeedsState>(
              builder: (context, state) {
                return Container(
                  height: 75.0,
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.only(top: 10.0),
                  decoration: BoxDecoration(
                    color: AppColors().mainColor,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0),
                    ),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 10.0,
                        offset: const Offset(0, 4),
                        color: AppColors().fBlack.withOpacity(0.15),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                          onTap: () => _changePageTo(0),
                          child: Icon(
                            IconBroken.Home,
                            color: _selectedIndex == 0
                                ? AppColors().fSelectedTapCol
                                : AppColors().fBlack,
                          )),
                      GestureDetector(
                        onTap: () {
                          Navigation().navigateTo(context, Messages());
                        },
                        child: Icon(
                          IconBroken.Message,
                          color: _selectedIndex == 1
                              ? AppColors().fSelectedTapCol
                              : AppColors().fBlack,
                        ),
                      ),
                      const SizedBox(width: 15),
                      GestureDetector(
                          onTap: () => Navigation().navigateTo(context,  FavouritesScreen()),
                          child: Icon(
                            IconBroken.Heart,
                            color: _selectedIndex == 2
                                ? AppColors().fSelectedTapCol
                                : AppColors().fBlack,
                          )),
                      GestureDetector(
                          onTap: () {
                            Navigation().navigateTo(context, const Profile());
                          },
                          child: di.sl<UserStorage>()
                                      .getData(id: HiveKeys.currentUser)!
                                      .image !=
                                  null
                              ? CircleAvatar(
                                  backgroundColor: Colors.black87,
                                  radius: 15,
                                  child: CircleAvatar(
                                    radius: 14,
                                    backgroundImage: NetworkImage(di.sl<UserStorage>()
                                        .getData(id: HiveKeys.currentUser)!
                                        .image!),
                                  ),
                                )
                              : const SizedBox(child: LoadingWidget()))
                    ],
                  ),
                );
              },
            ),
    );
  }
}
