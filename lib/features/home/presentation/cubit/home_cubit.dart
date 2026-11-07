import 'package:aura_maison_e_commerce/features/home/data/datasources/home_remote_data_source.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'home_state.dart';

export 'home_state.dart';

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
  final HomeRemoteDataSource _homeRemoteDataSource;

  OffersCubit([HomeRemoteDataSource? homeRemoteDataSource])
      : _homeRemoteDataSource = homeRemoteDataSource ?? HomeRemoteDataSource(),
        super(OffersInitialState());

  Future<void> fetchOffers() async {
    emit(OffersLoadingState());
    try {
      final offers = await _homeRemoteDataSource.getOffers();
      emit(OffersSuccessState(offers: offers));
    } catch (e) {
      emit(OffersFailureState(
        errorMessage: e.toString().replaceFirst('Exception: ', ''),
      ));
    }
  }
}

//=============Categories Cubit=====================
class CategoriesCubit extends Cubit<CategoriesState> {
  final HomeRemoteDataSource _homeRemoteDataSource;

  CategoriesCubit([HomeRemoteDataSource? homeRemoteDataSource])
      : _homeRemoteDataSource = homeRemoteDataSource ?? HomeRemoteDataSource(),
        super(CategoriesInitialState());

  Future<void> fetchCategories() async {
    emit(CategoriesLoadingState());
    try {
      final categories = await _homeRemoteDataSource.getCategories();
      emit(CategoriesSuccessState(categories: categories));
    } catch (e) {
      emit(CategoriesFailureState(
        errorMessage: e.toString().replaceFirst('Exception: ', ''),
      ));
    }
  }
}
