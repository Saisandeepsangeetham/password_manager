import 'package:project_app/addPasswordModel.dart';
import 'package:project_app/addPasswordProvider.dart';
import 'package:project_app/Screens/addPassword.dart';
import 'package:project_app/Screens/viewPassword.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:provider/provider.dart';

class VaultPage extends StatefulWidget {
  const VaultPage({super.key});

  @override
  State<VaultPage> createState() => _VaultPageState();
}

class _VaultPageState extends State<VaultPage> {
  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    context.read<AddPasswordProvider>().fatchdata;
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Saved Passwords',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FutureBuilder(
              future: context.read<AddPasswordProvider>().fatchdata,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    heightFactor: size.height * 0.02,
                    child: const CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                } else {
                  return ListView.separated(
                    controller: _controller,
                    scrollDirection: Axis.vertical,
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    separatorBuilder: (context, index) => SizedBox(height: size.height * 0.01),
                    itemCount: context.watch<AddPasswordProvider>().userPasswords.length,
                    itemBuilder: (context, index) {
                      final data = context.watch<AddPasswordProvider>().userPasswords[index];
                      return _buildCard(
                        context: context,
                        data: data,
                      );
                    },
                  );
                }
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddPassword(),
            ),
          );
        },
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }


  Widget _buildCard({
    required BuildContext context,
    required AddPasswordModel data,
  }) {
    int calculateDifference(DateTime date) {
      DateTime now = DateTime.now();
      return now.difference(date).inDays;
    }

    return Material(
      elevation: 1,
      borderRadius: BorderRadius.circular(5),
      child: InkWell(
        borderRadius: BorderRadius.circular(5),
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
          context
              .read<AddPasswordProvider>()
              .getPasswordData(id: int.parse(data.id));
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ViewPassword(),
            ),
          );
        },
        child: Card(
          elevation: 4,
          child: ListTile(
            title: Text(
              data.title,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
            subtitle: Text(
              calculateDifference(data.addeddate) == 0
                  ? 'Added Today'
                  : calculateDifference(data.addeddate) == 1
                  ? 'Added Yesterday'
                  : 'Added ${calculateDifference(data.addeddate)} days ago',
            ),
            leading: FutureBuilder<String>(
              initialData: '',
              future: context
                  .read<AddPasswordProvider>()
                  .getFavcicoUrl(url: data.url!),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }
                if (snapshot.hasData) {
                  return CachedNetworkImage(
                    placeholder: (context, url) => const SizedBox(
                      height: 32,
                      width: 32,
                      child: CircularProgressIndicator(),
                    ),
                    imageUrl: snapshot.data!,
                    errorWidget: (context, url, error) => const Icon(
                      Icons.error_outline,
                      size: 32,
                    ),
                  );
                }

                return const Icon(
                  Icons.language_outlined,
                  size: 32,
                );
              },
            ),
            trailing: const Icon(Icons.arrow_forward_ios),
          ),
        ),
      ),
    );
  }
}
