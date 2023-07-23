// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:bookly/Features/Search/data/repos/Search_repo.dart';
import 'package:bookly/Features/search/data/repos/search_repo_impl.dart';
import 'package:equatable/equatable.dart';

import '../../../../home/data/models/book_model/book_model.dart';

part 'search_books_state.dart';

class SearchBooksCubit extends Cubit<SearchBooksState> {
  SearchBooksCubit(this.searchRepoImpl) : super(SearchBooksInitial());

  final SearchRepoImpl searchRepoImpl;

  Future<void> fetchSearchBooks({required String searchMessage}) async {
    emit(SearchBooksLoading());
    var result = await searchRepoImpl.fetchSearchBooks(searchMessage: searchMessage);
    result.fold((failure) {
      emit(SearchBooksFailure(failure.errMessage));
    }, (books) {
      emit(SearchBooksSuccess(books));
    });
  }
}
