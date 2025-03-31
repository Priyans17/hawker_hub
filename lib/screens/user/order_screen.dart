import 'package:flutter/material.dart';
import '../../models/hawker_model.dart' show HawkerModel;
import 'payment_screen.dart';

class OrderScreen extends StatefulWidget {
  final HawkerModel hawker;
  final Map<String, int> cartItems;
  final List<Map<String, dynamic>> inventory;

  const OrderScreen({
    super.key,
    required this.hawker,
    required this.cartItems,
    required this.inventory,
  });

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  final _formKey = GlobalKey<FormState>();
  
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _landmarkController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  
  String _selectedPaymentMethod = 'Cash on Delivery';
  String _selectedDeliveryTime = 'As soon as possible';
  
  final List<String> _paymentMethods = [
    'Cash on Delivery',
    'Online Payment',
    'UPI',
  ];
  
  final List<String> _deliveryTimes = [
    'As soon as possible',
    'Within 1 hour',
    'Within 2 hours',
    'Evening (4 PM - 7 PM)',
  ];
  
  double _subtotal = 0.0;
  final double _deliveryFee = 30.0;
  double _total = 0.0;
  
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _calculateTotals();
    
    // Pre-fill user details (in a real app, this would come from user profile)
    _nameController.text = 'John Doe';
    _phoneController.text = '9876543210';
    _addressController.text = '123 Main St, Delhi';
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _landmarkController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  void _calculateTotals() {
    _subtotal = 0.0;
    
    widget.cartItems.forEach((itemId, quantity) {
      final item = widget.inventory.firstWhere((item) => item['id'] == itemId);
      _subtotal += item['price'] * quantity;
    });
    
    _total = _subtotal + _deliveryFee;
  }

  void _placeOrder() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      
      // Simulate API call
      Future.delayed(const Duration(seconds: 2), () {
        setState(() {
          _isLoading = false;
        });
        
        if (_selectedPaymentMethod == 'Cash on Delivery') {
          // Show success dialog
          _showOrderSuccessDialog();
        } else {
          // Navigate to payment screen
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PaymentScreen(
                amount: _total,
                orderId: 'ORD${DateTime.now().millisecondsSinceEpoch}',
                paymentMethod: _selectedPaymentMethod,
              ),
            ),
          );
        }
      });
    }
  }

  void _showOrderSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: const Text('Order Placed Successfully'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.check_circle,
                color: Colors.green,
                size: 64,
              ),
              const SizedBox(height: 16),
              const Text(
                'Your order has been placed successfully!',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'Order ID: ORD${DateTime.now().millisecondsSinceEpoch}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'You will receive a confirmation shortly.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: const Text('OK'),
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
        title: const Text('Checkout'),
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
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
                              children: [
                                CircleAvatar(
                                  backgroundImage: NetworkImage('https://via.placeholder.com/150?text=${widget.hawker.name[0]}'),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        widget.hawker.name,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
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
                                            ' ${widget.hawker.rating} (${widget.hawker.totalReviews})',
                                            style: TextStyle(
                                              color: Colors.grey[600],
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const Divider(height: 24),
                            const Text(
                              'Order Summary',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 8),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: widget.cartItems.length,
                              itemBuilder: (context, index) {
                                final itemId = widget.cartItems.keys.elementAt(index);
                                final quantity = widget.cartItems[itemId]!;
                                final item = widget.inventory.firstWhere((item) => item['id'] == itemId);
                                
                                return ListTile(
                                  contentPadding: EdgeInsets.zero,
                                  title: Text(item['name']),
                                  subtitle: Text('$quantity ${item['unit']} x ₹${item['price']}'),
                                  trailing: Text(
                                    '₹${(quantity * item['price']).toStringAsFixed(2)}',
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
                                const Text('Subtotal'),
                                Text(
                                  '₹${_subtotal.toStringAsFixed(2)}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Delivery Fee'),
                                Text(
                                  '₹${_deliveryFee.toStringAsFixed(2)}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            const Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Total',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  '₹${_total.toStringAsFixed(2)}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: Colors.green,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Delivery Information',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 16),
                            TextFormField(
                              controller: _nameController,
                              decoration: const InputDecoration(
                                labelText: 'Full Name',
                                border: OutlineInputBorder(),
                                prefixIcon: Icon(Icons.person),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your name';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 16),
                            TextFormField(
                              controller: _phoneController,
                              decoration: const InputDecoration(
                                labelText: 'Phone Number',
                                border: OutlineInputBorder(),
                                prefixIcon: Icon(Icons.phone),
                              ),
                              keyboardType: TextInputType.phone,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your phone number';
                                }
                                if (value.length != 10) {
                                  return 'Phone number must be 10 digits';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 16),
                            TextFormField(
                              controller: _addressController,
                              decoration: const InputDecoration(
                                labelText: 'Delivery Address',
                                border: OutlineInputBorder(),
                                prefixIcon: Icon(Icons.location_on),
                              ),
                              maxLines: 3,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your address';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 16),
                            TextFormField(
                              controller: _landmarkController,
                              decoration: const InputDecoration(
                                labelText: 'Landmark (Optional)',
                                border: OutlineInputBorder(),
                                prefixIcon: Icon(Icons.location_city),
                              ),
                            ),
                            const SizedBox(height: 16),
                            DropdownButtonFormField<String>(
                              decoration: const InputDecoration(
                                labelText: 'Delivery Time',
                                border: OutlineInputBorder(),
                                prefixIcon: Icon(Icons.access_time),
                              ),
                              value: _selectedDeliveryTime,
                              items: _deliveryTimes.map((String time) {
                                return DropdownMenuItem<String>(
                                  value: time,
                                  child: Text(time),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                if (newValue != null) {
                                  setState(() {
                                    _selectedDeliveryTime = newValue;
                                  });
                                }
                              },
                            ),
                            const SizedBox(height: 16),
                            TextFormField(
                              controller: _noteController,
                              decoration: const InputDecoration(
                                labelText: 'Note to Hawker (Optional)',
                                border: OutlineInputBorder(),
                                prefixIcon: Icon(Icons.note),
                              ),
                              maxLines: 2,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Payment Method',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 16),
                            ...List.generate(_paymentMethods.length, (index) {
                              final method = _paymentMethods[index];
                              return RadioListTile<String>(
                                title: Text(method),
                                value: method,
                                groupValue: _selectedPaymentMethod,
                                onChanged: (String? value) {
                                  if (value != null) {
                                    setState(() {
                                      _selectedPaymentMethod = value;
                                    });
                                  }
                                },
                                activeColor: Colors.green,
                                contentPadding: EdgeInsets.zero,
                              );
                            }),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: _placeOrder,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
                        ),
                        child: Text(
                          _selectedPaymentMethod == 'Cash on Delivery'
                              ? 'Place Order'
                              : 'Proceed to Payment',
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}