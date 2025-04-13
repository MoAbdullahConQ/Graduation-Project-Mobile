import 'package:flutter/material.dart';

class IpQrView extends StatefulWidget {
  const IpQrView({super.key});

  @override
  State<IpQrView> createState() => _IpQrViewState();
}

class _IpQrViewState extends State<IpQrView> {
  TextEditingController ip = TextEditingController();

  GlobalKey<FormState> formState = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formState,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Text(
                    'Desktop Ip',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              TextFormField(
                validator: (value) {
                  if (value == '') {
                    return 'can\'t empty';
                  }
                  return null;
                },
                controller: ip,
                keyboardType: TextInputType.url,
                decoration: InputDecoration(
                  label: Text('Enter Desktop Ip'),
                  suffixIcon: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.qr_code_scanner_rounded),
                  ),
                  hintText: "Enter Desktop Ip",
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 13,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  if (formState.currentState!.validate()) {
                    // code
                  } else {
                    print('not valid---------------');
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: Text(
                  'Go To Touchpad',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
