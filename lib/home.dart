import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:solution2/pass_generator.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final PassGenerator = '3J98t1WpEZ73CNmQviecrnyiWrnqRhWNLy';

  TextEditingController copyController = TextEditingController();
  TextEditingController pasteController = TextEditingController();

  @override
  void dispose() {
    copyController.dispose();
    pasteController.dispose();
    super.dispose();
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Generate/Copy/Paste',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 73, 203, 250),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(height: 30),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        ' Generate new password:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 4.0),
                      Container(
                        padding: EdgeInsets.all(15.0),
                        decoration: BoxDecoration(
                          border: Border.all(color: const Color.fromARGB(255, 34, 148, 255), width: 2.0),
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Text(PassGenerator),
                      ),
                    ],
                  ),
                  SizedBox(width: 20.0),
                  IconButton(
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: Pass));
                      _showSnackBar('Wallet address copied!');
                    },
                    icon: Icon(
                      Icons.content_copy,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 40),
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(20.0),
                  child: TextField(
                    decoration: InputDecoration(labelText: 'Copy This Input'),
                    controller: copyController,
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    Clipboard.setData(ClipboardData(text: copyController.text));
                    _showSnackBar('Text copied!');
                  },
                  label: Text('Copy'),
                  icon: Icon(Icons.content_copy),
                ),
                SizedBox(height: 10),
                ElevatedButton.icon(
                  onPressed: () async {
                    final clipPaste = await Clipboard.getData(Clipboard.kTextPlain);
                    final text = clipPaste?.text;
                    if(text == null || text.isEmpty){
                      _showSnackBar('clipboard is empty');
                    }
                    setState(() {
                      pasteController.text = text! ;
                    });
                  },
                  label: Text('Paste'),
                  icon: Icon(Icons.paste),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                  child: TextField(
                    decoration: InputDecoration(labelText: 'Paste Here'),
                    controller: pasteController,
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
