import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import 'daos/carboDao.dart';
import 'entities/carboEntity.dart';

part 'database.g.dart';

@Database(version: 1, entities: [carboEntity])
abstract class AppDatabase extends FloorDatabase {
  carboDao get carbodao;
}