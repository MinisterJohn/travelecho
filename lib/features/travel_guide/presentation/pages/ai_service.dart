import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class AIService {
  // Base URL for the API router
  final String _baseUrl = 'https://router.huggingface.co/fireworks-ai';
  final String _apiKey = 'hf_xxxxxxxxxxxxxxxxxxxxxxxx'; // Replace with your actual key

  Future<String> fetchCultureAnswer(String query) async {
    // Build the complete endpoint URL for chat completions
    final String url = '$_baseUrl/chat/completions';
    
    // Set headers with authorization and content type
    final headers = {
      'Authorization': 'Bearer $_apiKey',
      'Content-Type': 'application/json',
    };

    // Create the JSON payload with the desired parameters
    final body = json.encode({
      "model": "accounts/perplexity/models/r1-1776",
      "messages": [
        {
          "role": "user",
          "content": query,
        }
      ],
      "max_tokens": 500,
      "stream": true,
    });

    // Create a streaming request using http.Request and send it
    var request = http.Request('POST', Uri.parse(url));
    request.headers.addAll(headers);
    request.body = body;

    // Send the request and await a streamed response
    final streamedResponse = await request.send();

    if (streamedResponse.statusCode == 200) {
      // Use a StringBuffer to accumulate streaming content
      StringBuffer buffer = StringBuffer();

      // The streamedResponse.stream is a stream of bytes. Decode and process it.
      await for (var chunk in streamedResponse.stream.transform(utf8.decoder)) {
        // The API might return multiple JSON objects per chunk separated by newlines.
        List<String> lines = chunk.split('\n');
        for (String line in lines) {
          if (line.isNotEmpty) {
            // If the API returns Server-Sent Events (SSE), it might prefix lines with "data: "
            String processedLine = line;
            if (processedLine.startsWith('data: ')) {
              processedLine = processedLine.substring(6).trim();
            }
            // Check for the stream termination marker if applicable
            if (processedLine == "[DONE]") {
              break;
            }
            try {
              // Parse the JSON response from the chunk
              var jsonData = json.decode(processedLine);
              // Extract the content from the delta in the first choice
              if (jsonData["choices"] != null && jsonData["choices"].isNotEmpty) {
                var delta = jsonData["choices"][0]["delta"];
                if (delta != null && delta["content"] != null) {
                  buffer.write(delta["content"]);
                }
              }
            } catch (e) {
              // If parsing fails, print error and continue processing
              print("Error parsing chunk: $e");
            }
          }
        }
      }
      return buffer.toString();
    } else {
      throw Exception('Failed to fetch AI answer. Status: ${streamedResponse.statusCode}');
    }
  }
}
