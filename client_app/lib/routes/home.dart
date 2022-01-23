import 'package:client_app/data/shared.dart';
import 'package:client_app/logic/socket_client.dart';
import 'package:client_app/widgets/action_card.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final SocketClient soc = SharedData.soc as SocketClient;
  bool isFirstRun = true;
  String serverPath = '- -';

  void _initialize() {
    if (isFirstRun) {
      isFirstRun = false;
      soc.sendMessage('cd', listen: true);
      Future.delayed(Duration(milliseconds: SharedData.timeDelay * 2))
          .then((value) {
        setState(() {
          serverPath = SharedData.pool;
        });
      });
    }
  }

  Future<bool> _onWillPop() async {
    soc.disconnect();
    Navigator.pop(context);
    return true;
  }

  @override
  Widget build(BuildContext context) {
    _initialize();
    final appBar = AppBar(
      title: const Text('Actions'),
      actions: [
        IconButton(
            onPressed: () {
              soc.disconnect();
              Navigator.pop(context);
            },
            icon: const Icon(Icons.logout)),
        IconButton(
          onPressed: () {
            soc.shutdown();
            Navigator.pop(context);
          },
          icon: const Icon(Icons.power_off),
        ),
      ],
    );
    var availHeight = (MediaQuery.of(context).size.height -
        appBar.preferredSize.height -
        MediaQuery.of(context).padding.top);
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: appBar,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(5),
                height: availHeight * 0.2,
                child:
                    ActionCard('Server Executing At', '', subTitle: serverPath),
              ),
              Container(
                padding: const EdgeInsets.all(5),
                height: availHeight * 0.8,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const ActionCard('Create File', 'Create',
                          icon: Icons.add),
                      const ActionCard('Edit File', 'Edit', icon: Icons.edit),
                      const ActionCard('View File', 'View',
                          icon: Icons.remove_red_eye),
                      const ActionCard('Delete File', 'Delete',
                          icon: Icons.delete_forever),
                      const ActionCard('Raw Command', 'Execute',
                          icon: Icons.admin_panel_settings),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        alignment: Alignment.center,
                        child: Text(
                          '${soc.c.ip}:${soc.c.port}',
                        ),
                      ),
                    ],
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
