import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FullScreen extends StatefulWidget {
  final Widget _child;
  const FullScreen({child, Key? key}) : _child = child, super(key: key);

  @override
  _FullScreenState createState() => _FullScreenState();
}

class _FullScreenState extends State<FullScreen> {
  @override
  void initState() {
    super.initState();

    // Start full screen
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
  }

  @override
  void dispose() {
    super.dispose();

    // Exit full screen
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  }

  @override
  Widget build(BuildContext context) {
    return widget._child;
  }
}
