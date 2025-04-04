import 'package:flutter/material.dart';
import 'package:flutter_application_1/theme/theme.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final List<Map<String, dynamic>> notifications = [
    {
      'type': 'order',
      'title': 'Order Delivered',
      'message': 'Your order #1234 has been delivered successfully',
      'time': '2 mins ago',
      'read': false,
      'icon': Icons.local_shipping_outlined,
      'iconColor': AppTheme.success,
    },
    {
      'type': 'promo',
      'title': 'Special Offer',
      'message': 'Get 50% OFF on all electronics this weekend!',
      'time': '1 hours ago',
      'read': false,
      'icon': Icons.local_offer_outlined,
      'iconColor': AppTheme.primaryColor,
    },
    {
      'type': 'payment',
      'title': 'Payment Successful',
      'message': 'Payment of \$299.99 was successful',
      'time': '3 hours ago',
      'read': true,
      'icon': Icons.payment_outlined,
      'iconColor': AppTheme.success,
    },
    {
      'type': 'alert',
      'title': 'Price Drop Alert',
      'message': 'Price dropped for item in your wishlist',
      'time': '5 hours ago',
      'read': true,
      'icon': Icons.notifications_outlined,
      'iconColor': AppTheme.warning,
    },
    {
      'type': 'system',
      'title': 'System Update',
      'message': 'Your account settings have been updated',
      'time': '1 day ago',
      'read': false,
      'icon': Icons.system_update_outlined,
      'iconColor': AppTheme.secondaryColor,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 120,
            backgroundColor: Colors.transparent,
            foregroundColor: Colors.white,
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: AppTheme.primaryGradient,
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: FlexibleSpaceBar(
                centerTitle: true,
                titlePadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                title: const Text(
                  "Notifications",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
                background: Stack(
                  children: [
                    Positioned(
                      top: -50,
                      right: -50,
                      child: Container(
                        height: 150,
                        width: 150,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withOpacity(0.1),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.done_all,
                  color: Colors.white,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.more_vert,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                final notification = notifications[index];

                return Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: notification['read'] ? Colors.white54 : Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 20,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: ListTile(
                    leading: Stack(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: (notification['iconColor'] as Color)
                                .withOpacity(0.1),
                          ),
                          child: Icon(
                            notification['icon'] as IconData,
                            color: notification['iconColor'] as Color,
                            size: 24,
                          ),
                        ),
                        if (!notification['read'])
                          Positioned(
                            right: 0,
                            top: 0,
                            child: Container(
                              height: 8,
                              width: 8,
                              decoration: const BoxDecoration(
                                color: AppTheme.primaryColor,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                      ],
                    ),
                    title: Text(
                      notification['title'] as String,
                      style: TextStyle(
                        fontWeight: notification['read']
                            ? FontWeight.normal
                            : FontWeight.bold,
                        color: AppTheme.textPrimary,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 4),
                        Text(
                          notification['message'] as String,
                          style: const TextStyle(
                            color: AppTheme.textSecondary,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          notification['time'] as String,
                          style: const TextStyle(
                            color: AppTheme.primaryDark,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    trailing: IconButton(
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(20),
                            ),
                          ),
                          builder: (context) => Container(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ListTile(
                                  leading: const Icon(
                                      Icons.mark_email_read_outlined),
                                  title: const Text("Mark as read"),
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                ),
                                ListTile(
                                  leading: const Icon(Icons.delete_outlined),
                                  title: const Text("Delete Notification"),
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                ),
                                ListTile(
                                  leading: const Icon(Icons.block_outlined),
                                  title: const Text("Turn off notifications"),
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.more_horiz,
                        color: AppTheme.textSecondary,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
