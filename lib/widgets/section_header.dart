import 'package:flutter/material.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final String? actionText;
  final String? actionRoute;
  final VoidCallback? onActionTap;

  const SectionHeader({
    Key? key,
    required this.title,
    this.actionText,
    this.actionRoute,
    this.onActionTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          if (actionText != null)
            TextButton(
              onPressed: onActionTap ?? () {
                if (actionRoute != null) {
                  Navigator.of(context).pushNamed(actionRoute!);
                }
              },
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: const Size(0, 0),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: Text(actionText!),
            ),
        ],
      ),
    );
  }
}

