import 'dart:developer';
import 'dart:ffi';

import 'package:flutter/material.dart';

class UserLabel extends StatefulWidget {
  final List<String> label;
  final int i;
  const UserLabel({required lbl, required index, Key? key}) : label = lbl, i = index, super(key: key);

  @override
  _UserLabelState createState() => _UserLabelState();
}

class _UserLabelState extends State<UserLabel> {
  String? tempUser;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 10),
      child: Container(
        decoration: const BoxDecoration(shape: BoxShape.rectangle),
        constraints: const BoxConstraints(maxWidth: 500, maxHeight: 40),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: widget.label[widget.i],
                  border: InputBorder.none,
                  suffixIcon: GestureDetector(
                    onTap: _delete(widget.i),
                    child: const Icon(Icons.clear),
                    )
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
  _delete(int i) {
    widget.label.removeAt(i);
  }
}

