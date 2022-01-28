import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:sye/Expenses/expenses_page.dart';
import 'package:sye/Groups/group.dart';
import 'package:sye/Groups/group_loader.dart';

class GroupVisualizer extends StatelessWidget {
  final Map routeData;
  final String groupKey;

  const GroupVisualizer({required route,required k, Key? key}): routeData=route,groupKey=k,super(key:key);

  @override
  Widget build(BuildContext context) {
    
    Group g = Group(
        id: groupKey,
        name: routeData["name"],
        currency: routeData["currency"],
        description: routeData["description"],
        users: routeData["participants"],
        expenses: routeData['expenses'],
        category: routeData['category'],
        creator: routeData['creator'],
    );
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => GroupLoader(g: groupKey)));
      },
      child: Padding(
        padding: const EdgeInsets.all(5),
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
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (g.getDescription().toString().isNotEmpty)
                      Text(g.getDescription().toString(),
                        style: const TextStyle(
                          fontSize: 15,
                          overflow: TextOverflow.ellipsis,
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