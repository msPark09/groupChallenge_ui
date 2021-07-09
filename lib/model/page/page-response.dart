import 'pageable.dart';
import 'sort.dart';

class PageResponse{
  dynamic content;
  Pageable pageable;
  Sort sort;
  int totalPages;
  int totalElements;
  int numberOfElements;
  int number;
  int size;
  bool first;
  bool last;
  bool empty;

  PageResponse.fromJson(Map<String, dynamic> json) {
    content = json['content'];
    pageable = Pageable.fromJson(json['pageable']);
    sort = Sort.fromJson(json['sort']);
    totalPages = json['totalPages'];
    totalElements = json['totalElements'];
    numberOfElements = json['numberOfElements'];
    number = json['number'];
    size = json['size'];
    first = json['first'];
    last = json['last'];
    empty = json['empty'];
  }
}