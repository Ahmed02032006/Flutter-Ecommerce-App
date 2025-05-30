import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/order_details_screen.dart';
import 'package:flutter_application_1/screens/order_tracking_screen.dart';
import 'package:flutter_application_1/theme/theme.dart';

class OrdersListScreen extends StatelessWidget {
  final orders = [
    {
      'orderId': '12345',
      'date': 'Feb 10, 2025',
      'status': 'In Tranist',
      'items': ['Premium Cotton T-Shirt (2x)', 'Cotton Pants (1x)'],
      'total': 159.96,
    },
    {
      'orderId': '12345',
      'date': 'Feb 10, 2025',
      'status': 'Delivered',
      'items': ['Premium Sneakers (2x)', 'Sports Socks (1x)'],
      'total': 89.96,
    },
    {
      'orderId': '12345',
      'date': 'Feb 10, 2025',
      'status': 'Cancelled',
      'items': ['Winter Jacket (3x)'],
      'total': 199.96,
    },
    {
      'orderId': '12345',
      'date': 'Feb 10, 2025',
      'status': 'Processing',
      'items': ['Denim Jeans (2x)', 'Belt (1x)', 'Cotton Shirt (2x)'],
      'total': 245.96,
    },
  ];

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case "delivered":
        return AppTheme.success;
      case "in transit":
        return AppTheme.warning;
      case "processing":
        return AppTheme.primaryColor;
      case "cancelled":
        return AppTheme.error;
      default:
        return AppTheme.textSecondary;
    }
  }

  Widget _buildOrderCard({
    required String orderId,
    required String date,
    required String status,
    required List<String> items,
    required double total,
    required VoidCallback onTap,
    required BuildContext context,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Order #$orderId',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.textPrimary,
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: _getStatusColor(status).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      status,
                      style: TextStyle(
                        color: _getStatusColor(status),
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                'Ordered on $date',
                style: const TextStyle(
                  fontSize: 14,
                  color: AppTheme.textSecondary,
                ),
              ),
              const SizedBox(height: 12),
              const Divider(),
              const SizedBox(height: 12),
              Text(
                '${items.length} ${items.length == 1 ? 'item' : 'items'}:',
                style: const TextStyle(
                  fontSize: 14,
                  color: AppTheme.textSecondary,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                items.join(', '),
                style: const TextStyle(
                  fontSize: 14,
                  color: AppTheme.textPrimary,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Total: ",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.textPrimary,
                    ),
                  ),
                  Text(
                    "\$${total.toStringAsFixed(2)}",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.primaryColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 22),
              Row(
                children: [
                  const Spacer(),
                  TextButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const OrderTrackingScreen(),
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.local_shipping_outlined,
                      size: 18,
                    ),
                    label: const Text(
                      "Track Order",
                    ),
                    style: TextButton.styleFrom(
                      foregroundColor: AppTheme.primaryColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            leading: const Text(""),
            pinned: true,
            expandedHeight: 120,
            backgroundColor: Colors.transparent,
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: AppTheme.primaryGradient,
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: const FlexibleSpaceBar(
                title: Text(
                  "My Orders",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: "Search Orders...",
                              hintStyle: const TextStyle(
                                color: AppTheme.textSecondary,
                              ),
                              border: InputBorder.none,
                              icon: const Icon(
                                Icons.search,
                                color: AppTheme.textSecondary,
                              ),
                              suffixIcon: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: AppTheme.primaryColor.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Icon(
                                  Icons.filter_list,
                                  color: AppTheme.primaryColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  ...orders.map(
                    (order) => _buildOrderCard(
                      orderId: order['orderId'] as String,
                      date: order['date'] as String,
                      status: order['status'] as String,
                      items: order['items'] as List<String>,
                      total: order['total'] as double,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const OrderDetailsScreen(),
                          ),
                        );
                      },
                      context: context,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
