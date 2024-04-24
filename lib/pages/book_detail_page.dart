import 'package:ets_ppb/widgets/book_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:ets_ppb/db/books_database.dart';
import 'package:ets_ppb/model/book.dart';
import 'package:ets_ppb/pages/edit_books_page.dart';
import 'package:transparent_image/transparent_image.dart';

class BookDetailPage extends StatefulWidget {
  final int noteId;

  const BookDetailPage({required this.noteId, super.key});

  @override
  State<BookDetailPage> createState() => _BookDetailPageState();
}

class _BookDetailPageState extends State<BookDetailPage> {
  bool isLoading = true;
  late Book note;

  @override
  void initState() {
    super.initState();
    updateBook();
  }

  void updateBook() async {
    setState(() {
      isLoading = true;
    });
    Book loaded = await BooksDatabase.instance.readBook(widget.noteId);
    setState(() {
      isLoading = false;
      note = loaded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          deleteButton(),
          editButton(),
        ],
      ),
      body: isLoading ? const CircularProgressIndicator()
            : BookDetail(note: note),
    );
  }

  Widget deleteButton() {
    return IconButton(
      onPressed: () {
        BooksDatabase.instance.delete(note.id!);
        Navigator.pop(context);
      },
      icon: const Icon(Icons.delete)
    );
  }

  Widget editButton() {
    return IconButton(
      onPressed: () async {
        await Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => AddEditBookPage(note: note,)
          )
        );
        updateBook();
      },
      icon: const Icon(Icons.edit)
    );
  }
}

