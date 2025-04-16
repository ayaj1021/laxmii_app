import 'package:flutter/material.dart';

class CustomKeyboard extends StatelessWidget {
  final Function(String) onKeyTap;
  final VoidCallback onDelete;
  final Widget? child;

  const CustomKeyboard(
      {super.key, required this.onKeyTap, required this.onDelete, this.child});

  @override
  Widget build(BuildContext context) {
    List<String> keys = [
      "1",
      "2",
      "3",
      "4",
      "5",
      "6",
      "7",
      "8",
      "9",
      "",
      "0",
      "⌫"
    ];

    final colorScheme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        color: colorScheme.cardColor,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          child ?? const SizedBox.shrink(),
          SizedBox(
            height: child != null ? 10 : 0,
          ),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 1.5,
            ),
            itemCount: keys.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  if (keys[index] == "⌫") {
                    onDelete(); // Handle delete action
                  } else if (keys[index] != "") {
                    onKeyTap(keys[index]); // Handle number tap
                  }
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  margin:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                  decoration: BoxDecoration(
                    color: colorScheme.colorScheme.onSurface,

                    // (index == 9 || index == 11)
                    //     ? Colors.transparent
                    //     : const Color.fromARGB(255, 143, 143, 143)
                    //         .withValues(alpha: 0.6),

                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    keys[index],
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
