import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:async';

class OrderTrackingScreen extends StatefulWidget {
  final Map<String, dynamic> order;

  const OrderTrackingScreen({
    Key? key,
    required this.order,
  }) : super(key: key);

  @override
  State<OrderTrackingScreen> createState() => _OrderTrackingScreenState();
}

class _OrderTrackingScreenState extends State<OrderTrackingScreen> {
  late Timer _timer;
  late DateTime _estimatedDeliveryTime;
  late String _hawkerLocation;
  late String _deliveryStatus;
  late int _minutesRemaining;
  
  final List<Map<String, dynamic>> _trackingHistory = [];

  @override
  void initState() {
    super.initState();
    
    // Initialize tracking data
    _estimatedDeliveryTime = DateTime.now().add(const Duration(minutes: 45));
    _hawkerLocation = 'Connaught Place, Delhi';
    _deliveryStatus = widget.order['status'];
    _minutesRemaining = _estimatedDeliveryTime.difference(DateTime.now()).inMinutes;
    
    // Initialize tracking history
    _initTrackingHistory();
    
    // Start timer to update tracking info
    _timer = Timer.periodic(const Duration(seconds: 10), (timer) {
      setState(() {
        _minutesRemaining = _estimatedDeliveryTime.difference(DateTime.now()).inMinutes;
        
        // Simulate hawker movement
        if (_minutesRemaining % 2 == 0) {
          _updateHawkerLocation();
        }
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _initTrackingHistory() {
    final orderTime = widget.order['orderDate'];
    
    _trackingHistory.add({
      'status': 'Order Placed',
      'time': orderTime,
      'description': 'Your order has been placed successfully',
      'isCompleted': true,
    });
    
    _trackingHistory.add({
      'status': 'Order Confirmed',
      'time': orderTime.add(const Duration(minutes: 5)),
      'description': 'Hawker has confirmed your order',
      'isCompleted': true,
    });
    
    _trackingHistory.add({
      'status': 'Processing',
      'time': orderTime.add(const Duration(minutes: 10)),
      'description': 'Hawker is preparing your order',
      'isCompleted': widget.order['status'] != 'Pending',
    });
    
    _trackingHistory.add({
      'status': 'Out for Delivery',
      'time': orderTime.add(const Duration(minutes: 20)),
      'description': 'Hawker is on the way to deliver your order',
      'isCompleted': widget.order['status'] == 'Out for Delivery',
    });
    
    _trackingHistory.add({
      'status': 'Delivered',
      'time': _estimatedDeliveryTime,
      'description': 'Your order has been delivered',
      'isCompleted': widget.order['status'] == 'Delivered',
    });
  }

  void _updateHawkerLocation() {
    final locations = [
      'Connaught Place, Delhi',
      'Janpath, Delhi',
      'Rajiv Chowk, Delhi',
      'Barakhamba Road, Delhi',
      'Mandi House, Delhi',
      'Near your location',
    ];
    
    final currentIndex = locations.indexOf(_hawkerLocation);
    if (currentIndex < locations.length - 1) {
      _hawkerLocation = locations[currentIndex + 1];
    }
  }

  void _callHawker() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Calling ${widget.order['hawkerName']}...'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _cancelOrder() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Cancel Order'),
          content: const Text('Are you sure you want to cancel this order?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('No'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Order cancelled successfully'),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Track Order'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Order #${widget.order['id']}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: _getStatusColor(_deliveryStatus).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            _deliveryStatus,
                            style: TextStyle(
                              color: _getStatusColor(_deliveryStatus),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(widget.order['hawkerImage']),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.order['hawkerName'],
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Order placed on ${DateFormat('dd MMM yyyy, hh:mm a').format(widget.order['orderDate'])}',
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const Divider(height: 32),
                    if (_deliveryStatus == 'Out for Delivery')
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Estimated Delivery Time',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const Icon(
                                Icons.access_time,
                                color: Colors.green,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                DateFormat('hh:mm a').format(_estimatedDeliveryTime),
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                '(in $_minutesRemaining minutes)',
                                style: TextStyle(
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'Current Location',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const Icon(
                                Icons.location_on,
                                color: Colors.red,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                _hawkerLocation,
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton.icon(
                                  icon: const Icon(Icons.call),
                                  label: const Text('Call Hawker'),
                                  onPressed: _callHawker,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.green,
                                    foregroundColor: Colors.white,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: OutlinedButton.icon(
                                  icon: const Icon(Icons.cancel),
                                  label: const Text('Cancel Order'),
                                  onPressed: _cancelOrder,
                                  style: OutlinedButton.styleFrom(
                                    foregroundColor: Colors.red,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const Divider(height: 32),
                        ],
                      ),
                    const Text(
                      'Delivery Address',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(widget.order['address']),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Order Items',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 8),
            Card(
              child: ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: widget.order['items'].length,
                separatorBuilder: (context, index) => const Divider(),
                itemBuilder: (context, index) {
                  final item = widget.order['items'][index];
                  return ListTile(
                    title: Text(item['name']),
                    subtitle: Text('${item['quantity']} ${item['unit']}'),
                    trailing: Text(
                      '₹${(item['quantity'] * item['price']).toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Tracking History',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 8),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: List.generate(_trackingHistory.length, (index) {
                    final tracking = _trackingHistory[index];
                    final isLast = index == _trackingHistory.length - 1;
                    
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: tracking['isCompleted'] ? Colors.green : Colors.grey[300],
                                border: Border.all(
                                  color: tracking['isCompleted'] ? Colors.green : Colors.grey[300]!,
                                  width: 3,
                                ),
                              ),
                              child: tracking['isCompleted']
                                  ? const Icon(
                                      Icons.check,
                                      size: 12,
                                      color: Colors.white,
                                    )
                                  : null,
                            ),
                            if (!isLast)
                              Container(
                                width: 2,
                                height: 50,
                                color: tracking['isCompleted'] ? Colors.green : Colors.grey[300],
                              ),
                          ],
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                tracking['status'],
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                DateFormat('dd MMM yyyy, hh:mm a').format(tracking['time']),
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 12,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                tracking['description'],
                                style: TextStyle(
                                  color: Colors.grey[600],
                                ),
                              ),
                              const SizedBox(height: 16),
                            ],
                          ),
                        ),
                      ],
                    );
                  }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Pending':
        return Colors.orange;
      case 'Processing':
        return Colors.blue;
      case 'Out for Delivery':
        return Colors.purple;
      case 'Delivered':
        return Colors.green;
      case 'Cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}