import 'package:find_me_app/core/resources/colors.dart';
import 'package:flutter/material.dart';

class SelectableButtonsWithBody extends StatefulWidget {
  final List<String> labels;
  final List<Widget> bodies;
  final int initialIndex;
  final Color selectedColor;
  final Color unselectedColor;

  const SelectableButtonsWithBody({
    super.key,
    required this.labels,
    required this.bodies,
    this.initialIndex = 0,
    required this.selectedColor,
    required this.unselectedColor,
  }) : assert(labels.length == bodies.length,
            "labels and bodies must have the same length");

  @override
  State<SelectableButtonsWithBody> createState() =>
      _SelectableButtonsWithBodyState();
}

class _SelectableButtonsWithBodyState extends State<SelectableButtonsWithBody> {
  late int selectedIndex;

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: List.generate(widget.labels.length, (index) {
            final isSelected = selectedIndex == index;
            return ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(145, 40),
                backgroundColor:
                    isSelected ? widget.selectedColor : widget.unselectedColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onPressed: () {
                setState(() {
                  selectedIndex = index;
                });
              },
              child: Text(
                widget.labels[index],
                style: TextStyle(
                  color: isSelected ? Colors.white : AppColors.mainColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          }),
        ),
        const SizedBox(height: 20),
        Expanded(
          child: widget.bodies[selectedIndex],
        ),
      ],
    );
  }
}
