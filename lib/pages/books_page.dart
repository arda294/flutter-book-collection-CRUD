import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:ets_ppb/db/books_database.dart';
import 'package:ets_ppb/model/book.dart';
import 'package:ets_ppb/pages/edit_books_page.dart';
import 'package:ets_ppb/widgets/book_card.dart';

class BooksPage extends StatefulWidget {
  const BooksPage({super.key});

  @override
  State<BooksPage> createState() => _BooksPageState();
}

class _BooksPageState extends State<BooksPage> {
  late List<Book> books;

  bool isLoading = false;
  bool isDatabaseError = false;

  @override
  void initState() {
    super.initState();
    refreshBooks();
  }

  void refreshBooks() async {
    setState(() => isLoading = true);

    late List<Book> list;

    try {
      list = await BooksDatabase.instance.readAllBooks();
    } catch(e) {
      isDatabaseError = true;
    }

    setState(() {
      isLoading = false;
      books = list ?? [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Books',
          style: TextStyle(
            color: Colors.white
          ),
        ),
        backgroundColor: Colors.transparent,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const AddEditBookPage(),
            )
          );

          refreshBooks();
        },
        child: const Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: isLoading ? const CircularProgressIndicator()
          : books.isEmpty ? Center(
            child:  Text(
              !isDatabaseError ? 'No Books' : 'Database Error',
              style: const TextStyle(
                color: Colors.white
              ),
            ),
          )
          : buildBooks()
      ),
    );
  }

  Widget buildBooks() => StaggeredGrid.count(
    crossAxisCount: 2,
    mainAxisSpacing: 2,
    crossAxisSpacing: 2,
    children: List.generate(books.length, (index) {
      Book note = books[index];
      return StaggeredGridTile.fit(
        crossAxisCellCount: 1,
        child: BookCard(note, index: index, update: refreshBooks,),
      );
    }),
  );
}