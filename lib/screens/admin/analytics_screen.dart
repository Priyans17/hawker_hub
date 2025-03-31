import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String _selectedPeriod = 'This Week';
  final List<String> _periods = ['Today', 'This Week', 'This Month', 'This Year'];
  
  final Map<String, double> _salesByCategory = {
    'Fruits': 45000,
    'Vegetables': 35000,
    'Dairy': 20000,
    'Bakery': 15000,
    'Beverages': 10000,
  };
  
  final Map<String, double> _salesByLocation = {
    'Delhi': 60000,
    'Mumbai': 40000,
    'Bangalore': 30000,
    'Chennai': 25000,
    'Kolkata': 20000,
  };
  
  final List<Map<String, dynamic>> _topHawkers = [
    {
      'name': 'Ramesh Fruits',
      'sales': 12500,
      'orders': 120,
      'rating': 4.5,
    },
    {
      'name': 'Suresh Vegetables',
      'sales': 10800,
      'orders': 95,
      'rating': 4.2,
    },
    {
      'name': 'Mahesh Fresh Fruits',
      'sales': 15600,
      'orders': 150,
      'rating': 4.7,
    },
    {
      'name': 'Dinesh Organic Veggies',
      'sales': 18200,
      'orders': 200,
      'rating': 4.8,
    },
    {
      'name': 'Jignesh Fruit Corner',
      'sales': 8500,
      'orders': 80,
      'rating': 4.0,
    },
  ];
  
  final List<Map<String, dynamic>> _monthlySales = [
    {'month': 'Jan', 'sales': 45000},
    {'month': 'Feb', 'sales': 50000},
    {'month': 'Mar', 'sales': 60000},
    {'month': 'Apr', 'sales': 70000},
    {'month': 'May', 'sales': 65000},
    {'month': 'Jun', 'sales': 80000},
    {'month': 'Jul', 'sales': 85000},
    {'month': 'Aug', 'sales': 90000},
    {'month': 'Sep', 'sales': 75000},
    {'month': 'Oct', 'sales': 95000},
    {'month': 'Nov', 'sales': 100000},
    {'month': 'Dec', 'sales': 120000},
  ];
  
  final List<Map<String, dynamic>> _userGrowth = [
    {'month': 'Jan', 'users': 100},
    {'month': 'Feb', 'users': 150},
    {'month': 'Mar', 'users': 200},
    {'month': 'Apr', 'users': 300},
    {'month': 'May', 'users': 450},
    {'month': 'Jun', 'users': 600},
    {'month': 'Jul', 'users': 750},
    {'month': 'Aug', 'users': 900},
    {'month': 'Sep', 'users': 1050},
    {'month': 'Oct', 'users': 1200},
    {'month': 'Nov', 'users': 1350},
    {'month': 'Dec', 'users': 1500},
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Analytics'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Sales'),
            Tab(text: 'Users'),
            Tab(text: 'Hawkers'),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.download),
            onPressed: () {
              // Export analytics data
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Analytics Overview',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                DropdownButton<String>(
                  value: _selectedPeriod,
                  items: _periods.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      setState(() {
                        _selectedPeriod = newValue;
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
                _buildSalesTab(),
                _buildUsersTab(),
                _buildHawkersTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSalesTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSalesOverviewCards(),
          const SizedBox(height: 24),
          _buildMonthlySalesChart(),
          const SizedBox(height: 24),
          _buildSalesByCategoryChart(),
          const SizedBox(height: 24),
          _buildSalesByLocationChart(),
        ],
      ),
    );
  }

  Widget _buildSalesOverviewCards() {
    final totalSales = _monthlySales.fold(0.0, (sum, item) => sum + (item['sales'] as double));
    final averageSales = totalSales / _monthlySales.length;
    final highestSales = _monthlySales.map((e) => e['sales'] as double).reduce((a, b) => a > b ? a : b);
    final lowestSales = _monthlySales.map((e) => e['sales'] as double).reduce((a, b) => a < b ? a : b);

    final metrics = [
      {'title': 'Total Sales', 'value': '₹${NumberFormat('#,##0').format(totalSales)}', 'icon': Icons.attach_money, 'color': Colors.green},
      {'title': 'Average Monthly', 'value': '₹${NumberFormat('#,##0').format(averageSales)}', 'icon': Icons.trending_up, 'color': Colors.blue},
      {'title': 'Highest Month', 'value': '₹${NumberFormat('#,##0').format(highestSales)}', 'icon': Icons.arrow_upward, 'color': Colors.purple},
      {'title': 'Lowest Month', 'value': '₹${NumberFormat('#,##0').format(lowestSales)}', 'icon': Icons.arrow_downward, 'color': Colors.orange},
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2.5,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: metrics.length,
      itemBuilder: (context, index) {
        final metric = metrics[index];
        return Card(
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: (metric['color'] as Color).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    metric['icon'] as IconData,
                    color: metric['color'] as Color,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        metric['title'] as String,
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        metric['value'] as String,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildMonthlySalesChart() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Monthly Sales',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 250,
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  maxY: 150000,
                  barTouchData: BarTouchData(
                    enabled: true,
                    touchTooltipData: BarTouchTooltipData(
                      tooltipMargin: 8,
                      getTooltipItem: (group, groupIndex, rod, rodIndex) {
                        return BarTooltipItem(
                          '₹${NumberFormat('#,##0').format(_monthlySales[groupIndex]['sales'])}',
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
                          if (value.toInt() >= 0 && value.toInt() < _monthlySales.length) {
                            return Text(_monthlySales[value.toInt()]['month']);
                          }
                          return const Text('');
                        },
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          return Text('₹${(value / 1000).toInt()}K');
                        },
                        reservedSize: 40,
                      ),
                    ),
                  ),
                  borderData: FlBorderData(show: false),
                  barGroups: _monthlySales.asMap().entries.map((entry) {
                    final index = entry.key;
                    final data = entry.value;
                    return BarChartGroupData(
                      x: index,
                      barRods: [
                        BarChartRodData(
                          toY: data['sales'],
                          color: Colors.blue,
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

  Widget _buildSalesByCategoryChart() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Sales by Category',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 250,
              child: PieChart(
                PieChartData(
                  sectionsSpace: 2,
                  centerSpaceRadius: 40,
                  sections: _getSalesByCategorySections(),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 16,
              runSpacing: 8,
              children: _getSalesByCategoryLegend(),
            ),
          ],
        ),
      ),
    );
  }

  List<PieChartSectionData> _getSalesByCategorySections() {
    final total = _salesByCategory.values.fold(0.0, (sum, value) => sum + value);
    final colors = [
      Colors.blue,
      Colors.green,
      Colors.orange,
      Colors.purple,
      Colors.red,
    ];

    return _salesByCategory.entries.map((entry) {
      final index = _salesByCategory.keys.toList().indexOf(entry.key);
      final percentage = (entry.value / total) * 100;
      
      return PieChartSectionData(
        color: colors[index % colors.length],
        value: entry.value,
        title: '${percentage.toStringAsFixed(1)}%',
        radius: 100,
        titleStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      );
    }).toList();
  }

  List<Widget> _getSalesByCategoryLegend() {
    final colors = [
      Colors.blue,
      Colors.green,
      Colors.orange,
      Colors.purple,
      Colors.red,
    ];

    return _salesByCategory.entries.map((entry) {
      final index = _salesByCategory.keys.toList().indexOf(entry.key);
      
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 16,
            height: 16,
            color: colors[index % colors.length],
          ),
          const SizedBox(width: 4),
          Text(
            '${entry.key}: ₹${NumberFormat('#,##0').format(entry.value)}',
            style: const TextStyle(fontSize: 12),
          ),
        ],
      );
    }).toList();
  }

  Widget _buildSalesByLocationChart() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Sales by Location',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 250,
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  maxY: 70000,
                  barTouchData: BarTouchData(
                    enabled: true,
                    touchTooltipData: BarTouchTooltipData(
                      //tooltipBgColor: Colors.blueGrey,
                      getTooltipItem: (group, groupIndex, rod, rodIndex) {
                        final location = _salesByLocation.keys.elementAt(groupIndex);
                        final sales = _salesByLocation.values.elementAt(groupIndex);
                        return BarTooltipItem(
                          '$location: ₹${NumberFormat('#,##0').format(sales)}',
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
                          if (value.toInt() >= 0 && value.toInt() < _salesByLocation.length) {
                            return Text(
                              _salesByLocation.keys.elementAt(value.toInt()),
                              style: const TextStyle(fontSize: 10),
                            );
                          }
                          return const Text('');
                        },
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          return Text('₹${(value / 1000).toInt()}K');
                        },
                        reservedSize: 40,
                      ),
                    ),
                  ),
                  borderData: FlBorderData(show: false),
                  barGroups: _salesByLocation.entries.map((entry) {
                    final index = _salesByLocation.keys.toList().indexOf(entry.key);
                    return BarChartGroupData(
                      x: index,
                      barRods: [
                        BarChartRodData(
                          toY: entry.value,
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

  Widget _buildUsersTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildUserMetricsCards(),
          const SizedBox(height: 24),
          _buildUserGrowthChart(),
          const SizedBox(height: 24),
          _buildUserDemographics(),
        ],
      ),
    );
  }

  Widget _buildUserMetricsCards() {
    final metrics = [
      {'title': 'Total Users', 'value': '1,500', 'icon': Icons.people, 'color': Colors.blue},
      {'title': 'Active Users', 'value': '1,245', 'icon': Icons.person, 'color': Colors.green},
      {'title': 'New Users (This Month)', 'value': '150', 'icon': Icons.person_add, 'color': Colors.purple},
      {'title': 'Retention Rate', 'value': '85%', 'icon': Icons.repeat, 'color': Colors.orange},
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2.5,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: metrics.length,
      itemBuilder: (context, index) {
        final metric = metrics[index];
        return Card(
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: (metric['color'] as Color).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    metric['icon'] as IconData,
                    color: metric['color'] as Color,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        metric['title'] as String,
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        metric['value'] as String,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildUserGrowthChart() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'User Growth',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 250,
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(show: true),
                  titlesData: FlTitlesData(
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
                          if (value.toInt() >= 0 && value.toInt() < _userGrowth.length) {
                            return Text(_userGrowth[value.toInt()]['month']);
                          }
                          return const Text('');
                        },
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          return Text(value.toInt().toString());
                        },
                        reservedSize: 40,
                      ),
                    ),
                  ),
                  borderData: FlBorderData(show: true),
                  lineBarsData: [
                    LineChartBarData(
                      spots: _userGrowth.asMap().entries.map((entry) {
                        return FlSpot(entry.key.toDouble(), entry.value['users'].toDouble());
                      }).toList(),
                      isCurved: true,
                      color: Colors.blue,
                      barWidth: 3,
                      isStrokeCapRound: true,
                      dotData: FlDotData(show: false),
                      belowBarData: BarAreaData(
                        show: true,
                        color: Colors.blue.withOpacity(0.1),
                      ),
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

  Widget _buildUserDemographics() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'User Demographics',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      const Text(
                        'Age Distribution',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      SizedBox(
                        height: 150,
                        child: PieChart(
                          PieChartData(
                            sectionsSpace: 2,
                            centerSpaceRadius: 30,
                            sections: [
                              PieChartSectionData(
                                color: Colors.blue,
                                value: 25,
                                title: '25%',
                                radius: 50,
                                titleStyle: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              PieChartSectionData(
                                color: Colors.green,
                                value: 35,
                                title: '35%',
                                radius: 50,
                                titleStyle: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              PieChartSectionData(
                                color: Colors.orange,
                                value: 20,
                                title: '20%',
                                radius: 50,
                                titleStyle: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              PieChartSectionData(
                                color: Colors.purple,
                                value: 20,
                                title: '20%',
                                radius: 50,
                                titleStyle: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 4,
                        children: [
                          _buildLegendItem('18-24', Colors.blue),
                          _buildLegendItem('25-34', Colors.green),
                          _buildLegendItem('35-44', Colors.orange),
                          _buildLegendItem('45+', Colors.purple),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      const Text(
                        'Gender Distribution',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      SizedBox(
                        height: 150,
                        child: PieChart(
                          PieChartData(
                            sectionsSpace: 2,
                            centerSpaceRadius: 30,
                            sections: [
                              PieChartSectionData(
                                color: Colors.blue,
                                value: 60,
                                title: '60%',
                                radius: 50,
                                titleStyle: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              PieChartSectionData(
                                color: Colors.pink,
                                value: 40,
                                title: '40%',
                                radius: 50,
                                titleStyle: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 4,
                        children: [
                          _buildLegendItem('Male', Colors.blue),
                          _buildLegendItem('Female', Colors.pink),
                        ],
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

  Widget _buildLegendItem(String label, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12,
          height: 12,
          color: color,
        ),
        const SizedBox(width: 4),
        Text(
          label,
          style: const TextStyle(fontSize: 12),
        ),
      ],
    );
  }

  Widget _buildHawkersTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHawkerMetricsCards(),
          const SizedBox(height: 24),
          _buildTopHawkersTable(),
          const SizedBox(height: 24),
          _buildHawkerRatingsChart(),
        ],
      ),
    );
  }

  Widget _buildHawkerMetricsCards() {
    final metrics = [
      {'title': 'Total Hawkers', 'value': '87', 'icon': Icons.delivery_dining, 'color': Colors.blue},
      {'title': 'Active Hawkers', 'value': '65', 'icon': Icons.check_circle, 'color': Colors.green},
      {'title': 'Average Rating', 'value': '4.3', 'icon': Icons.star, 'color': Colors.orange},
      {'title': 'Pending Approvals', 'value': '12', 'icon': Icons.pending, 'color': Colors.red},
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2.5,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: metrics.length,
      itemBuilder: (context, index) {
        final metric = metrics[index];
        return Card(
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: (metric['color'] as Color).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    metric['icon'] as IconData,
                    color: metric['color'] as Color,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        metric['title'] as String,
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        metric['value'] as String,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildTopHawkersTable() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Top Performing Hawkers',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: const [
                  DataColumn(label: Text('Hawker Name')),
                  DataColumn(label: Text('Sales'), numeric: true),
                  DataColumn(label: Text('Orders'), numeric: true),
                  DataColumn(label: Text('Rating'), numeric: true),
                ],
                rows: _topHawkers.map((hawker) {
                  return DataRow(
                    cells: [
                      DataCell(Text(hawker['name'])),
                      DataCell(Text('₹${NumberFormat('#,##0').format(hawker['sales'])}')),
                      DataCell(Text(hawker['orders'].toString())),
                      DataCell(Row(
                        children: [
                          Text(hawker['rating'].toString()),
                          const SizedBox(width: 4),
                          Icon(
                            Icons.star,
                            size: 16,
                            color: Colors.amber,
                          ),
                        ],
                      )),
                    ],
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHawkerRatingsChart() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Hawker Ratings Distribution',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 250,
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  maxY: 40,
                  barTouchData: BarTouchData(
                    enabled: true,
                    touchTooltipData: BarTouchTooltipData(
                      //tooltipBgColor: Colors.blueGrey,
                      getTooltipItem: (group, groupIndex, rod, rodIndex) {
                        final ratings = ['1 Star', '2 Stars', '3 Stars', '4 Stars', '5 Stars'];
                        final percentages = [5, 10, 15, 30, 40];
                        return BarTooltipItem(
                          '${ratings[groupIndex]}: ${percentages[groupIndex]}%',
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
                          final ratings = ['1★', '2★', '3★', '4★', '5★'];
                          if (value.toInt() >= 0 && value.toInt() < ratings.length) {
                            return Text(ratings[value.toInt()]);
                          }
                          return const Text('');
                        },
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          return Text('${value.toInt()}%');
                        },
                        reservedSize: 40,
                      ),
                    ),
                  ),
                  borderData: FlBorderData(show: false),
                  barGroups: [
                    BarChartGroupData(
                      x: 0,
                      barRods: [
                        BarChartRodData(
                          toY: 5,
                          color: Colors.red,
                          width: 16,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(4),
                            topRight: Radius.circular(4),
                          ),
                        ),
                      ],
                    ),
                    BarChartGroupData(
                      x: 1,
                      barRods: [
                        BarChartRodData(
                          toY: 10,
                          color: Colors.orange,
                          width: 16,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(4),
                            topRight: Radius.circular(4),
                          ),
                        ),
                      ],
                    ),
                    BarChartGroupData(
                      x: 2,
                      barRods: [
                        BarChartRodData(
                          toY: 15,
                          color: Colors.yellow,
                          width: 16,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(4),
                            topRight: Radius.circular(4),
                          ),
                        ),
                      ],
                    ),
                    BarChartGroupData(
                      x: 3,
                      barRods: [
                        BarChartRodData(
                          toY: 30,
                          color: Colors.lightGreen,
                          width: 16,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(4),
                            topRight: Radius.circular(4),
                          ),
                        ),
                      ],
                    ),
                    BarChartGroupData(
                      x: 4,
                      barRods: [
                        BarChartRodData(
                          toY: 40,
                          color: Colors.green,
                          width: 16,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(4),
                            topRight: Radius.circular(4),
                          ),
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