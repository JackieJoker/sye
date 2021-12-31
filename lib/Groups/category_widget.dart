import 'package:flutter/material.dart';

class CategoryWidget extends StatefulWidget {
  const CategoryWidget({Key? key}) : super(key: key);

  @override
  State<CategoryWidget> createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {
  String? _value;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                ChoiceChip(
                label: const Text('🌍 Travel'),
                selected: _value == 'travel',
                onSelected: (bool selected) {
                  setState(() {
                    _value = selected ? 'travel' : null;
                    });
                  },
                ),
                ChoiceChip(
                  label: const Text('🏠 Shared house'),
                  selected: _value == 'shared house',
                  onSelected: (bool selected) {
                    setState(() {
                      _value = selected ? 'shared house' : null;
                    });
                  },
                ),
                ChoiceChip(
                  label: const  Text('😍 Couple'),
                  selected: _value == 'couple',
                  onSelected: (bool selected) {
                    setState(() {
                      _value = selected ? 'couple' : null;
                    });
                  },
                ),
              ],
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
            ),
            Row(
              children: [
                ChoiceChip(
                  label: const  Text('🎤 Event'),
                  selected: _value == 'event',
                  onSelected: (bool selected) {
                    setState(() {
                      _value = selected ? 'event' : null;
                    });
                  },
                ),
                ChoiceChip(
                  label: const  Text('🛠 Project'),
                  selected: _value == 'project',
                  onSelected: (bool selected) {
                    setState(() {
                      _value = selected ? 'project' : null;
                    });
                  },
                ),
                ChoiceChip(
                  label: const  Text('👉 Others'),
                  selected: _value == 'others',
                  onSelected: (bool selected) {
                    setState(() {
                      _value = selected ? 'others' : null;
                    });
                  },
                ),
              ],
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
            ),
          ],
        ),
    );
  }
}

/*ChoiceChip(
label: Text('Item $index'),
selected: _value == index,
onSelected: (bool selected) {
setState(() {
_value = selected ? index : null;
});
},
);*/