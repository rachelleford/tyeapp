import 'package:flutter/material.dart';
import 'package:business_course/chapter1/oneone.dart';
import 'journalentries.dart';

class JournalMain extends StatelessWidget {
  final List<Map<String, String>> journalEntries = [
    {
      'title': '1.1. The connections between personal and business finances',
      'prompt': 'Identify one personal financial habit to improve.'
    },
    {
      'title': '1.2 Budgeting basics',
      'prompt': 'Create a basic monthly budget for your personal finances.'
    },
    {
      'title': '1.3 Financial goal setting',
      'prompt': 'Set one short-term and one long-term financial goal.'
    },
    {
      'title': '1.4 Understanding cash flow',
      'prompt': 'Analyze your personal cash flow for the past month.'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Journal Entries'),
      ),
      body: ListView.builder(
        itemCount: journalEntries.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(journalEntries[index]['title']!),
            onTap: () {
              if (index == 0) {
                // If it's the first entry (1.1), navigate to OneOne page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => OneOne()),
                );
              } else {
                // For other entries, show the dialog as before
                _showEntryDialog(context, journalEntries[index]);
              }
            },
          );
        },
      ),
    );
  }

  void _showEntryDialog(BuildContext context, Map<String, String> entry) {
    final TextEditingController _controller = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(entry['title']!),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Prompt: ${entry['prompt']}'),
              SizedBox(height: 10),
              TextField(
                controller: _controller,
                maxLines: 5,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter your response here',
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: Text('Submit'),
              onPressed: () {
                // Save the entry
                JournalEntries.addEntry(entry['title']!, _controller.text);
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Journal entry saved')),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
