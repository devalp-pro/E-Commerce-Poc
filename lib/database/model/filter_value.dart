class FilterValue {
  final String name;
  final int count;

  bool selected = false;

  FilterValue(this.name, this.count, {this.selected = false});

  FilterValue clone() => new FilterValue(this.name, this.count, selected: this.selected);
}
