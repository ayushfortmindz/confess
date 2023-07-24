import 'package:confess/constant/color.dart';
import 'package:confess/screen/dashboard/dashboard_bloc/dashboard_bloc.dart';
import 'package:confess/screen/dashboard/widget/molecule/confess_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hoverover/hoverover.dart';
import 'package:responsive_framework/responsive_framework.dart';

class TabDashboardScreen extends StatefulWidget {
  const TabDashboardScreen({super.key});
  //route name
  static const String routeName = '/dashboard';

  @override
  State<TabDashboardScreen> createState() => _TabDashboardScreenState();
}

class _TabDashboardScreenState extends State<TabDashboardScreen> {
  late DashboardBloc dashboardBloc;
  @override
  void initState() {
    dashboardBloc = context.read<DashboardBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Row(
              children: [
                const Text(
                  'Confess.life',
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    color: Color(0xff1E0E62),
                  ),
                ),
                const Spacer(),
                HoverOver(
                  builder: (isHovered) {
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: isHovered ? Colors.white : Kcolor.pink,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(100),
                        ),
                        border: Border.all(
                          color: isHovered ? Kcolor.pink : Colors.white,
                        ),
                      ),
                      child: Text(
                        'Add Confession',
                        style: TextStyle(
                          color: isHovered ? Kcolor.pink : Colors.white,
                        ),
                      ),
                    );
                  },
                )
              ],
            ),
          ),
          const SizedBox(height: 20),
          Center(
            child: Text(
              'Latest confessions from around the world',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w900,
                color: Kcolor.purple,
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 8),
              child: SizedBox(
                width: 600,
                child: Text(
                  'Confess.life is a place where you can share your confessions anonymously and read confessions from other people.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Kcolor.grey,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Center(
            child: HoverOver(
              builder: (isHovered) {
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: isHovered ? Colors.white : Kcolor.pink,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(100),
                    ),
                    border: Border.all(
                      color: isHovered ? Kcolor.pink : Colors.white,
                    ),
                  ),
                  child: Text(
                    'Add Confession',
                    style: TextStyle(
                      color: isHovered ? Kcolor.pink : Colors.white,
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 20),
          BlocBuilder<DashboardBloc, DashboardState>(
            bloc: dashboardBloc,
            builder: (context, state) {
              return state.maybeWhen(
                orElse: () => const Center(
                  child: CircularProgressIndicator.adaptive(),
                ),
                loaded: (confessionList) => Center(
                  child: ResponsiveGridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: confessionList.length,
                    gridDelegate: const ResponsiveGridDelegate(
                      maxCrossAxisExtent: 300,
                      mainAxisSpacing: 20,
                      childAspectRatio: 16 / 12,
                      crossAxisSpacing: 20,
                    ),
                    itemBuilder: (context, index) =>
                        ConfessWidget(confession: confessionList[index]),
                  ),
                ),
                error: (message) => Center(
                  child: Text(message),
                ),
              );
            },
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
