import 'package:business_course/documentviewerpage.dart';
import 'package:flutter/material.dart';

class DocumentPage extends StatelessWidget {
  final List<Document> documents = [
    Document('Document 1', 'https://example.com/doc1.pdf'),
    Document('Document 2', 'https://example.com/doc2.pdf'),
    Document('Document 3', 'https://example.com/doc3.pdf'),
    Document('Document 3', 'https://example.com/doc3.pdf'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Documents')),
      body: ListView.builder(
        itemCount: documents.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(documents[index].name),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DocumentViewerPage(documents[index]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class Document {
  final String name;
  final String url;

  Document(this.name, this.url);
}
