import 'package:flutter/material.dart';

class NearbyHawkerCard extends StatelessWidget {
  final String hawkerId;
  final String name;
  final double distance;
  final double rating;
  final bool isOnline;
  final VoidCallback onTap;

  const NearbyHawkerCard({
    Key? key,
    required this.hawkerId,
    required this.name,
    required this.distance,
    required this.rating,
    required this.isOnline,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: isDarkMode ? Colors.grey[800] : Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Row(
          children: [
            // Hawker image
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withOpacity(0.1),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  bottomLeft: Radius.circular(12),
                ),
              ),
              child: Center(
                child: Icon(
                  Icons.store,
                  size: 40,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
            
            // Hawker details
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Name and online status
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            name,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: isOnline ? Colors.green : Colors.grey,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            isOnline ? 'Online' : 'Offline',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    
                    // Rating
                    Row(
                      children: [
                        const Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: 16,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          rating.toStringAsFixed(1),
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    
                    // Distance
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on,
                          color: Colors.red,
                          size: 16,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${distance.toStringAsFixed(1)} km away',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    
                    // View details button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: onTap,
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            minimumSize: const Size(0, 0),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: const Text('View Details'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

