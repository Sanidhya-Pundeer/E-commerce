import 'package:flutter/material.dart';

class HelpPoliciesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Help & Policies',
          style: TextStyle(color: Colors.white), 
        ),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Help & Policies',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Text(
                'Welcome to SwiftCart Help & Policies page. Here you will find information about our policies, return process, and how to get help if you need it.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              Text(
                'Return Policy',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                'At SwiftCart, we offer a 30-day return policy. If you are not satisfied with your purchase, you can return it within 30 days of receipt for a full refund or exchange.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              Text(
                'Privacy Policy',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                'Your privacy is important to us. We are committed to protecting your personal information and ensuring it is used responsibly.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              Text(
                'Contact Us',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                'If you have any questions or need further assistance, please contact our support team at support@swiftcart.com or call us at 1-800-123-4567.',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
