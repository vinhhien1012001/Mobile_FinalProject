part of "../pages/sub-pages/project_student.dart";

class SearchBar extends StatelessWidget {
  final Function(String) onChanged;
  final Function()? onFavoritePressed;
  final bool isFilterApplied;
  final bool isTyping;
  final Function()? onFilterPressed;

  const SearchBar({
    super.key,
    required this.onChanged,
    this.onFavoritePressed,
    this.isFilterApplied = false,
    required this.isTyping,
    this.onFilterPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Search bar with lookup or filter icon based on typing state
        Expanded(
          child: SizedBox(
            height: 40, // Adjust the height of the input field
            child: TextField(
              onChanged: onChanged,
              style: const TextStyle(fontSize: 16), // Adjust text size
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 8), // Adjust vertical padding
                hintText: 'Search projects',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
          ),
        ),
        // Favorite icon
        if (true)
          IconButton(
            onPressed: onFavoritePressed,
            iconSize: 24, // Adjust the size of the icon
            icon: const Icon(Icons.favorite),
            color: Colors.blue,
          ),
        // Filter icon (conditionally rendered)
        if (isTyping)
          IconButton(
            onPressed: onFilterPressed,
            iconSize: 24, // Adjust the size of the icon
            icon: const Icon(Icons.filter_alt),
            color: Colors.blue,
          ),
      ],
    );
  }
}
