import 'package:flutter/material.dart';
import 'package:project_app/generatepassword.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

class Generatorpage extends StatefulWidget {
  const Generatorpage({super.key});

  @override
  State<Generatorpage> createState() => _GeneratorpageState();
}

class _GeneratorpageState extends State<Generatorpage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Generate Password',
        style: TextStyle(
          fontSize: 25.0,
          color: Colors.white70,
          fontWeight: FontWeight.w500
        ),),
        backgroundColor: Colors.indigoAccent,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal:size.width*0.04
            ),
            child: Center(
              child: Column(
                children: [
                  Material(
                      borderRadius: BorderRadius.circular(5),
                      child:Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            heightFactor: 2.5,
                            child: Text(
                              context
                                  .watch<GeneratePassword>()
                                  .generatedpassword,
                              style: const TextStyle(
                                  fontSize: 24
                              ),
                            ),
                          ),
                          LinearProgressIndicator(
                            value: context
                                .watch<GeneratePassword>()
                                .passwordstrength,
                            backgroundColor: Colors.grey[300],
                            color: context
                                .watch<GeneratePassword>()
                                .passwordstrength <= 1.6/4
                                ? Colors.red:
                            context
                                .watch<GeneratePassword>()
                                .passwordstrength<=3.4/4
                                ?Colors.yellow:
                            Colors.green,
                            minHeight: 4,
                          )
                        ],
                      )
                  ),
                  SizedBox(
                    height: size.height*0.02,
                  ),
                  Container(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        context.read<GeneratePassword>().generatepassword;
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                        backgroundColor: Colors.indigoAccent,
                      ),
                      child: Text(
                        context.watch<GeneratePassword>().generatedpassword.isEmpty
                            ? 'Generate Password'
                            : 'Regenerate Password',
                        style:const TextStyle(
                            fontSize: 20,
                            color: Colors.white70
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height*0.01,
                  ),
                  InkWell(
                    onTap: context
                        .watch<GeneratePassword>()
                        .generatedpassword
                        .isEmpty
                        ? () => ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please generate password'),
                      ),
                    )
                        : () {
                      Clipboard.setData(
                        ClipboardData(
                          text: context
                              .read<GeneratePassword>()
                              .generatedpassword,
                        ),
                      ).then(
                            (value) {
                          return ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Password copied to clipboard'),
                            ),
                          );
                        },
                      );
                    },
                    borderRadius: BorderRadius.circular(5),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(5),
                        color: Theme.of(context).highlightColor,
                      ),
                      child: const Center(
                        heightFactor: 3,
                        child: Text('Copy Password',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                            )),
                      ),
                    ),
                  ),
                  SizedBox(height: size.height*0.02,),
                  const Text('Options',
                    style: TextStyle(
                        fontWeight: FontWeight.w500
                    ),
                  ),
                  _buildsliderOption(titletext: 'Length',
                    hinttext: context.watch<GeneratePassword>().length.floor().toString(),
                    onchanged: (value){
                      context.read<GeneratePassword>().length = value as double;
                    },
                    value: context.watch<GeneratePassword>().length,
                  ),
                  SizedBox(height: size.height*0.33,),
                  const Text(
                    '*Your password must be between 8 and 20 characters long.\n'
                      '*Include both lowercase and uppercase letters (a-z, A-Z)\n'
                        '*Include at least 1 special character: !@#\$%^&*()=+.\n'
                          '*Include at least 1 number: 0-9.\n',
                    style: TextStyle(
                      fontSize: 15.0,
                      color: Colors.grey
                    )
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  Widget _buildsliderOption({required String titletext,
    required String hinttext,
    required double value,
    required Function(double) onchanged}){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(titletext),
        Row(
          children: [
            Text(hinttext),
            Slider(max: 20.0,
              min:8.0,
              value: value,
              onChanged: onchanged,
              ),
          ],
        )
      ],
    );
  }
}
