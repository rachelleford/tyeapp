import 'package:flutter/material.dart';

class JournalEntries {
  static List<Map<String, String>> entries = [];

  static void addEntry(String title, String content) {
    entries.add({'title': title, 'content': content});
  }
}

class JournalEntriesView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Saved Journal Entries'),
      ),
      body: JournalEntries.entries.isEmpty
          ? Center(child: Text('No entries yet'))
          : ListView.builder(
              itemCount: JournalEntries.entries.length,
              itemBuilder: (context, index) {
                final entry = JournalEntries.entries[index];
                return ListTile(
                  title: Text(entry['title']!),
                  subtitle: Text(entry['content']!,
                      maxLines: 2, overflow: TextOverflow.ellipsis),
                  onTap: () => _showEntryDetails(context, entry),
                );
              },
            ),
    );
  }

  void _showEntryDetails(BuildContext context, Map<String, String> entry) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(entry['title']!),
          content: SingleChildScrollView(
            child: Text(entry['content']!),
          ),
          actions: [
            TextButton(
              child: Text('Close'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }
}
