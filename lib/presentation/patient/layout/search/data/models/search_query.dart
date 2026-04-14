class SearchQuery {
  final String searchText;
  final String specialization;
  final String gender;
  final String location;

  const SearchQuery({
    this.searchText = "",
    this.specialization = "",
    this.gender = "",
    this.location = "",
  });

  SearchQuery copyWith({
    String? searchText,
    String? specialization,
    String? gender,
    String? location,
  }) {
    return SearchQuery(
      searchText: searchText ?? this.searchText,
      specialization: specialization ?? this.specialization,
      gender: gender ?? this.gender,
      location: location ?? this.location,
    );
  }

  bool get isEmpty =>
      searchText.isEmpty &&
          specialization.isEmpty &&
          gender.isEmpty &&
          location.isEmpty;
}