import 'package:injectable/injectable.dart';
import 'package:data/data.dart';
import 'package:model/model.dart';

@LazySingleton(as: UserService)
class PseudUserService implements UserService {

  @override
  Future<UserData> getDefaultUser() async {
    await Future<void>.delayed(
      const Duration(seconds: 1),
    );

    return const UserData(id: 1, name: 'Default user');
  }

  @override
  Future<UserData> getUserById(int id) async {
    await Future<void>.delayed(
      const Duration(seconds: 1),
    );

    return UserData(id: id, name: 'UserID $id');
  }
}