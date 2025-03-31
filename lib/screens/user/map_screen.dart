import 'package:flutter/material.dart';
import 'dart:async';
import '../../models/hawker_model.dart';
import 'hawker_details_screen.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final List<HawkerModel> _hawkers = HawkerModel.getMockHawkers();
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  String _selectedCategory = 'All';

  final List<String> _categories = [
    'All',
    'Fruits',
    'Vegetables',
    'Dairy',
    'Bakery',
    'Beverages',
  ];

  bool _isMapView = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<HawkerModel> _getFilteredHawkers() {
    List<HawkerModel> filteredList = List.from(_hawkers);

    // Apply category filter
    if (_selectedCategory != 'All') {
      filteredList =
          filteredList
              .where((hawker) => (hawker.categories ?? []).contains(_selectedCategory))
              .toList();
    }

    // Apply search filter
    if (_searchQuery.isNotEmpty) {
      filteredList =
          filteredList.where((hawker) {
            return hawker.name.toLowerCase().contains(
                  _searchQuery.toLowerCase(),
                ) ||
                hawker.areas.any(
                  (area) =>
                      area.toLowerCase().contains(_searchQuery.toLowerCase()),
                );
          }).toList();
    }

    // Filter by online status
    filteredList = filteredList.where((hawker) => hawker.isOnline).toList();

    return filteredList;
  }

  void _getCurrentLocation() {
    setState(() {
      _isLoading = true;
    });

    // Simulate getting current location
    Timer(const Duration(seconds: 2), () {
      setState(() {
        _isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Location updated'),
          backgroundColor: Colors.green,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final filteredHawkers = _getFilteredHawkers();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Find Hawkers'),
        actions: [
          IconButton(
            icon: Icon(_isMapView ? Icons.list : Icons.map),
            onPressed: () {
              setState(() {
                _isMapView = !_isMapView;
              });
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search by hawker name or area',
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.my_location),
                      onPressed: _getCurrentLocation,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 0),
                    filled: true,
                    fillColor: Colors.grey[100],
                  ),
                  onChanged: (value) {
                    setState(() {
                      _searchQuery = value;
                    });
                  },
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: 40,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _categories.length,
                    itemBuilder: (context, index) {
                      final category = _categories[index];
                      final isSelected = category == _selectedCategory;

                      return Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: ChoiceChip(
                          label: Text(category),
                          selected: isSelected,
                          onSelected: (selected) {
                            if (selected) {
                              setState(() {
                                _selectedCategory = category;
                              });
                            }
                          },
                          backgroundColor: Colors.grey[200],
                          selectedColor: Colors.green.withOpacity(0.2),
                          labelStyle: TextStyle(
                            color: isSelected ? Colors.green : Colors.black,
                            fontWeight:
                                isSelected
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),

          if (_isLoading) const LinearProgressIndicator(),

          Expanded(
            child:
                _isMapView
                    ? _buildMapView(filteredHawkers)
                    : _buildListView(filteredHawkers),
          ),
        ],
      ),
    );
  }

  Widget _buildMapView(List<HawkerModel> hawkers) {
    return Stack(
      children: [
        // Mock map view
        Container(
          color: Colors.grey[200],
          child: Center(
            child:
                hawkers.isEmpty
                    ? const Text('No hawkers found in this area')
                    : const Text(
                      'Map View - Tap on markers to see hawker details',
                    ),
          ),
        ),

        // Hawker markers
        ...hawkers.map((hawker) {
          // Generate random positions for demo
          final left = (hawker.id.hashCode % 300).toDouble();
          final top = (hawker.name.hashCode % 500).toDouble();

          return Positioned(
            left: left,
            top: top,
            child: GestureDetector(
              onTap: () {
                _showHawkerInfoBottomSheet(hawker);
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 16,
                      backgroundImage: NetworkImage(
                        'https://via.placeholder.com/150?text=${hawker.name[0]}',
                      ),
                    ),
                    const SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          hawker.name,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 12,
                            ),
                            Text(
                              ' ${hawker.rating}',
                              style: const TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        }),

        // Current location button
        Positioned(
          right: 16,
          bottom: 16,
          child: FloatingActionButton(
            onPressed: _getCurrentLocation,
            backgroundColor: Colors.white,
            foregroundColor: Colors.blue,
            child: const Icon(Icons.my_location),
          ),
        ),
      ],
    );
  }

  Widget _buildListView(List<HawkerModel> hawkers) {
    if (hawkers.isEmpty) {
      return const Center(child: Text('No hawkers found'));
    }

    return ListView.builder(
      itemCount: hawkers.length,
      itemBuilder: (context, index) {
        final hawker = hawkers[index];

        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(
                'https://via.placeholder.com/150?text=${hawker.name[0]}',
              ),
            ),
            title: Text(
              hawker.name,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.amber, size: 16),
                    Text(' ${hawker.rating} (${hawker.totalReviews})'),
                  ],
                ),
                Text(
                  'Areas: ${hawker.areas.join(", ")}',
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
              ],
            ),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HawkerDetailsScreen(hawker: hawker),
                ),
              );
            },
          ),
        );
      },
    );
  }

  void _showHawkerInfoBottomSheet(HawkerModel hawker) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(
                      'https://via.placeholder.com/150?text=${hawker.name[0]}',
                    ),
                    radius: 24,
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          hawker.name,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 16,
                            ),
                            Text(
                              ' ${hawker.rating} (${hawker.totalReviews} reviews)',
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color:
                          hawker.isOnline
                              ? Colors.green.withOpacity(0.1)
                              : Colors.red.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      hawker.isOnline ? 'Online' : 'Offline',
                      style: TextStyle(
                        color: hawker.isOnline ? Colors.green : Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  const Icon(Icons.location_on, color: Colors.grey, size: 16),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      hawker.areas.join(', '),
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.category, color: Colors.grey, size: 16),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      (hawker.categories?.join(', ') ?? 'No categories'),
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) =>
                                    HawkerDetailsScreen(hawker: hawker),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                      ),
                      child: const Text('View Details'),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        // Get directions logic
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Directions functionality coming soon!',
                            ),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      },
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.blue,
                      ),
                      child: const Text('Get Directions'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
