import 'package:ebook_reader/domain/entities/book_entity.dart';

abstract class BookDataSource {
  Future<List<BookEntity>> getBooks();
}
