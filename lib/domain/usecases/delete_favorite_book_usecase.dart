import 'package:dartz/dartz.dart';
import 'package:ebook_reader/domain/repositories/book_repository.dart';
import 'package:ebook_reader/shared/failure.dart';
import 'package:ebook_reader/shared/usecases.dart';
import 'package:equatable/equatable.dart';

class DeleteFavoriteBookUsecase implements Usecases<bool, Params> {
  final BookRepository repository;

  DeleteFavoriteBookUsecase({
    required this.repository,
  });

  @override
  Future<Either<Failure, bool>> call(Params params) async {
    return await repository.deleteFavoriteBooks(params.bookId);
  }
}

class Params extends Equatable {
  final int bookId;

  const Params({required this.bookId});

  @override
  List<Object?> get props => throw UnimplementedError();
}
