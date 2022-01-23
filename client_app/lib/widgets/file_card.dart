import 'package:client_app/data/shared.dart';
import 'package:flutter/material.dart';

class FileCard extends StatelessWidget {
  const FileCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[300],
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListTile(
          leading: const CircleAvatar(
            radius: 30,
            child: Icon(Icons.text_fields, size: 30,),
          ),
          title: Text(SharedData.file['name']!, textScaleFactor: 1.5,),
          subtitle: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Text(
              SharedData.file['attr']!,
            ),
          ),
        ),
      ),
    );
  }
}
