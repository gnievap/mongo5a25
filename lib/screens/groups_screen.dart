import 'package:flutter/material.dart';
import 'package:mongo5a25/models/group_model.dart';
import 'package:mongo5a25/services/mongo_service.dart';


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
    _fetchPhones();
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

  void _fetchPhones() async {
    groups = await MongoService().getGroups();
    print('En fetch: $groups');
    setState(() {});
  }


  ListTile oneTile(GroupModel group) {
    return ListTile(
      title: Text(group.name),
      subtitle: Text(group.type),
      trailing: const  Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: null,
            icon:  Icon(Icons.edit),
          ),
          IconButton(
            onPressed: null,
            icon:  Icon(Icons.delete),
          ),
        ],
      ),
    );
  }
}
