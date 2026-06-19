import 'package:find_me_app/core/helpers/extensions/translation_ex.dart';
import 'package:flutter/material.dart';

class CommentsPage extends StatelessWidget {
  final List<Map<String, String>> comments = [
    {
      "id": "327",
      "text": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
      "time": "1d"
    },
    {
      "id": "645",
      "text": "Sed do eiusmod tempor incididunt ut labore.",
      "time": "1d"
    },
    {
      "id": "913",
      "text": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
      "time": "1d"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("comments".ts),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Input field for new comment
            TextField(
              decoration: InputDecoration(
                labelText: "Write a comment...",
                border: OutlineInputBorder(),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
              ),
            ),
            SizedBox(height: 20),
            // Display comments
            Expanded(
              child: ListView.builder(
                itemCount: comments.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 8.0),
                    child: ListTile(
                      contentPadding: EdgeInsets.all(16.0),
                      title: Text("Member #${comments[index]['id']}"),
                      subtitle: Text(comments[index]['text'] ?? ''),
                      trailing: Text(comments[index]['time'] ?? ''),
                      onTap: () {
                        // Show comment replies or handle actions
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
