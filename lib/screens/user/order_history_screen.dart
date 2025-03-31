import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'order_tracking_screen.dart';
import 'return_request_screen.dart';

class OrderHistoryScreen extends StatefulWidget {
  const OrderHistoryScreen({Key? key}) : super(key: key);

  @override
  State<OrderHistoryScreen> createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  
  final List<Map<String, dynamic>> _orders = [
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
      'paymentMethod': 'Cash on Delivery',
      'paymentStatus': 'Paid',
      'orderDate': DateTime.now().subtract(const Duration(days: 2)),
      'deliveryDate': DateTime.now().subtract(const Duration(days: 1)),
      'address': '123 Main St, Delhi, India',
      'canReturn': true,
    },
    {
      'id': 'ORD002',
      'hawkerName': 'Veggie Express',
      'hawkerImage': 'https://via.placeholder.com/150',
      'items': [
        {'name': 'Tomatoes', 'quantity': 1, 'unit': 'kg', 'price': 40.0},
        {'name': 'Potatoes', 'quantity': 2, 'unit': 'kg', 'price': 30.0},
        {'name': 'Onions', 'quantity': 1, 'unit': 'kg', 'price': 50.0},
      ],
      'totalAmount': 150.0,
      'status': 'Out for Delivery',
      'paymentMethod': 'Online Payment',
      'paymentStatus': 'Paid',
      'orderDate': DateTime.now().subtract(const Duration(hours: 5)),
      'deliveryDate': null,
      'address': '456 Park Ave, Delhi, India',
      'canReturn': false,
    },
    {
      'id': 'ORD003',
      'hawkerName': 'Dairy Delight',
      'hawkerImage': 'https://via.placeholder.com/150',
      'items': [
        {'name': 'Milk', 'quantity': 2, 'unit': 'liter', 'price': 60.0},
        {'name': 'Cheese', 'quantity': 0.5, 'unit': 'kg', 'price': 200.0},
      ],
      'totalAmount': 220.0,
      'status': 'Processing',
      'paymentMethod': 'Cash on Delivery',
      'paymentStatus': 'Pending',
      'orderDate': DateTime.now().subtract(const Duration(hours: 8)),
      'deliveryDate': null,
      'address': '789 Lake View, Delhi, India',
      'canReturn': false,
    },
    {
      'id': 'ORD004',
      'hawkerName': 'Bakery Bliss',
      'hawkerImage': 'https://via.placeholder.com/150',
      'items': [
        {'name': 'Bread', 'quantity': 2, 'unit': 'loaf', 'price': 35.0},
        {'name': 'Cookies', 'quantity': 1, 'unit': 'pack', 'price': 50.0},
      ],
      'totalAmount': 120.0,
      'status': 'Cancelled',
      'paymentMethod': 'Online Payment',
      'paymentStatus': 'Refunded',
      'orderDate': DateTime.now().subtract(const Duration(days: 3)),
      'deliveryDate': null,
      'address': '101 Green Park, Delhi, India',
      'canReturn': false,
    },
    {
      'id': 'ORD005',
      'hawkerName': 'Fresh Fruits Vendor',
      'hawkerImage': 'https://via.placeholder.com/150',
      'items': [
        {'name': 'Mangoes', 'quantity': 1, 'unit': 'kg', 'price': 150.0},
        {'name': 'Grapes', 'quantity': 0.5, 'unit': 'kg', 'price': 100.0},
      ],
      'totalAmount': 200.0,
      'status': 'Delivered',
      'paymentMethod': 'Cash on Delivery',
      'paymentStatus': 'Paid',
      'orderDate': DateTime.now().subtract(const Duration(days: 5)),
      'deliveryDate': DateTime.now().subtract(const Duration(days: 4)),
      'address': '202 Civil Lines, Delhi, India',
      'canReturn': false,
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> _getFilteredOrders(String status) {
    List<Map<String, dynamic>> filteredList = List.from(_orders);
    
    // Apply status filter
    if (status != 'All') {
      filteredList = filteredList.where((order) => order['status'] == status).toList();
    }
    
    // Apply search filter
    if (_searchQuery.isNotEmpty) {
      filteredList = filteredList.where((order) {
        return order['id'].toLowerCase().contains(_searchQuery.toLowerCase()) ||
            order['hawkerName'].toLowerCase().contains(_searchQuery.toLowerCase()) ||
            order['items'].any((item) => item['name'].toLowerCase().contains(_searchQuery.toLowerCase()));
      }).toList();
    }
    
    // Sort by order date (newest first)
    filteredList.sort((a, b) => b['orderDate'].compareTo(a['orderDate']));
    
    return filteredList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order History'),
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabs: const [
            Tab(text: 'All'),
            Tab(text: 'Processing'),
            Tab(text: 'Out for Delivery'),
            Tab(text: 'Delivered'),
          ],
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search by order ID or hawker',
                prefixIcon: const Icon(Icons.search),
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
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildOrderList(_getFilteredOrders('All')),
                _buildOrderList(_getFilteredOrders('Processing')),
                _buildOrderList(_getFilteredOrders('Out for Delivery')),
                _buildOrderList(_getFilteredOrders('Delivered')),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderList(List<Map<String, dynamic>> orders) {
    if (orders.isEmpty) {
      return const Center(
        child: Text('No orders found'),
      );
    }
    
    return ListView.builder(
      itemCount: orders.length,
      itemBuilder: (context, index) {
        final order = orders[index];
        
        Color statusColor;
        switch (order['status']) {
          case 'Pending':
            statusColor = Colors.orange;
            break;
          case 'Processing':
            statusColor = Colors.blue;
            break;
          case 'Out for Delivery':
            statusColor = Colors.purple;
            break;
          case 'Delivered':
            statusColor = Colors.green;
            break;
          case 'Cancelled':
            statusColor = Colors.red;
            break;
          default:
            statusColor = Colors.grey;
        }
        
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: ExpansionTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(order['hawkerImage']),
            ),
            title: Text(
              'Order #${order['id']}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(order['hawkerName']),
                Text(
                  'Date: ${DateFormat('dd MMM yyyy, hh:mm a').format(order['orderDate'])}',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '₹${order['totalAmount']}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    order['status'],
                    style: TextStyle(
                      color: statusColor,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Order Items',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 8),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: order['items'].length,
                      itemBuilder: (context, itemIndex) {
                        final item = order['items'][itemIndex];
                        return ListTile(
                          dense: true,
                          title: Text(item['name']),
                          subtitle: Text('${item['quantity']} ${item['unit']} x ₹${item['price']}'),
                          trailing: Text(
                            '₹${(item['quantity'] * item['price']).toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      },
                    ),
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Delivery Address:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            order['address'],
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              color: Colors.grey[600],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Payment Method:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          order['paymentMethod'],
                          style: TextStyle(
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Payment Status:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          order['paymentStatus'],
                          style: TextStyle(
                            color: order['paymentStatus'] == 'Paid' ? Colors.green : Colors.orange,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Total Amount:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '₹${order['totalAmount']}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        if (order['status'] == 'Out for Delivery' || order['status'] == 'Processing')
                          ElevatedButton.icon(
                            icon: const Icon(Icons.location_on),
                            label: const Text('Track Order'),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => OrderTrackingScreen(order: order),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              foregroundColor: Colors.white,
                            ),
                          ),
                        if (order['status'] == 'Delivered' && order['canReturn'])
                          ElevatedButton.icon(
                            icon: const Icon(Icons.assignment_return),
                            label: const Text('Return'),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ReturnRequestScreen(order: order),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.orange,
                              foregroundColor: Colors.white,
                            ),
                          ),
                        const SizedBox(width: 8),
                        OutlinedButton.icon(
                          icon: const Icon(Icons.receipt),
                          label: const Text('Invoice'),
                          onPressed: () {
                            // Download invoice logic
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Invoice downloading...'),
                                duration: Duration(seconds: 2),
                              ),
                            );
                          },
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.green,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}