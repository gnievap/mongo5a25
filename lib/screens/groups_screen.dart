import 'package:flutter/material.dart';
import 'package:mongo5a25/models/group_model.dart';
import 'package:mongo5a25/services/mongo_service.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;


class GroupsScreen extends StatefulWidget {
  const GroupsScreen({super.key});

  @override
  State<GroupsScreen> createState() => _GroupsScreenState();
}

class _GroupsScreenState extends State<GroupsScreen> {
  List<GroupModel> groups = [];


  @override
  void initState() {
    super.initState();
    _fetchGroups();
  }

  @override
  void dispose() {
    // Destruir esta screen cuando la app salga de esta ventana
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inventario de Teléfonos'),
      ),
      body: ListView.builder(
          itemCount: groups.length,
          itemBuilder: (context, index) {
            var group = groups[index];
            return oneTile(group);
          }),
    );
  }

  void _fetchGroups() async {
    groups = await MongoService().getGroups();
    print('En fetch: $groups');
    setState(() {});
  }

  void _deleteGroup(mongo.ObjectId id) async {
    await MongoService().deleteGroup(id);
    _fetchGroups();
  }

  ListTile oneTile(GroupModel group) {
    return ListTile(
      title: Text(group.name),
      subtitle: Text(group.type),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const IconButton(
            onPressed: null,
            icon:  Icon(Icons.edit),
          ),
          IconButton(
            onPressed: () => _deleteGroup(group.id),
            icon:  const Icon(Icons.delete),
          ),
        ],
      ),
    );
  }
}
