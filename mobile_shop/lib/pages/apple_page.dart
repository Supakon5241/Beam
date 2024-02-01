import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/bloc/brand_bloc.dart';

class ApplePage extends StatefulWidget {
  const ApplePage({Key? key});

  @override
  State<ApplePage> createState() => _ApplePageState();
}

class _ApplePageState extends State<ApplePage> {
  late ApiBlocApple apiBlocApple;
  @override
  Widget build(BuildContext context) {
    apiBlocApple = BlocProvider.of<ApiBlocApple>(context);
    apiBlocApple.add(FetchDataEvent());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product : Apple'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: BlocBuilder<ApiBlocApple, ApiState>(
          builder: (context, state) {
            if (state.data1.isNotEmpty) {
              final List<Map<String, String>> data1 = state.data1;
              print('API DataAppleX: $data1');
              return ListView.builder(
                itemCount: data1.length,
                itemBuilder: (context, index) {
                  final item = data1[index];
                  return Center(
                    child: Card(
                      margin: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 16),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 1.0,
                        height: 90,
                        child: ListTile(
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 16),
                          leading: Image.network(
                            item['image']!,
                            width: 80,
                            height: 80,
                          ),
                          title: Text(item['name']!),
                          subtitle: Text('ราคา: ${item['price']}'),
                          trailing: ElevatedButton(
                            onPressed: () {
                              print('เลือกรายการ: ${item['name']}');
                            },
                            child: const Text('+'),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            } else if (state.data.isEmpty) {
              return const Center(
                child: LinearProgressIndicator(),
              );
            } else {
              return const Text("Error occurred!");
            }
          },
        ),
      ),
    );
  }
}