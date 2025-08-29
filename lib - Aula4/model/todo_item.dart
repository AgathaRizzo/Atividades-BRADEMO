class TodoItem {
  late final String _title; // atributo privado (_nomeField)
  late final String _description; // atributo privado (_nomeField)
  //construtor com named parameters
  TodoItem({required String title, 
            required String description})
            : _title = title,
              _description = description;
  String get title => _title;
  String get description => _description;
}
