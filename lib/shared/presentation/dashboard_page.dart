import 'package:astro_app/astro_chat/presentation/astro_chat_page.dart';
import 'package:astro_app/impact_risk/presentation/impact_risk_page.dart';
import 'package:astro_app/shared/application/asteroids_page_controller.dart';
import 'package:astro_app/shared/application/asteroids_page_controller_state.dart';
import 'package:astro_app/shared/application/bottom_nav_bar.dart';
import 'package:astro_app/shared/domain/fetch_last_connection_use_case.dart';
import 'package:astro_app/shared/domain/fetch_neo_use_case.dart';
import 'package:astro_app/shared/domain/string_constants.dart';
import 'package:astro_app/shared/presentation/asteroid_details.dart';
import 'package:astro_app/shared/presentation/color_constants.dart';
import 'package:astro_app/shared/presentation/widgets/asteroid_widget.dart';
import 'package:astro_app/shared/presentation/widgets/date_picker.dart';
import 'package:astro_app/shared/presentation/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({
    super.key,
    required this.fetchNEOUseCase,
    required this.fetchLastConnectionUseCase,
  });

  final FetchNeoUseCase fetchNEOUseCase;
  final FetchLastConnectionUseCase fetchLastConnectionUseCase;
  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final bottomNavBarPageController = PageController();

  late final BottomNavBarController bottomNavBarController;
  @override
  void initState() {
    super.initState();

    bottomNavBarController = BottomNavBarController(bottomNavBarPageController);
  }

  @override
  void dispose() {
    bottomNavBarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: ValueListenableBuilder<int>(
        valueListenable: bottomNavBarController,
        builder: (_, val, __) => BottomNavigationBar(
          onTap: bottomNavBarController.changedSelection,
          selectedItemColor: Colors.amber[900],
          currentIndex: val,
          items: [
            const BottomNavigationBarItem(
              icon: Icon(
                Icons.satellite_alt_outlined,
              ),
              label: 'Asteroides',
            ),
            const BottomNavigationBarItem(
              icon: Icon(
                Icons.chat_bubble_outline,
              ),
              label: 'AstroChat',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                StringConstants.telescopeIconPath,
                height: 24,
                // ignore: deprecated_member_use
                color: Colors.white,
              ),
              label: 'Monitoreo',
            ),
          ],
        ),
      ),
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: bottomNavBarPageController,
        children: [
          _AsteroidsPage(
            widget.fetchNEOUseCase,
            widget.fetchLastConnectionUseCase,
          ),
          AstroChatPage(),
          const ImpactRiskPage(),
        ],
      ),
    );
  }
}

class _AsteroidsPage extends StatelessWidget {
  const _AsteroidsPage(
    this.fetchNEOUseCase,
    this.fetchLastConnectionUseCase,
  );
  final FetchNeoUseCase fetchNEOUseCase;
  final FetchLastConnectionUseCase fetchLastConnectionUseCase;
  @override
  Widget build(BuildContext context) {
    final asteroidsPageController = AsteroidsPageController(
      fetchNEOUseCase,
      fetchLastConnectionUseCase,
    )..inited();
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
        ),
        child: CustomScrollView(
          slivers: [
            const _Separator(
              height: 40,
            ),
            SliverToBoxAdapter(
              child: Text(
                '¡Bienvenido!',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            const _Separator(
              height: 20,
            ),
            SliverToBoxAdapter(
              child: InkWell(
                onTap: () {},
                splashColor: ColorConstants.redColor,
                borderRadius: BorderRadius.circular(20),
                child: Ink(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                  ),
                  decoration: BoxDecoration(
                    color: ColorConstants.darkBlueColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 7,
                        child: ValueListenableBuilder<AsteroidsPageControllerState>(
                          valueListenable: asteroidsPageController,
                          builder: (_, snapshot, __) {
                            return Text(
                              'Han pasado ${snapshot.asteroidsSinceLastVisit} asteroides cerca de la tierra desde tu última visita',
                              style: Theme.of(context).textTheme.titleSmall,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            );
                          },
                        ),
                      ),
                      const Spacer(),
                      const Flexible(
                        child: Asteroid(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const _Separator(
              height: 16,
            ),
            SliverToBoxAdapter(
              child: Row(
                children: [
                  Expanded(
                    flex: 10,
                    child: Text(
                      'Desde',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                  const Spacer(),
                  Expanded(
                    flex: 10,
                    child: Text(
                      'Hasta',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                ],
              ),
            ),
            const _Separator(
              height: 8,
            ),
            SliverAppBar(
              pinned: true,
              backgroundColor: Colors.black,
              title: Row(
                children: [
                  Expanded(
                    flex: 10,
                    child: ValueListenableBuilder<AsteroidsPageControllerState>(
                      valueListenable: asteroidsPageController,
                      builder: (_, snapshot, __) {
                        return DateSelectorWidget(
                          label: 'Desde',
                          showErrors: false,
                          value: snapshot.filterDateFrom,
                          controller: TextEditingController(
                            text: DateFormat.yMd().format(
                              snapshot.filterDateFrom,
                            ),
                          ),
                          onChanged: asteroidsPageController.changedFromDate,
                        );
                      },
                    ),
                  ),
                  const Spacer(),
                  Expanded(
                    flex: 10,
                    child: ValueListenableBuilder<AsteroidsPageControllerState>(
                      valueListenable: asteroidsPageController,
                      builder: (_, snapshot, __) {
                        return DateSelectorWidget(
                          label: 'Hasta',
                          showErrors: false,
                          value: snapshot.filterDateUntil,
                          controller: TextEditingController(
                            text: DateFormat.yMd().format(
                              snapshot.filterDateUntil,
                            ),
                          ),
                          minDate: snapshot.filterDateFrom,
                          onChanged: asteroidsPageController.changedUntilDate,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            const _Separator(
              height: 8,
            ),
            SliverToBoxAdapter(
              child: AnimatedSwitcher(
                duration: const Duration(
                  milliseconds: 400,
                ),
                switchInCurve: Curves.easeIn,
                switchOutCurve: Curves.easeOut,
                child: ValueListenableBuilder<AsteroidsPageControllerState>(
                  valueListenable: asteroidsPageController,
                  builder: (_, snapshot, __) => snapshot.isLoading
                      ? const Loader()
                      : OutlinedButton(
                          onPressed: asteroidsPageController.submitted,
                          child: const Text('Buscar'),
                        ),
                ),
              ),
            ),
            const _Separator(
              height: 16,
            ),
            ValueListenableBuilder<AsteroidsPageControllerState>(
              valueListenable: asteroidsPageController,
              builder: (_, snapshot, __) {
                return SliverList.separated(
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 8,
                  ),
                  itemCount: snapshot.asteroidsToShow.length,
                  itemBuilder: (_, i) {
                    final asteroid = snapshot.asteroidsToShow[i];
                    return Hero(
                      tag: 'asteroid_tile$i',
                      child: ListTile(
                        tileColor: ColorConstants.darkBlueColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            20,
                          ),
                        ),
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (_) => AsteroidDetails(
                              asteroid: asteroid,
                            ),
                          );
                        },
                        title: Text(
                          asteroid.name,
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        subtitle: Text(
                          'Distancia: ${NumberFormat.decimalPattern().format(
                            asteroid.approachData.distanceKM,
                          )} KM',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        trailing: Asteroid(
                          size: 40,
                          isHazardous: asteroid.isHazardous,
                          isPotentialImpact: asteroid.isSentry,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _Separator extends StatelessWidget {
  const _Separator({
    super.key,
    required this.height,
  });
  final double height;
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: height,
      ),
    );
  }
}
