import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class SwipeableItem extends StatelessWidget {
  final Widget item;
  final Function onDelete;

  const SwipeableItem({required this.item, required this.onDelete, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Slidable(
        endActionPane: ActionPane(
          motion: const DrawerMotion(),
          children: [
            SlidableAction(
              onPressed: (BuildContext context) {
                onDelete();
              },
              label: "Delete",
              backgroundColor: Colors.red,
            ),
          ],
          extentRatio: 0.2,
        ),
        child: item,
      ),
      const Divider(
        height: 0,
      ),
    ]);
  }
}