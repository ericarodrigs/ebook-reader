import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:ebook_reader/domain/entities/book_entity.dart';
import 'package:ebook_reader/domain/usecases/get_books_usecase.dart';

part 'get_books_bloc.freezed.dart';
part 'get_books_event.dart';
part 'get_books_state.dart';

class GetBooksBloc extends Bloc<GetBooksEvent, GetBooksState> {
  final GetBooksUsecase usecase;

  GetBooksBloc({
    required this.usecase,
  }) : super(const GetBooksState.initial()) {
    on<GetBooksEvent>((event, emit) async {
      if (event is GetAllBooksEvent) {
        emit(const GetBooksState.loading());
        final result = await usecase(
          NoParams(),
        );
        result.fold(
          (l) => emit(
            const GetBooksState.error(),
          ),
          (r) => emit(
            GetBooksState.loaded(r),
          ),
        );
      }
    });
  }
}
