import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/tourism_place.dart';
import 'package:flutter_application_1/restourant_surabaya/detail_screen.dart';

class MainScreen extends StatefulWidget {
  final VoidCallback toggleTheme;

  const MainScreen({required this.toggleTheme, super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String _searchQuery = "";
  int _selectedIndex = 0;

  void _onNavBarTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final textColor = Theme.of(context).textTheme.bodyLarge!.color;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Restourant Surabaya', style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: PlaceSearch());
            },
          ),
          IconButton(
            icon: Icon(Icons.brightness_6, color: textColor),
            onPressed: () {
              widget.toggleTheme();
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.orange.shade100, Colors.orange.shade300],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: LayoutBuilder(
          builder: (context, BoxConstraints constraints) {
            if (constraints.maxWidth <= 512) {
              return MyListView(searchQuery: _searchQuery);
            } else if (constraints.maxWidth <= 1024) {
              return MyGridView(crossAxisCount: 2, searchQuery: _searchQuery);
            } else if (constraints.maxWidth <= 1536) {
              return MyGridView(crossAxisCount: 3, searchQuery: _searchQuery);
            } else {
              return MyGridView(crossAxisCount: 4, searchQuery: _searchQuery);
            }
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onNavBarTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}


class PlaceSearch extends SearchDelegate<TourismPlace?> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = tourismPlaceList
        .where((place) => place.name.toLowerCase().contains(query.toLowerCase()))
        .toList();

    if (results.isEmpty) {
      return const Center(
        child: Text('Maaf, Restoran yang anda cari tidak ada'),
      );
    }

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final place = results[index];
        return ListTile(
          title: Text(place.name),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailScreen(place: place),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = tourismPlaceList
        .where((place) => place.name.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final place = suggestions[index];
        return ListTile(
          title: Text(place.name),
          onTap: () {
            query = place.name;
            showResults(context);
          },
        );
      },
    );
  }
}

class MyListView extends StatefulWidget {
  final String searchQuery;

  const MyListView({super.key, required this.searchQuery});

  @override
  _MyListViewState createState() => _MyListViewState();
}

class _MyListViewState extends State<MyListView> {
  @override
  Widget build(BuildContext context) {
    final filteredList = tourismPlaceList
        .where((place) => place.name.toLowerCase().contains(widget.searchQuery.toLowerCase()))
        .toList();

    if (filteredList.isEmpty) {
      return const Center(
        child: Text('No places found'),
      );
    }

    return ListView.builder(
      itemCount: filteredList.length,
      itemBuilder: (context, index) {
        final TourismPlace place = filteredList[index];
        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailScreen(place: place),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Stack(
              children: [
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                          place.imageAsset,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: 200,
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Color.fromARGB(137, 255, 255, 255), Colors.transparent],
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                            ),
                            borderRadius: BorderRadius.vertical(
                              bottom: Radius.circular(12),
                            ),
                          ),
                          child: Text(
                            place.name,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  right: 8,
                  top: 8,
                  child: IconButton(
                    icon: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      child: Icon(
                        place.isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: Colors.red,
                        key: ValueKey<bool>(place.isFavorite),
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        place.toggleFavorite();
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class MyGridView extends StatefulWidget {
  final int crossAxisCount;
  final String searchQuery;

  const MyGridView({required this.crossAxisCount, required this.searchQuery, super.key});

  @override
  _MyGridViewState createState() => _MyGridViewState();
}

class _MyGridViewState extends State<MyGridView> {
  @override
  Widget build(BuildContext context) {
    final filteredList = tourismPlaceList
        .where((place) => place.name.toLowerCase().contains(widget.searchQuery.toLowerCase()))
        .toList();

    if (filteredList.isEmpty) {
      return const Center(
        child: Text('No places found'),
      );
    }

    final textColor = Theme.of(context).textTheme.bodyLarge!.color;

    return Padding(
      padding: const EdgeInsets.all(24),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: widget.crossAxisCount,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: filteredList.length,
        itemBuilder: (context, index) {
          final place = filteredList[index];
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailScreen(place: place),
                ),
              );
            },
            child: Stack(
              children: [
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset(
                            place.imageAsset,
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          place.name,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: textColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  right: 8,
                  top: 8,
                  child: IconButton(
                    icon: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      child: Icon(
                        place.isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: Colors.red,
                        key: ValueKey<bool>(place.isFavorite),
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        place.toggleFavorite();
                      });
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}