import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../models/hawker_model.dart';

class HawkerApprovalScreen extends StatefulWidget {
  const HawkerApprovalScreen({Key? key}) : super(key: key);

  @override
  State<HawkerApprovalScreen> createState() => _HawkerApprovalScreenState();
}

class _HawkerApprovalScreenState extends State<HawkerApprovalScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  bool _isLoading = true;
  
  // Mock data for pending hawkers
  final List<HawkerModel> _pendingHawkers = [
    HawkerModel(
      id: '6',
      userId: '106',
      name: 'Rajesh Kumar',
      phone: '9876543206',
      aadharNumber: '123456789017',
      govtIdType: 'Aadhar',
      govtIdNumber: '123456789017',
      isVerified: false,
      isApproved: false,
      profileImage: 'https://randomuser.me/api/portraits/men/76.jpg',
      rating: null,
      totalOrders: 0,
      totalReviews: 0,
      createdAt: DateTime.now().subtract(const Duration(days: 2)),
      updatedAt: DateTime.now(),
      currentLatitude: 28.6529,
      currentLongitude: 77.2390,
      isOnline: false,
      areas: ['Rohini', 'Pitampura', 'Model Town'],
      address: 'Rohini, New Delhi',
    ),
    HawkerModel(
      id: '7',
      userId: '107',
      name: 'Amit Sharma',
      phone: '9876543207',
      aadharNumber: '123456789018',
      govtIdType: 'Aadhar',
      govtIdNumber: '123456789018',
      isVerified: false,
      isApproved: false,
      profileImage: 'https://randomuser.me/api/portraits/men/32.jpg',
      rating: null,
      totalOrders: 0,
      totalReviews: 0,
      createdAt: DateTime.now().subtract(const Duration(days: 3)),
      updatedAt: DateTime.now(),
      currentLatitude: 28.6329,
      currentLongitude: 77.2190,
      isOnline: false,
      areas: ['Saket', 'Malviya Nagar', 'Hauz Khas'],
      address: 'Saket, New Delhi',
    ),
    HawkerModel(
      id: '8',
      userId: '108',
      name: 'Priya Patel',
      phone: '9876543208',
      aadharNumber: '123456789019',
      govtIdType: 'Aadhar',
      govtIdNumber: '123456789019',
      isVerified: false,
      isApproved: false,
      profileImage: 'https://randomuser.me/api/portraits/women/44.jpg',
      rating: null,
      totalOrders: 0,
      totalReviews: 0,
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
      updatedAt: DateTime.now(),
      currentLatitude: 28.5529,
      currentLongitude: 77.2290,
      isOnline: false,
      areas: ['Greater Kailash', 'CR Park', 'Nehru Place'],
      address: 'Greater Kailash, New Delhi',
    ),
    HawkerModel(
      id: '9',
      userId: '109',
      name: 'Vikram Singh',
      phone: '9876543209',
      aadharNumber: '123456789020',
      govtIdType: 'Aadhar',
      govtIdNumber: '123456789020',
      isVerified: false,
      isApproved: false,
      profileImage: 'https://randomuser.me/api/portraits/men/62.jpg',
      rating: null,
      totalOrders: 0,
      totalReviews: 0,
      createdAt: DateTime.now().subtract(const Duration(days: 4)),
      updatedAt: DateTime.now(),
      currentLatitude: 28.7029,
      currentLongitude: 77.1090,
      isOnline: false,
      areas: ['Punjabi Bagh', 'Paschim Vihar', 'Janakpuri'],
      address: 'Punjabi Bagh, New Delhi',
    ),
    HawkerModel(
      id: '10',
      userId: '110',
      name: 'Neha Gupta',
      phone: '9876543210',
      aadharNumber: '123456789021',
      govtIdType: 'Aadhar',
      govtIdNumber: '123456789021',
      isVerified: false,
      isApproved: false,
      profileImage: 'https://randomuser.me/api/portraits/women/26.jpg',
      rating: null,
      totalOrders: 0,
      totalReviews: 0,
      createdAt: DateTime.now().subtract(const Duration(days: 5)),
      updatedAt: DateTime.now(),
      currentLatitude: 28.6129,
      currentLongitude: 77.3090,
      isOnline: false,
      areas: ['Noida Sector 18', 'Noida Sector 62', 'Noida Sector 63'],
      address: 'Noida Sector 18, Uttar Pradesh',
    ),
  ];
  
  // Mock data for approved hawkers
  final List<HawkerModel> _approvedHawkers = HawkerModel.getMockHawkers();
  
  // Mock data for rejected hawkers
  final List<HawkerModel> _rejectedHawkers = [
    HawkerModel(
      id: '11',
      userId: '111',
      name: 'Rahul Verma',
      phone: '9876543211',
      aadharNumber: '123456789022',
      govtIdType: 'Aadhar',
      govtIdNumber: '123456789022',
      isVerified: false,
      isApproved: false,
      profileImage: 'https://randomuser.me/api/portraits/men/55.jpg',
      rating: null,
      totalOrders: 0,
      totalReviews: 0,
      createdAt: DateTime.now().subtract(const Duration(days: 10)),
      updatedAt: DateTime.now(),
      currentLatitude: 28.5429,
      currentLongitude: 77.2590,
      isOnline: false,
      areas: ['Gurgaon', 'DLF Phase 1', 'DLF Phase 2'],
      address: 'Gurgaon, Haryana',
    ),
    HawkerModel(
      id: '12',
      userId: '112',
      name: 'Sanjay Mishra',
      phone: '9876543212',
      aadharNumber: '123456789023',
      govtIdType: 'Aadhar',
      govtIdNumber: '123456789023',
      isVerified: false,
      isApproved: false,
      profileImage: 'https://randomuser.me/api/portraits/men/41.jpg',
      rating: null,
      totalOrders: 0,
      totalReviews: 0,
      createdAt: DateTime.now().subtract(const Duration(days: 12)),
      updatedAt: DateTime.now(),
      currentLatitude: 28.6329,
      currentLongitude: 77.0890,
      isOnline: false,
      areas: ['Faridabad', 'Ballabhgarh', 'Surajkund'],
      address: 'Faridabad, Haryana',
    ),
  ];

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

  List<HawkerModel> _getFilteredHawkers(List<HawkerModel> hawkers) {
    if (_searchQuery.isEmpty) {
      return hawkers;
    }
    
    return hawkers.where((hawker) {
      return hawker.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          hawker.phone.contains(_searchQuery) ||
          hawker.address != null && hawker.address!.toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Hawker Approvals',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
          ),
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
                builder: (context) => AlertDialog(
                  title: const Text('Hawker Approval Help'),
                  content: const Text(
                    'This screen allows you to manage hawker registrations. '
                    'You can approve or reject hawker applications based on their information.'
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
                label: Text(_pendingHawkers.length.toString()),
                child: const Icon(Icons.pending_actions),
              ),
            ),
            Tab(
              text: 'Approved',
              icon: Badge(
                label: Text(_approvedHawkers.length.toString()),
                child: const Icon(Icons.check_circle_outline),
              ),
            ),
            Tab(
              text: 'Rejected',
              icon: Badge(
                label: Text(_rejectedHawkers.length.toString()),
                child: const Icon(Icons.cancel_outlined),
              ),
            ),
          ],
        ),
      ),
      body: _isLoading
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
                    'Loading hawker applications...',
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
                      hintText: 'Search by name, phone, or address',
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: _searchQuery.isNotEmpty
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
                      _buildHawkerList(_getFilteredHawkers(_pendingHawkers), isPending: true),
                      _buildHawkerList(_getFilteredHawkers(_approvedHawkers)),
                      _buildHawkerList(_getFilteredHawkers(_rejectedHawkers)),
                    ],
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildHawkerList(List<HawkerModel> hawkers, {bool isPending = false}) {
    if (hawkers.isEmpty) {
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
              'No hawkers found',
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
      itemCount: hawkers.length,
      itemBuilder: (context, index) {
        final hawker = hawkers[index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: ExpansionTile(
            leading: CircleAvatar(
              backgroundImage: hawker.profileImage != null 
                  ? NetworkImage(hawker.profileImage!)
                  : null,
              backgroundColor: hawker.profileImage == null 
                  ? Theme.of(context).primaryColor
                  : null,
              child: hawker.profileImage == null
                  ? Text(
                      hawker.name.substring(0, 1),
                      style: const TextStyle(color: Colors.white),
                    )
                  : null,
            ),
            title: Text(
              hawker.name,
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  hawker.phone,
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                  ),
                ),
                Text(
                  'Applied on: ${DateFormat('dd MMM yyyy').format(hawker.createdAt)}',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
            trailing: isPending
                ? Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.orange.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(
                        color: Colors.orange.withOpacity(0.3),
                      ),
                    ),
                    child: Text(
                      'Pending',
                      style: GoogleFonts.poppins(
                        color: Colors.orange,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                : Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: (hawker.isApproved ? Colors.green : Colors.red).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(
                        color: (hawker.isApproved ? Colors.green : Colors.red).withOpacity(0.3),
                      ),
                    ),
                    child: Text(
                      hawker.isApproved ? 'Approved' : 'Rejected',
                      style: GoogleFonts.poppins(
                        color: hawker.isApproved ? Colors.green : Colors.red,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: Colors.grey[200]!,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _buildInfoRow('ID', hawker.id),
                                    _buildInfoRow('User ID', hawker.userId),
                                    _buildInfoRow('Aadhar Number', hawker.aadharNumber ?? 'Not provided'),
                                    _buildInfoRow('Govt ID Type', hawker.govtIdType ?? 'Not provided'),
                                    _buildInfoRow('Govt ID Number', hawker.govtIdNumber ?? 'Not provided'),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _buildInfoRow('Address', hawker.address ?? 'Not provided'),
                                    _buildInfoRow('Areas', hawker.areas.join(', ')),
                                    _buildInfoRow('Registration Date', DateFormat('dd MMM yyyy').format(hawker.createdAt)),
                                    if (hawker.rating != null)
                                      _buildInfoRow('Rating', '${hawker.rating} (${hawker.totalReviews} reviews)'),
                                    if (hawker.totalOrders > 0)
                                      _buildInfoRow('Total Orders', hawker.totalOrders.toString()),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          const Divider(),
                          const SizedBox(height: 8),
                          Text(
                            'Service Areas',
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: hawker.areas.map((area) {
                              return Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(
                                    color: Theme.of(context).primaryColor.withOpacity(0.3),
                                  ),
                                ),
                                child: Text(
                                  area,
                                  style: GoogleFonts.poppins(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ).animate().fadeIn(duration: 300.ms).slideY(begin: 0.1, end: 0),
                    
                    const SizedBox(height: 16),
                    
                    if (isPending)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton.icon(
                            icon: const Icon(Icons.close),
                            label: const Text('Reject'),
                            onPressed: () {
                              _showRejectDialog(hawker);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              foregroundColor: Colors.white,
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                            ),
                          ),
                          const SizedBox(width: 16),
                          ElevatedButton.icon(
                            icon: const Icon(Icons.check),
                            label: const Text('Approve'),
                            onPressed: () {
                              _showApproveDialog(hawker);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              foregroundColor: Colors.white,
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                            ),
                          ),
                        ],
                      ).animate().fadeIn(duration: 300.ms, delay: 200.ms).slideY(begin: 0.2, end: 0),
                  ],
                ),
              ),
            ],
          ),
        ).animate().fadeIn(duration: 300.ms, delay: (index * 50).ms).slideY(begin: 0.1, end: 0);
      },
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              '$label:',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                color: Colors.grey[700],
                fontSize: 13,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: GoogleFonts.poppins(
                fontSize: 13,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showApproveDialog(HawkerModel hawker) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Approve Hawker',
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Are you sure you want to approve ${hawker.name}?'),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: Colors.green.withOpacity(0.3),
                  ),
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
                        'This hawker will be able to start selling products once approved.',
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
                // Approve hawker logic
                setState(() {
                  _pendingHawkers.remove(hawker);
                  _approvedHawkers.add(
                    hawker.copyWith(
                      isVerified: true,
                      isApproved: true,
                      updatedAt: DateTime.now(),
                    ),
                  );
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${hawker.name} has been approved'),
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
                          final approvedHawker = _approvedHawkers.firstWhere(
                            (h) => h.id == hawker.id,
                          );
                          _approvedHawkers.remove(approvedHawker);
                          _pendingHawkers.add(
                            approvedHawker.copyWith(
                              isVerified: false,
                              isApproved: false,
                              updatedAt: DateTime.now(),
                            ),
                          );
                        });
                      },
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
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

  void _showRejectDialog(HawkerModel hawker) {
    final TextEditingController reasonController = TextEditingController();
    
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Reject Hawker',
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Are you sure you want to reject ${hawker.name}?'),
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
                
                // Reject hawker logic
                setState(() {
                  _pendingHawkers.remove(hawker);
                  _rejectedHawkers.add(
                    hawker.copyWith(
                      updatedAt: DateTime.now(),
                    ),
                  );
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${hawker.name} has been rejected'),
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
                          final rejectedHawker = _rejectedHawkers.firstWhere(
                            (h) => h.id == hawker.id,
                          );
                          _rejectedHawkers.remove(rejectedHawker);
                          _pendingHawkers.add(
                            rejectedHawker.copyWith(
                              updatedAt: DateTime.now(),
                            ),
                          );
                        });
                      },
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
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