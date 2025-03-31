  import 'package:flutter/material.dart';
  import 'package:hawker_app/models/hawker_model.dart';
  import 'package:intl/intl.dart';
  import 'order_screen.dart';

  class HawkerDetailsScreen extends StatefulWidget {
    final HawkerModel hawker;

    const HawkerDetailsScreen({
      super.key,
      required this.hawker, // parameter
    });

    @override
    State<HawkerDetailsScreen> createState() => _HawkerDetailsScreenState();
  }

  class _HawkerDetailsScreenState extends State<HawkerDetailsScreen> with SingleTickerProviderStateMixin {
    late TabController _tabController;
    bool _isFavorite = false;
    
    // Mock inventory data
    final List<Map<String, dynamic>> _inventory = [
      {
        'id': '1',
        'name': 'Apples',
        'category': 'Fruits',
        'price': 120.0,
        'unit': 'kg',
        'stock': 5,
        'image': 'https://via.placeholder.com/150',
        'description': 'Fresh red apples from Himachal Pradesh',
      },
      {
        'id': '2',
        'name': 'Bananas',
        'category': 'Fruits',
        'price': 60.0,
        'unit': 'dozen',
        'stock': 3,
        'image': 'https://via.placeholder.com/150',
        'description': 'Ripe yellow bananas',
      },
      {
        'id': '3',
        'name': 'Tomatoes',
        'category': 'Vegetables',
        'price': 40.0,
        'unit': 'kg',
        'stock': 8,
        'image': 'https://via.placeholder.com/150',
        'description': 'Fresh red tomatoes',
      },
      {
        'id': '4',
        'name': 'Potatoes',
        'category': 'Vegetables',
        'price': 30.0,
        'unit': 'kg',
        'stock': 15,
        'image': 'https://via.placeholder.com/150',
        'description': 'Fresh potatoes from Punjab',
      },
      {
        'id': '5',
        'name': 'Milk',
        'category': 'Dairy',
        'price': 60.0,
        'unit': 'liter',
        'stock': 6,
        'image': 'https://via.placeholder.com/150',
        'description': 'Fresh cow milk',
      },
      {
        'id': '6',
        'name': 'Bread',
        'category': 'Bakery',
        'price': 35.0,
        'unit': 'loaf',
        'stock': 4,
        'image': 'https://via.placeholder.com/150',
        'description': 'Freshly baked bread',
      },
      {
        'id': '7',
        'name': 'Oranges',
        'category': 'Fruits',
        'price': 80.0,
        'unit': 'kg',
        'stock': 2,
        'image': 'https://via.placeholder.com/150',
        'description': 'Sweet and juicy oranges',
      },
    ];
    
    // Mock reviews data
    final List<Map<String, dynamic>> _reviews = [
      {
        'id': '1',
        'userName': 'John Doe',
        'rating': 4.5,
        'comment': 'Great quality products and excellent service!',
        'date': DateTime.now().subtract(const Duration(days: 2)),
        'userImage': 'https://via.placeholder.com/150',
      },
      {
        'id': '2',
        'userName': 'Jane Smith',
        'rating': 5.0,
        'comment': 'Always fresh and delivered on time. Highly recommended!',
        'date': DateTime.now().subtract(const Duration(days: 5)),
        'userImage': 'https://via.placeholder.com/150',
      },
      {
        'id': '3',
        'userName': 'Robert Johnson',
        'rating': 3.5,
        'comment': 'Good products but sometimes delivery is delayed.',
        'date': DateTime.now().subtract(const Duration(days: 10)),
        'userImage': 'https://via.placeholder.com/150',
      },
      {
        'id': '4',
        'userName': 'Emily Davis',
        'rating': 4.0,
        'comment': 'Fresh vegetables and reasonable prices.',
        'date': DateTime.now().subtract(const Duration(days: 15)),
        'userImage': 'https://via.placeholder.com/150',
      },
    ];
    
    // Mock categories
    final List<String> _categories = [
      'All',
      'Fruits',
      'Vegetables',
      'Dairy',
      'Bakery',
      'Beverages',
    ];
    
    String _selectedCategory = 'All';
    final TextEditingController _searchController = TextEditingController();
    String _searchQuery = '';
    final Map<String, int> _cartItems = {};
    int _cartItemCount = 0;
    double _cartTotal = 0.0;

    @override
    void initState() {
      super.initState();
      _tabController = TabController(length: 2, vsync: this);
    }

    @override
    void dispose() {
      _tabController.dispose();
      _searchController.dispose();
      super.dispose();
    }

    List<Map<String, dynamic>> _getFilteredInventory() {
      List<Map<String, dynamic>> filteredList = List.from(_inventory);
      
      // Apply category filter
      if (_selectedCategory != 'All') {
        filteredList = filteredList.where((item) => item['category'] == _selectedCategory).toList();
      }
      
      // Apply search filter
      if (_searchQuery.isNotEmpty) {
        filteredList = filteredList.where((item) {
          return item['name'].toLowerCase().contains(_searchQuery.toLowerCase()) ||
              item['description'].toLowerCase().contains(_searchQuery.toLowerCase());
        }).toList();
      }
      
      return filteredList;
    }

    void _addToCart(Map<String, dynamic> item) {
      setState(() {
        if (_cartItems.containsKey(item['id'])) {
          _cartItems[item['id']] = _cartItems[item['id']]! + 1;
        } else {
          _cartItems[item['id']] = 1;
        }
        
        _updateCartSummary();
      });
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${item['name']} added to cart'),
          action: SnackBarAction(
            label: 'View Cart',
            onPressed: () {
              // Navigate to cart screen or show cart bottom sheet
              _showCartBottomSheet();
            },
          ),
          duration: const Duration(seconds: 2),
        ),
      );
    }

    void _updateCartSummary() {
      _cartItemCount = 0;
      _cartTotal = 0.0;
      
      _cartItems.forEach((itemId, quantity) {
        _cartItemCount += quantity;
        
        final item = _inventory.firstWhere((item) => item['id'] == itemId);
        _cartTotal += item['price'] * quantity;
      });
    }

    void _showCartBottomSheet() {
      if (_cartItems.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Your cart is empty'),
          ),
        );
        return;
      }
      
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        builder: (context) {
          return StatefulBuilder(
            builder: (context, setState) {
              return Container(
                padding: const EdgeInsets.all(16),
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.7,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Your Cart',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                    const Divider(),
                    Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: _cartItems.length,
                        itemBuilder: (context, index) {
                          final itemId = _cartItems.keys.elementAt(index);
                          final quantity = _cartItems[itemId]!;
                          final item = _inventory.firstWhere((item) => item['id'] == itemId);
                          
                          return ListTile(
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(item['image']),
                            ),
                            title: Text(item['name']),
                            subtitle: Text('₹${item['price']} per ${item['unit']}'),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.remove_circle_outline),
                                  onPressed: () {
                                    setState(() {
                                      if (quantity > 1) {
                                        _cartItems[itemId] = quantity - 1;
                                      } else {
                                        _cartItems.remove(itemId);
                                      }
                                      
                                      _updateCartSummary();
                                    });
                                  },
                                ),
                                Text(
                                  quantity.toString(),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.add_circle_outline),
                                  onPressed: () {
                                    setState(() {
                                      _cartItems[itemId] = quantity + 1;
                                      _updateCartSummary();
                                    });
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    const Divider(),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Total:',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '₹${_cartTotal.toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => OrderScreen(
                                hawker: widget.hawker,
                                cartItems: _cartItems,
                                inventory: _inventory,
                              ),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
                        ),
                        child: const Text(
                          'Proceed to Checkout',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      );
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                expandedHeight: 200,
                floating: false,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  title: Text(widget.hawker.name),
                  background: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.network(
                        'https://via.placeholder.com/800x400',
                        fit: BoxFit.cover,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              // ignore: deprecated_member_use
                              Colors.black.withOpacity(0.7),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                actions: [
                  IconButton(
                    icon: Icon(
                      _isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: _isFavorite ? Colors.red : Colors.white,
                    ),
                    onPressed: () {
                      setState(() {
                        _isFavorite = !_isFavorite;
                      });
                      
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            _isFavorite
                                ? '${widget.hawker.name} added to favorites'
                                : '${widget.hawker.name} removed from favorites',
                          ),
                          duration: const Duration(seconds: 2),
                        ),
                      );
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.share),
                    onPressed: () {
                      // Share hawker details
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Sharing functionality coming soon!'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    },
                  ),
                ],
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              // ignore: deprecated_member_use
                              color: Colors.green.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                  size: 16,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  widget.hawker.rating.toString(),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  ' (${widget.hawker.totalReviews})',
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              // ignore: deprecated_member_use
                              color: widget.hawker.isOnline ? Colors.green.withOpacity(0.1) : Colors.red.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              widget.hawker.isOnline ? 'Online' : 'Offline',
                              style: TextStyle(
                                color: widget.hawker.isOnline ? Colors.green : Colors.red,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              // ignore: deprecated_member_use
                              color: Colors.blue.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.shopping_bag,
                                  color: Colors.blue,
                                  size: 16,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  '${widget.hawker.totalOrders}+ orders',
                                  style: const TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          const Icon(
                            Icons.location_on,
                            color: Colors.grey,
                            size: 16,
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              widget.hawker.areas.join(', '),
                              style: TextStyle(
                                color: Colors.grey[600],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(
                            Icons.access_time,
                            color: Colors.grey,
                            size: 16,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'Available: 8:00 AM - 8:00 PM',
                            style: TextStyle(
                              color: Colors.grey[600],
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
                              label: const Text('Call'),
                              onPressed: () {
                                // Call hawker
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Calling ${widget.hawker.phone}'),
                                    duration: const Duration(seconds: 2),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                foregroundColor: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: ElevatedButton.icon(
                              icon: const Icon(Icons.message),
                              label: const Text('Message'),
                              onPressed: () {
                                // Message hawker
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Messaging functionality coming soon!'),
                                    duration: Duration(seconds: 2),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                foregroundColor: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SliverPersistentHeader(
                delegate: _SliverAppBarDelegate(
                  TabBar(
                    controller: _tabController,
                    tabs: const [
                      Tab(text: 'Products'),
                      Tab(text: 'Reviews'),
                    ],
                    labelColor: Colors.green,
                    unselectedLabelColor: Colors.grey,
                    indicatorColor: Colors.green,
                  ),
                ),
                pinned: true,
              ),
            ];
          },
          body: TabBarView(
            controller: _tabController,
            children: [
              _buildProductsTab(),
              _buildReviewsTab(),
            ],
          ),
        ),
        floatingActionButton: _cartItemCount > 0
            ? FloatingActionButton.extended(
                onPressed: _showCartBottomSheet,
                backgroundColor: Colors.green,
                icon: const Icon(Icons.shopping_cart),
                label: Text('$_cartItemCount | ₹${_cartTotal.toStringAsFixed(2)}'),
              )
            : null,
      );
    }

    Widget _buildProductsTab() {
      final filteredInventory = _getFilteredInventory();
      
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search products',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
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
          SizedBox(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _categories.length,
              itemBuilder: (context, index) {
                final category = _categories[index];
                final isSelected = category == _selectedCategory;
                
                return Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: ChoiceChip(
                    label: Text(category),
                    selected: isSelected,
                    onSelected: (selected) {
                      if (selected) {
                        setState(() {
                          _selectedCategory = category;
                        });
                      }
                    },
                    backgroundColor: Colors.grey[200],
                    // ignore: deprecated_member_use
                    selectedColor: Colors.green.withOpacity(0.2),
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.green : Colors.black,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: filteredInventory.isEmpty
                ? const Center(
                    child: Text('No products found'),
                  )
                : GridView.builder(
                    padding: const EdgeInsets.all(16),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.75,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                    ),
                    itemCount: filteredInventory.length,
                    itemBuilder: (context, index) {
                      final item = filteredInventory[index];
                      
                      return Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
                              child: Image.network(
                                item['image'],
                                height: 100,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item['name'],
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    item['description'],
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                      fontSize: 12,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        '₹${item['price']}/${item['unit']}',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.green,
                                        ),
                                      ),
                                      IconButton(
                                        icon: const Icon(
                                          Icons.add_circle,
                                          color: Colors.green,
                                        ),
                                        onPressed: () {
                                          _addToCart(item);
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),
        ],
      );
    }

    Widget _buildReviewsTab() {
      return ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        widget.hawker.rating.toString(),
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Icon(
                        Icons.star,
                        color: Colors.amber,
                        size: 24,
                      ),
                    ],
                  ),
                  Text(
                    '${widget.hawker.totalReviews} reviews',
                    style: TextStyle(
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  _showAddReviewDialog();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Write a Review'),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Divider(),
          ..._reviews.map((review) => _buildReviewItem(review)),
        ],
      );
    }

    Widget _buildReviewItem(Map<String, dynamic> review) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: CircleAvatar(
              backgroundImage: NetworkImage(review['userImage']),
            ),
            title: Text(
              review['userName'],
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              DateFormat('dd MMM yyyy').format(review['date']),
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 12,
              ),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  review['rating'].toString(),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 4),
                const Icon(
                  Icons.star,
                  color: Colors.amber,
                  size: 16,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 56.0, bottom: 16.0),
            child: Text(review['comment']),
          ),
          const Divider(),
        ],
      );
    }

    void _showAddReviewDialog() {
      double rating = 5.0;
      final commentController = TextEditingController();
      
      showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                title: const Text('Write a Review'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          rating.toString(),
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: 24,
                        ),
                      ],
                    ),
                    Slider(
                      value: rating,
                      min: 1.0,
                      max: 5.0,
                      divisions: 8,
                      activeColor: Colors.amber,
                      onChanged: (value) {
                        setState(() {
                          rating = value;
                        });
                      },
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: commentController,
                      decoration: const InputDecoration(
                        labelText: 'Your Review',
                        border: OutlineInputBorder(),
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
                      if (commentController.text.trim().isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please write your review'),
                            backgroundColor: Colors.red,
                          ),
                        );
                        return;
                      }
                      
                      // Add review logic
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Thank you for your review!'),
                          backgroundColor: Colors.green,
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                    child: const Text('Submit'),
                  ),
                ],
              );
            },
          );
        },
      );
    }
  }

  class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
    final TabBar _tabBar;

    _SliverAppBarDelegate(this._tabBar);

    @override
    double get minExtent => _tabBar.preferredSize.height;
    
    @override
    double get maxExtent => _tabBar.preferredSize.height;

    @override
    Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
      return Container(
        color: Colors.white,
        child: _tabBar,
      );
    }

    @override
    bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
      return false;
    }
  }