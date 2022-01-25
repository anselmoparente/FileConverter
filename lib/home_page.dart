import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:file_converter/hex.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final dictionary = BrailleDictionary();

  String? path = 'storage/emulated/0/Teste/braille.txt';

  File? file;

  String text = '';

  List<String> content = [];

  List<List<String>> conteudo = [];

  Map<String, dynamic> toJson(List<List<String>> conteudoNtb) {
    return {
      'meta': {'author': '', 'title': ''},
      'pages': [
        for (int i = 0; i < conteudoNtb.length; i++)
          {
            'index': i,
            'size': {'width': 34, 'height': 28},
            'lines': [
              for (int j = 0; j < conteudoNtb[i].length; j++)
                {'id': j, 'content': conteudoNtb[i][j]}
            ],
          }
      ]
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Converter'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          Center(
            child: TextButton(
              onPressed: () async {
                Permission.manageExternalStorage.request();
              },
              child: const Text('Permissão'),
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          Center(
            child: TextButton(
              onPressed: () async {
                file = File(path!);
                text = await file!.readAsString();
              },
              child: const Text('Carregar Arquivo'),
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          Center(
            child: TextButton(
              onPressed: () async {
                text = dictionary.translateStringToHex(text);
              },
              child: const Text('Converter para Hexa do Braille'),
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          Center(
            child: TextButton(
              onPressed: () async {
                counterLinesNtb(value: text);
                counterPagesNtb(content);
              },
              child: const Text('Formatar conteúdo'),
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          Center(
            child: TextButton(
              onPressed: () {
                log(text);
                log(content.toString());
                log(conteudo.toString());
              },
              child: const Text('Verificar conteúdo'),
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          Center(
            child: TextButton(
              onPressed: () async {
                File fileNTB = File('/storage/emulated/0/Teste/braille.ntb');
                fileNTB.createSync();
                Map<String, dynamic> contentTeste = toJson(conteudo);
                fileNTB.writeAsStringSync(json.encode(contentTeste),
                    mode: FileMode.append);
              },
              child: const Text('Salvar arquivo'),
            ),
          ),
        ],
      ),
    );
  }

  void counterLinesNtb({required String value}) {
    if (value.length > 68) {
      int? length = value.length;
      int? tamList = length ~/ 68;
      for (int i = 0; i < tamList; i++) {
        content.add(value.substring(i * 68, (i + 1) * 68));
        if (i == (tamList - 1)) {
          content.add(value.substring((i + 1) * 68));
        }
      }
    } else {
      content.add(value);
    }
  }

  void counterPagesNtb(List<String> value) {
    int? pagesNtb;
    List<String> list = [];
    int totalLines = value.length;
    if (totalLines > 28) {
      pagesNtb = ((totalLines ~/ 28) + 1);
      for (int i = 0; i < (pagesNtb - 1); i++) {
        for (int j = (i * 28); j < ((i + 1) * 28); j++) {
          list.add(value[j]);
        }
        conteudo.insert(i, list);
        list = [];
      }
      for (int k = (pagesNtb - 1) * 28; k < totalLines; k++) {
        list.add(value[k]);
      }
      conteudo.insert((pagesNtb - 1), list);
      list = [];
    } else {
      pagesNtb = 1;
      conteudo.add(value);
    }
  }
}
