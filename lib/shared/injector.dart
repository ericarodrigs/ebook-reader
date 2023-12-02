import 'package:ebook_reader/data/datasources/book_datasource.dart';
import 'package:ebook_reader/data/datasources/book_remote_datasource_impl.dart';
import 'package:ebook_reader/data/repositories/book_repository_impl.dart';
import 'package:ebook_reader/domain/repositories/book_repository.dart';
import 'package:ebook_reader/domain/usecases/get_books_usecase.dart';
import 'package:ebook_reader/presentation/bloc/get_books_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

final injector = GetIt.instance;

Future<void> initDependencies() async {
  /// Data Source ///
  injector.registerLazySingleton<BookDataSource>(
      () => BookRemoteDataSourceImpl(client: injector()));

  /// Repository ///
  injector.registerLazySingleton<BookRepository>(
      () => BookRepositoryImpl(dataSource: injector()));

  /// UseCase ///
  injector.registerLazySingleton(() => GetBooksUsecase(repository: injector()));

  ///BloC///
  injector.registerFactory(() => GetBooksBloc(usecase: injector()));

  ///Shared///
  injector.registerLazySingleton(() => http.Client());
}
