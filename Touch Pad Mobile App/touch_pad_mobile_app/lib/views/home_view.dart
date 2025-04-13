import 'dart:async';

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
  String stateConnect = "OFF";

  // Timer to send movement
  Timer? _movementTimer;

  // Time between transmissions (in milliseconds)
  final int throttleTime = 50; // 50ms = 20 updates per second

  // Store cumulative movement
  double accumulatedDx = 0;
  double accumulatedDy = 0;

  //Motion speed factor
  final double speedMultiplier = 2.5;

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
        stateConnect = 'ON';
      });
    });

    socket.onDisconnect((_) {
      print('❌ Disconnected from server');
      setState(() {
        isConnected = false;
        stateConnect = 'OFF';
      });
    });

    // Start timer to send movement
    _startMovementTimer();
  }

  void _startMovementTimer() {
    _movementTimer?.cancel();
    _movementTimer = Timer.periodic(Duration(milliseconds: throttleTime), (
      timer,
    ) {
      // here is code that send every 50ms
      _sendAccumulatedMovement();
    });
  }

  void _sendAccumulatedMovement() {
    // Send accumulated traffic only if it exceeds a certain value
    if (accumulatedDx.abs() > 0.1 || accumulatedDy.abs() > 0.1) {
      socket.emit('mouse_move', {
        'dx': accumulatedDx * speedMultiplier,
        'dy': accumulatedDy * speedMultiplier,
      });

      print(
        '📤 Sent movement: dx=${accumulatedDx * speedMultiplier}, dy=${accumulatedDy * speedMultiplier}',
      );

      // Reset accumulated movement
      accumulatedDx = 0;
      accumulatedDy = 0;
    }
  }

  void handleSwipe(DragUpdateDetails details) {
    // Collect changes in motion
    accumulatedDx += details.delta.dx;
    accumulatedDy += details.delta.dy;
  }

  void handleLeftClick() {
    socket.emit('mouse_command', 'click');
    print('📤 Sent command: Left Click');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blue,
        title: Text('Touchpad Remote Control'),
        actions: [
          Center(
            child: Text(
              stateConnect,
              style: TextStyle(
                fontSize: 18,
                color: isConnected ? Colors.lightGreenAccent : Colors.red,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: 15, left: 10),
            width: 15,
            height: 15,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isConnected ? Colors.lightGreenAccent : Colors.red,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        child: Column(
          children: [
            SizedBox(height: 100),
            GestureDetector(
              onPanUpdate: handleSwipe,
              onTap: handleLeftClick,
              child: Container(
                height: 300,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.blue.shade300,
                  borderRadius: BorderRadius.circular(16),
                ),
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
                    onPressed: handleLeftClick,
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
