import 'package:flutter/material.dart';

class getIcon extends StatefulWidget {
  final IconData icon;
  final double horizontalPadding;
  final Color color;

  const getIcon(
      {Key? key,
      required this.icon,
      required this.horizontalPadding,
      required this.color})
      : super(key: key);

  @override
  State<getIcon> createState() => _getIconState();
}

class _getIconState extends State<getIcon> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: widget.horizontalPadding),
      child: Icon(
        widget.icon,
        color: widget.color,
        size: 30,
      ),
    );
  }
}
