import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class InventoryManagementScreen extends StatefulWidget {
  const InventoryManagementScreen({Key? key}) : super(key: key);

  @override
  State<InventoryManagementScreen> createState() => _InventoryManagementScreenState();
}

class _InventoryManagementScreenState extends State<InventoryManagementScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  String _selectedCategory = 'All';
  String _selectedSort = 'Name (A-Z)';
  
  final List<String> _categories = [
    'All',
    'Fruits',
    'Vegetables',
    'Dairy',
    'Bakery',
    'Beverages',
  ];
  
  final List<String> _sortOptions = [
    'Name (A-Z)',
    'Name (Z-A)',
    'Price (Low to High)',
    'Price (High to Low)',
    'Stock (Low to High)',
    'Stock (High to Low)',
  ];
  
  final List<Map<String, dynamic>> _inventory = [
    {
      'id': '1',
      'name': 'Apples',
      'category': 'Fruits',
      'price': 120.0,
      'unit': 'kg',
      'stock': 50,
      'lowStockThreshold': 10,
      'image': 'https://via.placeholder.com/150',
      'description': 'Fresh red apples from Himachal Pradesh',
      'lastUpdated': DateTime.now().subtract(const Duration(days: 2)),
    },
    {
      'id': '2',
      'name': 'Bananas',
      'category': 'Fruits',
      'price': 60.0,
      'unit': 'dozen',
      'stock': 30,
      'lowStockThreshold': 5,
      'image': 'https://via.placeholder.com/150',
      'description': 'Ripe yellow bananas',
      'lastUpdated': DateTime.now().subtract(const Duration(days: 1)),
    },
    {
      'id': '3',
      'name': 'Tomatoes',
      'category': 'Vegetables',
      'price': 40.0,
      'unit': 'kg',
      'stock': 80,
      'lowStockThreshold': 15,
      'image': 'https://via.placeholder.com/150',
      'description': 'Fresh red tomatoes',
      'lastUpdated': DateTime.now().subtract(const Duration(days: 3)),
    },
    {
      'id': '4',
      'name': 'Potatoes',
      'category': 'Vegetables',
      'price': 30.0,
      'unit': 'kg',
      'stock': 100,
      'lowStockThreshold': 20,
      'image': 'https://via.placeholder.com/150',
      'description': 'Fresh potatoes from Punjab',
      'lastUpdated': DateTime.now().subtract(const Duration(days: 5)),
    },
    {
      'id': '5',
      'name': 'Milk',
      'category': 'Dairy',
      'price': 60.0,
      'unit': 'liter',
      'stock': 40,
      'lowStockThreshold': 10,
      'image': 'https://via.placeholder.com/150',
      'description': 'Fresh cow milk',
      'lastUpdated': DateTime.now().subtract(const Duration(days: 1)),
    },
    {
      'id': '6',
      'name': 'Bread',
      'category': 'Bakery',
      'price': 35.0,
      'unit': 'loaf',
      'stock': 25,
      'lowStockThreshold': 5,
      'image': 'https://via.placeholder.com/150',
      'description': 'Freshly baked bread',
      'lastUpdated': DateTime.now().subtract(const Duration(hours: 12)),
    },
    {
      'id': '7',
      'name': 'Oranges',
      'category': 'Fruits',
      'price': 80.0,
      'unit': 'kg',
      'stock': 5,
      'lowStockThreshold': 10,
      'image': 'https://via.placeholder.com/150',
      'description': 'Sweet and juicy oranges',
      'lastUpdated': DateTime.now().subtract(const Duration(days: 4)),
    },
    {
      'id': '8',
      'name': 'Onions',
      'category': 'Vegetables',
      'price': 50.0,
      'unit': 'kg',
      'stock': 70,
      'lowStockThreshold': 15,
      'image': 'https://via.placeholder.com/150',
      'description': 'Fresh red onions',
      'lastUpdated': DateTime.now().subtract(const Duration(days: 6)),
    },
    {
      'id': '9',
      'name': 'Yogurt',
      'category': 'Dairy',
      'price': 40.0,
      'unit': 'cup',
      'stock': 3,
      'lowStockThreshold': 5,
      'image': 'https://via.placeholder.com/150',
      'description': 'Fresh yogurt',
      'lastUpdated': DateTime.now().subtract(const Duration(days: 2)),
    },
    {
      'id': '10',
      'name': 'Water Bottles',
      'category': 'Beverages',
      'price': 20.0,
      'unit': 'bottle',
      'stock': 150,
      'lowStockThreshold': 30,
      'image': 'https://via.placeholder.com/150',
      'description': 'Mineral water bottles',
      'lastUpdated': DateTime.now().subtract(const Duration(days: 7)),
    },
  ];

  @override
  void dispose() {
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
    
    // Apply sorting
    switch (_selectedSort) {
      case 'Name (A-Z)':
        filteredList.sort((a, b) => a['name'].compareTo(b['name']));
        break;
      case 'Name (Z-A)':
        filteredList.sort((a, b) => b['name'].compareTo(a['name']));
        break;
      case 'Price (Low to High)':
        filteredList.sort((a, b) => a['price'].compareTo(b['price']));
        break;
      case 'Price (High to Low)':
        filteredList.sort((a, b) => b['price'].compareTo(a['price']));
        break;
      case 'Stock (Low to High)':
        filteredList.sort((a, b) => a['stock'].compareTo(b['stock']));
        break;
      case 'Stock (High to Low)':
        filteredList.sort((a, b) => b['stock'].compareTo(a['stock']));
        break;
    }
    
    return filteredList;
  }

  @override
  Widget build(BuildContext context) {
    final filteredInventory = _getFilteredInventory();
    final lowStockItems = _inventory.where((item) => item['stock'] <= item['lowStockThreshold']).toList();
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inventory Management'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              _showAddEditItemDialog();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search inventory',
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
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        decoration: const InputDecoration(
                          labelText: 'Category',
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        ),
                        value: _selectedCategory,
                        items: _categories.map((String category) {
                          return DropdownMenuItem<String>(
                            value: category,
                            child: Text(category),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          if (newValue != null) {
                            setState(() {
                              _selectedCategory = newValue;
                            });
                          }
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        decoration: const InputDecoration(
                          labelText: 'Sort By',
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        ),
                        value: _selectedSort,
                        items: _sortOptions.map((String option) {
                          return DropdownMenuItem<String>(
                            value: option,
                            child: Text(option),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          if (newValue != null) {
                            setState(() {
                              _selectedSort = newValue;
                            });
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          if (lowStockItems.isNotEmpty)
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.red.withOpacity(0.3)),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.warning,
                    color: Colors.red,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      '${lowStockItems.length} items are running low on stock',
                      style: const TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _selectedCategory = 'All';
                        _selectedSort = 'Stock (Low to High)';
                      });
                    },
                    child: const Text('View All'),
                  ),
                ],
              ),
            ),
          
          Expanded(
            child: filteredInventory.isEmpty
                ? const Center(
                    child: Text('No inventory items found'),
                  )
                : ListView.builder(
                    itemCount: filteredInventory.length,
                    itemBuilder: (context, index) {
                      final item = filteredInventory[index];
                      final isLowStock = item['stock'] <= item['lowStockThreshold'];
                      
                      return Card(
                        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(item['image']),
                          ),
                          title: Text(item['name']),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Category: ${item['category']}'),
                              Text('Price: ₹${item['price']} per ${item['unit']}'),
                            ],
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: isLowStock ? Colors.red.withOpacity(0.1) : Colors.green.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(4),
                                  border: Border.all(
                                    color: isLowStock ? Colors.red.withOpacity(0.3) : Colors.green.withOpacity(0.3),
                                  ),
                                ),
                                child: Text(
                                  'Stock: ${item['stock']}',
                                  style: TextStyle(
                                    color: isLowStock ? Colors.red : Colors.green,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              PopupMenuButton<String>(
                                onSelected: (value) {
                                  if (value == 'edit') {
                                    _showAddEditItemDialog(item: item);
                                  } else if (value == 'delete') {
                                    _showDeleteItemDialog(item);
                                  } else if (value == 'restock') {
                                    _showRestockDialog(item);
                                  }
                                },
                                itemBuilder: (context) => [
                                  const PopupMenuItem<String>(
                                    value: 'edit',
                                    child: Row(
                                      children: [
                                        Icon(Icons.edit),
                                        SizedBox(width: 8),
                                        Text('Edit'),
                                      ],
                                    ),
                                  ),
                                  const PopupMenuItem<String>(
                                    value: 'restock',
                                    child: Row(
                                      children: [
                                        Icon(Icons.add_shopping_cart),
                                        SizedBox(width: 8),
                                        Text('Restock'),
                                      ],
                                    ),
                                  ),
                                  const PopupMenuItem<String>(
                                    value: 'delete',
                                    child: Row(
                                      children: [
                                        Icon(Icons.delete, color: Colors.red),
                                        SizedBox(width: 8),
                                        Text('Delete', style: TextStyle(color: Colors.red)),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          onTap: () {
                            _showItemDetailsDialog(item);
                          },
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddEditItemDialog();
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showItemDetailsDialog(Map<String, dynamic> item) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(item['name']),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(
                  child: Image.network(
                    item['image'],
                    height: 150,
                    width: 150,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 16),
                _buildDetailRow('ID', item['id']),
                _buildDetailRow('Category', item['category']),
                _buildDetailRow('Price', '₹${item['price']} per ${item['unit']}'),
                _buildDetailRow('Stock', item['stock'].toString()),
                _buildDetailRow('Low Stock Threshold', item['lowStockThreshold'].toString()),
                _buildDetailRow('Description', item['description']),
                _buildDetailRow('Last Updated', DateFormat('dd MMM yyyy, hh:mm a').format(item['lastUpdated'])),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Close'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _showAddEditItemDialog(item: item);
              },
              child: const Text('Edit'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              '$label:',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
          ),
          Expanded(
            child: Text(value),
          ),
        ],
      ),
    );
  }

  void _showAddEditItemDialog({Map<String, dynamic>? item}) {
    final isEditing = item != null;
    
    final nameController = TextEditingController(text: isEditing ? item['name'] : '');
    final categoryController = TextEditingController(text: isEditing ? item['category'] : '');
    final priceController = TextEditingController(text: isEditing ? item['price'].toString() : '');
    final unitController = TextEditingController(text: isEditing ? item['unit'] : '');
    final stockController = TextEditingController(text: isEditing ? item['stock'].toString() : '');
    final thresholdController = TextEditingController(text: isEditing ? item['lowStockThreshold'].toString() : '');
    final imageController = TextEditingController(text: isEditing ? item['image'] : 'https://via.placeholder.com/150');
    final descriptionController = TextEditingController(text: isEditing ? item['description'] : '');
    
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(isEditing ? 'Edit Item' : 'Add New Item'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    labelText: 'Category',
                    border: OutlineInputBorder(),
                  ),
                  value: isEditing ? item['category'] : _categories[1],
                  items: _categories.where((c) => c != 'All').map((String category) {
                    return DropdownMenuItem<String>(
                      value: category,
                      child: Text(category),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      categoryController.text = newValue;
                    }
                  },
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: TextField(
                        controller: priceController,
                        decoration: const InputDecoration(
                          labelText: 'Price',
                          border: OutlineInputBorder(),
                          prefixText: '₹',
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      flex: 1,
                      child: TextField(
                        controller: unitController,
                        decoration: const InputDecoration(
                          labelText: 'Unit',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: stockController,
                        decoration: const InputDecoration(
                          labelText: 'Stock',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: TextField(
                        controller: thresholdController,
                        decoration: const InputDecoration(
                          labelText: 'Low Stock Threshold',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: imageController,
                  decoration: const InputDecoration(
                    labelText: 'Image URL',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: descriptionController,
                  decoration: const InputDecoration(
                    labelText: 'Description',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 3,
                ),
              ],
            ),
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
                // Validate inputs
                if (nameController.text.isEmpty ||
                    categoryController.text.isEmpty ||
                    priceController.text.isEmpty ||
                    unitController.text.isEmpty ||
                    stockController.text.isEmpty ||
                    thresholdController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please fill all required fields'),
                      backgroundColor: Colors.red,
                    ),
                  );
                  return;
                }
                
                final newItem = {
                  'id': isEditing ? item['id'] : DateTime.now().millisecondsSinceEpoch.toString(),
                  'name': nameController.text,
                  'category': categoryController.text,
                  'price': double.parse(priceController.text),
                  'unit': unitController.text,
                  'stock': int.parse(stockController.text),
                  'lowStockThreshold': int.parse(thresholdController.text),
                  'image': imageController.text,
                  'description': descriptionController.text,
                  'lastUpdated': DateTime.now(),
                };
                
                setState(() {
                  if (isEditing) {
                    final index = _inventory.indexWhere((i) => i['id'] == item['id']);
                    if (index != -1) {
                      _inventory[index] = newItem;
                    }
                  } else {
                    _inventory.add(newItem);
                  }
                });
                
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(isEditing ? 'Item updated successfully' : 'Item added successfully'),
                    backgroundColor: Colors.green,
                  ),
                );
              },
              child: Text(isEditing ? 'Update' : 'Add'),
            ),
          ],
        );
      },
    );
  }

  void _showDeleteItemDialog(Map<String, dynamic> item) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete Item'),
          content: Text('Are you sure you want to delete ${item['name']}?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _inventory.removeWhere((i) => i['id'] == item['id']);
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${item['name']} has been deleted'),
                    backgroundColor: Colors.red,
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  void _showRestockDialog(Map<String, dynamic> item) {
    final restockController = TextEditingController();
    
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Restock Item'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Current stock of ${item['name']}: ${item['stock']} ${item['unit']}'),
              const SizedBox(height: 16),
              TextField(
                controller: restockController,
                decoration: const InputDecoration(
                  labelText: 'Add Stock',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
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
                if (restockController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please enter a valid quantity'),
                      backgroundColor: Colors.red,
                    ),
                  );
                  return;
                }
                
                final additionalStock = int.parse(restockController.text);
                
                setState(() {
                  final index = _inventory.indexWhere((i) => i['id'] == item['id']);
                  if (index != -1) {
                    _inventory[index] = {
                      ..._inventory[index],
                      'stock': _inventory[index]['stock'] + additionalStock,
                      'lastUpdated': DateTime.now(),
                    };
                  }
                });
                
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Added $additionalStock ${item['unit']} to ${item['name']}'),
                    backgroundColor: Colors.green,
                  ),
                );
              },
              child: const Text('Restock'),
            ),
          ],
        );
      },
    );
  }
}