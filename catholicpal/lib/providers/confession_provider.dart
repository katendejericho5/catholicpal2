import 'package:catholicpal/models/confession_model.dart';
import 'package:catholicpal/services/confession_service.dart';
import 'package:flutter/foundation.dart';

class ExaminationProvider extends ChangeNotifier {
  final DataService _dataService = DataService();
  List<LifeStageCategory> _categories = [];
  String _selectedLifeStage = '';
  String _searchQuery = '';

  List<LifeStageCategory> get categories => _categories;
  String get selectedLifeStage => _selectedLifeStage;
  String get searchQuery => _searchQuery;

  ExaminationProvider() {
    _loadData();
  }

  Future<void> _loadData() async {
    print('Calling loadData()...');

    _categories = await _dataService.loadData();
    print('Loaded ${_categories.length} categories');
    if (_categories.isNotEmpty) {
      _selectedLifeStage = _categories[0].name;
    }
    notifyListeners();
  }

  void setSelectedLifeStage(String lifeStageName) {
    _selectedLifeStage = lifeStageName;
    notifyListeners();
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  Future<void> updateCheckpoint(String lifeStageName, String areaName,
      String questionText, bool isChecked) async {
    await _dataService.updateCheckpoint(
        lifeStageName, areaName, questionText, isChecked);
    await _loadData(); // Reload data to reflect changes
    print('Updated checkpoint: $questionText');
  }

  Future<void> clearAllCheckpoints() async {
    await _dataService.clearAllCheckpoints();

    await _loadData(); // Reload data to reflect changes
    print('Cleared all checkpoints');
  }

  List<ExaminationArea> getFilteredAreas(String lifeStageName) {
    LifeStageCategory? category = _categories.firstWhere(
        (c) => c.name == lifeStageName,
        orElse: () => LifeStageCategory(name: '', areas: []));
    List<ExaminationArea> areas = category.areas;

    if (_searchQuery.isEmpty) {
      return _sortAreas(areas);
    }

    List<ExaminationArea> filteredAreas = areas
        .map((area) {
          List<Checkpoint> filteredCheckpoints = area.checkpoints
              .where((checkpoint) => checkpoint.question
                  .toLowerCase()
                  .contains(_searchQuery.toLowerCase()))
              .toList();
          return ExaminationArea(
              name: area.name, checkpoints: filteredCheckpoints);
        })
        .where((area) => area.checkpoints.isNotEmpty)
        .toList();

    return _sortAreas(filteredAreas);
  }

  List<ExaminationArea> _sortAreas(List<ExaminationArea> areas) {
    for (var area in areas) {
      area.checkpoints.sort((a, b) {
        if (a.isChecked == b.isChecked) {
          return 0;
        }
        return a.isChecked ? -1 : 1;
      });
    }
    return areas;
  }

  double getProgress(String lifeStageName) {
    LifeStageCategory category = _categories.firstWhere(
        (c) => c.name == lifeStageName,
        orElse: () => LifeStageCategory(name: '', areas: []));
    int totalCheckpoints = 0;
    int checkedCheckpoints = 0;

    for (var area in category.areas) {
      for (var checkpoint in area.checkpoints) {
        totalCheckpoints++;
        if (checkpoint.isChecked) {
          checkedCheckpoints++;
        }
      }
    }

    return totalCheckpoints > 0 ? checkedCheckpoints / totalCheckpoints : 0.0;
  }
}
