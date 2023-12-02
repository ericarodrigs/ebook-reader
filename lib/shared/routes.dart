import 'package:ebook_reader/presentation/bloc/get_books_bloc.dart';
import 'package:ebook_reader/presentation/book_shelf_page.dart';
import 'package:ebook_reader/shared/injector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static const root = '/';

  static final GoRouter _router = GoRouter(
    routes: [
      GoRoute(
        path: root,
        pageBuilder: (context, state) => CustomTransitionPage(
          child: BlocProvider(
              create: (context) =>
                  injector<GetBooksBloc>()..add(const GetAllBooksEvent()),
              child: const BookShelf()),
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              FadeTransition(opacity: animation, child: child),
        ),
      ),
    ],
  );

  static GoRouter get router => _router;
}
