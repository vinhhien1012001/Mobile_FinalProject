part of "../pages/sub-pages/project_student.dart";

class SearchBar extends StatelessWidget {
  final Function(String) onChanged;
  const SearchBar({super.key, required this.onChanged});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Search bar with lookup icon
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
        IconButton(
          onPressed: () {
            // Handle favorite action
          },
          iconSize: 24, // Adjust the size of the icon
          icon: const Icon(Icons.favorite),
          color: Colors.blue,
        ),
      ],
    );
  }
}
