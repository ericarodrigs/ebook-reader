import 'package:dartz/dartz.dart';
import 'package:ebook_reader/domain/entities/book_entity.dart';
import 'package:ebook_reader/domain/repositories/book_repository.dart';
import 'package:ebook_reader/shared/failure.dart';
import 'package:ebook_reader/shared/usecases.dart';
import 'package:equatable/equatable.dart';

class GetFavoriteBooksUsecase implements Usecases<List<BookEntity>, NoParams> {
  final BookRepository repository;

  GetFavoriteBooksUsecase({
    required this.repository,
  });

  @override
  Future<Either<Failure, List<BookEntity>>> call(NoParams params) async {
    return await repository.getFavoriteBooks();
  }
}

class NoParams extends Equatable {
  @override
  List<Object?> get props => throw UnimplementedError();
}
