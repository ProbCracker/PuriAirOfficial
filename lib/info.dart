import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class Info extends StatefulWidget {
  const Info({Key? key}) : super(key: key);

  @override
  _InfoState createState() => _InfoState();
}

class _InfoState extends State<Info> {
  bool _showMicroPopup = false;
  bool _showCo2Popup = false;
  bool _showBmePopup = false;

  void _toggleMicroPopup() {
    setState(() {
      _showMicroPopup = true;
    });
    Future.delayed(Duration(seconds: 5), () {
      setState(() {
        _showMicroPopup = false;
      });
    });
  }

  void _toggleCo2Popup() {
    setState(() {
      _showCo2Popup = true;
    });
    Future.delayed(Duration(seconds: 5), () {
      setState(() {
        _showCo2Popup = false;
      });
    });
  }

  void _toggleBmePopup() {
    setState(() {
      _showBmePopup = true;
    });
    Future.delayed(Duration(seconds: 5), () {
      setState(() {
        _showBmePopup = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Informasi Aplikasi'),
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/background.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/gradient.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              AnimationLimiter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: AnimationConfiguration.toStaggeredList(
                    duration: const Duration(milliseconds: 375),
                    childAnimationBuilder: (widget) => SlideAnimation(
                      horizontalOffset: 50.0,
                      child: FadeInAnimation(
                        child: widget,
                      ),
                    ),
                    children: <Widget>[
                      buildCard(
                        'Hardware:',
                        [
                          buildListTile(
                            Icons.memory,
                            'Microcontroller: Firebeetle ESP-32 E',
                            Colors.blueAccent,
                            onTap: _toggleMicroPopup,
                          ),
                          buildDivider(),
                          buildListTile(
                            Icons.sensors,
                            'Sensor CO2: MH-Z19B',
                            Colors.green,
                            onTap: _toggleCo2Popup,
                          ),
                          buildDivider(),
                          buildListTile(
                            Icons.thermostat,
                            'Sensor untuk suhu, kelembaban, dan tekanan: BME280',
                            Colors.red,
                            onTap: _toggleBmePopup,
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      buildCard(
                        'Aplikasi ini dibuat dengan:',
                        [
                          buildListTile(Icons.code, 'Flutter sebagai framework pengembangan UI', Colors.orange),
                          buildDivider(),
                          buildListTile(Icons.build, 'Controller yang digunakan:', Colors.purple),
                          Padding(
                            padding: const EdgeInsets.only(left: 40),
                            child: Text('Arduino IDE untuk meng-upload program ke ESP32'),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      buildCard(
                        'Versi Aplikasi:',
                        [
                          buildListTile(Icons.info, 'Versi 1.0', Colors.teal),
                        ],
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

  Widget buildCard(String title, List<Widget> children) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            SizedBox(height: 10),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget buildListTile(IconData icon, String text, Color iconColor, {Function()? onTap}) {
    return ListTile(
      leading: Icon(icon, color: iconColor),
      title: Text(text),
      onTap: onTap,
    );
  }

  Widget buildDivider() {
    return Divider();
  }
}

void main() {
  runApp(MaterialApp(
    home: Info(),
  ));
}
