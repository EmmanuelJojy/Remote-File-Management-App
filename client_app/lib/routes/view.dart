import 'package:client_app/widgets/file_card.dart';
import 'package:flutter/material.dart';

import '../data/shared.dart';

class ViewPage extends StatelessWidget {
  const ViewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: const Text('View File'),
    );
    var availHeight = (MediaQuery.of(context).size.height -
        appBar.preferredSize.height -
        MediaQuery.of(context).padding.top);

    var availWidth = MediaQuery.of(context).size.width - 25;

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: SizedBox(
          height: availHeight,
          child: Column(
            children: [
              SizedBox(
                height: availHeight * 0.2,
                child: const FileCard(),
              ),
              Container(
                padding: const EdgeInsets.all(5),
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                alignment: Alignment.topLeft,
                height: availHeight * 0.75,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                ),
                child: SingleChildScrollView(
                  child: SizedBox(
                    width: availWidth,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Text(
                        SharedData.pool,
                        textScaleFactor: 2.0,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
