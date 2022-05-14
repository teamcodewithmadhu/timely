import 'package:flutter/material.dart';
import 'package:timely/modules/home/widgets/timely_tab_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this);

    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: SafeArea(
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(kToolbarHeight),
            child: TimelyTabBar(tabController: _tabController),
          ),
          body: TabBarView(
            controller: _tabController,
            children: const [
              Icon(Icons.alarm),
              Icon(Icons.watch_later_outlined),
              Icon(Icons.timer_outlined),
              Icon(Icons.hourglass_empty_outlined),
            ],
          ),
        ),
      ),
    );
  }
}
