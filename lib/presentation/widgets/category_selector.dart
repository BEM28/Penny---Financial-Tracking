import 'package:flutter/material.dart';
import 'package:penny/utils/constants.dart';

class categorySelectector extends StatelessWidget {
  const categorySelectector({
    super.key,
    this.onTap,
    required this.selected,
    required this.title,
  });

  final void Function()? onTap;
  final String title;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 150,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: selected ? AppColors.secondary : null,
            border: Border.all(width: 1, color: AppColors.secondary),
            borderRadius: BorderRadius.circular(8)),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              color: selected ? AppColors.primary : AppColors.secondary,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }
}
