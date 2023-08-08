import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:business/src/block_simple.config.dart';
import 'package:data/data.dart';

@InjectableInit()
void initializeBlocs(){
  initializeServices();
  $initGetIt(GetIt.I);
}