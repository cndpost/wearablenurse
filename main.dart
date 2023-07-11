import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

void main() {
  runApp(WearableNurseApp());
}

class WearableNurseApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WearableNurse',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  stt.SpeechToText _speechToText;
  bool _isListening = false;
  String _text = '';

  @override
  void initState() {
    super.initState();
    _speechToText = stt.SpeechToText();
  }

  void _listen() async {
    if (!_isListening) {
      bool available = await _speechToText.initialize();
      if (available) {
        setState(() {
          _isListening = true;
        });
        _speechToText.listen(
          onResult: (stt.SpeechRecognitionResult result) {
            setState(() {
              _text = result.recognizedWords;
            });
          },
        );
      }
    } else {
      setState(() {
        _isListening = false;
        _speechToText.stop();
      });
    }
  }

  void _askQuestion() {
    // Make API call to chatGPT with the _text variable as the question
    // Handle the response and update the UI accordingly
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('WearableNurse'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Question: $_text',
              style: TextStyle(fontSize: 20.0),
            ),
            SizedBox(height: 20.0),
            RaisedButton(
              onPressed: _listen,
              child: Icon(
                _isListening ? Icons.mic : Icons.mic_none,
                size: 36.0,
              ),
            ),
            SizedBox(height: 20.0),
            RaisedButton(
              onPressed: _askQuestion,
              child: Text(
                'Ask Question',
                style: TextStyle(fontSize: 20.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
