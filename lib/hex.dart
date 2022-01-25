import 'dart:convert';
import 'dart:core';

///Static class that translated from braille cell states for the corresponding characters
class BrailleDictionary {
  ///Map of characters to translate
  static final Map<String, String> _brailleMap = {
    '00': " ",
    '80': "A",
    'C0': "B",
    '90': "C",
    '98': "D",
    '88': "E",
    'D0': "F",
    'D8': "G",
    'C8': "H",
    '50': "I",
    '58': "J",
    'A0': "K",
    'E0': "L",
    'B0': "M",
    'B8': "N",
    'A8': "O",
    'F0': "P",
    'F8': "Q",
    'E8': "R",
    '70': "S",
    '78': "T",
    'A4': "U",
    'E4': "V",
    '5C': "W",
    'B4': "X",
    'BC': "Y",
    'AC': "Z",
    'F4': "Ç", //"Cedilha";
    'FC': "É", //"E com Acento Agudo";
    'EC': "Á", //"A com Acento Agudo";
    '74': "È", //"E Craseado";
    '84': "Â", //"A com Acento Circunflexo";
    'C4': "Ê", //"E com Acento Circunflexo";
    '94': "Ì", //"I Craseado";
    '9C': "Ô", //"O com Acento Circunflexo";
    '8C': "Ù", //"U Craseado";
    'D4': "À", //"A Craseado";
    '54': "Õ", //"O com Til";
    '30': "Í", //"I Com Acento Agudo ";
    '34': "Ó", //"O com Acento Agudo";
    '38': "Ã", //"A com Til";
    '3C': "№", //"Numeral";
    '24': "-", //"Hífen";
    '20': "'", //"Apóstrofo";
    '40': ",", //"Vírgula";
    '14': "˄", //"Maiúsculo";
    '60': ";", //"Ponto e Vírgula";
    '48': ":", //"Dois Pontos";
    '4C': ".", //"Ponto";
    '44': "?", //"Ponto de Interrogação";
    '68': "!", //"Ponto de Exclamação";
    '6C': "(", //"Parênteses";
    '64': '"', //Aspas";
    '28': "*",
  };

  static final Map<String, String> _brailleNumber = {
    '58': "0",
    '80': "1",
    'C0': "2",
    '90': "3",
    '98': "4",
    '88': "5",
    'D0': "6",
    'D8': "7",
    'C8': "8",
    '50': "9",
  };

  static final Map<String, String> _charToBrailleMap = {
    " ": '00',
    "0": '1a',
    "1": '01',
    "2": '03',
    "3": '09',
    "4": '19',
    "5": '11',
    "6": '0b',
    "7": '1b',
    "8": '13',
    "9": '0a',
    "A": '01',
    "B": '03',
    "C": '09',
    "D": '19',
    "E": '11',
    "F": '0b',
    "G": '1b',
    "H": '13',
    "I": '0a',
    "J": '1a',
    "K": '05',
    "L": '07',
    "M": '0d',
    "N": '1d',
    "O": '15',
    "P": '0f',
    "Q": '1f',
    "R": '17',
    "S": '0e',
    "T": '1e',
    "U": '25',
    "V": '27',
    "W": '3a',
    "X": '2d',
    "Y": '3d',
    "Z": '35',
    "Ç": '2f', //"Cedilha";
    "Á": '37', //"A com Acento Agudo";
    "É": '3f', //"E com Acento Agudo";
    "Í": '0c', //"I Com Acento Agudo ";
    "Ó": '0d', //"O com Acento Agudo";
    "Ú": '3e', //"U com Acento Agudo";
    "Â": '21', //"A com Acento Circunflexo";
    "Ê": '23', //"E com Acento Circunflexo";
    "Ô": '39', //"O com Acento Circunflexo";
    "À": '2b', //"A Craseado";
    "Ã": '1c', //"A com Til";
    "Õ": '2a', //"O com Til";
    ",": '02', //"Vírgula";
    ";": '06', //"Ponto e Vírgula";
    ".": '04', //"Ponto";
    ":": '12', //"Dois Pontos";
    "?": '22', //"Ponto de Interrogação";
    "!": '16', //"Ponto de Exclamação";
    "-": '24', //"Hífen";
    "˄": '28', //"Maiúsculo";
    "№": '3C', //"Numeral";
  };

  static final Map<String, String> _brailleNumberToString = {
    utf8.decode([0xE2, 0xA0, 0x9A]): "0",
    utf8.decode([0xE2, 0xA0, 0x81]): "1",
    utf8.decode([0xE2, 0xA0, 0x83]): "2",
    utf8.decode([0xE2, 0xA0, 0x89]): "3",
    utf8.decode([0xE2, 0xA0, 0x99]): "4",
    utf8.decode([0xE2, 0xA0, 0x91]): "5",
    utf8.decode([0xE2, 0xA0, 0x8B]): "6",
    utf8.decode([0xE2, 0xA0, 0x9B]): "7",
    utf8.decode([0xE2, 0xA0, 0x93]): "8",
    utf8.decode([0xE2, 0xA0, 0x8A]): "9",
  };

  static final Map<dynamic, String> _brailleToHex = {
    ' ': '00',
    '|': '7c',
    utf8.decode([0xE2, 0xA0, 0x81]): '01',
    utf8.decode([0xE2, 0xA0, 0x82]): '02',
    utf8.decode([0xE2, 0xA0, 0x83]): '03',
    utf8.decode([0xE2, 0xA0, 0x84]): '04',
    utf8.decode([0xE2, 0xA0, 0x85]): '05',
    utf8.decode([0xE2, 0xA0, 0x86]): '06',
    utf8.decode([0xE2, 0xA0, 0x87]): '07',
    utf8.decode([0xE2, 0xA0, 0x88]): '08',
    utf8.decode([0xE2, 0xA0, 0x89]): '09',
    utf8.decode([0xE2, 0xA0, 0x8A]): '0a',
    utf8.decode([0xE2, 0xA0, 0x8B]): '0b',
    utf8.decode([0xE2, 0xA0, 0x8C]): '0c',
    utf8.decode([0xE2, 0xA0, 0x8D]): '0d',
    utf8.decode([0xE2, 0xA0, 0x8E]): '0e',
    utf8.decode([0xE2, 0xA0, 0x8F]): '0f',
    utf8.decode([0xE2, 0xA0, 0x90]): '10',
    utf8.decode([0xE2, 0xA0, 0x91]): '11',
    utf8.decode([0xE2, 0xA0, 0x92]): '12',
    utf8.decode([0xE2, 0xA0, 0x93]): '13',
    utf8.decode([0xE2, 0xA0, 0x94]): '14',
    utf8.decode([0xE2, 0xA0, 0x95]): '15',
    utf8.decode([0xE2, 0xA0, 0x96]): '16',
    utf8.decode([0xE2, 0xA0, 0x97]): '17',
    utf8.decode([0xE2, 0xA0, 0x98]): '18',
    utf8.decode([0xE2, 0xA0, 0x99]): '19',
    utf8.decode([0xE2, 0xA0, 0x9A]): '1a',
    utf8.decode([0xE2, 0xA0, 0x9B]): '1b',
    utf8.decode([0xE2, 0xA0, 0x9C]): '1c',
    utf8.decode([0xE2, 0xA0, 0x9D]): '1d',
    utf8.decode([0xE2, 0xA0, 0x9E]): '1e',
    utf8.decode([0xE2, 0xA0, 0x9F]): '1f',
    utf8.decode([0xE2, 0xA0, 0xA0]): '20',
    utf8.decode([0xE2, 0xA0, 0xA1]): '21',
    utf8.decode([0xE2, 0xA0, 0xA2]): '22',
    utf8.decode([0xE2, 0xA0, 0xA3]): '23',
    utf8.decode([0xE2, 0xA0, 0xA4]): '24',
    utf8.decode([0xE2, 0xA0, 0xA5]): '25',
    utf8.decode([0xE2, 0xA0, 0xA6]): '26',
    utf8.decode([0xE2, 0xA0, 0xA7]): '27',
    utf8.decode([0xE2, 0xA0, 0xA8]): '28',
    utf8.decode([0xE2, 0xA0, 0xA9]): '29',
    utf8.decode([0xE2, 0xA0, 0xAA]): '2a',
    utf8.decode([0xE2, 0xA0, 0xAB]): '2b',
    utf8.decode([0xE2, 0xA0, 0xAC]): '2c',
    utf8.decode([0xE2, 0xA0, 0xAD]): '2d',
    utf8.decode([0xE2, 0xA0, 0xAE]): '2e',
    utf8.decode([0xE2, 0xA0, 0xAF]): '2f',
    utf8.decode([0xE2, 0xA0, 0xB0]): '30',
    utf8.decode([0xE2, 0xA0, 0xB1]): '31',
    utf8.decode([0xE2, 0xA0, 0xB2]): '32',
    utf8.decode([0xE2, 0xA0, 0xB3]): '33',
    utf8.decode([0xE2, 0xA0, 0xB4]): '34',
    utf8.decode([0xE2, 0xA0, 0xB5]): '35',
    utf8.decode([0xE2, 0xA0, 0xB6]): '36',
    utf8.decode([0xE2, 0xA0, 0xB7]): '37',
    utf8.decode([0xE2, 0xA0, 0xB8]): '38',
    utf8.decode([0xE2, 0xA0, 0xB9]): '39',
    utf8.decode([0xE2, 0xA0, 0xBA]): '3a',
    utf8.decode([0xE2, 0xA0, 0xBB]): '3b',
    utf8.decode([0xE2, 0xA0, 0xBC]): '3c',
    utf8.decode([0xE2, 0xA0, 0xBD]): '3d',
    utf8.decode([0xE2, 0xA0, 0xBE]): '3e',
    utf8.decode([0xE2, 0xA0, 0xBF]): '3f',
  };

  static final Map<dynamic, String> _brailleToString = {
    ' ': ' ',
    utf8.decode([0xE2, 0xA0, 0x81]): 'a',
    utf8.decode([0xE2, 0xA0, 0x82]): ',',
    utf8.decode([0xE2, 0xA0, 0x83]): 'b',
    utf8.decode([0xE2, 0xA0, 0x84]): '.',
    utf8.decode([0xE2, 0xA0, 0x85]): 'k',
    utf8.decode([0xE2, 0xA0, 0x86]): ';',
    utf8.decode([0xE2, 0xA0, 0x87]): 'l',
    utf8.decode([0xE2, 0xA0, 0x88]): '',
    utf8.decode([0xE2, 0xA0, 0x89]): 'c',
    utf8.decode([0xE2, 0xA0, 0x8A]): 'i',
    utf8.decode([0xE2, 0xA0, 0x8B]): 'f',
    utf8.decode([0xE2, 0xA0, 0x8C]): 'í',
    utf8.decode([0xE2, 0xA0, 0x8D]): 'm',
    utf8.decode([0xE2, 0xA0, 0x8E]): 's',
    utf8.decode([0xE2, 0xA0, 0x8F]): 'p',
    utf8.decode([0xE2, 0xA0, 0x90]): '',
    utf8.decode([0xE2, 0xA0, 0x91]): 'e',
    utf8.decode([0xE2, 0xA0, 0x92]): ':',
    utf8.decode([0xE2, 0xA0, 0x93]): 'h',
    utf8.decode([0xE2, 0xA0, 0x94]): '',
    utf8.decode([0xE2, 0xA0, 0x95]): 'o',
    utf8.decode([0xE2, 0xA0, 0x96]): '!',
    utf8.decode([0xE2, 0xA0, 0x97]): 'r',
    utf8.decode([0xE2, 0xA0, 0x98]): '',
    utf8.decode([0xE2, 0xA0, 0x99]): 'd',
    utf8.decode([0xE2, 0xA0, 0x9A]): 'j',
    utf8.decode([0xE2, 0xA0, 0x9B]): 'g',
    utf8.decode([0xE2, 0xA0, 0x9C]): 'ã',
    utf8.decode([0xE2, 0xA0, 0x9D]): 'n',
    utf8.decode([0xE2, 0xA0, 0x9E]): 't',
    utf8.decode([0xE2, 0xA0, 0x9F]): 'q',
    utf8.decode([0xE2, 0xA0, 0xA0]): '',
    utf8.decode([0xE2, 0xA0, 0xA1]): 'â',
    utf8.decode([0xE2, 0xA0, 0xA2]): '?',
    utf8.decode([0xE2, 0xA0, 0xA3]): 'ê',
    utf8.decode([0xE2, 0xA0, 0xA4]): '-',
    utf8.decode([0xE2, 0xA0, 0xA5]): 'u',
    utf8.decode([0xE2, 0xA0, 0xA6]): '',
    utf8.decode([0xE2, 0xA0, 0xA7]): 'v',
    utf8.decode([0xE2, 0xA0, 0xA8]): '',
    utf8.decode([0xE2, 0xA0, 0xA9]): '',
    utf8.decode([0xE2, 0xA0, 0xAA]): 'õ',
    utf8.decode([0xE2, 0xA0, 0xAB]): 'à',
    utf8.decode([0xE2, 0xA0, 0xAC]): '',
    utf8.decode([0xE2, 0xA0, 0xAD]): 'x',
    utf8.decode([0xE2, 0xA0, 0xAE]): '',
    utf8.decode([0xE2, 0xA0, 0xAF]): 'ç',
    utf8.decode([0xE2, 0xA0, 0xB0]): '',
    utf8.decode([0xE2, 0xA0, 0xB1]): '',
    utf8.decode([0xE2, 0xA0, 0xB2]): '',
    utf8.decode([0xE2, 0xA0, 0xB3]): '',
    utf8.decode([0xE2, 0xA0, 0xB4]): '',
    utf8.decode([0xE2, 0xA0, 0xB5]): 'z',
    utf8.decode([0xE2, 0xA0, 0xB6]): '',
    utf8.decode([0xE2, 0xA0, 0xB7]): 'á',
    utf8.decode([0xE2, 0xA0, 0xB8]): '',
    utf8.decode([0xE2, 0xA0, 0xB9]): 'ô',
    utf8.decode([0xE2, 0xA0, 0xBA]): 'w',
    utf8.decode([0xE2, 0xA0, 0xBB]): '',
    utf8.decode([0xE2, 0xA0, 0xBC]): '',
    utf8.decode([0xE2, 0xA0, 0xBD]): 'y',
    utf8.decode([0xE2, 0xA0, 0xBE]): 'ú',
    utf8.decode([0xE2, 0xA0, 0xBF]): 'é',
  };

  String translateStringToHex(String text) {
    List<String> hex = [];
    for (int i = 0; i < text.length; i++) {
      String char = text.substring(i, i + 1);
      if (_charToBrailleMap.containsKey(char.toUpperCase())) {
        if (char.contains(RegExp(r'[A-Z]'))) {
          hex.add(_charToBrailleMap["˄"]!);
          hex.add(_charToBrailleMap[char.toUpperCase()]!);
        } else if (char.contains(RegExp(r'[0-9]'))) {
          hex.add(_charToBrailleMap["№"]!);
          hex.add(_charToBrailleMap[char.toUpperCase()]!);
        } else {
          hex.add(_charToBrailleMap[char.toUpperCase()]!);
        }
      }
    }

    return hex.join();
  }

  String translateBrailleToHex(String text) {
    List<String> hex = [];
    for (int i = 0; i < text.length; i++) {
      String char = text.substring(i, i + 1);
      if (_brailleToHex.containsKey(char)) {
        hex.add(_brailleToHex[char]!);
      }
    }

    return hex.join();
  }

  String translateHexToString(String hex) {
    String? previous;
    List<String> string = [];
    for (int i = 0; i < hex.length; i = i + 2) {
      String char = hex.substring(i, i + 2);
      if (i >= 2) {
        previous = hex.substring(i - 2, i);
      }
      if (char.toUpperCase() == "14") {
      } else if (char.toUpperCase() == "3C") {
      } else {
        if (previous == "14") {
          string.add(_brailleMap[char.toUpperCase()]!);
        } else if (previous == "3C") {
          string.add(_brailleNumber[char.toUpperCase()]!);
        } else {
          string.add(_brailleMap[char.toUpperCase()]!.toLowerCase());
        }
      }
    }

    return string.join();
  }

  String translateBrailleToString(String text) {
    String? previous;
    List<String> string = [];
    for (int i = 0; i < text.length; i++) {
      String char = text.substring(i, i + 1);
      if (i >= 1) {
        previous = text.substring(i - 1, i);
      }
      if (char == "14") {
      } else if (char == "3C") {
      } else if (char == "Ⱥ") {
      } else if (char == "\n") {
      } else {
        if (previous == utf8.decode([0xE2, 0xA0, 0xBC])) {
          string.add(_brailleNumberToString[char]!);
        } else {
          string.add(_brailleToString[char]!);
        }
      }
    }

    return string.join();
  }
}
