import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:hawker_app/models/hawker_model.dart';
import 'package:hawker_app/screens/hawker/hawker_verification_screen.dart';
import 'package:hawker_app/screens/hawker/inventory_management_screen.dart';
import 'package:hawker_app/screens/hawker/order_management_screen.dart';
import 'package:intl/intl.dart';

class HawkerDashboard extends StatefulWidget {
  const HawkerDashboard({Key? key}) : super(key: key);

  @override
  State<HawkerDashboard> createState() => _HawkerDashboardState();
}

class _HawkerDashboardState extends State<HawkerDashboard> {
  // Mock hawker data
  late HawkerModel _hawker;
  
  // Mock earnings data
  final List<Map<String, dynamic>> _dailyEarnings = [
    {'day': 'Mon', 'earnings': 1200.0},
    {'day': 'Tue', 'earnings': 950.0},
    {'day': 'Wed', 'earnings': 1500.0},
    {'day': 'Thu', 'earnings': 1100.0},
    {'day': 'Fri', 'earnings': 1800.0},
    {'day': 'Sat', 'earnings': 2200.0},
    {'day': 'Sun', 'earnings': 1700.0},
  ];
  
  // Mock orders data
  final List<Map<String, dynamic>> _recentOrders = [
    {
      'id': 'ORD001',
      'customerName': 'John Doe',
      'items': [
        {'name': 'Apples', 'quantity': 2, 'unit': 'kg'},
        {'name': 'Bananas', 'quantity': 1, 'unit': 'dozen'},
      ],
      'totalAmount': 300.0,
      'status': 'Delivered',
      'orderDate': DateTime.now().subtract(const Duration(hours: 5)),
    },
    {
      'id': 'ORD002',
      'customerName': 'Jane Smith',
      'items': [
        {'name': 'Tomatoes', 'quantity': 1, 'unit': 'kg'},
        {'name': 'Potatoes', 'quantity': 2, 'unit': 'kg'},
      ],
      'totalAmount': 150.0,
      'status': 'Processing',
      'orderDate': DateTime.now().subtract(const Duration(hours: 3)),
    },
    {
      'id': 'ORD003',
      'customerName': 'Robert Johnson',
      'items': [
        {'name': 'Oranges', 'quantity': 1, 'unit': 'kg'},
      ],
      'totalAmount': 80.0,
      'status': 'Out for Delivery',
      'orderDate': DateTime.now().subtract(const Duration(hours: 4)),
    },
  ];
  
  // Mock inventory alerts
  final List<Map<String, dynamic>> _inventoryAlerts = [
    {
      'name': 'Apples',
      'currentStock': 5,
      'unit': 'kg',
      'threshold': 10,
    },
    {
      'name': 'Oranges',
      'currentStock': 3,
      'unit': 'kg',
      'threshold': 8,
    },
    {
      'name': 'Bananas',
      'currentStock': 2,
      'unit': 'dozen',
      'threshold': 5,
    },
  ];
  
  // Mock metrics
  final Map<String, dynamic> _metrics = {
    'todayEarnings': 1200.0,
    'weeklyEarnings': 8450.0,
    'monthlyEarnings': 32500.0,
    'totalOrders': 120,
    'pendingOrders': 5,
    'completedOrders': 115,
    'totalCustomers': 45,
    'rating': 4.5,
  };
  
  bool _isOnline = true;

  @override
  void initState() {
    super.initState();
    // Initialize with mock data
    _hawker = HawkerModel.getMockHawkers()[0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hawker Dashboard'),
        actions: [
          Switch(
            value: _isOnline,
            onChanged: (value) {
              setState(() {
                _isOnline = value;
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(_isOnline ? 'You are now online' : 'You are now offline'),
                  backgroundColor: _isOnline ? Colors.green : Colors.red,
                ),
              );
            },
            activeColor: Colors.green,
            activeTrackColor: Colors.green.withOpacity(0.5),
            inactiveThumbColor: Colors.red,
            inactiveTrackColor: Colors.red.withOpacity(0.5),
          ),
          const SizedBox(width: 8),
          const CircleAvatar(
            backgroundImage: NetworkImage('https://via.placeholder.com/150'),
            radius: 16,
          ),
          const SizedBox(width: 16),
        ],
      ),
      drawer: _buildHawkerDrawer(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildWelcomeHeader(),
            const SizedBox(height: 24),
            _buildStatusCard(),
            const SizedBox(height: 24),
            _buildMetricsGrid(),
            const SizedBox(height: 24),
            _buildEarningsChart(),
            const SizedBox(height: 24),
            _buildRecentOrdersSection(),
            const SizedBox(height: 24),
            _buildInventoryAlertsSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildWelcomeHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome, ${_hawker.name}',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              DateFormat('EEEE, MMMM d, yyyy').format(DateTime.now()),
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 14,
              ),
            ),
          ],
        ),
        ElevatedButton.icon(
          icon: const Icon(Icons.location_on),
          label: const Text('Update Location'),
          onPressed: () {
            // Update location logic
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Location updated successfully'),
                backgroundColor: Colors.green,
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildStatusCard() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Account Status',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: _hawker.isApproved ? Colors.green.withOpacity(0.1) : Colors.orange.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    _hawker.isApproved ? 'Approved' : 'Pending Approval',
                    style: TextStyle(
                      color: _hawker.isApproved ? Colors.green : Colors.orange,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            if (!_hawker.isVerified || !_hawker.isApproved)
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.orange.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.orange.withOpacity(0.3)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.warning,
                          color: Colors.orange,
                        ),
                        const SizedBox(width: 8),
                        const Expanded(
                          child: Text(
                            'Your account needs verification to access all features',
                            style: TextStyle(
                              color: Colors.orange,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const HawkerVerification()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        foregroundColor: Colors.white,
                      ),
                      child: const Text('Complete Verification'),
                    ),
                  ],
                ),
              ),
            if (_hawker.isVerified && _hawker.isApproved)
              Row(
                children: [
                  Expanded(
                    child: _buildInfoTile(
                      'Current Rating',
                      '${_hawker.rating} ★',
                      '${_hawker.totalReviews} reviews',
                      Icons.star,
                      Colors.amber,
                    ),
                  ),
                  Expanded(
                    child: _buildInfoTile(
                      'Total Orders',
                      _hawker.totalOrders.toString(),
                      'Lifetime',
                      Icons.shopping_bag,
                      Colors.blue,
                    ),
                  ),
                  Expanded(
                    child: _buildInfoTile(
                      'Service Areas',
                      _hawker.areas.length.toString(),
                      'Active locations',
                      Icons.location_on,
                      Colors.green,
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoTile(String title, String value, String subtitle, IconData icon, Color color) {
    return Column(
      children: [
        Icon(
          icon,
          color: color,
          size: 28,
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          title,
          style: const TextStyle(
            fontSize: 14,
          ),
        ),
        Text(
          subtitle,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildMetricsGrid() {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      childAspectRatio: 1.5,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      children: [
        _buildMetricCard(
          'Today\'s Earnings',
          '₹${_metrics['todayEarnings']}',
          Icons.monetization_on,
          Colors.green,
        ),
        _buildMetricCard(
          'Weekly Earnings',
          '₹${_metrics['weeklyEarnings']}',
          Icons.calendar_today,
          Colors.blue,
        ),
        _buildMetricCard(
          'Pending Orders',
          _metrics['pendingOrders'].toString(),
          Icons.pending_actions,
          Colors.orange,
        ),
        _buildMetricCard(
          'Total Customers',
          _metrics['totalCustomers'].toString(),
          Icons.people,
          Colors.purple,
        ),
      ],
    );
  }

  Widget _buildMetricCard(String title, String value, IconData icon, Color color) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    icon,
                    color: color,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        value,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEarningsChart() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Weekly Earnings',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                DropdownButton<String>(
                  value: 'This Week',
                  items: ['This Week', 'Last Week', 'Last Month']
                      .map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    // Handle dropdown change
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 200,
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  maxY: 2500,
                  barTouchData: BarTouchData(
                    enabled: true,
                    touchTooltipData: BarTouchTooltipData(
                      //tooltipBgColor: Colors.blueGrey,
                      getTooltipItem: (group, groupIndex, rod, rodIndex) {
                        return BarTooltipItem(
                          '₹${_dailyEarnings[groupIndex]['earnings']}',
                          const TextStyle(color: Colors.white),
                        );
                      },
                    ),
                  ),
                  titlesData: FlTitlesData(
                    show: true,
                    rightTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    topTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          if (value.toInt() >= 0 && value.toInt() < _dailyEarnings.length) {
                            return Text(_dailyEarnings[value.toInt()]['day']);
                          }
                          return const Text('');
                        },
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          return Text('₹${value.toInt()}');
                        },
                        reservedSize: 40,
                      ),
                    ),
                  ),
                  borderData: FlBorderData(show: false),
                  barGroups: _dailyEarnings.asMap().entries.map((entry) {
                    final index = entry.key;
                    final data = entry.value;
                    return BarChartGroupData(
                      x: index,
                      barRods: [
                        BarChartRodData(
                          toY: data['earnings'],
                          color: Colors.green,
                          width: 16,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(4),
                            topRight: Radius.circular(4),
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentOrdersSection() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Recent Orders',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const OrderManagement()),
                    );
                  },
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
                
                return ListTile(
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
                  subtitle: Text(
                    '${order['customerName']} • ${DateFormat('hh:mm a').format(order['orderDate'])}',
                  ),
                  trailing: Text(
                    '₹${order['totalAmount']}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  onTap: () {
                    // Navigate to order details
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const OrderManagement()),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInventoryAlertsSection() {
    if (_inventoryAlerts.isEmpty) {
      return const SizedBox.shrink();
    }
    
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Inventory Alerts',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const InventoryManagement()),
                    );
                  },
                  child: const Text('Manage Inventory'),
                ),
              ],
            ),
            const SizedBox(height: 8),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _inventoryAlerts.length,
              itemBuilder: (context, index) {
                final item = _inventoryAlerts[index];
                
                return ListTile(
                  leading: const Icon(
                    Icons.warning,
                    color: Colors.red,
                  ),
                  title: Text(
                    item['name'],
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    'Current stock: ${item['currentStock']} ${item['unit']} (Threshold: ${item['threshold']} ${item['unit']})',
                  ),
                  trailing: ElevatedButton(
                    onPressed: () {
                      // Navigate to inventory management
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const InventoryManagement()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Restock'),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHawkerDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.green,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CircleAvatar(
                  backgroundImage: NetworkImage('https://via.placeholder.com/150'),
                  radius: 30,
                ),
                const SizedBox(height: 10),
                Text(
                  _hawker.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
                Text(
                  _hawker.phone,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.dashboard),
            title: const Text('Dashboard'),
            selected: true,
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.verified_user),
            title: const Text('Verification'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HawkerVerification()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.inventory),
            title: const Text('Inventory Management'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const InventoryManagement()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.shopping_cart),
            title: const Text('Order Management'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const OrderManagement()),
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.location_on),
            title: const Text('My Areas'),
            onTap: () {
              Navigator.pop(context);
              // Navigate to areas management
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {
              Navigator.pop(context);
              // Navigate to settings
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () {
              // Handle logout
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}