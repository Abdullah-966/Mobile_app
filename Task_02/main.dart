import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BGNUPage(),
    );
  }
}

class BGNUPage extends StatelessWidget {
  const BGNUPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black38,
        toolbarHeight: 100,
        title: Row(
          children: [
            Image.asset(
              'images/bgnu_logo.png', // Ensure this asset exists
              height: 70,
            ),
            const SizedBox(width: 10),
            const Text(
              "Baba Guru Nanak University",
              style: TextStyle(color: Colors.white,fontSize: 28, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 20),

          // University Image (Before Text)
          Image.asset(
            'images/vc_image.jpeg', // Ensure this asset exists
            height: 200,
            width: 200,
            fit: BoxFit.cover,
          ),

          const SizedBox(height: 20),

          // Description Text
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              "Baba Guru Nanak University (BGNU) is a Public sector university located in District Nankana Sahib, in the Punjab region of Pakistan. It plans to facilitate between 10,000 to 15,000 students from all over the world at the university. The foundation stone of the university was laid on October 28, 2019, ahead of the 550th of Guru Nanak Gurpurab by the Prime Minister of Pakistan. On July 02, 2020, Government of Punjab has formally passed Baba Guru Nanak University Nankana Sahib Act 2020 (X of 2020).\n\n"
                  "The university aims to promote academic excellence and research in various disciplines, including science, technology, and humanities. With world-class faculty and state-of-the-art facilities, BGNU is committed to nurturing the next generation of leaders and scholars. The institution also focuses on international collaborations, fostering a diverse and inclusive learning environment for students from different backgrounds. Additionally, BGNU emphasizes cultural studies, including Punjabi language and literature, ensuring the preservation and promotion of regional heritage.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
          ),

          const Spacer(),

          // Footer Section
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16.0),
            color: Colors.black38,
            child: const Text(
              "© 2025 Baba Guru Nanak University. All rights reserved.",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}