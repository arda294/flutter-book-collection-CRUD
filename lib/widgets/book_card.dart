import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ets_ppb/model/book.dart';
import 'package:ets_ppb/pages/book_detail_page.dart';
import 'package:transparent_image/transparent_image.dart';

class BookCard extends StatelessWidget {
  final Book note;
  final Function? update;
  const BookCard(this.note, {
    this.update,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => BookDetailPage(noteId: note.id!,)
          )
        );
        if(update != null) update!();
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                DateFormat.yMd().format(note.createdTime),
                style: const TextStyle(
                  color: Colors.black38,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 5,),
              Center(
                child: FadeInImage.memoryNetwork(
                  placeholder: kTransparentImage,
                  image: note.coverImageUrl,
                  imageErrorBuilder: (context, error, stackTrace) => Image.asset('assets/no-image.png'),
                ),
              ),
              SizedBox(height: 5,),
              Text(
                note.title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}