import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../models/hawker_model.dart';
import 'map_screen.dart';
import 'order_history_screen.dart';
import 'hawker_details_screen.dart';
// Removed unused import

class UserDashboardScreen extends StatefulWidget {
  const UserDashboardScreen({super.key});

  @override
  State<UserDashboardScreen> createState() => _UserDashboardScreenState();
}

class _UserDashboardScreenState extends State<UserDashboardScreen> {
  final TextEditingController _searchController = TextEditingController();
  // ignore: unused_field
  String _searchQuery = '';

  final List<HawkerModel> _nearbyHawkers = HawkerModel.getMockHawkers();

  // Mock categories
  final List<Map<String, dynamic>> _categories = [
    {'name': 'Fruits', 'icon': Icons.apple, 'color': Colors.red},
    {'name': 'Vegetables', 'icon': Icons.eco, 'color': Colors.green},
    {'name': 'Dairy', 'icon': Icons.egg, 'color': Colors.blue},
    {'name': 'Bakery', 'icon': Icons.bakery_dining, 'color': Colors.orange},
    {'name': 'Beverages', 'icon': Icons.local_drink, 'color': Colors.purple},
  ];

  // Mock recent orders
  final List<Map<String, dynamic>> _recentOrders = [
    {
      'id': 'ORD001',
      'hawkerName': 'Fresh Fruits Vendor',
      'hawkerImage': 'https://via.placeholder.com/150',
      'items': [
        {'name': 'Apples', 'quantity': 2, 'unit': 'kg', 'price': 120.0},
        {'name': 'Bananas', 'quantity': 1, 'unit': 'dozen', 'price': 60.0},
      ],
      'totalAmount': 300.0,
      'status': 'Delivered',
      'orderDate': DateTime.now().subtract(const Duration(days: 2)),
    },
    {
      'id': 'ORD002',
      'hawkerName': 'Veggie Express',
      'hawkerImage': 'https://via.placeholder.com/150',
      'items': [
        {'name': 'Tomatoes', 'quantity': 1, 'unit': 'kg', 'price': 40.0},
        {'name': 'Potatoes', 'quantity': 2, 'unit': 'kg', 'price': 30.0},
      ],
      'totalAmount': 150.0,
      'status': 'Out for Delivery',
      'orderDate': DateTime.now().subtract(const Duration(hours: 5)),
    },
  ];

  // Mock promotions
  final List<Map<String, dynamic>> _promotions = [
    {
      'title': 'Get 20% off on your first order',
      'description': 'Use code FIRST20',
      'image': 'https://via.placeholder.com/800x400',
      'validUntil': DateTime.now().add(const Duration(days: 7)),
    },
    {
      'title': 'Free delivery on orders above ₹500',
      'description': 'Limited time offer',
      'image': 'https://via.placeholder.com/800x400',
      'validUntil': DateTime.now().add(const Duration(days: 3)),
    },
    {
      'title': 'Buy 1 Get 1 Free on all fruits',
      'description': 'Weekend special',
      'image': 'https://via.placeholder.com/800x400',
      'validUntil': DateTime.now().add(const Duration(days: 2)),
    },
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _navigateToMapScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const MapScreen()),
    );
  }

  void _navigateToOrderHistory() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const OrderHistoryScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              // Navigate to notifications screen
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Notifications coming soon!'),
                  duration: Duration(seconds: 2),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              // Navigate to cart screen
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Cart coming soon!'),
                  duration: Duration(seconds: 2),
                ),
              );
            },
          ),
        ],
      ),
      drawer: _buildDrawer(),
      body: RefreshIndicator(
        onRefresh: () async {
          // Simulate refresh
          await Future.delayed(const Duration(seconds: 1));
          setState(() {
            // Refresh data
          });
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search for hawkers, products...',
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.filter_list),
                    onPressed: () {
                      // Show filter options
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Filters coming soon!'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    },
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
              _buildPromotionCarousel(),
              const SizedBox(height: 24),
              _buildCategorySection(),
              const SizedBox(height: 24),
              _buildNearbyHawkersSection(),
              const SizedBox(height: 24),
              _buildRecentOrdersSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const UserAccountsDrawerHeader(
            accountName: Text('John Doe'),
            accountEmail: Text('john.doe@example.com'),
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage('https://via.placeholder.com/150'),
            ),
            decoration: BoxDecoration(color: Colors.green),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            selected: true,
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('My Profile'),
            onTap: () {
              Navigator.pop(context);
              // Navigate to profile screen
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Profile coming soon!'),
                  duration: Duration(seconds: 2),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.shopping_bag),
            title: const Text('My Orders'),
            onTap: () {
              Navigator.pop(context);
              _navigateToOrderHistory();
            },
          ),
          ListTile(
            leading: const Icon(Icons.favorite),
            title: const Text('Favorites'),
            onTap: () {
              Navigator.pop(context);
              // Navigate to favorites screen
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Favorites coming soon!'),
                  duration: Duration(seconds: 2),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.location_on),
            title: const Text('Addresses'),
            onTap: () {
              Navigator.pop(context);
              // Navigate to addresses screen
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Addresses coming soon!'),
                  duration: Duration(seconds: 2),
                ),
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {
              Navigator.pop(context);
              // Navigate to settings screen
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Settings coming soon!'),
                  duration: Duration(seconds: 2),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.help),
            title: const Text('Help & Support'),
            onTap: () {
              Navigator.pop(context);
              // Navigate to help screen
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Help & Support coming soon!'),
                  duration: Duration(seconds: 2),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () {
              // Handle logout
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Logout functionality coming soon!'),
                  duration: Duration(seconds: 2),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPromotionCarousel() {
    return SizedBox(
      height: 180,
      child: PageView.builder(
        itemCount: _promotions.length,
        itemBuilder: (context, index) {
          final promotion = _promotions[index];

          return Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                  image: NetworkImage(promotion['image']),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.3),
                    BlendMode.darken,
                  ),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      promotion['title'],
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      promotion['description'],
                      style: const TextStyle(color: Colors.white, fontSize: 14),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Valid until ${DateFormat('dd MMM yyyy').format(promotion['validUntil'])}',
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildCategorySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Categories',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 100,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: _categories.length,
            itemBuilder: (context, index) {
              final category = _categories[index];

              return Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {
                        // Navigate to category screen
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              '${category['name']} category selected',
                            ),
                            duration: const Duration(seconds: 2),
                          ),
                        );
                      },
                      child: Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: category['color'].withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          category['icon'],
                          color: category['color'],
                          size: 30,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      category['name'],
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildNearbyHawkersSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Nearby Hawkers',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextButton(
              onPressed: _navigateToMapScreen,
              child: const Text('View All'),
            ),
          ],
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 220,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: _nearbyHawkers.length,
            itemBuilder: (context, index) {
              final hawker = _nearbyHawkers[index];

              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HawkerDetailsScreen(hawker: hawker),
                    ),
                  );
                },
                child: Container(
                  width: 160,
                  margin: const EdgeInsets.only(right: 16),
                  child: Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(12),
                              ),
                              child: Image.network(
                                'https://via.placeholder.com/300x200',
                                height: 100,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned(
                              top: 8,
                              right: 8,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color:
                                      hawker.isOnline
                                          ? Colors.green
                                          : Colors.red,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  hawker.isOnline ? 'Online' : 'Offline',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                hawker.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                    size: 16,
                                  ),
                                  Text(
                                    ' ${hawker.rating} (${hawker.totalReviews})',
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.location_on,
                                    color: Colors.grey,
                                    size: 16,
                                  ),
                                  Expanded(
                                    child: Text(
                                      ' ${hawker.areas.first}',
                                      style: TextStyle(
                                        color: Colors.grey[600],
                                        fontSize: 12,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Text(
                                hawker.categories?.join(', ') ?? '',
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 12,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildRecentOrdersSection() {
    if (_recentOrders.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Recent Orders',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextButton(
              onPressed: _navigateToOrderHistory,
              child: const Text('View All'),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _recentOrders.length,
          itemBuilder: (context, index) {
            final order = _recentOrders[index];

            Color statusColor;
            IconData statusIcon;

            switch (order['status']) {
              case 'Pending':
                statusColor = Colors.orange;
                statusIcon = Icons.hourglass_empty;
                break;
              case 'Processing':
                statusColor = Colors.blue;
                statusIcon = Icons.sync;
                break;
              case 'Out for Delivery':
                statusColor = Colors.purple;
                statusIcon = Icons.local_shipping;
                break;
              case 'Delivered':
                statusColor = Colors.green;
                statusIcon = Icons.check_circle;
                break;
              case 'Cancelled':
                statusColor = Colors.red;
                statusIcon = Icons.cancel;
                break;
              default:
                statusColor = Colors.grey;
                statusIcon = Icons.help;
            }

            return Card(
              elevation: 2,
              margin: const EdgeInsets.only(bottom: 16),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(order['hawkerImage']),
                          radius: 20,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                order['hawkerName'],
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Order #${order['id']} • ${DateFormat('dd MMM yyyy').format(order['orderDate'])}',
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 12,
                                ),
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
                            color: statusColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Row(
                            children: [
                              Icon(statusIcon, color: statusColor, size: 12),
                              const SizedBox(width: 4),
                              Text(
                                order['status'],
                                style: TextStyle(
                                  color: statusColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const Divider(height: 24),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${order['items'].length} items',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                order['items']
                                    .map((item) => item['name'])
                                    .join(', '),
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 12,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        Text(
                          '₹${order['totalAmount']}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {
                              // Reorder logic
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Reorder functionality coming soon!',
                                  ),
                                  duration: Duration(seconds: 2),
                                ),
                              );
                            },
                            style: OutlinedButton.styleFrom(
                              foregroundColor: Colors.green,
                            ),
                            child: const Text('Reorder'),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              _navigateToOrderHistory();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              foregroundColor: Colors.white,
                            ),
                            child: const Text('Track Order'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
