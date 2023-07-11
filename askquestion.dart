import 'package:http/http.dart' as http;
import 'dart:convert';

// ...

void _askQuestion() async {
  String question = _text;

  // Make API call to chatGPT
  var url = Uri.parse('YOUR_CHATGPT_API_ENDPOINT');
  var headers = {'Content-Type': 'application/json'};
  var body = jsonEncode({'question': question});

  var response = await http.post(url, headers: headers, body: body);

  if (response.statusCode == 200) {
    // Handle the response
    var data = jsonDecode(response.body);
    String answer = data['answer'];

    // Update the UI with the answer
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Answer'),
          content: Text(answer),
          actions: <Widget>[
            FlatButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  } else {
    // Handle the error case
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text('Failed to get the answer.'),
          actions: <Widget>[
            FlatButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
