part of 'insert_favorite_books_bloc.dart';

@freezed
class InsertFavoriteBooksState with _$InsertFavoriteBooksState {
  const factory InsertFavoriteBooksState.initial() = _Initial;
  const factory InsertFavoriteBooksState.loading() = _Loading;
  const factory InsertFavoriteBooksState.loaded() = _Loaded;
  const factory InsertFavoriteBooksState.error() = _Failed;
}
