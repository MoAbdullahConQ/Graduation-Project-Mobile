import 'package:flutter/material.dart';
import 'package:socket_io_client_flutter/socket_io_client_flutter.dart' as IO;
import 'package:touch_pad_mobile_app/widgets/custom_btn.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late IO.Socket socket;
  bool isConnected = false;

  @override
  void initState() {
    super.initState();

    socket = IO.io('http://192.168.1.36:5000', <String, dynamic>{
      'transports': ['websocket'], // Fast direct connection using WebSocket
      'autoConnect': true, // The connection starts automatically
    });

    socket.onConnect((data) {
      print('✅ Connected to server');
      setState(() {
        isConnected = true;
      });
    });

    socket.onDisconnect((_) {
      print('❌ Disconnected from server');
      setState(() {
        isConnected = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Touchpad Remote Control'),
        actions: [
          Container(
            margin: EdgeInsets.all(15),
            width: 15,
            height: 15,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isConnected ? Colors.green : Colors.red,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        child: Column(
          children: [
            SizedBox(height: 100),
            Container(
              height: 300,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.blue.shade300,
                borderRadius: BorderRadius.circular(16),
              ),
              child: GestureDetector(
                child: Center(
                  child: Text(
                    'Moving Mouse here \n OR \n Left Click',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
              ),
            ),
            SizedBox(height: 30),
            Row(
              children: [
                Expanded(
                  child: CustomBtn(
                    text: 'Left Click',
                    bkColor: Colors.blue,
                    onPressed: () {},
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: CustomBtn(
                    text: 'Right Click',
                    bkColor: Colors.blue,
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
