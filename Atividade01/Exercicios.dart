//Exercicio1
void main() {
  var equipamento = "impressora 3d";
  String local = "Lab de Protótipos"; 
  dynamic patrimonio = 12345; 
  patrimonio = "12345-A";

  print("Nome do equipamento: $equipamento\n"
  "Local: $local\n"
  "Patrimônio: $patrimonio"); // Foi possivel alterar pois defini o patrimonio como dynamic, então posse ser string ou var.

}
//

//Exercicio2
void main(){
  cadastrarFuncionario(nome:"Ana", cargo:"Analista"); 
  cadastrarFuncionario(nome:"Carlos");
}

void cadastrarFuncionario({required String nome, String? cargo}) {
  if (cargo != null && cargo.isNotEmpty) { 
    print("Bem-vindo(a), $nome! Cargo: $cargo.");
  } else {
    print("Bem-vindo(a), $nome!");
  }
}

//Exercicio3
void main() {

  Laptop laptop1 = Laptop(id: 1, nome: "pc1", ram: 8, clockCpu: 3.2);
  Laptop laptop2 = Laptop(id: 2, nome: "pc2", ram: 12, clockCpu: 3.5);
  Laptop laptop3 = Laptop(id: 3, nome: "pc3", ram: 16, clockCpu: 2.8);


  laptop1.mostrarDetalhes();
  laptop2.mostrarDetalhes();
  laptop3.mostrarDetalhes();
}


class Laptop {
  int id;
  String nome;
  int ram;
  double clockCpu;


  Laptop({required this.id, required this.nome, required this.ram, required this.clockCpu});


  void mostrarDetalhes() {
    print("Laptop ID: $id");
    print("Nome: $nome");
    print("RAM: ${ram}GB");
    print("Clock da CPU: ${clockCpu}GHz\n");
  }
}

//Exercicio4
void main() {

  Laptop laptopNavegacao = Laptop.navegacao();
  Laptop laptopEscritorio = Laptop.escritorio();
  Laptop laptopProgramacao = Laptop.programacao();


  laptopNavegacao.mostrarDetalhes();
  laptopEscritorio.mostrarDetalhes();
  laptopProgramacao.mostrarDetalhes();
}


class Laptop {
  int id;
  String nome;
  int ram;
  double clockCpu;

  Laptop({required this.id, required this.nome, required this.ram, required this.clockCpu});

 
  Laptop.navegacao()
      : id = 1,
        nome = "Laptop Internet",
        ram = 4,
        clockCpu = 2.0;


  Laptop.escritorio()
      : id = 2,
        nome = "Laptop Escritório",
        ram = 8,
        clockCpu = 2.5;


  Laptop.programacao()
      : id = 3,
        nome = "Laptop Programação",
        ram = 16,
        clockCpu = 3.5;


  void mostrarDetalhes() {
    print("Laptop ID: $id");
    print("Nome: $nome");
    print("RAM: ${ram}GB");
    print("Clock da CPU: ${clockCpu}GHz\n");
  }
}

//Exercicio5
import 'dart:io';

void main() {

  stdout.write("Digite o ID da casa 1: ");
  int id1 = int.parse(stdin.readLineSync()!);
  stdout.write("Digite o nome da casa 1: ");
  String name1 = stdin.readLineSync()!;
  stdout.write("Digite o preço da casa 1: ");
  double price1 = double.parse(stdin.readLineSync()!);

  House casa1 = House(id1, name1, price1)..name = "${name1} (Cadastrada)";


  stdout.write("Digite o ID da casa 2: ");
  int id2 = int.parse(stdin.readLineSync()!);
  stdout.write("Digite o nome da casa 2: ");
  String name2 = stdin.readLineSync()!;
  stdout.write("Digite o preço da casa 2: ");
  double price2 = double.parse(stdin.readLineSync()!);

  House casa2 = House(id2, name2, price2)..name = "${name2} (Cadastrada)";


  stdout.write("Digite o ID da casa 3: ");
  int id3 = int.parse(stdin.readLineSync()!);
  stdout.write("Digite o nome da casa 3: ");
  String name3 = stdin.readLineSync()!;
  stdout.write("Digite o preço da casa 3: ");
  double price3 = double.parse(stdin.readLineSync()!);

  House casa3 = House(id3, name3, price3)..name = "${name3} (Cadastrada)";


  List<House> casas = [casa1, casa2, casa3];


  print("\nCasas cadastradas:");
  for (var casa in casas) {
    print("ID: ${casa.id}");
    print("Nome: ${casa.name}");
    print("Preço: \$${casa.price}\n");
  }
}


class House {
  int id;
  String name;
  double price;

  House(this.id, this.name, this.price);
}
