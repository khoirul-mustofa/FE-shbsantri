import '../../../infrastructure/dal/daos/remote/param.dart';

class DetailNewsParam extends ToJson {
  final int id;

  DetailNewsParam({required this.id});

  @override
  Map<String, dynamic> toJson() => {
        'id': id,
      }..removeWhere((key, value) => value == null || value == '');
}
