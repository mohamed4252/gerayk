import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TeachersPage extends StatelessWidget {
  final String level;
  final String subject;

  TeachersPage({required this.level, required this.subject});

  final List<Map<String, String>> teachers = [
    {
      "name": "الأستاذ محمد أحمد",
      "phone": "22222222",
      "image": "assets/teacher1.png",
      "level": "التعليم الإعدادي",
      "subject": "الرياضيات",
      "cv": "أستاذ رياضيات بخبرة 10 سنوات.",
    },
    {
      "name": "الأستاذة فاطمة بنت سيدي",
      "phone": "33333333",
      "image": "assets/teacher2.png",
      "level": "التعليم الثانوي",
      "subject": "الفرنسية",
      "cv": "أستاذة لغة فرنسية بخبرة طويلة.",
    },
    {
      "name": "الأستاذة عائشة",
      "phone": "44444444",
      "image": "assets/teacher1.png",
      "level": "التعليم الإعدادي",
      "subject": "الفرنسية",
      "cv": "أستاذة فرنسية للمرحلة الإعدادية.",
    },
  ];

  @override
  Widget build(BuildContext context) {
    final filtered =
        teachers
            .where((t) => t['level'] == level && t['subject'] == subject)
            .toList();

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text("أساتذة $subject - $level"),
          backgroundColor: const Color.fromARGB(255, 18, 88, 211),
        ),
        body:
            filtered.isEmpty
                ? Center(
                  child: Text(
                    "لا يوجد أساتذة لهذا المستوى والمادة حالياً.",
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                )
                : ListView.builder(
                  itemCount: filtered.length,
                  itemBuilder: (context, index) {
                    final teacher = filtered[index];
                    return Card(
                      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage: AssetImage(teacher["image"]!),
                        ),
                        title: Text(teacher["name"]!),
                        subtitle: Row(
                          children: [
                            Text(teacher["phone"]!),
                            IconButton(
                              icon: Icon(Icons.copy, size: 18),
                              onPressed: () {
                                Clipboard.setData(
                                  ClipboardData(text: teacher["phone"]!),
                                );
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text("تم نسخ الرقم")),
                                );
                              },
                            ),
                          ],
                        ),
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (_) {
                              return AlertDialog(
                                title: Text("تفاصيل الأستاذ"),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text("الاسم: ${teacher["name"]}"),
                                    Text("الهاتف: ${teacher["phone"]}"),
                                    SizedBox(height: 8),
                                    Text("السيرة الذاتية:\n${teacher["cv"]}"),
                                  ],
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: Text("إغلاق"),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                    );
                  },
                ),
      ),
    );
  }
}
