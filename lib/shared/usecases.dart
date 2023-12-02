import 'package:dartz/dartz.dart';
import 'package:ebook_reader/shared/failure.dart';

abstract class Usecases<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}
