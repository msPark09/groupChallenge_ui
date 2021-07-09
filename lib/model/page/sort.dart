class Sort {
  bool sorted;
  bool unsorted;
  bool empty;

  Sort.fromJson(Map<String, dynamic> json) {
    sorted = json['sorted'];
    unsorted = json['unsorted'];
    empty = json['empty'];
  }
}