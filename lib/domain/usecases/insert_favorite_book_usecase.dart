import 'package:dartz/dartz.dart';
import 'package:ebook_reader/domain/entities/book_entity.dart';
import 'package:ebook_reader/domain/repositories/book_repository.dart';
import 'package:ebook_reader/shared/failure.dart';
import 'package:ebook_reader/shared/usecases.dart';
import 'package:equatable/equatable.dart';

class InsertFavoriteBookUsecase implements Usecases<bool, Params> {
  final BookRepository repository;

  InsertFavoriteBookUsecase({
    required this.repository,
  });

  @override
  Future<Either<Failure, bool>> call(Params params) async {
    return await repository.insertFavoriteBooks(params.book);
  }
}

class Params extends Equatable {
  final BookEntity book;

  const Params({required this.book});

  @override
  List<Object?> get props => throw UnimplementedError();
}
