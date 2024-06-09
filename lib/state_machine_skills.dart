import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

/// An example showing how to drive a StateMachine via one numeric input.
class StateMachineSkills extends StatefulWidget {
  const StateMachineSkills({Key? key}) : super(key: key);

  @override
  State<StateMachineSkills> createState() => _StateMachineSkillsState();
}

class _StateMachineSkillsState extends State<StateMachineSkills> {
  Artboard? _riveArtboard;
  SMINumber? _levelInput;

  @override
  void initState() {
    super.initState();

    _loadRiveFile();
  }

  Future<void> _loadRiveFile() async {
    final file = await RiveFile.asset('assets/skills.riv');

    // The artboard is the root of the animation and gets drawn in the
    // Rive widget.
    final artboard = file.mainArtboard.instance();
    var controller =
        StateMachineController.fromArtboard(artboard, 'Designer\'s Test');
    if (controller != null) {
      artboard.addController(controller);
      _levelInput = controller.getNumberInput('Level');
    }
    setState(() => _riveArtboard = artboard);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Skills Machine'),
      ),
      body: Center(
        child: _riveArtboard == null
            ? const SizedBox()
            : Stack(
                children: [
                  Positioned.fill(
                    child: Rive(
                      artboard: _riveArtboard!,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned.fill(
                    bottom: 32,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          child: const Text('Beginner'),
                          onPressed: () => _levelInput?.value = 0,
                        ),
                        const SizedBox(width: 10),
                        ElevatedButton(
                          child: const Text('Intermediate'),
                          onPressed: () => _levelInput?.value = 1,
                        ),
                        const SizedBox(width: 10),
                        ElevatedButton(
                          child: const Text('Expert'),
                          onPressed: () => _levelInput?.value = 2,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
