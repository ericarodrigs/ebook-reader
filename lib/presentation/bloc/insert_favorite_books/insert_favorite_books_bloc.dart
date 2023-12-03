import 'package:ebook_reader/domain/entities/book_entity.dart';
import 'package:ebook_reader/domain/usecases/insert_favorite_book_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'insert_favorite_books_bloc.freezed.dart';
part 'insert_favorite_books_event.dart';
part 'insert_favorite_books_state.dart';

class InsertFavoriteBooksBloc
    extends Bloc<InsertFavoriteBooksEvent, InsertFavoriteBooksState> {
  final InsertFavoriteBookUsecase usecase;

  InsertFavoriteBooksBloc({
    required this.usecase,
  }) : super(const InsertFavoriteBooksState.initial()) {
    on<InsertFavoriteBooksEvent>((event, emit) async {
      if (event is InsertOneFavoriteBooksEvent) {
        emit(const InsertFavoriteBooksState.loading());
        final result = await usecase(
          Params(book: event.book),
        );
        result.fold(
          (l) => emit(
            const InsertFavoriteBooksState.error(),
          ),
          (r) => emit(
            const InsertFavoriteBooksState.loaded(),
          ),
        );
      }
    });
  }
}
