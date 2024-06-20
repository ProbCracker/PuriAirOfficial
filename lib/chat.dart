import 'package:flutter/material.dart';

void main() {
  runApp(const Chat());
}

class Chat extends StatelessWidget {
  const Chat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ChatBot',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const ChatBotPage(),
    );
  }
}

class ChatBotPage extends StatefulWidget {
  const ChatBotPage({Key? key}) : super(key: key);

  @override
  _ChatBotPageState createState() => _ChatBotPageState();
}

class _ChatBotPageState extends State<ChatBotPage> {
  final List<Map<String, String>> _messages = [];
  final String _question1 = 'Mengapa menjaga kualitas udara sangat penting?';
  final String _answer1 =
      'Menjaga kualitas udara sangat penting karena udara yang kita hirup mempengaruhi kesehatan kita secara keseluruhan. Berikut beberapa alasan mengapa menjaga kualitas udara penting: \n'
      '* Mencegah penyakit pernapasan: Udara yang tercemar dapat memicu asma, bronkitis, dan penyakit paru obstruktif kronis (PPOK). \n'
      '* Mengurangi risiko penyakit jantung: Paparan polusi udara yang tinggi dapat meningkatkan risiko penyakit jantung koroner dan stroke. \n'
      '* Meningkatkan kesehatan mental: Kualitas udara yang buruk dapat berdampak negatif pada kesehatan mental, menyebabkan stres, kecemasan, dan depresi. \n'
      '* Melindungi lingkungan: Udara yang tercemar dapat merusak tanaman dan ekosistem, serta berkontribusi terhadap perubahan iklim.';

  final String _question2 = 'Bagaimana cara menjaga kualitas udara tetap baik?';
  final String _answer2 =
      'Beberapa cara untuk menjaga kualitas udara tetap baik antara lain: \n'
      '* Mengurangi penggunaan kendaraan bermotor: Pilihlah transportasi umum, bersepeda, atau berjalan kaki jika memungkinkan. \n'
      '* Mengurangi penggunaan bahan bakar fosil: Gunakan energi terbarukan dan kurangi penggunaan energi yang berasal dari bahan bakar fosil. \n'
      '* Mengurangi penggunaan produk yang menghasilkan polusi: Kurangi penggunaan bahan kimia berbahaya di rumah dan pilih produk ramah lingkungan. \n'
      '* Menanam lebih banyak pohon: Pohon dapat membantu menyerap karbon dioksida dan menghasilkan oksigen. \n'
      '* Menjaga kebersihan lingkungan: Hindari membakar sampah dan pastikan sampah dibuang di tempatnya.';

  final String _question3 = 'Bagaimana cara membuat kualitas udara ruangan membaik?';
  final String _answer3 =
      'Berikut beberapa cara untuk meningkatkan kualitas udara di dalam ruangan: \n'
      '* Ventilasi yang baik: Pastikan ruangan memiliki ventilasi yang memadai untuk mengganti udara stale dengan udara segar. \n'
      '* Gunakan penyaring udara: Pertimbangkan penggunaan penyaring udara HEPA untuk mengurangi partikel di udara. \n'
      '* Hindari penggunaan bahan kimia berbahaya: Pilih cat, pembersih, dan bahan kimia rumah tangga yang ramah lingkungan. \n'
      '* Tanam tanaman dalam ruangan: Beberapa tanaman dapat membantu menyaring udara dan meningkatkan kualitas udara di dalam ruangan. \n'
      '* Kurangi kelembapan: Gunakan dehumidifier untuk mengurangi kelembapan yang berlebihan, yang bisa menyebabkan pertumbuhan jamur.';

  void _sendMessage(String question, String answer) {
    setState(() {
      _messages.add({'role': 'user', 'text': question});
      _messages.add({'role': 'bot', 'text': answer});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ChatBot'),
        backgroundColor: Colors.teal,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Align(
                    alignment: message['role'] == 'user' ? Alignment.centerRight : Alignment.centerLeft,
                    child: Card(
                      color: message['role'] == 'user' ? Colors.blue[100] : Colors.green[100],
                      elevation: 4,
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          message['text']!,
                          style: const TextStyle(fontSize: 16.0),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Divider(thickness: 1, color: Colors.grey),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                ListTile(
                  title: TextButton(
                    onPressed: () => _sendMessage(_question1, _answer1),
                    child: Text(
                      _question1,
                      style: const TextStyle(color: Colors.blue, fontSize: 16.0),
                    ),
                  ),
                ),
                ListTile(
                  title: TextButton(
                    onPressed: () => _sendMessage(_question2, _answer2),
                    child: Text(
                      _question2,
                      style: const TextStyle(color: Colors.blue, fontSize: 16.0),
                    ),
                  ),
                ),
                ListTile(
                  title: TextButton(
                    onPressed: () => _sendMessage(_question3, _answer3),
                    child: Text(
                      _question3,
                      style: const TextStyle(color: Colors.blue, fontSize: 16.0),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
