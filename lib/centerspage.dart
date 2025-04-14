import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CentersPage extends StatefulWidget {
  const CentersPage({Key? key}) : super(key: key);

  @override
  State<CentersPage> createState() => _CentersPageState();
}

class _CentersPageState extends State<CentersPage> {
  final List<Map<String, String>> cl = [
    {
      'image': 'images/m.png',
      'name': 'Sibewyhi',
      'loc': 'تيارت',
      'phone': '22222222',
      'details': 'مركز أدبي متخصص في اللغة العربية والتاريخ.',
    },
  ];

  final List<Map<String, String>> cs = [
    {
      'image': 'images/m.png',
      'name': 'newton',
      'loc': 'تفرغ زينه',
      'phone': '46789002',
      'details': 'maths ,pc et Sn',
    },
  ];

  final List<Map<String, String>> cf = [
    {
      'image': 'images/m.png',
      'name': ' EBC ',
      'loc': 'madrid',
      'phone': '2556278',
      'details': '',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const TabBar(
            labelColor: Colors.blue,

            tabs: [
              Tab(text: 'الأدبية'),
              Tab(text: 'العلمية'),
              Tab(text: 'التكوينية'),
            ],
          ),
        ),

        body: TabBarView(
          children: [
            _buildCenterList(cl),
            _buildCenterList(cs),
            _buildCenterList(cf),
          ],
        ),
      ),
    );
  }

  Widget _buildCenterList(List<Map<String, String>> data) {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, i) {
        final center = data[i];
        return Card(
          margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),

          child: ListTile(
            leading: Image.asset(center['image']!, width: 50, height: 50),
            title: Text(center['name']!),
            subtitle: Text(center['loc']!),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    title: Text(center['name']!, textAlign: TextAlign.center),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(child: Text("الرقم: ${center['phone']}")),
                            IconButton(
                              icon: const Icon(Icons.copy, size: 18),
                              onPressed: () {
                                Clipboard.setData(
                                  ClipboardData(text: center['phone']!),
                                );
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text("تم نسخ الرقم")),
                                );
                              },
                            ),
                          ],
                        ),
                        Text("الموقع: ${center['loc']}"),
                        const SizedBox(height: 8),
                        Text("التفاصيل:\n${center['details']}"),
                      ],
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text("إغلاق"),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}
