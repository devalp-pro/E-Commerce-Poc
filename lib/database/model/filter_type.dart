import 'package:equatable/equatable.dart';

class FilterType {
  final String filterName;
  int selectedCount = 0;

  bool selected = false;

  FilterType(this.filterName, {this.selected = false, this.selectedCount = 0});

  FilterType clone() => new FilterType(this.filterName, selectedCount: this.selectedCount, selected: this.selected);
}
