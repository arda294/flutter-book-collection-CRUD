import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ets_ppb/model/book.dart';
import 'package:ets_ppb/pages/book_detail_page.dart';
import 'package:transparent_image/transparent_image.dart';

class BookCard extends StatelessWidget {
  final Book note;
  final Function? update;
  final int index;
  const BookCard(this.note, {
    required this.index,
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
        color: getColor(index),
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

  Color getColor(int index) {
    switch(index % 5) {
      case 0: 
        return Color.fromARGB(255, 241,245,143);
      case 1: 
        return Color.fromARGB(255, 255,169,48);
      case 2: 
        return Color.fromARGB(255, 255,50,178);
      case 3: 
        return Color.fromARGB(255, 169,237,241);
      case 4: 
        return Color.fromARGB(255, 116,237,75);
    }
    return Colors.white;
  }
}