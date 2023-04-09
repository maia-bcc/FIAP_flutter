
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:trabalho_final_flutter/screens/cadastro.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../scr/model/empregado.dart';
import 'components/rounded_button.dart';
import 'login.dart';


class Menu extends StatefulWidget {
  static const String id = 'menu_screen';

  const Menu({Key? key}) : super(key: key);

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {


var db = FirebaseFirestore.instance;
var id = ' ';
var nome = ' ';
var dataDeNascimento = ' ';
Person person = Person(documentId: '', name: '', birthDate: '', address: '', phone: '');


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("Lista de funcionários"),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.yellow,
        child: Icon(Icons.add),
        onPressed: () =>
        {
          person.documentId = ' ',
          person.name = " ",
          person.birthDate = " ",
          person.address = " ",
          person.phone = " ",
          Navigator.of(context).pushNamed(
              Cadastro.id,
              arguments: person),
        }
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('recursos_humanos').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            return ListView.builder(
             itemCount: snapshot.data!.docs.length,
            itemBuilder: (context,index){
               DocumentSnapshot document = snapshot.data!.docs[index];
              return Card(
                margin: EdgeInsets.all(8),
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: ListTile(
                    leading: IconButton(
                      icon: const Icon(
                        Icons.edit,
                      ),
                      onPressed: () => {
                        person.documentId = snapshot.data!.docs[index].id,
                        person.name = document['nome'],
                        person.birthDate = document['data_de_aniversario'],
                        person.address = document['endereco'],
                        person.phone = document['telefone'],
                          Navigator.of(context).pushNamed(
                           Cadastro.id,
                           arguments: person),
                      },
                    ),
                    title: Text(document['nome']),
                    subtitle: Text(document['data_de_aniversario']),
                    trailing:
                    IconButton(
                      icon: const Icon(
                        Icons.delete,
                      ),
                      onPressed: () =>
                      {
                        id = snapshot.data!.docs[index].id,
                        deletaDados(id),
                      }
                    ),
                  ),
                ),
              );
            });
        },
      ),
    );

  }

deletaDados(id) async {
  var col = db.collection('recursos_humanos');
  var ref = col.doc(id);

  await ref.delete();

}
//Navigator.pop(context);

}


