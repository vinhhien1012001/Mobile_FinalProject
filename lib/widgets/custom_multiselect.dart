import 'package:flutter/material.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';

class MutiselectDropdown extends StatefulWidget {
  const MutiselectDropdown({super.key});

  @override
  State<MutiselectDropdown> createState() => _MutiselectDropdownState();

  static const _headerStyle = TextStyle(
    fontSize: 12,
    color: Colors.blue,
  );
}

class Skill {
  final String name;
  final int id;

  Skill({required this.name, required this.id});

  @override
  String toString() {
    return 'Skill(name: $name, id: $id)';
  }
}

class _MutiselectDropdownState extends State<MutiselectDropdown> {
  final MultiSelectController<Skill> _controller = MultiSelectController();

  final List<ValueItem> _selectedOptions = [];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MultiSelectDropDown<Skill>(
              controller: _controller,
              clearIcon: const Icon(Icons.reddit),
              onOptionSelected: (options) {},
              options: [
                Skill(id: 1, name: 'iOS Development'),
                Skill(id: 2, name: 'C'),
                Skill(id: 3, name: 'Java'),
                Skill(id: 4, name: 'Kubernetes'),
                Skill(id: 5, name: 'PostgreSQL'),
                Skill(id: 6, name: 'Redis'),
                Skill(id: 7, name: 'Android'),
                Skill(id: 8, name: 'Node.js'),
                Skill(id: 9, name: 'Objective-C'),
                Skill(id: 10, name: 'React Native'),
                Skill(id: 11, name: 'Microservices'),
                Skill(id: 12, name: 'Socket.io'),
                Skill(id: 13, name: 'AWS'),
                Skill(id: 14, name: 'React'),
                Skill(id: 15, name: 'Git'),
                Skill(id: 16, name: 'WebScrape'),
              ]
                  .map((skill) => ValueItem(label: skill.name, value: skill))
                  .toList(),
              // maxItems: 4,
              singleSelectItemStyle:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              chipConfig: const ChipConfig(
                  wrapType: WrapType.wrap, backgroundColor: Colors.blue),
              optionTextStyle: const TextStyle(fontSize: 16),
              selectedOptionIcon: const Icon(
                Icons.check_circle,
                color: Colors.pink,
              ),
              searchEnabled: true,
              selectedOptionBackgroundColor: Colors.grey.shade300,
              selectedOptionTextColor: Colors.blue,
              dropdownMargin: 2,
              onOptionRemoved: (index, option) {},
              optionBuilder: (context, valueItem, isSelected) {
                return ListTile(
                  title: Text(valueItem.value!.name),
                  // subtitle: Text(valueItem.value.toString()),
                  trailing: isSelected
                      ? const Icon(Icons.check_circle)
                      : const Icon(Icons.radio_button_unchecked),
                );
              },
            ),
            // Wrap(
            //   children: [
            //     ElevatedButton(
            //       onPressed: () {
            //         _controller.clearAllSelection();
            //         setState(() {
            //           _selectedOptions.clear();
            //         });
            //       },
            //       child: const Text('CLEAR'),
            //     ),
            //     const SizedBox(
            //       width: 8,
            //     ),
            //     ElevatedButton(
            //       onPressed: () {
            //         setState(() {
            //           _selectedOptions.clear();
            //           _selectedOptions.addAll(_controller.selectedOptions);
            //         });
            //       },
            //       child: const Text('Get Selected Options'),
            //     ),
            //   ],
            // ),

            // Text(
            //   'Selected Options: $_selectedOptions',
            //   style: const TextStyle(
            //     fontSize: 16,
            //     fontWeight: FontWeight.bold,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
