class HomeState {
  final bool isDark;
  final int selectedTab;
  final Set<int> favorites;

  const HomeState({
    this.isDark = true,
    this.selectedTab = 0,
    this.favorites = const {},
  });

  HomeState copyWith({
    bool? isDark,
    int? selectedTab,
    Set<int>? favorites,
  }) {
    return HomeState(
      isDark: isDark ?? this.isDark,
      selectedTab: selectedTab ?? this.selectedTab,
      favorites: favorites ?? this.favorites,
    );
  }
}
