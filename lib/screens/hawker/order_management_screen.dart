import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrderManagement extends StatefulWidget {
  const OrderManagement({super.key});

  @override
  State<OrderManagement> createState() => _OrderManagementState();
}

class _OrderManagementState extends State<OrderManagement> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  String _selectedFilter = 'All';
  
  final List<String> _filters = [
    'All',
    'Today',
    'This Week',
    'This Month',
  ];
  
  final List<Map<String, dynamic>> _orders = [
    {
      'id': 'ORD001',
      'customerName': 'John Doe',
      'customerPhone': '9876543210',
      'items': [
        {'name': 'Apples', 'quantity': 2, 'unit': 'kg', 'price': 120.0},
        {'name': 'Bananas', 'quantity': 1, 'unit': 'dozen', 'price': 60.0},
      ],
      'totalAmount': 300.0,
      'status': 'Delivered',
      'paymentMethod': 'Cash on Delivery',
      'paymentStatus': 'Paid',
      'orderDate': DateTime.now().subtract(const Duration(hours: 5)),
      'deliveryDate': DateTime.now().subtract(const Duration(hours: 2)),
      'address': '123 Main St, Delhi, India',
      'customerNote': 'Please deliver at the gate',
    },
    {
      'id': 'ORD002',
      'customerName': 'Jane Smith',
      'customerPhone': '9876543211',
      'items': [
        {'name': 'Tomatoes', 'quantity': 1, 'unit': 'kg', 'price': 40.0},
        {'name': 'Potatoes', 'quantity': 2, 'unit': 'kg', 'price': 30.0},
        {'name': 'Onions', 'quantity': 1, 'unit': 'kg', 'price': 50.0},
      ],
      'totalAmount': 150.0,
      'status': 'Processing',
      'paymentMethod': 'Online Payment',
      'paymentStatus': 'Paid',
      'orderDate': DateTime.now().subtract(const Duration(hours: 3)),
      'deliveryDate': null,
      'address': '456 Park Ave, Delhi, India',
      'customerNote': '',
    },
    {
      'id': 'ORD003',
      'customerName': 'Robert Johnson',
      'customerPhone': '9876543212',
      'items': [
        {'name': 'Oranges', 'quantity': 1, 'unit': 'kg', 'price': 80.0},
        {'name': 'Apples', 'quantity': 1, 'unit': 'kg', 'price': 120.0},
      ],
      'totalAmount': 200.0,
      'status': 'Out for Delivery',
      'paymentMethod': 'Cash on Delivery',
      'paymentStatus': 'Pending',
      'orderDate': DateTime.now().subtract(const Duration(hours: 4)),
      'deliveryDate': null,
      'address': '789 Lake View, Delhi, India',
      'customerNote': 'Call before delivery',
    },
    {
      'id': 'ORD004',
      'customerName': 'Emily Davis',
      'customerPhone': '9876543213',
      'items': [
        {'name': 'Tomatoes', 'quantity': 1, 'unit': 'kg', 'price': 40.0},
        {'name': 'Spinach', 'quantity': 0.5, 'unit': 'kg', 'price': 60.0},
        {'name': 'Carrots', 'quantity': 0.5, 'unit': 'kg', 'price': 50.0},
      ],
      'totalAmount': 125.0,
      'status': 'Cancelled',
      'paymentMethod': 'Online Payment',
      'paymentStatus': 'Refunded',
      'orderDate': DateTime.now().subtract(const Duration(days: 1)),
      'deliveryDate': null,
      'address': '101 Green Park, Delhi, India',
      'customerNote': '',
    },
    {
      'id': 'ORD005',
      'customerName': 'Michael Wilson',
      'customerPhone': '9876543214',
      'items': [
        {'name': 'Mangoes', 'quantity': 1, 'unit': 'kg', 'price': 150.0},
        {'name': 'Grapes', 'quantity': 0.5, 'unit': 'kg', 'price': 100.0},
      ],
      'totalAmount': 200.0,
      'status': 'Pending',
      'paymentMethod': 'Cash on Delivery',
      'paymentStatus': 'Pending',
      'orderDate': DateTime.now().subtract(const Duration(minutes: 30)),
      'deliveryDate': null,
      'address': '202 Civil Lines, Delhi, India',
      'customerNote': 'Fresh fruits only please',
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
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
    
    // Apply date filter
    if (_selectedFilter != 'All') {
      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);
      
      switch (_selectedFilter) {
        case 'Today':
          filteredList = filteredList.where((order) {
            final orderDate = order['orderDate'] as DateTime;
            return orderDate.isAfter(today.subtract(const Duration(days: 1)));
          }).toList();
          break;
        case 'This Week':
          filteredList = filteredList.where((order) {
            final orderDate = order['orderDate'] as DateTime;
            return orderDate.isAfter(today.subtract(const Duration(days: 7)));
          }).toList();
          break;
        case 'This Month':
          filteredList = filteredList.where((order) {
            final orderDate = order['orderDate'] as DateTime;
            return orderDate.isAfter(today.subtract(const Duration(days: 30)));
          }).toList();
          break;
      }
    }
    
    // Apply search filter
    if (_searchQuery.isNotEmpty) {
      filteredList = filteredList.where((order) {
        return order['id'].toLowerCase().contains(_searchQuery.toLowerCase()) ||
            order['customerName'].toLowerCase().contains(_searchQuery.toLowerCase()) ||
            order['customerPhone'].contains(_searchQuery);
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
        title: const Text('Order Management'),
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabs: const [
            Tab(text: 'All'),
            Tab(text: 'Pending'),
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
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Search by order ID or customer',
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
                const SizedBox(width: 16),
                DropdownButton<String>(
                  value: _selectedFilter,
                  items: _filters.map((String filter) {
                    return DropdownMenuItem<String>(
                      value: filter,
                      child: Text(filter),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      setState(() {
                        _selectedFilter = newValue;
                      });
                    }
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildOrderList(_getFilteredOrders('All')),
                _buildOrderList(_getFilteredOrders('Pending')),
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
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: ExpansionTile(
            leading: CircleAvatar(
              backgroundColor: statusColor.withOpacity(0.2),
              child: Icon(
                statusIcon,
                color: statusColor,
              ),
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
                Text('Customer: ${order['customerName']}'),
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
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildInfoRow('Customer', order['customerName']),
                              _buildInfoRow('Phone', order['customerPhone']),
                              _buildInfoRow('Payment Method', order['paymentMethod']),
                              _buildInfoRow('Payment Status', order['paymentStatus']),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildInfoRow('Address', order['address']),
                              if (order['customerNote'].isNotEmpty)
                                _buildInfoRow('Note', order['customerNote']),
                              if (order['deliveryDate'] != null)
                                _buildInfoRow(
                                  'Delivery Date',
                                  DateFormat('dd MMM yyyy, hh:mm a').format(order['deliveryDate']),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const Divider(),
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
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Text(
                          'Total Amount:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 8),
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
                        if (order['status'] == 'Pending')
                          ElevatedButton.icon(
                            icon: const Icon(Icons.sync),
                            label: const Text('Accept Order'),
                            onPressed: () {
                              _updateOrderStatus(order, 'Processing');
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              foregroundColor: Colors.white,
                            ),
                          ),
                        if (order['status'] == 'Processing')
                          ElevatedButton.icon(
                            icon: const Icon(Icons.local_shipping),
                            label: const Text('Start Delivery'),
                            onPressed: () {
                              _updateOrderStatus(order, 'Out for Delivery');
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.purple,
                              foregroundColor: Colors.white,
                            ),
                          ),
                        if (order['status'] == 'Out for Delivery')
                          ElevatedButton.icon(
                            icon: const Icon(Icons.check_circle),
                            label: const Text('Mark as Delivered'),
                            onPressed: () {
                              _updateOrderStatus(order, 'Delivered');
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              foregroundColor: Colors.white,
                            ),
                          ),
                        if (order['status'] != 'Delivered' && order['status'] != 'Cancelled')
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: ElevatedButton.icon(
                              icon: const Icon(Icons.cancel),
                              label: const Text('Cancel Order'),
                              onPressed: () {
                                _showCancelOrderDialog(order);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                                foregroundColor: Colors.white,
                              ),
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

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label: ',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
          Expanded(
            child: Text(value),
          ),
        ],
      ),
    );
  }

  void _updateOrderStatus(Map<String, dynamic> order, String newStatus) {
    setState(() {
      final index = _orders.indexWhere((o) => o['id'] == order['id']);
      if (index != -1) {
        _orders[index] = {
          ..._orders[index],
          'status': newStatus,
          'deliveryDate': newStatus == 'Delivered' ? DateTime.now() : _orders[index]['deliveryDate'],
        };
      }
    });
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Order #${order['id']} status updated to $newStatus'),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _showCancelOrderDialog(Map<String, dynamic> order) {
    final TextEditingController reasonController = TextEditingController();
    
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Cancel Order'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Are you sure you want to cancel Order #${order['id']}?'),
              const SizedBox(height: 16),
              TextField(
                controller: reasonController,
                decoration: const InputDecoration(
                  labelText: 'Reason for cancellation',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('No'),
            ),
            ElevatedButton(
              onPressed: () {
                if (reasonController.text.trim().isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please provide a reason for cancellation'),
                      backgroundColor: Colors.red,
                    ),
                  );
                  return;
                }
                
                setState(() {
                  final index = _orders.indexWhere((o) => o['id'] == order['id']);
                  if (index != -1) {
                    _orders[index] = {
                      ..._orders[index],
                      'status': 'Cancelled',
                      'paymentStatus': order['paymentStatus'] == 'Paid' ? 'Refunded' : order['paymentStatus'],
                    };
                  }
                });
                
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Order #${order['id']} has been cancelled'),
                    backgroundColor: Colors.red,
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              child: const Text('Yes, Cancel'),
            ),
          ],
        );
      },
    );
  }
}