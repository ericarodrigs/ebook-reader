import 'package:ebook_reader/domain/entities/book_entity.dart';
import 'package:flutter/material.dart';

class GridViewBooks extends StatelessWidget {
  final List<BookEntity>? books;
  const GridViewBooks({
    Key? key,
    this.books,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Center(
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          itemCount: books?.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                //onTap: () => GoRouter.of(context).go(AppRouter.registerTruck),
                child: Container(
                  width: 20,
                  height: 20,
                  color: Colors.blueGrey.withOpacity(0.5),
                  child: Image.network(books?[index].coverUrl ?? ''),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
