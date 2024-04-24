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
            : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        note.title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        DateFormat.yMd().format(note.createdTime),
                        style: const TextStyle(
                          color: Colors.white70,
                        ),
                      ),
                      Center(
                        child: Padding(
                          padding: EdgeInsets.all(15),
                          child: FadeInImage.memoryNetwork(
                            placeholder: kTransparentImage,
                            image: note.coverImageUrl,
                            imageErrorBuilder: (context, error, stackTrace) => Image.asset('assets/no-image.png'),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10,),
                      Text(
                        note.description,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
              ),
            ),
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