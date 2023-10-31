import 'package:flutter/material.dart';

class EditIcon extends StatelessWidget {
  const EditIcon({super.key, this.onTap, this.alignment});
  final VoidCallback? onTap;
  final Alignment? alignment;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment ?? Alignment(Alignment.bottomCenter.x + 0.8, 0.6),
      child: GestureDetector(
        onTap: onTap,
        child: CircleAvatar(
          backgroundColor: Colors.green.shade400,
          radius: 25,
          child: const Icon(
            Icons.edit,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
