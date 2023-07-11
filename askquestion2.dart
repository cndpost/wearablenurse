import 'dart:convert';
import 'package:http/http.dart' as http;

Future<String> askMedicalQuestion(String question) async {
  var apiKey = 'YOUR_API_KEY';
  var url = Uri.parse('https://api.openai.com/v1/engines/davinci-codex/completions');
  var headers = {
    'Authorization': 'Bearer $apiKey',
    'Content-Type': 'application/json',
  };
  var body = jsonEncode({
    'prompt': question,
    'max_tokens': 100,
  });

  var response = await http.post(url, headers: headers, body: body);

  if (response.statusCode == 200) {
    var data = jsonDecode(response.body);
    var answer = data['choices'][0]['text'];
    return answer;
  } else {
    throw Exception('Failed to get the answer');
  }
}

// Example usage:
void main() async {
  try {
    var question = "What is the treatment for diabetes?";
    var answer = await askMedicalQuestion(question);
    print('Question: $question');
    print('Answer: $answer');
  } catch (e) {
    print('Error: $e');
  }
}
