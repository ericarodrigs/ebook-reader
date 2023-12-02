import 'package:dartz/dartz.dart';
import 'package:ebook_reader/data/datasources/book_datasource.dart';
import 'package:ebook_reader/domain/entities/book_entity.dart';
import 'package:ebook_reader/domain/repositories/book_repository.dart';
import 'package:ebook_reader/shared/failure.dart';

class BookRepositoryImpl implements BookRepository {
  final BookDataSource dataSource;

  BookRepositoryImpl({
    required this.dataSource,
  });

  @override
  Future<Either<Failure, List<BookEntity>>> getBooks() async {
    try {
      final response = await dataSource.getBooks();
      return Right(response);
    } on Exception {
      return Left(NoDataFailure());
    }
  }
}
