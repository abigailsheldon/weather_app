import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),

      home: DefaultTabController(
        length: 3, 
        child: _TabsNonScrollableDemo()
        ),

    );
  }
}

class _TabsNonScrollableDemo extends StatefulWidget {
  @override
  _TabsNonScrollableDemoState createState() =>
_TabsNonScrollableDemoState();
}

class _TabsNonScrollableDemoState extends State< _TabsNonScrollableDemo>
  with SingleTickerProviderStateMixin, RestorationMixin {
    late TabController _tabController;

    final RestorableInt tabIndex = RestorableInt(0);
    final TextEditingController _cityController = TextEditingController();

    @override
    String get restorationId => 'tab_non_scrollable_demo';

    @override
    void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
      registerForRestoration(tabIndex,'tab_index');
      _tabController.index = tabIndex.value;
    }
    @override
    void initState(){
      super.initState();
      _tabController = TabController(
        initialIndex: 0,
        length: 3,
        vsync: this,
      );
      _tabController.addListener((){
        setState((){
          tabIndex.value = _tabController.index;
        });
      });
    }
    @override
    void dispose() {
      _tabController.dispose();
      tabIndex.dispose();
      super.dispose();
  }  
  @override
  Widget build(BuildContext context){
    final tabs = ['Weather 1','Weather 2','Weather 3'];
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Weather App',
        ),
        bottom: TabBar(
          controller: _tabController,
          isScrollable: false,
          tabs: [
            for (final tab in tabs) Tab(text: tab),
          ],
          ),
        ),
    body: TabBarView(
      controller: _tabController,
      children: [
       Center(
        child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Enter City Name:'),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _cityController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter city',
                    ),
                  ),
                ),
              ],
            ),
          ),
       Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Weather'),
            ], 
            
        ),
       ),
           Center(child: Text('Weather')), 
      ],
    ),
  );
  }
}


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. 
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
       
        title: Text(widget.title),
      ),
      body: Center(
        
        child: Column(
          
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), 
    );
  }
}
