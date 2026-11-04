import 'package:aura_maison_e_commerce/features/home/data/datasources/home_remote_data_source.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(const HomeState());

  void toggleTheme() {
    emit(state.copyWith(isDark: !state.isDark));
  }

  void toggleFavorite(int index) {
    final favorites = Set<int>.from(state.favorites);

    if (!favorites.add(index)) {
      favorites.remove(index);
    }

    emit(state.copyWith(favorites: favorites));
  }

  void changeTab(int index) {
    emit(state.copyWith(selectedTab: index));
  }
}
//=============Offers Cubit=========================
class OffersCubit extends Cubit<OffersState> {
  OffersCubit() : super(OffersLoadingState());

  Future<void> fetchOffers() async {
    HomeRemoteDataSource homeRemoteDataSource = HomeRemoteDataSource();
    emit(OffersLoadingState());
    try {
      // Simulate fetching offers from an API or database
      await homeRemoteDataSource.getOffers().then((val) {
        emit(OffersSuccessState(offers: val));
      });

    
    } on DioException catch (e) {
      emit(OffersFailureState(errorMessage: e.response?.data.toString() ?? e.toString()));
    }
  }
}
class CategoriesCubit extends Cubit<CategoriesState> {
  CategoriesCubit() : super(CategoriesLoadingState());

  Future<void> fetchCategories() async {
    HomeRemoteDataSource homeRemoteDataSource = HomeRemoteDataSource();
    emit(CategoriesLoadingState());
    try {
      // Simulate fetching categories from an API or database
      await homeRemoteDataSource.getCategories().then((val) {
        emit(CategoriesSuccessState(categories: val));
      });
    } on DioException catch (e) {
      emit(CategoriesFailureState(errorMessage: e.response?.data.toString() ?? e.toString()));
    }
  }
}
