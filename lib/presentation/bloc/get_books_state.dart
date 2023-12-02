part of 'get_books_bloc.dart';

@freezed
class GetBooksState with _$GetBooksState {
  const factory GetBooksState.initial() = _Initial;
  const factory GetBooksState.loading() = _Loading;
  const factory GetBooksState.loaded(List<BookEntity> books) = _Loaded;
  const factory GetBooksState.error() = _Failed;
}
