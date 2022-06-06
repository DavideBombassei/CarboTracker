import 'dart:async';
import 'package:app19/database/daos/puzzleDao.dart';
import 'package:app19/database/entities/puzzleEntity.dart';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import 'daos/carboDao.dart';
import 'entities/carboEntity.dart';
import 'daos/puzzleDao.dart';
import 'entities/puzzleEntity.dart';

part 'database.g.dart';

@Database(version: 1, entities: [carboEntity, puzzleEntity])
abstract class AppDatabase extends FloorDatabase {
  carboDao get carbodao;
  puzzleDao get puzzledao;
}