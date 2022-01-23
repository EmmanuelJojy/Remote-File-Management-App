import 'package:flutter/material.dart';

import '../data/shared.dart';
import '../widgets/file_card.dart';

class EditPage extends StatefulWidget {
  const EditPage({Key? key}) : super(key: key);

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  TextEditingController textController = TextEditingController(); // dump

  Future<void> _showStatus(bool flag) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit Status'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                flag
                    ? const Text('Operation Successful.')
                    : const Text('Operation Failed.'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
                if(flag) {
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    textController = TextEditingController(text: SharedData.pool);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: const Text('Edit File'),
      actions: [
        ElevatedButton(
          onPressed: () {
            String msg =
                'ef ' + SharedData.file['name']! + ' ' + textController.text;
            SharedData.soc!.sendMessage(msg, listen: true);
            Future.delayed(Duration(milliseconds: SharedData.timeDelay))
                .then((value) => SharedData.pool == '0' ? _showStatus(false) : _showStatus(true));
          },
          child: const Text('Apply Edit'),
        )
      ],
    );
    var availHeight = (MediaQuery.of(context).size.height -
            appBar.preferredSize.height -
            MediaQuery.of(context).padding.top) -
        10;

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
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                alignment: Alignment.topLeft,
                height: availHeight * 0.8,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                ),
                child: TextField(
                  expands: true,
                  maxLines: null,
                  controller: textController,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
