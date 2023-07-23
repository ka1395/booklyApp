

import 'package:dartz/dartz.dart';

import 'package:bookly/core/errors/failures.dart';
import 'package:dio/dio.dart';



import '../../../../core/utils/api_service.dart';
import '../../../home/data/models/book_model/book_model.dart';
import 'search_repo.dart';

class SearchRepoImpl implements SearchRepo{
 final ApiService apiService;

  SearchRepoImpl(this.apiService);
  @override
  Future<Either<Failure, List<BookModel>>> fetchSearchBooks({required String searchMessage})async {
     
    try {
      var data = await apiService.get(
          endPoint:
              'volumes?q=${searchMessage}');
      List<BookModel> books = [];
      for (var item in data['items']) {
        books.add(BookModel.fromJson(item));
      }

      return right(books);
    } catch (e) {
      if (e is DioError) {
        return left(
          ServerFailure.fromDioError(e),
        );
      }
      return left(
        ServerFailure(
          e.toString(),
        ),
      );
    }
  }
  }

// class HomeRepoImpl implements HomeRepo {
//   final ApiService apiService;

//   HomeRepoImpl(this.apiService);
//   @override
//   Future<Either<Failure, List<BookModel>>> fetchNewsetBooks() async {
//     try {
//       var data = await apiService.get(
//           endPoint:
//               'volumes?Filtering=free-ebooks&Sorting=newest &q=computer science');
//       List<BookModel> books = [];
//       for (var item in data['items']) {
//         try {
//           books.add(BookModel.fromJson(item));
//         } catch (e) {
//           books.add(BookModel.fromJson(item));
//         }
//       }

//       return right(books);
//     } catch (e) {
//       if (e is DioError) {
//         return left(
//           ServerFailure.fromDioError(e),
//         );
//       }
//       return left(
//         ServerFailure(
//           e.toString(),
//         ),
//       );
//     }
//   }

//   @override
//   Future<Either<Failure, List<BookModel>>> fetchFeaturedBooks() async {
//     try {
//       var data = await apiService.get(
//           endPoint: 'volumes?Filtering=free-ebooks&q=subject:Programming');
//       List<BookModel> books = [];
//       for (var item in data['items']) {
//         books.add(BookModel.fromJson(item));
//       }

//       return right(books);
//     } catch (e) {
//       if (e is DioError) {
//         return left(
//           ServerFailure.fromDioError(e),
//         );
//       }
//       return left(
//         ServerFailure(
//           e.toString(),
//         ),
//       );
//     }
//   }

//   @override
//   Future<Either<Failure, List<BookModel>>> fetchSimilarBooks(
//       {required String category}) async {
//     try {
//       var data = await apiService.get(
//           endPoint:
//               'volumes?Filtering=free-ebooks&Sorting=relevance &q=subject:Programming');
//       List<BookModel> books = [];
//       for (var item in data['items']) {
//         books.add(BookModel.fromJson(item));
//       }

//       return right(books);
//     } catch (e) {
//       if (e is DioError) {
//         return left(
//           ServerFailure.fromDioError(e),
//         );
//       }
//       return left(
//         ServerFailure(
//           e.toString(),
//         ),
//       );
//     }
//   }
// }
