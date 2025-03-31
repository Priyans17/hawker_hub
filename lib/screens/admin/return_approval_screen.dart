import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ReturnApprovalScreen extends StatefulWidget {
  const ReturnApprovalScreen({Key? key}) : super(key: key);

  @override
  State<ReturnApprovalScreen> createState() => _ReturnApprovalScreenState();
}

class _ReturnApprovalScreenState extends State<ReturnApprovalScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  final List<Map<String, dynamic>> _pendingReturns = [
    {
      'id': 'RET001',
      'orderId': 'ORD001',
      'customerName': 'John Doe',
      'customerPhone': '9876543210',
      'hawkerName': 'Ramesh Fruits',
      'hawkerId': '1',
      'items': [
        {
          'name': 'Apples',
          'quantity': 1,
          'unit': 'kg',
          'price': 120.0,
          'reason': 'Bad quality',
        },
      ],
      'totalAmount': 120.0,
      'status': 'Pending',
      'requestDate': DateTime.now().subtract(const Duration(hours: 10)),
      'orderDate': DateTime.now().subtract(const Duration(hours: 15)),
      'returnReason': 'The apples were rotten',
      'images': ['https://via.placeholder.com/150'],
    },
    {
      'id': 'RET002',
      'orderId': 'ORD003',
      'customerName': 'Robert Johnson',
      'customerPhone': '9876543212',
      'hawkerName': 'Mahesh Fresh Fruits',
      'hawkerId': '3',
      'items': [
        {
          'name': 'Oranges',
          'quantity': 1,
          'unit': 'kg',
          'price': 80.0,
          'reason': 'Wrong item delivered',
        },
      ],
      'totalAmount': 80.0,
      'status': 'Pending',
      'requestDate': DateTime.now().subtract(const Duration(hours: 5)),
      'orderDate': DateTime.now().subtract(const Duration(hours: 8)),
      'returnReason': 'I ordered apples but received oranges',
      'images': ['https://via.placeholder.com/150'],
    },
    {
      'id': 'RET003',
      'orderId': 'ORD005',
      'customerName': 'Michael Wilson',
      'customerPhone': '9876543214',
      'hawkerName': 'Jignesh Fruit Corner',
      'hawkerId': '5',
      'items': [
        {
          'name': 'Mangoes',
          'quantity': 0.5,
          'unit': 'kg',
          'price': 75.0,
          'reason': 'Bad quality',
        },
      ],
      'totalAmount': 75.0,
      'status': 'Pending',
      'requestDate': DateTime.now().subtract(const Duration(days: 1)),
      'orderDate': DateTime.now().subtract(const Duration(days: 2)),
      'returnReason': 'The mangoes were not ripe',
      'images': [
        'https://via.placeholder.com/150',
        'https://via.placeholder.com/150',
      ],
    },
  ];

  final List<Map<String, dynamic>> _approvedReturns = [
    {
      'id': 'RET004',
      'orderId': 'ORD007',
      'customerName': 'David Miller',
      'customerPhone': '9876543216',
      'hawkerName': 'Suresh Vegetables',
      'hawkerId': '2',
      'items': [
        {
          'name': 'Potatoes',
          'quantity': 2,
          'unit': 'kg',
          'price': 60.0,
          'reason': 'Bad quality',
        },
      ],
      'totalAmount': 60.0,
      'status': 'Approved',
      'requestDate': DateTime.now().subtract(const Duration(days: 3, hours: 2)),
      'orderDate': DateTime.now().subtract(const Duration(days: 3, hours: 5)),
      'approvalDate': DateTime.now().subtract(const Duration(days: 2)),
      'returnReason': 'The potatoes had black spots',
      'images': ['https://via.placeholder.com/150'],
      'refundStatus': 'Processed',
    },
    {
      'id': 'RET005',
      'orderId': 'ORD002',
      'customerName': 'Jane Smith',
      'customerPhone': '9876543211',
      'hawkerName': 'Suresh Vegetables',
      'hawkerId': '2',
      'items': [
        {
          'name': 'Tomatoes',
          'quantity': 0.5,
          'unit': 'kg',
          'price': 20.0,
          'reason': 'Bad quality',
        },
      ],
      'totalAmount': 20.0,
      'status': 'Approved',
      'requestDate': DateTime.now().subtract(const Duration(days: 4)),
      'orderDate': DateTime.now().subtract(const Duration(days: 5)),
      'approvalDate': DateTime.now().subtract(const Duration(days: 3)),
      'returnReason': 'The tomatoes were smashed',
      'images': ['https://via.placeholder.com/150'],
      'refundStatus': 'Processed',
    },
  ];

  final List<Map<String, dynamic>> _rejectedReturns = [
    {
      'id': 'RET006',
      'orderId': 'ORD004',
      'customerName': 'Emily Davis',
      'customerPhone': '9876543213',
      'hawkerName': 'Dinesh Organic Veggies',
      'hawkerId': '4',
      'items': [
        {
          'name': 'Spinach',
          'quantity': 0.5,
          'unit': 'kg',
          'price': 30.0,
          'reason': 'Changed mind',
        },
      ],
      'totalAmount': 30.0,
      'status': 'Rejected',
      'requestDate': DateTime.now().subtract(const Duration(days: 1, hours: 5)),
      'orderDate': DateTime.now().subtract(const Duration(days: 1, hours: 10)),
      'rejectionDate': DateTime.now().subtract(
        const Duration(days: 1, hours: 2),
      ),
      'returnReason': 'I changed my mind, don\'t want spinach anymore',
      'rejectionReason':
          'Return policy does not allow returns for change of mind',
      'images': [],
    },
    {
      'id': 'RET007',
      'orderId': 'ORD006',
      'customerName': 'Sarah Brown',
      'customerPhone': '9876543215',
      'hawkerName': 'Ramesh Fruits',
      'hawkerId': '1',
      'items': [
        {
          'name': 'Bananas',
          'quantity': 1,
          'unit': 'dozen',
          'price': 60.0,
          'reason': 'Bad quality',
        },
      ],
      'totalAmount': 60.0,
      'status': 'Rejected',
      'requestDate': DateTime.now().subtract(const Duration(days: 2)),
      'orderDate': DateTime.now().subtract(const Duration(days: 3)),
      'rejectionDate': DateTime.now().subtract(const Duration(days: 1)),
      'returnReason': 'The bananas were not fresh',
      'rejectionReason': 'Return request submitted after 24 hours of delivery',
      'images': ['https://via.placeholder.com/150'],
    },
  ];

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);

    // Simulate loading
    Future.delayed(const Duration(milliseconds: 1500), () {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> _getFilteredReturns(
    List<Map<String, dynamic>> returns,
  ) {
    if (_searchQuery.isEmpty) {
      return returns;
    }

    return returns.where((returnRequest) {
      return returnRequest['id'].toLowerCase().contains(
            _searchQuery.toLowerCase(),
          ) ||
          returnRequest['orderId'].toLowerCase().contains(
            _searchQuery.toLowerCase(),
          ) ||
          returnRequest['customerName'].toLowerCase().contains(
            _searchQuery.toLowerCase(),
          ) ||
          returnRequest['customerPhone'].contains(_searchQuery) ||
          returnRequest['hawkerName'].toLowerCase().contains(
            _searchQuery.toLowerCase(),
          );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Return Approvals',
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        ),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              setState(() {
                _isLoading = true;
              });

              Future.delayed(const Duration(milliseconds: 1500), () {
                if (mounted) {
                  setState(() {
                    _isLoading = false;
                  });
                }
              });
            },
          ),
          IconButton(
            icon: const Icon(Icons.help_outline),
            onPressed: () {
              // Show help dialog
              showDialog(
                context: context,
                builder:
                    (context) => AlertDialog(
                      title: const Text('Return Approval Help'),
                      content: const Text(
                        'This screen allows you to manage return requests from customers. '
                        'You can approve or reject return requests based on the provided information and images.',
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('OK'),
                        ),
                      ],
                    ),
              );
            },
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Theme.of(context).primaryColor,
          indicatorWeight: 3,
          labelStyle: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
          tabs: [
            Tab(
              text: 'Pending',
              icon: Badge(
                label: Text(_pendingReturns.length.toString()),
                child: const Icon(Icons.pending_actions),
              ),
            ),
            Tab(
              text: 'Approved',
              icon: Badge(
                label: Text(_approvedReturns.length.toString()),
                child: const Icon(Icons.check_circle_outline),
              ),
            ),
            Tab(
              text: 'Rejected',
              icon: Badge(
                label: Text(_rejectedReturns.length.toString()),
                child: const Icon(Icons.cancel_outlined),
              ),
            ),
          ],
        ),
      ),
      body:
          _isLoading
              ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Lottie.network(
                      'https://assets10.lottiefiles.com/packages/lf20_x62chJ.json',
                      width: 200,
                      height: 200,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Loading return requests...',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              )
              : Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText:
                            'Search by return ID, order ID, customer, or hawker',
                        prefixIcon: const Icon(Icons.search),
                        suffixIcon:
                            _searchQuery.isNotEmpty
                                ? IconButton(
                                  icon: const Icon(Icons.clear),
                                  onPressed: () {
                                    setState(() {
                                      _searchController.clear();
                                      _searchQuery = '';
                                    });
                                  },
                                )
                                : null,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Theme.of(context).primaryColor,
                            width: 2,
                          ),
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
                        _buildReturnList(
                          _getFilteredReturns(_pendingReturns),
                          isPending: true,
                        ),
                        _buildReturnList(_getFilteredReturns(_approvedReturns)),
                        _buildReturnList(_getFilteredReturns(_rejectedReturns)),
                      ],
                    ),
                  ),
                ],
              ),
    );
  }

  Widget _buildReturnList(
    List<Map<String, dynamic>> returns, {
    bool isPending = false,
  }) {
    if (returns.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.network(
              'https://assets9.lottiefiles.com/packages/lf20_hl5n0bwb.json',
              width: 200,
              height: 200,
            ),
            const SizedBox(height: 20),
            Text(
              'No return requests found',
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      itemCount: returns.length,
      itemBuilder: (context, index) {
        final returnRequest = returns[index];

        Color statusColor;
        IconData statusIcon;

        switch (returnRequest['status']) {
          case 'Pending':
            statusColor = Colors.orange;
            statusIcon = Icons.hourglass_empty;
            break;
          case 'Approved':
            statusColor = Colors.green;
            statusIcon = Icons.check_circle;
            break;
          case 'Rejected':
            statusColor = Colors.red;
            statusIcon = Icons.cancel;
            break;
          default:
            statusColor = Colors.grey;
            statusIcon = Icons.help;
        }

        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: ExpansionTile(
            leading: CircleAvatar(
              backgroundColor: statusColor.withOpacity(0.2),
              child: Icon(statusIcon, color: statusColor),
            ),
            title: Text(
              'Return #${returnRequest['id']}',
              style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Order #${returnRequest['orderId']}'),
                Text(
                  'Date: ${DateFormat('dd MMM yyyy, hh:mm a').format(returnRequest['requestDate'])}',
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
              ],
            ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '₹${returnRequest['totalAmount']}',
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
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
                    border: Border.all(
                      color: statusColor.withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                  child: Text(
                    returnRequest['status'],
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
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey[200]!),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildInfoRow(
                                  'Customer',
                                  returnRequest['customerName'],
                                ),
                                _buildInfoRow(
                                  'Phone',
                                  returnRequest['customerPhone'],
                                ),
                                _buildInfoRow(
                                  'Hawker',
                                  returnRequest['hawkerName'],
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildInfoRow(
                                  'Order Date',
                                  DateFormat(
                                    'dd MMM yyyy, hh:mm a',
                                  ).format(returnRequest['orderDate']),
                                ),
                                _buildInfoRow(
                                  'Return Request Date',
                                  DateFormat(
                                    'dd MMM yyyy, hh:mm a',
                                  ).format(returnRequest['requestDate']),
                                ),
                                if (returnRequest['approvalDate'] != null)
                                  _buildInfoRow(
                                    'Approval Date',
                                    DateFormat(
                                      'dd MMM yyyy, hh:mm a',
                                    ).format(returnRequest['approvalDate']),
                                  ),
                                if (returnRequest['rejectionDate'] != null)
                                  _buildInfoRow(
                                    'Rejection Date',
                                    DateFormat(
                                      'dd MMM yyyy, hh:mm a',
                                    ).format(returnRequest['rejectionDate']),
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Divider(),
                    Row(
                          children: [
                            const Icon(Icons.shopping_bag_outlined, size: 20),
                            const SizedBox(width: 8),
                            Text(
                              'Return Items',
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        )
                        .animate()
                        .fadeIn(duration: 300.ms)
                        .slideX(begin: -0.1, end: 0),
                    const SizedBox(height: 8),
                    Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[50],
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.grey[200]!),
                          ),
                          child: ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: returnRequest['items'].length,
                            separatorBuilder:
                                (context, index) => const Divider(height: 1),
                            itemBuilder: (context, itemIndex) {
                              final item = returnRequest['items'][itemIndex];
                              return ListTile(
                                dense: true,
                                title: Text(
                                  item['name'],
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${item['quantity']} ${item['unit']} x ₹${item['price']}',
                                    ),
                                    Text(
                                      'Reason: ${item['reason']}',
                                      style: TextStyle(
                                        color: Colors.red[700],
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                                trailing: Text(
                                  '₹${(item['quantity'] * item['price']).toStringAsFixed(2)}',
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              );
                            },
                          ),
                        )
                        .animate()
                        .fadeIn(duration: 300.ms, delay: 100.ms)
                        .slideY(begin: 0.1, end: 0),
                    const Divider(),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey[200]!),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.comment,
                                size: 18,
                                color: Colors.grey,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'Return Reason:',
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey[700],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Container(
                            padding: const EdgeInsets.all(8),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.grey[300]!),
                            ),
                            child: Text(returnRequest['returnReason']),
                          ),
                          if (returnRequest['rejectionReason'] != null) ...[
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                const Icon(
                                  Icons.cancel_outlined,
                                  size: 18,
                                  color: Colors.red,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  'Rejection Reason:',
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.red[700],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Container(
                              padding: const EdgeInsets.all(8),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: Colors.red[100]!),
                              ),
                              child: Text(returnRequest['rejectionReason']!),
                            ),
                          ],
                          if (returnRequest['refundStatus'] != null) ...[
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                const Icon(
                                  Icons.payments_outlined,
                                  size: 18,
                                  color: Colors.green,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  'Refund Status:',
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.green[700],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Container(
                              padding: const EdgeInsets.all(8),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: Colors.green[100]!),
                              ),
                              child: Text(returnRequest['refundStatus']!),
                            ),
                          ],
                        ],
                      ),
                    ).animate().fadeIn(duration: 300.ms, delay: 200.ms),

                    if (returnRequest['images'].isNotEmpty) ...[
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          const Icon(Icons.image, size: 20),
                          const SizedBox(width: 8),
                          Text(
                            'Images',
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ).animate().fadeIn(duration: 300.ms, delay: 300.ms),
                      const SizedBox(height: 8),
                      SizedBox(
                        height: 120,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: returnRequest['images'].length,
                          itemBuilder: (context, imageIndex) {
                            return Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: InkWell(
                                    onTap: () {
                                      // Show full image
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return Dialog(
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                AppBar(
                                                  title: const Text(
                                                    'Return Image',
                                                  ),
                                                  automaticallyImplyLeading:
                                                      false,
                                                  actions: [
                                                    IconButton(
                                                      icon: const Icon(
                                                        Icons.close,
                                                      ),
                                                      onPressed:
                                                          () => Navigator.pop(
                                                            context,
                                                          ),
                                                    ),
                                                  ],
                                                ),
                                                Image.network(
                                                  returnRequest['images'][imageIndex],
                                                  fit: BoxFit.contain,
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      );
                                    },
                                    child: Container(
                                      height: 120,
                                      width: 120,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                          color: Colors.grey[300]!,
                                        ),
                                        image: DecorationImage(
                                          image: NetworkImage(
                                            returnRequest['images'][imageIndex],
                                          ),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                                .animate()
                                .fadeIn(
                                  duration: 300.ms,
                                  delay: 400.ms + (imageIndex * 100).ms,
                                )
                                .scale(
                                  begin: const Offset(0.8, 0.8),
                                  end: const Offset(1, 1),
                                );
                          },
                        ),
                      ),
                    ],

                    const SizedBox(height: 16),

                    if (isPending)
                      Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ElevatedButton.icon(
                                icon: const Icon(Icons.close),
                                label: const Text('Reject'),
                                onPressed: () {
                                  _showRejectDialog(returnRequest);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red,
                                  foregroundColor: Colors.white,
                                  elevation: 2,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 10,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              ElevatedButton.icon(
                                icon: const Icon(Icons.check),
                                label: const Text('Approve'),
                                onPressed: () {
                                  _showApproveDialog(returnRequest);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green,
                                  foregroundColor: Colors.white,
                                  elevation: 2,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 10,
                                  ),
                                ),
                              ),
                            ],
                          )
                          .animate()
                          .fadeIn(duration: 300.ms, delay: 500.ms)
                          .slideY(begin: 0.2, end: 0),
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
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600,
              color: Colors.grey[700],
              fontSize: 13,
            ),
          ),
          Expanded(
            child: Text(value, style: GoogleFonts.poppins(fontSize: 13)),
          ),
        ],
      ),
    );
  }

  void _showApproveDialog(Map<String, dynamic> returnRequest) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Approve Return',
            style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Are you sure you want to approve Return #${returnRequest['id']}?',
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.green.withOpacity(0.3)),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.info_outline,
                      color: Colors.green,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'This will initiate a refund process for the customer.',
                        style: GoogleFonts.poppins(
                          color: Colors.green[800],
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                // Approve return logic
                setState(() {
                  _pendingReturns.remove(returnRequest);
                  _approvedReturns.add({
                    ...returnRequest,
                    'status': 'Approved',
                    'approvalDate': DateTime.now(),
                    'refundStatus': 'Processing',
                  });
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Return #${returnRequest['id']} has been approved',
                    ),
                    backgroundColor: Colors.green,
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    action: SnackBarAction(
                      label: 'UNDO',
                      textColor: Colors.white,
                      onPressed: () {
                        setState(() {
                          final approvedReturn = _approvedReturns.firstWhere(
                            (r) => r['id'] == returnRequest['id'],
                          );
                          _approvedReturns.remove(approvedReturn);
                          _pendingReturns.add({
                            ...approvedReturn,
                            'status': 'Pending',
                            'approvalDate': null,
                            'refundStatus': null,
                          });
                        });
                      },
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('Approve'),
            ),
          ],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 5,
        );
      },
    );
  }

  void _showRejectDialog(Map<String, dynamic> returnRequest) {
    final TextEditingController reasonController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Reject Return',
            style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Are you sure you want to reject Return #${returnRequest['id']}?',
              ),
              const SizedBox(height: 16),
              TextField(
                controller: reasonController,
                decoration: InputDecoration(
                  labelText: 'Reason for rejection',
                  labelStyle: GoogleFonts.poppins(),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: Theme.of(context).primaryColor,
                      width: 2,
                    ),
                  ),
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
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (reasonController.text.trim().isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please provide a reason for rejection'),
                      backgroundColor: Colors.red,
                    ),
                  );
                  return;
                }

                // Reject return logic
                setState(() {
                  _pendingReturns.remove(returnRequest);
                  _rejectedReturns.add({
                    ...returnRequest,
                    'status': 'Rejected',
                    'rejectionDate': DateTime.now(),
                    'rejectionReason': reasonController.text,
                  });
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Return #${returnRequest['id']} has been rejected',
                    ),
                    backgroundColor: Colors.red,
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    action: SnackBarAction(
                      label: 'UNDO',
                      textColor: Colors.white,
                      onPressed: () {
                        setState(() {
                          final rejectedReturn = _rejectedReturns.firstWhere(
                            (r) => r['id'] == returnRequest['id'],
                          );
                          _rejectedReturns.remove(rejectedReturn);
                          _pendingReturns.add({
                            ...rejectedReturn,
                            'status': 'Pending',
                            'rejectionDate': null,
                            'rejectionReason': null,
                          });
                        });
                      },
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('Reject'),
            ),
          ],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 5,
        );
      },
    );
  }
}
