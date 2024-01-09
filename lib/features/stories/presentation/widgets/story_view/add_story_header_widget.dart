import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fsociety/core/local_storage/hive_keys.dart';
import 'package:fsociety/core/local_storage/user_storage.dart';
import 'package:fsociety/injuctoin_container.dart' as di;

class AddStoryHeaderWidget extends StatelessWidget {
  const AddStoryHeaderWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15.0),
      child: Row(
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(di.sl<UserStorage>().getData(id: HiveKeys.currentUser)!
                    .image!),
                radius: 20,
              ),
              const SizedBox(width: 15),
              Text(
                di.sl<UserStorage>().getData(id: HiveKeys.currentUser)!.name!,
                style: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .copyWith(color: Colors.white),
              ),
              SizedBox(width: 15),
              // TimeAgoWidget(timestamp: FeedsCubit.get(context).validStories[index].date!),
              Text(
                'now',
                style: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .copyWith(color: Colors.white54, fontSize: 12),
              ),
            ],
          ),
          const Spacer(),
          IconButton(
              onPressed: () {
                Navigator.pop(context);
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
                  )))
        ],
      ),
    );
  }
}
