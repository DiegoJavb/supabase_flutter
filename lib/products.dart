import 'package:call_supabase/models/device.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Products extends StatefulWidget {
  const Products({Key? key}) : super(key: key);

  @override
  State<Products> createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  late Future<List<Device>> _listadoDevices;
  List<Device> devices = [];
  bool _isloading = false;

  Future<List<Device>> _getDevices() async {
    List<Device> devices = [];
    try {
      final data = await Supabase.instance.client
          .from('products')
          .select()
          .order('id', ascending: true);
      for (var element in data) {
        devices.add(
          Device(name: element['name'], id: element['id'].toString()),
        );
      }
    } catch (e) {
      throw Exception(e);
    }
    return devices;
  }

  _addDevice(device) async {
    setState(() {
      _isloading = true;
    });
    try {
      final data = await Supabase.instance.client
          .from('products')
          .insert({'name': device});

      print(data);
    } catch (e) {
      throw Exception(e);
    }
    setState(() {
      _isloading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _listadoDevices = _getDevices();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
      ),
      body: FutureBuilder<List<Device>>(
        future: _listadoDevices,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(snapshot.data![index].name),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addDevice('mouse gamer');
          setState(() {
            _listadoDevices = _getDevices();
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
