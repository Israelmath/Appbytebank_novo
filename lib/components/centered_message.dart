import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CenteredMessage extends StatelessWidget {
  final String message;
  final IconData icon;
  final double iconSize;
  final double fontsize;

  CenteredMessage(this.message,
      {this.icon, this.iconSize = 64, this.fontsize = 24});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Visibility(
            child: Icon(
              icon,
              size: iconSize,
              color: Colors.blue,
            ),
            visible: icon != null,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 24.0, right: 24.0, top: 16),
            child: Text(
              message,
              style: TextStyle(
                color: Colors.grey,
                fontSize: fontsize,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
