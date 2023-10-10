import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/theme_bloc.dart';
import 'locale_delegate.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isSwitched = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleLocalizations.of(context).tr('title')),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Column(
        children: [
          Switch(
            value: isSwitched,
            onChanged: (v) {
              context.read<ThemeBloc>().add(
                    ThemeChanged(
                      themeMode: v ? ThemeMode.dark : ThemeMode.light,
                    ),
                  );
              setState(
                () {
                  isSwitched = v;
                },
              );
            },
          ),
          BlocBuilder<ThemeBloc, ThemeState>(
            buildWhen: (p, c) => p.locale != c.locale,
            builder: (_, state) {
              return Switch(
                value: state.locale == const Locale('en'),
                onChanged: (v) {
                  context.read<ThemeBloc>().add(
                        LocaleChanged(
                          locale: v ? const Locale('en') : const Locale('uz'),
                        ),
                      );
                },
              );
            },
          ),
          const Center(
            child: TextField(),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        minimum: EdgeInsets.only(
          left: 16,
          right: 16,
          bottom: 16 + MediaQuery.of(context).viewInsets.bottom,
          top: 16,
        ),
        child: ElevatedButton(
          onPressed: () {},
          child: const Text("Button"),
        ),
      ),
    );
  }
}
