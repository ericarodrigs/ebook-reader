import 'package:ebook_reader/presentation/bloc/get_books/get_books_bloc.dart';
import 'package:ebook_reader/presentation/widgets/grid_view_books.dart';
import 'package:ebook_reader/shared/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookShelf extends StatelessWidget {
  const BookShelf({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    late Widget view;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Biblioteca'),
      ),
      body: BlocBuilder<GetBooksBloc, GetBooksState>(
        builder: (context, state) {
          state.when(
            initial: () => view = const Center(
              child: CircularProgressIndicator(
                color: AppColors.primary,
              ),
            ),
            loading: () => view = const Center(
              child: CircularProgressIndicator(
                color: AppColors.primary,
              ),
            ),
            loaded: (books) => view = GridViewBooks(books: books),
            error: () => view = const Center(
              child: Text('Ocorreu algum erro'),
            ),
          );
          return view;
        },
      ),
    );
  }
}
