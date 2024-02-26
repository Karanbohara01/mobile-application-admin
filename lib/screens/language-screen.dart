import 'package:flutter/material.dart';

class LanguageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Language'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 20.0),
            Text(
              'Choose your preferred language:',
              style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20.0),
            LanguageOption(
              language: 'English',
              onTap: () {
                // Set language to English
                // Implement your logic here
              },
            ),
            SizedBox(height: 12.0),
            LanguageOption(
              language: 'Spanish',
              onTap: () {
                // Set language to Spanish
                // Implement your logic here
              },
            ),
            SizedBox(height: 12.0),
            LanguageOption(
              language: 'French',
              onTap: () {
                // Set language to French
                // Implement your logic here
              },
            ),
            // Add more language options as needed
          ],
        ),
      ),
    );
  }
}

class LanguageOption extends StatelessWidget {
  final String language;
  final VoidCallback onTap;

  const LanguageOption({
    required this.language,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8.0),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.blueGrey),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                language,
                style: TextStyle(fontSize: 18.0, color: Colors.black87),
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: Colors.blueGrey,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
