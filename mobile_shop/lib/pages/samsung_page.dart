import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/bloc/brand_bloc.dart';

class SamsungPage extends StatefulWidget {
  const SamsungPage({Key? key});

  @override
  State<SamsungPage> createState() => _SamsungPageState();
}

class _SamsungPageState extends State<SamsungPage> {
  late ApiBlocSamsung apiBlocSamsung;

  @override
  Widget build(BuildContext context) {
    apiBlocSamsung = BlocProvider.of<ApiBlocSamsung>(context);
    apiBlocSamsung.add(FetchDataEvent());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product : Samsung'),
        backgroundColor:Colors.blue,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: BlocBuilder<ApiBlocSamsung, ApiState>(
          builder: (context, state) {
            if (state.data2.isNotEmpty) {
              final List<Map<String, String>> data2 = state.data2;
              print('API DataAppleS: $data2');
              return ListView.builder(
                itemCount: data2.length,
                itemBuilder: (context, index) {
                  final item = data2[index];
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
