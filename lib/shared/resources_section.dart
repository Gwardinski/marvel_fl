import 'package:flutter/material.dart';
import 'package:marvel_heroes/models/resource.dart';
import 'package:url_launcher/url_launcher.dart';

class ResourcesSection extends StatelessWidget {
  const ResourcesSection({
    @required this.resources,
  });

  final List<Resource> resources;

  Future<void> _launchURL(String url, context) async {
    final can = await canLaunch(url);
    if (can) {
      return await launch(url);
    }
    final snackBar = SnackBar(content: Text('Could not open URL'));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Online Resources:",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Wrap(
          children: resources
              .map(
                (r) => Padding(
                  padding: EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () => _launchURL(r.url, context),
                    child: Chip(
                      label: Text(
                        r.name ?? "",
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      backgroundColor: Colors.red, // TODO
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}
