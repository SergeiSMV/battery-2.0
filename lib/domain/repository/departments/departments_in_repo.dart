


import '../../models/accesses/accesses.dart';

abstract class DepartmentsInRepository{

  int inQuantity(Accesses? allAccesses, String depence);

  List departmentsAccesses(Accesses? allAccesses, String depence);

}