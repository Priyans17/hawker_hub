import 'package:flutter/material.dart';

class LocationBar extends StatelessWidget {
  final String address;
  final bool isLoading;
  final VoidCallback onTap;

  const LocationBar({
    Key? key,
    required this.address,
    this.isLoading = false,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.dark
              ? Colors.grey[800]
              : Colors.grey[100],
          border: Border(
            bottom: BorderSide(
              color: Theme.of(context).dividerColor,
              width: 1,
            ),
          ),
        ),
        child: Row(
          children: [
            const Icon(Icons.location_on, size: 20),
            const SizedBox(width: 8),
            Expanded(
              child: isLoading
                  ? Row(
                      children: [
                        const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Getting location...',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    )
                  : Text(
                      address,
                      style: Theme.of(context).textTheme.bodyMedium,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
            ),
            const Icon(Icons.arrow_drop_down, size: 20),
          ],
        ),
      ),
    );
  }
}

