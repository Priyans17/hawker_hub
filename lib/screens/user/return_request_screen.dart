import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ReturnRequestScreen extends StatefulWidget {
  final Map<String, dynamic> order;

  const ReturnRequestScreen({super.key, required this.order});

  @override
  State<ReturnRequestScreen> createState() => _ReturnRequestScreenState();
}

class _ReturnRequestScreenState extends State<ReturnRequestScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _reasonController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  String _selectedReason = 'Damaged Product';
  final List<String> _selectedItems = [];
  final List<File> _images = [];

  final List<String> _returnReasons = [
    'Damaged Product',
    'Wrong Product',
    'Quality Issue',
    'Missing Items',
    'Other',
  ];

  bool _isLoading = false;

  @override
  void dispose() {
    _reasonController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _pickImages() async {
    final XFile? pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    final File? image = pickedFile != null ? File(pickedFile.path) : null;

    if (image != null) {
      setState(() {
        _images.add(image);
      });
    }
  }

  void _removeImage(int index) {
    setState(() {
      _images.removeAt(index);
    });
  }

  void _submitReturnRequest() {
    if (_formKey.currentState!.validate()) {
      if (_selectedItems.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please select at least one item to return'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      setState(() {
        _isLoading = true;
      });

      // Simulate API call
      Future.delayed(const Duration(seconds: 2), () {
        setState(() {
          _isLoading = false;
        });

        // Show success dialog
        _showReturnSuccessDialog();
      });
    }
  }

  void _showReturnSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: const Text('Return Request Submitted'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.check_circle, color: Colors.green, size: 64),
              const SizedBox(height: 16),
              const Text(
                'Your return request has been submitted successfully!',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'Return ID: RTN${DateTime.now().millisecondsSinceEpoch}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                'We will review your request and get back to you soon.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
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
      appBar: AppBar(title: const Text('Return Request')),
      body:
          _isLoading
              ? const Center(child: CircularProgressIndicator())
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Order #${widget.order['id']}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.green.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: const Text(
                                      'Delivered',
                                      style: TextStyle(
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              Row(
                                children: [
                                  CircleAvatar(
                                    backgroundImage: NetworkImage(
                                      widget.order['hawkerImage'],
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Text(
                                    widget.order['hawkerName'],
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Select Items to Return',
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
                            final itemName = item['name'];
                            final isSelected = _selectedItems.contains(
                              itemName,
                            );

                            return CheckboxListTile(
                              title: Text(itemName),
                              subtitle: Text(
                                '${item['quantity']} ${item['unit']} x ₹${item['price']}',
                              ),
                              secondary: CircleAvatar(
                                backgroundImage: NetworkImage(
                                  'https://via.placeholder.com/150',
                                ),
                              ),
                              value: isSelected,
                              onChanged: (value) {
                                setState(() {
                                  if (value == true) {
                                    _selectedItems.add(itemName);
                                  } else {
                                    _selectedItems.remove(itemName);
                                  }
                                });
                              },
                              activeColor: Colors.green,
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Return Reason',
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              DropdownButtonFormField<String>(
                                decoration: const InputDecoration(
                                  labelText: 'Reason for Return',
                                  border: OutlineInputBorder(),
                                ),
                                value: _selectedReason,
                                items:
                                    _returnReasons.map((String reason) {
                                      return DropdownMenuItem<String>(
                                        value: reason,
                                        child: Text(reason),
                                      );
                                    }).toList(),
                                onChanged: (String? newValue) {
                                  if (newValue != null) {
                                    setState(() {
                                      _selectedReason = newValue;
                                    });
                                  }
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please select a reason';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 16),
                              TextFormField(
                                controller: _descriptionController,
                                decoration: const InputDecoration(
                                  labelText: 'Description',
                                  border: OutlineInputBorder(),
                                  hintText:
                                      'Please provide more details about the issue',
                                ),
                                maxLines: 3,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please provide a description';
                                  }
                                  if (value.length < 10) {
                                    return 'Description must be at least 10 characters';
                                  }
                                  return null;
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Upload Images (Optional)',
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Add photos to help us understand the issue better',
                                style: TextStyle(color: Colors.grey),
                              ),
                              const SizedBox(height: 16),
                              if (_images.isEmpty)
                                InkWell(
                                  onTap: _pickImages,
                                  child: Container(
                                    height: 150,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: Colors.grey[200],
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                        color: Colors.grey[300]!,
                                      ),
                                    ),
                                    child: const Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.add_a_photo,
                                          size: 48,
                                          color: Colors.grey,
                                        ),
                                        SizedBox(height: 8),
                                        Text(
                                          'Tap to upload photos',
                                          style: TextStyle(color: Colors.grey),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              else
                                Column(
                                  children: [
                                    SizedBox(
                                      height: 100,
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: _images.length + 1,
                                        itemBuilder: (context, index) {
                                          if (index == _images.length) {
                                            return InkWell(
                                              onTap: _pickImages,
                                              child: Container(
                                                width: 100,
                                                margin: const EdgeInsets.only(
                                                  right: 8,
                                                ),
                                                decoration: BoxDecoration(
                                                  color: Colors.grey[200],
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  border: Border.all(
                                                    color: Colors.grey[300]!,
                                                  ),
                                                ),
                                                child: const Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Icon(
                                                      Icons.add,
                                                      color: Colors.grey,
                                                    ),
                                                    SizedBox(height: 4),
                                                    Text(
                                                      'Add More',
                                                      style: TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: 12,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          }

                                          return Stack(
                                            children: [
                                              Container(
                                                width: 100,
                                                height: 100,
                                                margin: const EdgeInsets.only(
                                                  right: 8,
                                                ),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  image: DecorationImage(
                                                    image: FileImage(
                                                      _images[index],
                                                    ),
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                top: 4,
                                                right: 12,
                                                child: InkWell(
                                                  onTap:
                                                      () => _removeImage(index),
                                                  child: Container(
                                                    padding:
                                                        const EdgeInsets.all(4),
                                                    decoration:
                                                        const BoxDecoration(
                                                          color: Colors.white,
                                                          shape:
                                                              BoxShape.circle,
                                                        ),
                                                    child: const Icon(
                                                      Icons.close,
                                                      size: 16,
                                                      color: Colors.red,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: _submitReturnRequest,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            foregroundColor: Colors.white,
                          ),
                          child: const Text(
                            'Submit Return Request',
                            style: TextStyle(fontSize: 16),
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
