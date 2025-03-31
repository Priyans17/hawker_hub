import 'package:flutter/material.dart';
import 'dart:async';

class PaymentScreen extends StatefulWidget {
  final double amount;
  final String orderId;
  final String paymentMethod;

  const PaymentScreen({
    Key? key,
    required this.amount,
    required this.orderId,
    required this.paymentMethod,
  }) : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final _formKey = GlobalKey<FormState>();
  
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _cardHolderController = TextEditingController();
  final TextEditingController _expiryController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();
  final TextEditingController _upiIdController = TextEditingController();
  
  bool _isLoading = false;
  // ignore: unused_field
  bool _isPaymentSuccessful = false; // Added field to track payment success
  String _paymentError = '';

  @override
  void dispose() {
    _cardNumberController.dispose();
    _cardHolderController.dispose();
    _expiryController.dispose();
    _cvvController.dispose();
    _upiIdController.dispose();
    super.dispose();
  }

  void _processPayment() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
        _paymentError = '';
      });
      
      // Simulate payment processing
      Timer(const Duration(seconds: 2), () {
        // Simulate successful payment (in a real app, this would be an API call)
        final isSuccess = DateTime.now().second % 2 == 0; // Simulate success or failure randomly
        
        setState(() {
          _isLoading = false;
          _isPaymentSuccessful = isSuccess;
          if (!isSuccess) {
            _paymentError = 'Payment failed. Please try again.';
          }
        });
        
        if (isSuccess) {
          _showPaymentSuccessDialog();
        }
      });
    }
  }

  void _showPaymentSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: const Text('Payment Successful'),
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
                'Your payment has been processed successfully!',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'Order ID: ${widget.orderId}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Amount: ₹${widget.amount.toStringAsFixed(2)}',
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
        title: const Text('Payment'),
      ),
      body: _isLoading
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('Processing payment...'),
                ],
              ),
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
                            const Text(
                              'Payment Summary',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Order ID'),
                                Text(
                                  widget.orderId,
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
                                const Text('Payment Method'),
                                Text(
                                  widget.paymentMethod,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            const Divider(height: 24),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Amount to Pay',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  '₹${widget.amount.toStringAsFixed(2)}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.green,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    if (_paymentError.isNotEmpty)
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.red.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.red.withOpacity(0.3)),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.error,
                              color: Colors.red,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                _paymentError,
                                style: const TextStyle(
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    const SizedBox(height: 16),
                    widget.paymentMethod == 'UPI'
                        ? _buildUpiPaymentForm()
                        : _buildCardPaymentForm(),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: _processPayment,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
                        ),
                        child: Text(
                          'Pay ₹${widget.amount.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Center(
                      child: Text(
                        'Your payment information is secure and encrypted',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.lock,
                            size: 16,
                            color: Colors.grey,
                          ),
                          SizedBox(width: 4),
                          Text(
                            'Secured by SSL encryption',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildCardPaymentForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Card Details',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: _cardNumberController,
          decoration: const InputDecoration(
            labelText: 'Card Number',
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.credit_card),
            hintText: '1234 5678 9012 3456',
          ),
          keyboardType: TextInputType.number,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your card number';
            }
            if (value.replaceAll(' ', '').length != 16) {
              return 'Card number must be 16 digits';
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: _cardHolderController,
          decoration: const InputDecoration(
            labelText: 'Card Holder Name',
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.person),
            hintText: 'John Doe',
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter card holder name';
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: _expiryController,
                decoration: const InputDecoration(
                  labelText: 'Expiry Date',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.date_range),
                  hintText: 'MM/YY',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter expiry date';
                  }
                  if (!RegExp(r'^\d{2}/\d{2}$').hasMatch(value)) {
                    return 'Use format MM/YY';
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: TextFormField(
                controller: _cvvController,
                decoration: const InputDecoration(
                  labelText: 'CVV',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.security),
                  hintText: '123',
                ),
                obscureText: true,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter CVV';
                  }
                  if (value.length != 3) {
                    return 'CVV must be 3 digits';
                  }
                  return null;
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildUpiPaymentForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'UPI Details',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: _upiIdController,
          decoration: const InputDecoration(
            labelText: 'UPI ID',
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.account_balance),
            hintText: 'yourname@upi',
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your UPI ID';
            }
            if (!value.contains('@')) {
              return 'Please enter a valid UPI ID';
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        const Text(
          'Supported UPI Apps',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildUpiOption('Google Pay', 'https://via.placeholder.com/50'),
            _buildUpiOption('PhonePe', 'https://via.placeholder.com/50'),
            _buildUpiOption('Paytm', 'https://via.placeholder.com/50'),
            _buildUpiOption('BHIM', 'https://via.placeholder.com/50'),
          ],
        ),
      ],
    );
  }

  Widget _buildUpiOption(String name, String imageUrl) {
    return Column(
      children: [
        CircleAvatar(
          radius: 24,
          backgroundImage: NetworkImage(imageUrl),
        ),
        const SizedBox(height: 4),
        Text(
          name,
          style: const TextStyle(
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}