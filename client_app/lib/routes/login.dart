import 'package:client_app/data/shared.dart';
import 'package:flutter/material.dart';

import '../logic/socket_client.dart';
import '../models/connection.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool notValidInput = false;
  Connection? connection;
  final idController = TextEditingController(text: 'MyDevice');
  final ipController = TextEditingController(text: '192.168.1.205');
  final portController = TextEditingController(text: '65432');

  void _validateAddress() async {
    String id = idController.text;
    String ip = ipController.text;
    String port = portController.text;

    if (id.isEmpty ||
        ip.isEmpty ||
        port.isEmpty ||
        ip.contains(RegExp(r'[A-Za-z]')) ||
        port.contains(RegExp(r'[A-Za-z]'))) {
    } else {
      connection = Connection(ip, port, id);
      SocketClient socket = SocketClient(connection!);
      SharedData.soc = socket;
      await socket.connect() ? _watchState(isConnected: true) : _watchState();
    }
  }

  void _watchState({bool isConnected = false, }) {
    notValidInput = false;
    if (isConnected) {
      Navigator.pushNamed(context, '/home');
    } else if (notValidInput == false) {
      setState(() {
        notValidInput = true;
      });
    }
  }

  @override
  void initState() {
    setState(() {
      notValidInput = false;
    });
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    
    final appBar = AppBar(
        title: const Text('Client Side App'),
      );
    var availHeight = (MediaQuery.of(context).size.height -
        appBar.preferredSize.height -
        MediaQuery.of(context).padding.top);
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Container(
            height: availHeight,
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Establish Connection',
                  style: TextStyle(fontSize: 24),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  decoration:
                      const InputDecoration(labelText: 'Device Identifier'),
                  controller: idController,
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Flexible(
                      fit: FlexFit.tight,
                      flex: 3,
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: 'IP Address',
                          errorText: (notValidInput ? 'Invalid/Timeout' : null),
                        ),
                        controller: ipController,
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                      ),
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    Flexible(
                      flex: 1,
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: 'Port',
                          errorText: (notValidInput ? portController.text : null),
                        ),
                        controller: portController,
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: false),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                TextButton(
                  onPressed: () {
                    _validateAddress();
                  },
                  child: const Text(
                    'Connect',
                    style: TextStyle(fontSize: 18),
                  ),
                )
              ],
            ),
          ),
        ),
      
    );
  }
}
