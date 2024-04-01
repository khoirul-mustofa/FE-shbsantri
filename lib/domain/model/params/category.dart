import '../../../infrastructure/dal/daos/remote/param.dart';

class CategoryBody extends RequestBody {
  final String name;

  CategoryBody({required this.name});

  @override
  Map<String, dynamic> toJson() => {'name': name};
}
