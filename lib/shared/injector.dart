import 'package:ebook_reader/data/datasources/book_local_datasource.dart';
import 'package:ebook_reader/data/datasources/book_remote_datasource.dart';
import 'package:ebook_reader/data/repositories/book_repository_impl.dart';
import 'package:ebook_reader/domain/repositories/book_repository.dart';
import 'package:ebook_reader/domain/usecases/delete_favorite_book_usecase.dart';
import 'package:ebook_reader/domain/usecases/get_books_usecase.dart';
import 'package:ebook_reader/domain/usecases/get_favorite_books_usecase.dart';
import 'package:ebook_reader/domain/usecases/insert_favorite_book_usecase.dart';
import 'package:ebook_reader/presentation/bloc/get_books/get_books_bloc.dart';
import 'package:ebook_reader/presentation/bloc/insert_favorite_books/insert_favorite_books_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

final injector = GetIt.instance;

Future<void> initDependencies() async {
  /// Data Source ///
  injector.registerLazySingleton<BookRemoteDataSource>(
      () => BookRemoteDataSourceImpl(client: injector()));
  injector.registerLazySingleton<BookLocalDataSource>(
      () => BookLocalDataSourceImpl());

  /// Repository ///
  injector.registerLazySingleton<BookRepository>(() => BookRepositoryImpl(
      localDataSource: injector(), remoteDataSource: injector()));

  /// UseCase ///
  injector.registerLazySingleton(() => GetBooksUsecase(repository: injector()));
  injector.registerLazySingleton(
      () => GetFavoriteBooksUsecase(repository: injector()));
  injector.registerLazySingleton(
      () => InsertFavoriteBookUsecase(repository: injector()));
  injector.registerLazySingleton(
      () => DeleteFavoriteBookUsecase(repository: injector()));

  ///BloC///
  injector.registerFactory(() => GetBooksBloc(usecase: injector()));
  injector.registerFactory(() => InsertFavoriteBooksBloc(usecase: injector()));

  ///Shared///
  injector.registerLazySingleton(() => http.Client());

  await injector<BookLocalDataSource>().initDb();
}
