import 'package:flutter/material.dart';
import 'package:hawker_app/screens/hawker/hawker_dashboard_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class HawkerVerification extends StatefulWidget {
  const HawkerVerification({Key? key}) : super(key: key);

  @override
  State<HawkerVerification> createState() => _HawkerVerificationState();
}

class _HawkerVerificationState extends State<HawkerVerification> {
  final _formKey = GlobalKey<FormState>();
  
  final TextEditingController _aadharController = TextEditingController();
  
  String _selectedIdType = 'Aadhar Card';
  final List<String> _idTypes = ['Aadhar Card', 'Voter ID', 'Driving License', 'Passport'];
  
  final TextEditingController _idNumberController = TextEditingController();
  
  File? _aadharImage;
  File? _govtIdImage;
  File? _selfieWithIdImage;
  
  bool _isLoading = false;
  int _currentStep = 0;
  
  final ImagePicker _picker = ImagePicker();

  @override
  void dispose() {
    _aadharController.dispose();
    _idNumberController.dispose();
    super.dispose();
  }

  Future<void> _pickImage(ImageSource source, Function(File) setImage) async {
    final XFile? image = await _picker.pickImage(source: source);
    
    if (image != null) {
      setImage(File(image.path));
    }
  }

  void _submitVerification() {
    if (_formKey.currentState!.validate()) {
      if (_aadharImage == null || _govtIdImage == null || _selfieWithIdImage == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please upload all required documents'),
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
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return AlertDialog(
              title: const Text('Verification Submitted'),
              content: const Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.check_circle,
                    color: Colors.green,
                    size: 64,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Your verification documents have been submitted successfully. We will review your documents and update you soon.',
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const HawkerDashboard()),
                    );
                  },
                  child: const Text('Go to Dashboard'),
                ),
              ],
            );
          },
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hawker Verification'),
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Stepper(
              type: StepperType.vertical,
              currentStep: _currentStep,
              onStepContinue: () {
                if (_currentStep < 2) {
                  setState(() {
                    _currentStep += 1;
                  });
                } else {
                  _submitVerification();
                }
              },
              onStepCancel: () {
                if (_currentStep > 0) {
                  setState(() {
                    _currentStep -= 1;
                  });
                }
              },
              controlsBuilder: (context, details) {
                return Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Row(
                    children: [
                      ElevatedButton(
                        onPressed: details.onStepContinue,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
                        ),
                        child: Text(_currentStep == 2 ? 'Submit' : 'Continue'),
                      ),
                      if (_currentStep > 0)
                        TextButton(
                          onPressed: details.onStepCancel,
                          child: const Text('Back'),
                        ),
                    ],
                  ),
                );
              },
              steps: [
                Step(
                  title: const Text('Personal Information'),
                  content: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Please provide your identification details',
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _aadharController,
                          decoration: const InputDecoration(
                            labelText: 'Aadhar Number',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.credit_card),
                          ),
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your Aadhar number';
                            }
                            if (value.length != 12) {
                              return 'Aadhar number must be 12 digits';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        DropdownButtonFormField<String>(
                          decoration: const InputDecoration(
                            labelText: 'Government ID Type',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.badge),
                          ),
                          value: _selectedIdType,
                          items: _idTypes.map((String type) {
                            return DropdownMenuItem<String>(
                              value: type,
                              child: Text(type),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            if (newValue != null) {
                              setState(() {
                                _selectedIdType = newValue;
                              });
                            }
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _idNumberController,
                          decoration: const InputDecoration(
                            labelText: 'Government ID Number',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.numbers),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your ID number';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                  isActive: _currentStep >= 0,
                  state: _currentStep > 0 ? StepState.complete : StepState.indexed,
                ),
                Step(
                  title: const Text('Document Upload'),
                  content: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Please upload clear images of your documents',
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 16),
                      _buildDocumentUploadCard(
                        title: 'Aadhar Card',
                        description: 'Front side of your Aadhar card',
                        image: _aadharImage,
                        onTap: () {
                          _showImageSourceDialog((source) {
                            _pickImage(source, (file) {
                              setState(() {
                                _aadharImage = file;
                              });
                            });
                          });
                        },
                      ),
                      const SizedBox(height: 16),
                      _buildDocumentUploadCard(
                        title: _selectedIdType,
                        description: 'Front side of your $_selectedIdType',
                        image: _govtIdImage,
                        onTap: () {
                          _showImageSourceDialog((source) {
                            _pickImage(source, (file) {
                              setState(() {
                                _govtIdImage = file;
                              });
                            });
                          });
                        },
                      ),
                    ],
                  ),
                  isActive: _currentStep >= 1,
                  state: _currentStep > 1 ? StepState.complete : StepState.indexed,
                ),
                Step(
                  title: const Text('Selfie Verification'),
                  content: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Please upload a selfie holding your ID card',
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 16),
                      _buildDocumentUploadCard(
                        title: 'Selfie with ID',
                        description: 'Take a selfie while holding your ID card',
                        image: _selfieWithIdImage,
                        onTap: () {
                          _showImageSourceDialog((source) {
                            _pickImage(source, (file) {
                              setState(() {
                                _selfieWithIdImage = file;
                              });
                            });
                          });
                        },
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Guidelines for selfie:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      _buildGuideline('Ensure your face is clearly visible'),
                      _buildGuideline('Hold your ID card next to your face'),
                      _buildGuideline('Make sure the ID details are readable'),
                      _buildGuideline('Take the photo in good lighting'),
                    ],
                  ),
                  isActive: _currentStep >= 2,
                  state: _currentStep > 2 ? StepState.complete : StepState.indexed,
                ),
              ],
            ),
    );
  }

  Widget _buildDocumentUploadCard({
    required String title,
    required String description,
    required File? image,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 2,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Icon(
                    image != null ? Icons.check_circle : Icons.upload,
                    color: image != null ? Colors.green : Colors.grey,
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                description,
                style: const TextStyle(
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 16),
              if (image != null)
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.file(
                    image,
                    height: 150,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                )
              else
                Container(
                  height: 150,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey[300]!),
                  ),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.add_a_photo,
                        size: 48,
                        color: Colors.grey,
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Tap to upload',
                        style: TextStyle(
                          color: Colors.grey,
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

  Widget _buildGuideline(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.check_circle,
            size: 16,
            color: Colors.green,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(text),
          ),
        ],
      ),
    );
  }

  void _showImageSourceDialog(Function(ImageSource) onSourceSelected) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Select Image Source'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Camera'),
                onTap: () {
                  Navigator.pop(context);
                  onSourceSelected(ImageSource.camera);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Gallery'),
                onTap: () {
                  Navigator.pop(context);
                  onSourceSelected(ImageSource.gallery);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}