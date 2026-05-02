import "package:flutter/material.dart";

class VerbDisplayWidget extends StatelessWidget {
  final String verb;
  final VoidCallback onTap;

  const VerbDisplayWidget({super.key, required this.verb, required this.onTap});

  void _handleTap() {
    onTap();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: TextButton(
        onPressed: _handleTap,
        child: Text(
          verb,
          style: TextStyle(fontFamily: "CharisSIL", fontSize: 40),
        ),
      ),
    );
  }
}
