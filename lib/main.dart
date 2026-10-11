import 'package:flutter/material.dart';

void main() {
  runApp(const QueueLessApp());
}

class QueueLessApp extends StatelessWidget {
  const QueueLessApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'QueueLess',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2563EB),
        ),
        useMaterial3: true,
      ),
      home: const QueueHomePage(),
    );
  }
}

class QueueHomePage extends StatefulWidget {
  const QueueHomePage({super.key});

  @override
  State<QueueHomePage> createState() => _QueueHomePageState();
}

class _QueueHomePageState extends State<QueueHomePage> {
  final List<Map<String, dynamic>> services = [
    {
      'name': 'City Care Clinic',
      'type': 'Healthcare',
      'icon': Icons.local_hospital,
      'color': Colors.blue,
      'waiting': 5,
      'minutes': 15,
      'prefix': 'C',
    },
    {
      'name': 'Citizen Service Office',
      'type': 'Government Services',
      'icon': Icons.account_balance,
      'color': Colors.deepPurple,
      'waiting': 8,
      'minutes': 25,
      'prefix': 'O',
    },
    {
      'name': 'College Help Desk',
      'type': 'Education',
      'icon': Icons.school,
      'color': Colors.teal,
      'waiting': 3,
      'minutes': 10,
      'prefix': 'S',
    },
  ];

  String? token;
  String? selectedService;
  int currentTab = 0;

  void generateToken(Map<String, dynamic> service) {
    setState(() {
      service['waiting'] = service['waiting'] + 1;
      token =
          '${service['prefix']}-${(100 + service['waiting']).toString()}';
      selectedService = service['name'];
    });

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        icon: const Icon(
          Icons.check_circle,
          color: Colors.green,
          size: 55,
        ),
        title: const Text('Token Generated!'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              token!,
              style: const TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 10),
            Text(service['name']),
            Text('Estimated wait: ${service['minutes']} minutes'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Done'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Row(
          children: [
            Icon(Icons.confirmation_number, color: Colors.blue),
            SizedBox(width: 8),
            Text(
              'QueueLess',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Welcome to QueueLess!')),
              );
            },
            icon: const Icon(Icons.notifications_none),
          ),
        ],
      ),
      body: IndexedStack(
        index: currentTab,
        children: [
          _buildHome(),
          _buildMyToken(),
          _buildAbout(),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentTab,
        onDestinationSelected: (index) {
          setState(() => currentTab = index);
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.confirmation_number_outlined),
            selectedIcon: Icon(Icons.confirmation_number),
            label: 'My Token',
          ),
          NavigationDestination(
            icon: Icon(Icons.info_outline),
            label: 'About',
          ),
        ],
      ),
    );
  }

  Widget _buildHome() {
    return ListView(
      padding: const EdgeInsets.all(18),
      children: [
        Container(
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF2563EB), Color(0xFF6046E8)],
            ),
            borderRadius: BorderRadius.circular(22),
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Skip the line.',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 27,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Save your time.',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 27,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 12),
              Text(
                'Book your queue token from anywhere.',
                style: TextStyle(color: Colors.white70, fontSize: 15),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        const Text(
          'Find a Service',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 5),
        const Text(
          'Choose a service and get your token.',
          style: TextStyle(color: Colors.black54),
        ),
        const SizedBox(height: 14),
        ...services.map((service) => _serviceCard(service)),
        const SizedBox(height: 12),
        Card(
          child: ListTile(
            leading: const Icon(Icons.lightbulb_outline, color: Colors.orange),
            title: const Text('Why QueueLess?'),
            subtitle: const Text(
              'Reduce waiting, save time, and manage queues easily.',
            ),
          ),
        ),
      ],
    );
  }

  Widget _serviceCard(Map<String, dynamic> service) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.only(bottom: 14),
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(13),
                  decoration: BoxDecoration(
                    color: (service['color'] as Color).withOpacity(0.12),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(
                    service['icon'],
                    color: service['color'],
                    size: 30,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        service['name'],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        service['type'],
                        style: const TextStyle(color: Colors.black54),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Divider(height: 25),
            Row(
              children: [
                const Icon(Icons.people_outline, size: 19),
                const SizedBox(width: 5),
                Text('${service['waiting']} waiting'),
                const Spacer(),
                const Icon(Icons.access_time, size: 18),
                const SizedBox(width: 5),
                Text('${service['minutes']} min'),
              ],
            ),
            const SizedBox(height: 14),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () => generateToken(service),
                child: const Text('Get Queue Token'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMyToken() {
    if (token == null) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(25),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.confirmation_number_outlined,
                size: 75,
                color: Colors.blue,
              ),
              SizedBox(height: 16),
              Text(
                'No Active Token',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'Go to Home and select a service to get your token.',
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(28),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.check_circle, color: Colors.green, size: 55),
                const Text('Your Queue Token'),
                const SizedBox(height: 12),
                Text(
                  token!,
                  style: const TextStyle(
                    fontSize: 42,
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(selectedService ?? ''),
                const SizedBox(height: 20),
                const Text('Keep your token ready when your turn arrives.'),
                const SizedBox(height: 20),
                OutlinedButton(
                  onPressed: () {
                    setState(() {
                      token = null;
                      selectedService = null;
                    });
                  },
                  child: const Text('Cancel Token'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAbout() {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(25),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.confirmation_number, size: 70, color: Colors.blue),
            SizedBox(height: 16),
            Text(
              'QueueLess',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),
            Text(
              'A digital queue management app for clinics, offices, and colleges.',
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16),
            Text(
              'This demo stores token information temporarily on your device. '
              'It does not yet sync tokens between multiple users.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }
}
