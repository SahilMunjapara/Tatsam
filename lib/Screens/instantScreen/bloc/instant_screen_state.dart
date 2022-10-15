abstract class InstantScreenState {}

class InstantInitialState extends InstantScreenState {}

class InstantSearchState extends InstantScreenState {
  bool isSearching;
  InstantSearchState(this.isSearching);
}

class InstantSelectSearchState extends InstantScreenState {
  bool isSelectSearching;
  InstantSelectSearchState(this.isSelectSearching);
}
