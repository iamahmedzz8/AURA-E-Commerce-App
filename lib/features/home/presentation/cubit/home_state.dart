import 'package:aura_maison_e_commerce/features/home/data/models/offer_model.dart';

class HomeState {
  final bool isDark;
  final int selectedTab;
  final Set<int> favorites;

  const HomeState({
    this.isDark = true,
    this.selectedTab = 0,
    this.favorites = const {},
  });

  HomeState copyWith({bool? isDark, int? selectedTab, Set<int>? favorites}) {
    return HomeState(
      isDark: isDark ?? this.isDark,
      selectedTab: selectedTab ?? this.selectedTab,
      favorites: favorites ?? this.favorites,
    );
  }
}

//=============================Offers State=========================
abstract class OffersState {}

class OffersInitialState extends OffersState {}

class OffersLoadingState extends OffersState {}

class OffersSuccessState extends OffersState {
  final List<OfferModel> offers;
  OffersSuccessState({required this.offers});
}

class OffersFailureState extends OffersState {
  final String errorMessage;
  OffersFailureState({required this.errorMessage});
}

//=============================Categories State=========================
abstract class CategoriesState {}

class CategoriesLoadingState extends CategoriesState {}

class CategoriesSuccessState extends CategoriesState {
  final List categories;
  CategoriesSuccessState({required this.categories});
}

class CategoriesFailureState extends CategoriesState {
  final String errorMessage;
  CategoriesFailureState({required this.errorMessage});
}
