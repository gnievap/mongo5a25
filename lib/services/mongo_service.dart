import 'dart:io';

import 'package:mongo5a25/models/group_model.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;

class MongoService {
  // Servicio para conectar con MongoDB Atlas
  // Usando Singleton
  static final MongoService _instance = MongoService._internal();

  late mongo.Db _db;

  MongoService._internal();

  factory MongoService() {
    return _instance;
  }

  Future<void> connect() async {
    try {
      _db = await mongo.Db.create(
          'mongodb+srv://gnieva:wdDnN11T9nUgOyaF@cluster0.1hqs0.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0');
      await _db.open();
       _db.databaseName = 'musica';
      print('Conexión a MongoDB establecida.');
    } on SocketException catch (e) {
      print('Error de conexión: $e');
    rethrow; // Vuelve a lanzar la excepción después de imprimir el mensaje
  }
  }

  mongo.Db get db {
    if (!db.isConnected) {
      throw StateError(
          'Base de datos no inicializa, llama a connect() primero');
    }
    return _db;
  }

  Future<List<GroupModel>> getGroups() async {
    final collection = _db.collection('grupos');
    print('Colección obtenida: $collection');
    var groups = await collection.find().toList();
    print('En MongoService: $groups');
    if (groups.isEmpty) {
      print('No se encontraron datos en la colección.');
    }
    return groups.map((group) => GroupModel.fromJson(group)).toList();
  }

  Future<void> deleteGroup(mongo.ObjectId id) async {
    final collection = _db.collection('grupos');
    await collection.remove(mongo.where.eq('_id', id));
  }

  Future<void> updateGroup(GroupModel group) async {
    final collection = _db.collection('grupos');
    await collection.updateOne(
      mongo.where.eq('_id', group.id),
      mongo.modify.set('name', group.name).set('type', group.type).set('albums', group.albums),
    );
  }
 

  
}
        