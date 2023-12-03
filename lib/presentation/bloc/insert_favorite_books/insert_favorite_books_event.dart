part of 'insert_favorite_books_bloc.dart';

@freezed
class InsertFavoriteBooksEvent with _$InsertFavoriteBooksEvent {
  const factory InsertFavoriteBooksEvent.insertBooks(BookEntity book) =
      InsertOneFavoriteBooksEvent;
}
