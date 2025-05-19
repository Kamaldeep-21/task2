import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:solution2/models/generator.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool _isObscure = true;
  TextEditingController copyController = TextEditingController();
  TextEditingController pasteController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  
  // Password options
  final bool _useCaps = true;
  final bool _useSmalls = true;
  final bool _useNumbers = true;
  final bool _useSymbols = true;

  @override
  void dispose() {
    copyController.dispose();
    pasteController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  void _generatePassword() {
    setState(() {
      _passwordController.text = PassGenerator().generatePass(12
        
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Generate a Password',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 73, 203, 250),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Password Text Field
              TextField(
                controller: _passwordController,
                obscureText: _isObscure,
                readOnly: true,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.lock),
                  labelText: 'Password',
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isObscure ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _isObscure = !_isObscure;
                      });
                    },
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Password Options
              

              // Generate Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _generatePassword,
                  child: const Text('Generate Password'),
                ),
              ),

              const SizedBox(height: 30),

              // Copy/Paste Section
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: TextField(
                      controller: copyController,
                      decoration: const InputDecoration(
                        labelText: 'Copy Text',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.content_copy, color: Colors.blue),
                    onPressed: () {
                      if (_passwordController.text.isEmpty) {
                        _showSnackBar('Generate a password first!');
                        return;
                      }
                      Clipboard.setData(ClipboardData(text: _passwordController.text));
                      _showSnackBar('Password copied!');
                    },
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Paste Section
              TextField(
                controller: pasteController,
                decoration: const InputDecoration(
                  labelText: 'Paste Here',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.paste),
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  final data = await Clipboard.getData(Clipboard.kTextPlain);
                  if (data?.text == null || data!.text!.isEmpty) {
                    _showSnackBar('Clipboard is empty!');
                    return;
                  }
                  setState(() {
                    pasteController.text = data.text!;
                  });
                },
                child: const Text('Paste from Clipboard'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
