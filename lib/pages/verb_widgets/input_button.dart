import "package:flutter/material.dart";

// Input button to submit the conjugated verb
class InputButtonWidget extends StatelessWidget {
  final VoidCallback onSubmit;
  const InputButtonWidget({super.key, required this.onSubmit});

  void _handleSubmit() {
    onSubmit();
  }

  @override
  Widget build(BuildContext context) {
    return IconButton.filled(
      onPressed: _handleSubmit,
      icon: const Icon(Icons.arrow_forward),
    );
  }
}
