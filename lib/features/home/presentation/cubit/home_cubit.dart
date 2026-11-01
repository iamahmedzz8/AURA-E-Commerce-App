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
