import 'package:ebook_reader/domain/entities/book_entity.dart';
import 'package:ebook_reader/shared/text_styles.dart';
import 'package:flutter/material.dart';

class GridViewBooks extends StatelessWidget {
  final List<BookEntity>? books;
  const GridViewBooks({
    Key? key,
    this.books,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisExtent: 300,
        ),
        itemCount: books?.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            //onTap: () => GoRouter.of(context).go(AppRouter.registerTruck),
            child: Column(
              children: [
                Image.network(
                  books?[index].coverUrl ?? '',
                  fit: BoxFit.cover,
                  cacheWidth: 150,
                  cacheHeight: 200,
                ),
                const SizedBox(height: 8),
                Text(
                  'Título: ${books?[index].title ?? ''}',
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.bold14BlueGrey700(),
                ),
                const SizedBox(height: 8),
                Text(
                  'Autor: ${books?[index].author ?? ''}',
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.bold14BlueGrey700(),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
