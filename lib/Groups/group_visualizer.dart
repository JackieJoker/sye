import 'package:flutter/material.dart';
import 'package:sye/Classes/group.dart';

class GroupVisualizer extends StatelessWidget {
  /*final String _name;
  final String _currency;
  final String _description;*/
  final Map routeData;

  /*const GroupVisualizer({required nam,required curren, desc, Key? key}) : _name = nam,
        _currency = curren,
        _description = desc,
        super(key:key);*/
  const GroupVisualizer({required route, Key? key}): routeData=route,super(key:key);

  @override
  Widget build(BuildContext context) {
    Group g = Group(
        name: routeData["name"],
        currency: routeData["currency"],
        description: routeData["description"],

    );
    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Container(
          child:
            Row(
              children: [
                Column(
                  children: [
                    Text(
                      g.getName(),
                      style: const TextStyle(
                        fontSize: 30,
                      ),
                    ),
                    if (g.getDescription().toString().isNotEmpty)
                      Text(g.getDescription().toString(),
                        style: const TextStyle(
                          fontSize: 15,
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