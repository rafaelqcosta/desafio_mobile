import 'package:desafio/app/models/usuario_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class LocalDB {
  String CREATE_USUARIO_TABLE_SCRIPT =
      "CREATE TABLE usuario(id INTEGER PRIMARY KEY,email TEXT, posicao_atual TEXT)";
  String TABLE_NAME = 'usuario';

  Future<Database> getDatabase() async {
    // Get a location using getDatabasesPath
    final databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'localDB.db');

    return await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      // When creating the db, create the table
      await db.execute(CREATE_USUARIO_TABLE_SCRIPT);
    });
  }

  Future create(UsuarioModel usuarioModel) async {
    try {
      final Database db = await getDatabase();

      await db.insert(
        TABLE_NAME,
        usuarioModel.toMap(),
      );
      await db.close();
    } catch (ex) {
      print(ex);
      return;
    }
  }

  Future delete(int id) async {
    try {
      final Database db = await getDatabase();

      await db.delete(
        TABLE_NAME,
        where: "id = ?",
        whereArgs: [id],
      );

      await db.close();
    } catch (ex) {
      print(ex);
      return;
    }
  }

  Future update(UsuarioModel usuarioModel) async {
    try {
      final Database db = await getDatabase();

      await db.update(
        TABLE_NAME,
        usuarioModel.toMap(),
        where: "id = ?",
        whereArgs: [usuarioModel.id],
      );

      await db.close();
    } catch (ex) {
      print(ex);
      return;
    }
  }

  Future<List<UsuarioModel>> getUsuarios() async {
    try {
      final Database db = await getDatabase();
      final List<Map<String, dynamic>> maps = await db.query(TABLE_NAME);

      return List.generate(
        maps.length,
        (i) {
          return UsuarioModel.fromMap(maps[i]);
        },
      );
      await db.close();
    } catch (ex) {
      print(ex);
      return [];
    }
  }
}
