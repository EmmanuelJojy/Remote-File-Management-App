import 'package:flutter/material.dart';
import '../logic/socket_client.dart';
import '../data/shared.dart';

class ActionCard extends StatefulWidget {
  final String text;
  final IconData? icon;
  final String? subTitle;
  final String buttonText;
  const ActionCard(this.text, this.buttonText,
      {this.icon, this.subTitle, Key? key})
      : super(key: key);

  @override
  State<ActionCard> createState() => _ActionCardState();
}

class _ActionCardState extends State<ActionCard> {
  final controller = TextEditingController();
  bool operationStatus = true;

  void actionHandler(var setStateOfDialog) {
    final SocketClient soc = SharedData.soc as SocketClient;
    String name = controller.text;
    SharedData.pool = '';

    if (name.isEmpty == false) {
      if (widget.buttonText == 'Create') {
        soc.sendMessage('cf $name', listen: true);
        Future.delayed(Duration(milliseconds: SharedData.timeDelay))
            .then((value) => SharedData.pool == '0'
                ? setStateOfDialog(() {
                    operationStatus = false;
                  })
                : Navigator.pop(context));
      } else if (widget.buttonText == 'Delete') {
        soc.sendMessage('df $name', listen: true);
        Future.delayed(Duration(milliseconds: SharedData.timeDelay))
            .then((value) => SharedData.pool == '0'
                ? setStateOfDialog(() {
                    operationStatus = false;
                  })
                : Navigator.pop(context));
      } else if (widget.buttonText == 'View' || widget.buttonText == 'Edit') {
        soc.sendMessage('vf $name', listen: true);
        SharedData.file['name'] = name;
        Future.delayed(Duration(milliseconds: SharedData.timeDelay)).then(
          (value) {
            if (SharedData.pool == '0') {
              setStateOfDialog(
                () {
                  operationStatus = false;
                },
              );
            } else {
              Navigator.pop(context);
              SharedData.updateFileAttributes();
              if (widget.buttonText == 'View') {
                Navigator.pushNamed(context, '/home/view');
              } else {
                Navigator.pushNamed(context, '/home/edit');
              }
            }
          },
        );
      } else if (widget.buttonText == 'Execute') {
        soc.sendMessage('rc $name', listen: true);
        Future.delayed(Duration(milliseconds: SharedData.timeDelay))
            .then((value) => SharedData.pool == '0'
                ? setStateOfDialog(() {
                    operationStatus = false;
                  })
                : Navigator.pop(context));
      }
    }
  }

  void _resetState() {
    controller.text = '';
    operationStatus = true;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _resetState();
        showDialog(
          context: context,
          builder: (context) {
            operationStatus = true;
            return StatefulBuilder(
              builder: (context, setState) {
                return AlertDialog(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16.0))),
                  title: Text(widget.text),
                  content: SingleChildScrollView(
                    child: Column(children: [
                      TextField(
                        decoration: InputDecoration(
                          labelText: widget.buttonText == 'Execute'
                              ? 'Command To Execute'
                              : 'File Name',
                          errorText:
                              operationStatus ? null : 'Operation Unsuccessful',
                        ),
                        controller: controller,
                        keyboardType: TextInputType.text,
                      ),
                    ]),
                  ),
                  actions: <Widget>[
                    TextButton(
                      child: Text(widget.buttonText),
                      onPressed: () {
                        actionHandler(setState);
                      },
                    ),
                  ],
                );
              },
            );
          },
        );
      },
      child: Card(
        color: widget.icon == null ? Colors.grey[350] : null,
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
        elevation: widget.icon != null ? 4 : 0,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListTile(
            leading: widget.icon != null
                ? CircleAvatar(
                    radius: 30,
                    child: Icon(widget.icon),
                  )
                : null,
            title: Text(
              widget.text,
              textAlign: widget.icon == null ? TextAlign.center : null,
            ),
            subtitle: widget.subTitle != null
                ? SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Text(
                      widget.subTitle!,
                      textAlign: TextAlign.center,
                    ),
                  )
                : null,
          ),
        ),
      ),
    );
  }
}
