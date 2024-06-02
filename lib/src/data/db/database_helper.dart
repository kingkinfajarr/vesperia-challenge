import 'package:entrance_test/src/models/product_table.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper? _databaseHelper;

  DatabaseHelper._instance() {
    _databaseHelper = this;
  }

  factory DatabaseHelper() => _databaseHelper ?? DatabaseHelper._instance();

  static Database? _database;

  Future<Database?> get database async {
    _database ??= await _initDb();
    return _database;
  }

  static const String _tblProducts = 'products';

  Future<Database> _initDb() async {
    final path = await getDatabasesPath();
    final databasePath = '$path/products.db';

    var db = await openDatabase(databasePath, version: 1, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE  $_tblProducts (
        id TEXT PRIMARY KEY,
        name TEXT,
        price INTEGER,
        discount_price INTEGER,
        image TEXT
      );
    ''');
  }

  Future<int> insertFavorite(ProductTable product) async {
    final db = await database;
    return await db!.insert(_tblProducts, product.toJson());
  }

  Future<int> removeFavorite(ProductTable product) async {
    final db = await database;
    return await db!.delete(
      _tblProducts,
      where: 'id = ?',
      whereArgs: [product.id],
    );
  }

  Future<Map<String, dynamic>?> getProductById(int id) async {
    final db = await database;
    final results = await db!.query(
      _tblProducts,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> getFavoritesProduct() async {
    final db = await database;
    final List<Map<String, dynamic>> results = await db!.query(_tblProducts);

    return results;
  }
}
