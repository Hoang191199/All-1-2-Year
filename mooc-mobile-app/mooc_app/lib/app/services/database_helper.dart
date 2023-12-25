import 'dart:io';

import 'package:mooc_app/domain/entities/cart.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static Database? _database;
  static DatabaseHelper? databaseHelper;

  String cartTable = 'cartTable';
  String colId = 'id';
  String colCourseId = 'course_id';
  String colUserId = 'user_id';

  DatabaseHelper._createInstance();

  static final DatabaseHelper db = DatabaseHelper._createInstance();

  factory DatabaseHelper() {
    databaseHelper ??= DatabaseHelper._createInstance();
    return databaseHelper!;
  }

  Future<Database> get database async {
    _database ??= await initializeDatabase();
    return _database!;
  }

  Future<Database> initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.toString(), 'cart.db');
    var appDatabase = await openDatabase(path, version: 1, onCreate: _createDb);
    return appDatabase;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute(
      "CREATE TABLE $cartTable("
      "$colId INTEGER PRIMARY KEY AUTOINCREMENT,"
      " $colCourseId INTEGER," 
      " $colUserId INTEGER"
      ")"
    );
  }

  close() async {
    var db = await database;
    var result = db.close();
    return result;
  }

  Future<List<Cart>> getCartLocalList(int userId) async {
    var cartMapList = await getCartMapList(userId);
    // int count = await getCount(cartTable, userId);

    List<Cart> cartList = [];
    for (int i = 0; i < cartMapList.length; i++) {
      cartList.add(Cart.fromJson(cartMapList[i]));
    }
    return cartList;
  }

  Future<List<Map<String, dynamic>>> getCartMapList(int userId) async {
    Database db = await database;
    var result = await db.query(cartTable, where: "$colUserId = $userId", orderBy: "$colId DESC");
    return result;
  }

  Future<int> getCount(String tableName, int userId) async {
    Database db = await database;
    List<Map<String, dynamic>> x =
        await db.rawQuery('SELECT COUNT (*) from $tableName WHERE $colUserId = $userId');
    int result = Sqflite.firstIntValue(x) ?? 0;
    return result;
  }

  Future<int> insertCart(Cart cart) async {
    Database db = await database;
    var result = await db.insert(cartTable, cart.toJson());
    return result;
  }

  Future<int> deleteCart(int id) async {
    var db = await database;
    int result = await db.delete(cartTable, where: '$colId = ?', whereArgs: [id]);
    return result;
  }
}