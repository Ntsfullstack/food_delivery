import 'package:flutter/material.dart';

class GridViewDashWidget extends StatelessWidget {
  GridViewDashWidget({
    Key? key,
    required this.countItem,
    required this.child,
  }) : super(key: key);
  final int countItem;
  final IndexedWidgetBuilder child;

  @override
  Widget build(BuildContext context) {
    // int lengthRow = (countItem + (4 - countItem % 4)) ~/ 4;
    int lengthRow = (countItem/4).ceil();
    return ListView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      itemCount: lengthRow,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        return GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              childAspectRatio: 0.8,
            ),
            itemCount: 4,
            itemBuilder: (BuildContext ctx, i) {
              return Column(
                children: [
                  Expanded(
                      child: (4 * index + i) < countItem
                          ? child(context, 4 * index + i)
                          : Container())
                ],
              );
            });
      },
    );
  }
}
