import 'package:flutter/cupertino.dart';

class FilterProvider extends ChangeNotifier {

  TextEditingController searchController = TextEditingController();
  
  String _search = '';
  String _selectedFilter = '';
  int _filterStage = -1;

  String get search => _search;
  set search(String searchValue) {
    _search = searchValue;
    notifyListeners();
  }

  String get selectedFilter => _selectedFilter;
  set selectedFilter(String selectedFilterValue) {
    _selectedFilter = selectedFilterValue;
    notifyListeners();
  }

  int get filterStage => _filterStage;
  set filterStage(int filterStageValue) {
    _filterStage = filterStageValue;
    notifyListeners();
  }

  bool get isSearching => _search.isNotEmpty;

  bool get isFiltering => _selectedFilter.isNotEmpty;

  void clear() {
    search = '';
    searchController.clear();
    selectedFilter = '';
    filterStage = -1;
  }

}