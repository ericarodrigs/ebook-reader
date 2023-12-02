part of 'get_books_bloc.dart';

@freezed
class GetBooksEvent with _$GetBooksEvent {
  const factory GetBooksEvent.getBooks() = GetAllBooksEvent;
}
