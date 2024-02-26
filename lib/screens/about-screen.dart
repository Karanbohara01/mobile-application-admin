import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'About Our App',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'Welcome to our e-commerce app!',
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.grey[800],
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'Version: 1.0.0',
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'Developed by: Karan Bohara',
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 32.0),
            Text(
              'Contact Us',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            Row(
              children: [
                Icon(
                  Icons.email,
                  color: Colors.blue,
                ),
                SizedBox(width: 10.0),
                Text(
                  'karanbohara216@example.com',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.blue,
                    decoration: TextDecoration.none,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.0),
            Row(
              children: [
                Icon(
                  Icons.phone,
                  color: Colors.blue,
                ),
                SizedBox(width: 10.0),
                Text(
                  '+977-9706127862',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ],
            ),
            SizedBox(height: 32.0),
            Text(
              'About Our Company',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'We envision a future where shopping knows no boundaries, where every customer can find what they need with ease and confidence. Through innovation, technology, and collaboration,'
                  ' we aim to redefine the way people shop and connect in the digital age.',
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.grey[800],
              ),
            ),
            // SizedBox(height: 32.0),
            // Container(
            //   alignment: Alignment.center,
            //   child: Image.asset(
            //     'assets/images/company_logo.png', // Add your company logo image
            //     width: 200.0,
            //     height: 200.0,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
