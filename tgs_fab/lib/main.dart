import 'package:flutter/material.dart';

void main() => runApp(const AdaptiveDemo());

class AdaptiveDemo extends StatelessWidget {
  const AdaptiveDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Adaptive Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.indigo),
      darkTheme: ThemeData.dark(useMaterial3: true),
      themeMode: ThemeMode.system,
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final _items = List<String>.generate(20, (i) => 'Acara Kampus#${i + 1}');

  void _onFabPressed() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('FloatingActionButton!')),
    );
  }

  Widget _buildBody(BuildContext context) {
    if (_selectedIndex == 0) {
      return const Center(child: Text('Beranda'));
    } else if (_selectedIndex == 1) {
      final width = MediaQuery.of(context).size.width;
      final cols = width < 600
          ? 1
          : (width < 905)
          ? 2
          : 3;
      return _FeedGrid(cols: cols, items: _items);
    } else {
      return const Center(child: Text('Profil'));
    }
  }

  Widget _buildNavItem(
      IconData icon,
      String label,
      int index,
      ) {
    final isSelected = _selectedIndex == index;
    final color = isSelected
        ? Theme.of(context).colorScheme.primary
        : Colors.grey;

    return GestureDetector(
      onTap: () => setState(() => _selectedIndex = index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(fontSize: 12, color: color),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isCompact = MediaQuery.of(context).size.width < 600;

    return Scaffold(
      body: _buildBody(context),
      bottomNavigationBar: isCompact
          ? Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceVariant,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(Icons.home, 'Beranda', 0),
            _buildNavItem(Icons.event, 'Acara', 1),
            _buildNavItem(Icons.person, 'Profil', 2),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color:
                    Theme.of(context).colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.add),
                    iconSize: 20,
                    color: Theme.of(context)
                        .colorScheme
                        .onPrimaryContainer,
                    onPressed: _onFabPressed,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Tambah',
                  style: TextStyle(
                    fontSize: 12,
                    color: Theme.of(context)
                        .colorScheme
                        .onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ],
        ),
      )
          : null,
    );
  }
}

class _FeedGrid extends StatelessWidget {
  const _FeedGrid({required this.cols, required this.items});
  final int cols;
  final List<String> items;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: items.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: cols,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: cols == 1 ? 5 : 3 / 2,
      ),
      itemBuilder: (_, i) => Card(
        elevation: 2,
        child: Center(
          child: Text(
            items[i],
            style: Theme.of(context).textTheme.labelLarge,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
