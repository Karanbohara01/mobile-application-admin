import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact Us'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Get in Touch',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            ListTile(
              leading: Icon(Icons.email),
              title: Text('Email'),
              subtitle: Text('karanbohara216@example.com'),
              onTap: () => _launchEmail('karanbohara216@example.com'),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.phone),
              title: Text('Phone'),
              subtitle: Text('+977-9828848192'),
              onTap: () => _launchPhone('+977-9828848192'),
            ),
            Divider(),
            const ListTile(
              leading: Icon(Icons.location_on),
              title: Text('Address'),
              subtitle: Text('Kathmandu,Nepal'),
              // You can add functionality to launch map app here
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.web),
              title: Text('Website'),
              subtitle: Text('www.example.com'),
              onTap: () => _launchUrl('https://www.example.com'),
            ),
          ],
        ),
      ),
    );
  }

  void _launchEmail(String email) async {
    final Uri _emailLaunchUri = Uri(
      scheme: 'mailto',
      path: email,
    );
    if (await canLaunch(_emailLaunchUri.toString())) {
      await launch(_emailLaunchUri.toString());
    } else {
      throw 'Could not launch $email';
    }
  }

  void _launchPhone(String phone) async {
    final Uri _phoneLaunchUri = Uri(
      scheme: 'tel',
      path: phone,
    );
    if (await canLaunch(_phoneLaunchUri.toString())) {
      await launch(_phoneLaunchUri.toString());
    } else {
      throw 'Could not launch $phone';
    }
  }

  void _launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
