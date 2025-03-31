// ignore_for_file: use_super_parameters

import 'package:flutter/material.dart';
import 'package:hawker_app/screens/hawker/hawker_verification_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';


class HawkerRegistration extends StatefulWidget {
  const HawkerRegistration({Key? key}) : super(key: key);

  @override
  State<HawkerRegistration> createState() => _HawkerRegistrationState();
}

class _HawkerRegistrationState extends State<HawkerRegistration> {
  final _formKey = GlobalKey<FormState>();
  
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  
  final List<String> _selectedAreas = [];
  File? _profileImage;
  bool _isLoading = false;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  
  final List<String> _availableAreas = [
    'Connaught Place',
    'Janpath',
    'Rajiv Chowk',
    'Karol Bagh',
    'Patel Nagar',
    'Rajendra Place',
    'Lajpat Nagar',
    'Defence Colony',
    'South Extension',
    'Vasant Kunj',
    'Vasant Vihar',
    'Munirka',
    'Dwarka',
    'Janakpuri',
    'Uttam Nagar',
  ];
  
  final ImagePicker _picker = ImagePicker();

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    
    if (image != null) {
      setState(() {
        _profileImage = File(image.path);
      });
    }
  }

  void _register() {
    if (_formKey.currentState!.validate()) {
      if (_selectedAreas.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please select at least one service area'),
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
        
        // Navigate to verification screen
        Navigator.pushReplacement(
          // ignore: use_build_context_synchronously
          context,
          MaterialPageRoute(builder: (context) => const HawkerVerification()),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hawker Registration'),
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
                    Center(
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: _pickImage,
                            child: CircleAvatar(
                              radius: 50,
                              backgroundColor: Colors.grey[300],
                              backgroundImage: _profileImage != null ? FileImage(_profileImage!) : null,
                              child: _profileImage == null
                                  ? const Icon(
                                      Icons.add_a_photo,
                                      size: 40,
                                      color: Colors.grey,
                                    )
                                  : null,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Upload Profile Picture',
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'Personal Information',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        labelText: 'Business Name',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.business),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your business name';
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
                      controller: _emailController,
                      decoration: const InputDecoration(
                        labelText: 'Email (Optional)',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.email),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value != null && value.isNotEmpty) {
                          // Simple email validation
                          if (!value.contains('@') || !value.contains('.')) {
                            return 'Please enter a valid email address';
                          }
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        border: const OutlineInputBorder(),
                        prefixIcon: const Icon(Icons.lock),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword ? Icons.visibility : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                        ),
                      ),
                      obscureText: _obscurePassword,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a password';
                        }
                        if (value.length < 6) {
                          return 'Password must be at least 6 characters';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _confirmPasswordController,
                      decoration: InputDecoration(
                        labelText: 'Confirm Password',
                        border: const OutlineInputBorder(),
                        prefixIcon: const Icon(Icons.lock),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscureConfirmPassword ? Icons.visibility : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscureConfirmPassword = !_obscureConfirmPassword;
                            });
                          },
                        ),
                      ),
                      obscureText: _obscureConfirmPassword,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please confirm your password';
                        }
                        if (value != _passwordController.text) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'Business Information',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _addressController,
                      decoration: const InputDecoration(
                        labelText: 'Address',
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
                    const Text(
                      'Service Areas',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Select areas where you will provide service',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: _availableAreas.map((area) {
                        final isSelected = _selectedAreas.contains(area);
                        return FilterChip(
                          label: Text(area),
                          selected: isSelected,
                          onSelected: (selected) {
                            setState(() {
                              if (selected) {
                                _selectedAreas.add(area);
                              } else {
                                _selectedAreas.remove(area);
                              }
                            });
                          },
                          backgroundColor: Colors.grey[200],
                          // ignore: deprecated_member_use
                          selectedColor: Colors.green.withOpacity(0.2),
                          checkmarkColor: Colors.green,
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: _register,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
                        ),
                        child: const Text(
                          'Register',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Already have an account?'),
                        TextButton(
                          onPressed: () {
                            // Navigate to login screen
                            Navigator.pop(context);
                          },
                          child: const Text('Login'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}