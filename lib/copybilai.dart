import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

/// Basic skinning example. The skinning states is set in the Rive editor and
/// triggers are used to change the value.
class CopyBilai extends StatefulWidget {
  const CopyBilai({Key? key}) : super(key: key);

  @override
  State<CopyBilai> createState() => _CopyBilaiState();
}

class _CopyBilaiState extends State<CopyBilai> {
  void _onRiveInit(Artboard artboard) {
    final controller = StateMachineController.fromArtboard(
      artboard,
      'Artboard',
      // onStateChange: _onStateChange,
    );

    artboard.addController(controller!);
  }

  // void _onStateChange(String stateMachineName, String stateName) {
  //   if (stateName.contains("Skin_")) {
  //     setState(() {
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Skinning Demo'),
      ),
      body: Stack(
        children: [
          Center(
            child: RiveAnimation.asset(
              'assets/copybilai.riv',
              fit: BoxFit.cover,
              onInit: _onRiveInit,
            ),
          ),
        ],
      ),
    );
  }
}
