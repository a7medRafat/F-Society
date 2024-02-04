import 'package:flutter/cupertino.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'galery_viwer.dart';

class GridWidget extends StatelessWidget {
  const GridWidget({super.key, required this.length, required this.listName});
  final int length;
  final List <String> listName;
  @override
  Widget build(BuildContext context) {
    return StaggeredGrid.count(

      crossAxisCount: 2,
      mainAxisSpacing: 14.0,
      crossAxisSpacing: 14.0,
      children: [
        ...List.generate(
            length,
            (index) => StaggeredGridTile.count(
              crossAxisCellCount: 1,
              mainAxisCellCount: index.isEven ? 1.5 :1,
              child: ClipRRect(
                    borderRadius: BorderRadius.circular(19.0),
                    child: GestureDetector(
                      onLongPress: () => GalleryViewer().view(context,
                          img: listName[index]),
                      child: Image.network(
                        listName[index],
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
            ))
      ],
    );
  }
}
