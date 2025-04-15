import 'package:flutter/material.dart';

void main() {
  runApp(TaoDiarioApp());
}

class TaoDiarioApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tao Diario',
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.teal,
        scaffoldBackgroundColor: Color(0xFFF5F5F5),
        textTheme: TextTheme(
          headline6: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          bodyText2: TextStyle(fontSize: 16),
        ),
      ),
      darkTheme: ThemeData.dark(),
      home: MainNavigation(),
    );
  }
}

class MainNavigation extends StatefulWidget {
  @override
  _MainNavigationState createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    HomeScreen(),
    RoutineChecklist(),
    TaoDiary(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
          BottomNavigationBarItem(icon: Icon(Icons.check_circle), label: 'Rutina'),
          BottomNavigationBarItem(icon: Icon(Icons.edit), label: 'Diario'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Ajustes'),
        ],
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final String phrase = "El sabio no acumula. Cuanto más ayuda a los demás, más se beneficia él mismo.";

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Frase del día',
              style: Theme.of(context).textTheme.headline6,
            ),
            SizedBox(height: 20),
            Text(
              phrase,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ],
        ),
      ),
    );
  }
}

class RoutineChecklist extends StatefulWidget {
  @override
  _RoutineChecklistState createState() => _RoutineChecklistState();
}

class _RoutineChecklistState extends State<RoutineChecklist> {
  final List<String> tasks = [
    'Meditación matutina',
    'Qi Gong o estiramiento',
    'Lectura Taoísta',
    'Estudio ICFES – Sesión 1',
    'Caminata consciente',
    'Estudio ICFES – Sesión 2',
    'Meditación nocturna',
    'Diario Tao',
  ];

  final Map<String, bool> completed = {};

  @override
  void initState() {
    super.initState();
    for (var task in tasks) {
      completed[task] = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        String task = tasks[index];
        return CheckboxListTile(
          title: Text(task),
          value: completed[task],
          onChanged: (bool? value) {
            setState(() {
              completed[task] = value ?? false;
            });
          },
        );
      },
    );
  }
}

class TaoDiary extends StatefulWidget {
  @override
  _TaoDiaryState createState() => _TaoDiaryState();
}

class _TaoDiaryState extends State<TaoDiary> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Escribe tu reflexión de hoy:', style: Theme.of(context).textTheme.headline6),
          SizedBox(height: 10),
          Expanded(
            child: TextField(
              controller: _controller,
              maxLines: null,
              expands: true,
              decoration: InputDecoration(
                hintText: '¿Qué aprendiste hoy del Tao?',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Entrada guardada (no persistente aún).')),
              );
            },
            child: Text('Guardar'),
          )
        ],
      ),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Opciones (futuras): notificaciones, tema, etc.'),
    );
  }
}
