import 'package:flutter/material.dart';

class SearchResultsList extends StatelessWidget {
  final List<dynamic> searchResults;
  final bool isLightTheme;

  const SearchResultsList({
    super.key,
    required this.searchResults,
    required this.isLightTheme,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: isLightTheme
            ? const Color.fromARGB(255, 238, 255, 234)
            : const Color(0xFF333739),
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListView.builder(
        itemCount: searchResults.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          final item = searchResults[index];
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: isLightTheme
                        ? Colors.white60
                        : const Color.fromARGB(255, 48, 48, 48),
                    border: Border.all(
                      color: isLightTheme ? Colors.black26 : Colors.white24,
                      width: 0.5,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    leading: item.image != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(item.image!),
                          )
                        : null,
                    title: Text(
                      item.name ?? '',
                      style: TextStyle(
                        color: isLightTheme ? Colors.black : Colors.white,
                      ),
                    ),
                    subtitle: Text(
                      item.cuisine ?? "",
                      style: TextStyle(
                        color: isLightTheme ? Colors.black : Colors.white70,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 6),
            ],
          );
        },
      ),
    );
  }
}
