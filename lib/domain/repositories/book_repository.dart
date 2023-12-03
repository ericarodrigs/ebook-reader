import 'package:dartz/dartz.dart';
import 'package:ebook_reader/domain/entities/book_entity.dart';
import 'package:ebook_reader/shared/failure.dart';

abstract class BookRepository {
  Future<Either<Failure, List<BookEntity>>> getBooks();
  Future<Either<Failure, List<BookEntity>>> getFavoriteBooks();
  Future<Either<Failure, bool>> insertFavoriteBooks(BookEntity book);
  Future<Either<Failure, bool>> deleteFavoriteBooks(int bookId);
}
