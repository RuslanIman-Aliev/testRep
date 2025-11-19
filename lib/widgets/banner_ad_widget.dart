import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; 

class BannerAdWidget extends StatefulWidget {
  const BannerAdWidget({super.key});

  @override
  State<BannerAdWidget> createState() => _BannerAdWidgetState();
}

class _BannerAdWidgetState extends State<BannerAdWidget> {
  
  final Uri _targetUrl = Uri.parse('https://github.com/RuslanIman-Aliev');
  
  final String _imageUrl = 'https://placehold.co/468x60/2196f3/ffffff?text=My+Resume+App+Ads';

  Future<void> _launchUrl() async {
    if (!await launchUrl(_targetUrl)) {
      throw Exception('Could not launch $_targetUrl');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: double.infinity,
      color: Colors.grey[200],
      child: Center(
        child: InkWell(
          onTap: _launchUrl,
          child: Stack(
            alignment: Alignment.topRight,
            children: [
              Image.network(
                _imageUrl,
                fit: BoxFit.contain,
                errorBuilder: (ctx, err, stack) => const Center(
                  child: Text("Реклама "),
                ),
              ),
              Container(
                color: Colors.amber,
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                child: const Text(
                  'Ad', 
                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}