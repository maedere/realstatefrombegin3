
import 'package:realstatefrombegin3/model/object/person.dart';

class UserRepository {
  Person user;

  UserRepository();

/*  Future<Person> login(Person user) async{
      _user = await UserApi.login(user);
      return _user;
  }

  Future<Person> register(Person user) async{
    _user = await UserApi.register(user);
    return _user;
  }*/

  void setUser(Person user) {
    this.user = user;
  }
}
