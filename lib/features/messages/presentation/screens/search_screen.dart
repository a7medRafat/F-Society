import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fsociety/features/messages/data/models/get_all_users.dart';
import 'package:fsociety/features/messages/presentation/widgets/message/messsages_background.dart';
import 'package:fsociety/features/messages/presentation/widgets/search/search_item.dart';
import '../../../../config/style/app_colors.dart';
import '../../../../config/style/icons_broken.dart';
import '../../../../core/utiles/loading_widget.dart';

class SearchContactsScreen extends StatefulWidget {
  const SearchContactsScreen({super.key});

  @override
  State<SearchContactsScreen> createState() => _SearchContactsScreenState();
}

class _SearchContactsScreenState extends State<SearchContactsScreen> {
  var searchName = "";
  final CollectionReference users =
      FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> searchStream = users
        .orderBy('name')
        .startAt([searchName]).endAt(['$searchName\uf8ff']).snapshots();

    return MessageBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  searchWidget(),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                  StreamBuilder<QuerySnapshot>(
                    stream: searchStream,
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const SizedBox(
                            height: 15, width: 15, child: LoadingWidget());
                      }
                      if (snapshot.hasError) {
                        return const Text('Something went wrong');
                      }
                      return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: snapshot.data?.docs.length,
                          itemBuilder: (context, index) {
                            var data = snapshot.data!.docs[index];
                            AllUsersModel model = AllUsersModel(
                                name: data['name'],
                                email: data['email'],
                                phone: data['phone'],
                                uid: data['uid'],
                                isEmailVerified: data['isEmailVerified'],
                                image: data['image'],
                                bio: data['bio']);
                            return SearchItem(model: model);
                          });
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget searchWidget() => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          boxShadow: [
            BoxShadow(
              offset: const Offset(4, 4),
              blurRadius: 15,
              color: AppColors().rectangle3.withOpacity(0.10),
            )
          ],
        ),
        child: TextField(
          style: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(color: AppColors().hintColor),
          onChanged: (value) {
            setState(() {
              searchName = value;
            });
          },
          decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
              filled: true,
              fillColor: AppColors().mainColor,
              hintText: 'Search for contacts',
              hintStyle: Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .copyWith(color: AppColors().hintColor),
              prefixIcon: const Icon(
                IconBroken.Search,
                color: Colors.grey,
              )),
        ),
      );
}
