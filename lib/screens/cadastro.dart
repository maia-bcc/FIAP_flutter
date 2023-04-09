import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:trabalho_final_flutter/scr/model/empregado.dart';



class Cadastro extends StatelessWidget{
  Cadastro({super.key});
  static const String id = 'cadastro_screen';

  var idDocument = ' ';
  var nome = ' ';
  var dataDeNascimento = ' ';
  var endereco = ' ';
  var telefone = ' ';
  static const enabled = true;

  var db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Person;
    if(args.documentId.isNotEmpty){
      idDocument = args.documentId;
      nome = args.name;
      dataDeNascimento = args.birthDate;
      endereco = args.address;
      telefone = args.phone;

    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Cadastro"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 30),
          child: Column(
            children: [
              TextFormField(
                initialValue: nome,
                decoration: const InputDecoration(
                  label: Text("Digite o seu nome")
                ),
                onChanged: (value) => nome = value,
              ),
              TextFormField(
                initialValue: dataDeNascimento,
                decoration: const InputDecoration(
                    label: Text("Digite a sua data de nascimento")
                ),
                onChanged: (value) => dataDeNascimento = value,
              ),
              TextFormField(
                initialValue: endereco,
                decoration: const InputDecoration(
                    label: Text("Digite o seu endereço")
                ),
                onChanged: (value) => endereco = value,
              ),
              TextFormField(
                initialValue: telefone,
                decoration: const InputDecoration(
                    label: Text("Digite o seu telefone")
                ),
                onChanged: (value) => telefone = value,
              ),
              const SizedBox(height: 10),
              ElevatedButton(style: ElevatedButton.styleFrom(
                    minimumSize: Size(100, 36),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(1000)),
                    ),
                  ),
                  onPressed: () =>
                    salvaDados(context),
                  child: const Text('Salvar',
                  style: TextStyle(
                    fontSize: 12,
                  ),
              ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  salvaDados(BuildContext context) async {
    print('Teste');
    print(idDocument);
    var col = db.collection('recursos_humanos');
    if(idDocument != ' '){
      var ref = col.doc(idDocument);
      await ref.update({
        "nome": nome,
        "data_de_aniversario": dataDeNascimento,
        "telefone":telefone,
        "endereco":endereco
      }).then((value) => Navigator.pop(context));
    }else{
      var ref = col.doc();
      await ref.set({
        "nome": nome,
        "data_de_aniversario": dataDeNascimento,
        "telefone":telefone,
        "endereco":endereco
      }).then((value) => Navigator.pop(context));
    }

  }


}