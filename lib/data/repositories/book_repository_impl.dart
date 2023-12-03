import 'package:dartz/dartz.dart';
import 'package:ebook_reader/data/datasources/book_local_datasource.dart';
import 'package:ebook_reader/data/datasources/book_remote_datasource.dart';
import 'package:ebook_reader/domain/entities/book_entity.dart';
import 'package:ebook_reader/domain/repositories/book_repository.dart';
import 'package:ebook_reader/shared/failure.dart';

class BookRepositoryImpl implements BookRepository {
  final BookLocalDataSource localDataSource;
  final BookRemoteDataSource remoteDataSource;

  BookRepositoryImpl({
    required this.localDataSource,
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, List<BookEntity>>> getBooks() async {
    try {
      final response = await remoteDataSource.getBooks();
      return Right(response);
    } on Exception {
      return Left(NoDataFailure());
    }
  }

  @override
  Future<Either<Failure, List<BookEntity>>> getFavoriteBooks() async {
    try {
      final response = await localDataSource.getFavoriteBooks();
      return Right(response);
    } on Exception {
      return Left(NoDataFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> insertFavoriteBooks(BookEntity book) async {
    try {
      final response = await localDataSource.insertFavoriteBook(book);
      return Right(response);
    } on Exception {
      return Left(NoDataFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> deleteFavoriteBooks(int bookId) async {
    try {
      final response = await localDataSource.deleteFavoriteBook(bookId);
      return Right(response);
    } on Exception {
      return Left(NoDataFailure());
    }
  }
}
