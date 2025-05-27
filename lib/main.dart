import 'package:flutter/material.dart';

Set<String> passedLessons = {}; // Keeps track of passed lessons

void main() {
  runApp(K9AssistApp());
}

class K9AssistApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'K9 Assist',
      theme: ThemeData(
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: Color(0xFFFFF0F5), // Light pink background
        fontFamily: 'Roboto',
      ),
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

Map<String, List<String>> lessonInstructions = {
  'Sit': [
    'Choose a quiet space to minimize distractions.',
    'Hold a high-value treat close to your dog’s nose.',
    'Slowly move the treat upward and slightly behind their head.',
    'As your dog’s nose follows the treat, their rear will naturally lower.',
    'Once the dog’s bottom touches the ground, clearly say "Sit" and immediately give the treat.',
    'Use calm praise like “Good sit!” to reinforce the behavior.',
    'Repeat for 5–10 short sessions per day until consistent.',
    'IAADP Tip: Never push your dog’s rear down — let them offer the behavior voluntarily.'
  ],
  'Stand': [
    'Begin with your dog in a sitting position.',
    'Show the treat just in front of their nose.',
    'Move the treat slowly forward in a straight, low line.',
    'As the dog stretches forward, they will naturally stand.',
    'Say "Stand" the moment they rise and reward instantly.',
    'Pair with verbal praise like “Yes! Good stand!”',
    'Practice daily with short, focused sessions.',
    'Ensure the dog understands the position — not just movement.'
  ],
  'Down': [
    'Start with your dog sitting calmly in front of you.',
    'Hold the treat at the nose, then slowly move it straight down between the front paws.',
    'Once the nose goes down, begin sliding the treat outward along the ground.',
    'As your dog follows the motion, they will lie down.',
    'Say "Down" the instant both elbows touch the floor and reward.',
    'Reinforce calmly with “Good down.”',
    'Avoid luring too quickly — slow movement builds success.',
    'IAADP Tip: Never force your dog into position; build confidence through choice.'
  ],
  'Stay': [
    'Ask your dog to “Sit” or “Down.”',
    'Stand directly in front and hold your hand up like a stop sign.',
    'Say “Stay” in a calm, firm tone.',
    'Take one small step back. If your dog remains, return and reward.',
    'Gradually increase distance and duration.',
    'Always return to reward — do not call your dog while practicing "Stay."',
    'Introduce a release word such as “Okay!” to indicate freedom.',
    'IAADP Tip: Reinforce calm, still behavior rather than physical restraint.'
  ],
  'Come': [
    'Practice in a safe, distraction-free area first.',
    'Crouch down and say “Come!” in an upbeat, inviting tone.',
    'Open your arms and reward immediately when your dog reaches you.',
    'If hesitant, show the treat, use clapping, or step back to encourage.',
    'Reward with enthusiasm — “Great job! Good come!”',
    'Never scold your dog if they’re slow or hesitant — make it a joyful experience.',
    'Progress to using longer distances and mild distractions.',
    'IAADP Tip: Reliable recall can be life-saving — always make coming to you worthwhile.'
  ],
};

class HomePage extends StatelessWidget {
  final double boxHeight = 420;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: boxHeight,
          margin: EdgeInsets.symmetric(horizontal: 24),
          padding: EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(32),
            boxShadow: [
              BoxShadow(
                color: Colors.pink.shade50,
                blurRadius: 12,
                spreadRadius: 2,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '🐾 K9 Assist 🐾',
                style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                  color: Colors.green[900],
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16),
              Text(
                'Making Assistance Dog Training Accessible!',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey[700],
                  fontStyle: FontStyle.italic,
                ),
              ),
              SizedBox(height: 24),
              Icon(Icons.pets, size: 60, color: Colors.pink[300]),
              SizedBox(height: 32),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pink[300],
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LessonListPage()),
                  );
                },
                child: Text(
                  'Start Training',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LessonListPage extends StatelessWidget {
  final List<String> lessons = ['Sit', 'Stand', 'Down', 'Stay', 'Come'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Module 1: Foundation Skills"), backgroundColor: Colors.green[400]),
      body: ListView.builder(
        itemCount: lessons.length,
        itemBuilder: (context, index) {
          final lesson = lessons[index];
          return Card(
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: ListTile(
              title: Text(
                lesson,
                style: TextStyle(fontSize: 18),
              ),
              leading: Icon(
                passedLessons.contains(lesson) ? Icons.check_circle : Icons.radio_button_unchecked,
                color: passedLessons.contains(lesson) ? Colors.green : Colors.pink[200],
              ),
              trailing: Icon(Icons.arrow_forward_ios, size: 18),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LessonDetailPage(
                      lessonTitle: lesson,
                      steps: lessonInstructions[lesson]!,
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class LessonDetailPage extends StatefulWidget {
  final String lessonTitle;
  final List<String> steps;

  LessonDetailPage({required this.lessonTitle, required this.steps});

  @override
  _LessonDetailPageState createState() => _LessonDetailPageState();
}

class _LessonDetailPageState extends State<LessonDetailPage> {
  int currentStepIndex = 0;

  @override
  Widget build(BuildContext context) {
    final stepText = widget.steps[currentStepIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.lessonTitle),
        backgroundColor: Colors.green[400],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Text(
              'Step ${currentStepIndex + 1} of ${widget.steps.length}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.grey[600]),
            ),
            SizedBox(height: 16),
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  stepText,
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: currentStepIndex > 0
                      ? () => setState(() => currentStepIndex--)
                      : null,
                  icon: Icon(Icons.arrow_back_ios),
                  color: currentStepIndex > 0 ? Colors.green[400] : Colors.grey,
                ),
                IconButton(
                  onPressed: currentStepIndex < widget.steps.length - 1
                      ? () => setState(() => currentStepIndex++)
                      : null,
                  icon: Icon(Icons.arrow_forward_ios),
                  color: currentStepIndex < widget.steps.length - 1 ? Colors.green[400] : Colors.grey,
                ),
              ],
            ),
            SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FakeUploadPage(),
                  ),
                );
              },
              icon: Icon(Icons.videocam),
              label: Text("Upload Video for Evaluation"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pink[300],
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FakeUploadPage extends StatefulWidget {
  @override
  _FakeUploadPageState createState() => _FakeUploadPageState();
}

class _FakeUploadPageState extends State<FakeUploadPage> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Video Upload"),
        backgroundColor: Colors.green[400],
      ),
      body: Center(
        child: isLoading
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text("Uploading video...", style: TextStyle(fontSize: 18)),
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.check_circle, color: Colors.green, size: 64),
                  SizedBox(height: 16),
                  Text("Test Passed ✅", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                ],
              ),
      ),
    );
  }
}
