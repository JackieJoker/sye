import 'package:flutter/material.dart';
import 'package:sye/Groups/group.dart';
import 'package:sye/Groups/group_loader.dart';
import 'package:sye/Tablet/group_widget.dart';

class GroupVisualizer extends StatelessWidget {
  final Map routeData;
  final String groupKey;
  final _notifier;

  const GroupVisualizer({required route, required k, notifier ,Key? key}): _notifier = notifier , routeData=route,groupKey=k,super(key:key);

  @override
  Widget build(BuildContext context) {
    
    Group g = Group(
        id: groupKey,
        name: routeData["name"],
        currency: routeData["currency"],
        description: (routeData["description"] != null) ? routeData["description"] : '',
        users: routeData["participants"],
        expenses: routeData['expenses'],
        category: routeData['category'],
        creator: routeData['creator'],
    );
    return InkWell(
      onTap: () {
        if(_notifier == null) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => GroupLoader(g: groupKey)));
        } else {
          _notifier.value = GroupWidget(GroupLoader(g: groupKey), g);
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          child:
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      g.getName(),
                      style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w700,
                        overflow: TextOverflow.ellipsis,
                        color: Colors.blueAccent,
                      ),
                    ),
                    if (g.getDescription().toString().isNotEmpty)
                      Text(g.getDescription().toString(),
                        style: const TextStyle(
                          fontSize: 15,
                          overflow: TextOverflow.ellipsis,
                          fontWeight: FontWeight.w400,
                        ),
                      )
                    else
                      const Text("No description",
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      )
                  ]
                ),
                const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.blueAccent,
                )
              ],
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
            ),
          width: 500,
        ),
      ),
    );
  }
}