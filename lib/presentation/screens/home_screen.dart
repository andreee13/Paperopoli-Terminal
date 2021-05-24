import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:paperopoli_terminal/core/utils/constants.dart';
import 'package:paperopoli_terminal/cubits/authentication/authentication_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paperopoli_terminal/data/models/category_model.dart';
import 'package:paperopoli_terminal/presentation/widgets/categories/goodsWidget.dart';
import 'package:paperopoli_terminal/presentation/widgets/categories/shipsWidget.dart';
import 'package:paperopoli_terminal/presentation/widgets/categories/vehiclesWidget.dart';
import 'package:paperopoli_terminal/presentation/widgets/views/calendarWidget.dart';
import 'package:paperopoli_terminal/presentation/widgets/views/dashboardWidget.dart';
import 'package:paperopoli_terminal/presentation/widgets/views/operationsWidget.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();

  static _HomeScreenState? of(
    BuildContext context,
  ) =>
      context.findAncestorStateOfType<_HomeScreenState>();
}

class _HomeScreenState extends State<HomeScreen> {
  CategoryModel _selectedCategory = CATEGORIES[0];

  User getUser() =>
      (context.read<AuthenticationCubit>().state as AuthenticationLogged).user!;

  Widget _buildCategories(
    BuildContext _,
    int index,
  ) =>
      index == 0
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSeparator(_, 5),
                ListTile(
                  title: Text(
                    CATEGORIES[index].name,
                    style: TextStyle(
                      color: _selectedCategory == CATEGORIES[index]
                          ? Colors.white
                          : Color(0xff909399),
                    ),
                  ),
                  leading: Icon(
                    CATEGORIES[index].mainIcon,
                    color: _selectedCategory == CATEGORIES[index]
                        ? Colors.white
                        : Color(0xff909399),
                  ),
                  selected: _selectedCategory == CATEGORIES[index],
                  hoverColor: Colors.white10,
                  selectedTileColor: Colors.white10,
                  onTap: () {
                    setState(() {
                      _selectedCategory = CATEGORIES[index];
                    });
                  },
                ),
              ],
            )
          : ListTile(
              title: Text(
                CATEGORIES[index].name,
                style: TextStyle(
                  color: _selectedCategory == CATEGORIES[index]
                      ? Colors.white
                      : Color(0xff909399),
                ),
              ),
              leading: Icon(
                CATEGORIES[index].mainIcon,
                color: _selectedCategory == CATEGORIES[index]
                    ? Colors.white
                    : Color(0xff909399),
              ),
              selected: _selectedCategory == CATEGORIES[index],
              hoverColor: Colors.white10,
              selectedTileColor: Colors.white10,
              onTap: () {
                setState(() {
                  _selectedCategory = CATEGORIES[index];
                });
              },
            );

  Widget _buildSeparator(
    BuildContext _,
    int index,
  ) =>
      index == 1 || index == 5
          ? Padding(
              padding: const EdgeInsets.only(
                top: 30,
                bottom: 16,
                left: 16,
              ),
              child: Text(
                index == 1 ? 'Categorie' : 'Viste',
                style: TextStyle(
                  color: Colors.white60,
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                ),
              ),
            )
          : SizedBox();

  Widget _buildMainWidget() {
    switch (_selectedCategory.name) {
      case 'Dashboard':
        return DashboardWidget();
      case 'Programma':
        return CalendarWidget();
      case 'Operazioni':
        return OperationsWidget();
      case 'Navi':
        return ShipsWidget();
      case 'Merci':
        return GoodsWidget();
      case 'Veicoli':
        return VehiclesWidget();
      default:
        return SizedBox();
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.white,
        floatingActionButton: CATEGORIES.indexOf(_selectedCategory) > 1
            ? FloatingActionButton(
                onPressed: () {},
                //onPressed: () => _buildNewItemScreen(),
                child: Icon(
                  Icons.add,
                ),
              )
            : null,
        /*appBar: AppBar(
          title: Container(
            color: Color(0xffF44235),
            height: 40,
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
            ),
            child: MaterialButton(
              hoverColor: Colors.black.withOpacity(
                0.1,
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  10,
                ),
              ),
              onPressed: () => setState(
                () => _selectedCategory = CATEGORIES[0],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/images/ship_icon_white.png',
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    'Paperopoli Terminal',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            IconButton(
              icon: Icon(
                Icons.account_circle_outlined,
              ),
              onPressed: () async {
                printWrapped(
                  await FirebaseAuth.instance.currentUser!.getIdToken(),
                );
              }, //TODO
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              child: IconButton(
                icon: Icon(
                  Ionicons.power,
                ),
                onPressed: () async => await showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text(
                      'Logout',
                    ),
                    content: Text(
                      'Vuoi davverro effetuare il logout?',
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(
                          context,
                          false,
                        ),
                        child: Text(
                          'Annulla',
                        ),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(
                          context,
                          true,
                        ),
                        child: Text(
                          'Logout',
                        ),
                      ),
                    ],
                  ),
                ).then(
                  (value) async => value
                      ? await context.read<AuthenticationCubit>().logOut()
                      : {},
                ),
              ),
            ),
          ],
        ),
        */
        body: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Drawer(
              elevation: 0,
              child: Stack(
                children: [
                  SizedBox.expand(
                    child: Material(
                      color: Colors.white,
                    ),
                  ),
                  SizedBox.expand(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        right: 32,
                      ),
                      child: Material(
                        color: Color(0xff242342),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(
                        16,
                        8,
                        48,
                        16,
                      ),
                      child: Image.asset(
                        'assets/images/ship_icon_white.png',
                        height: 125,
                        width: 125,
                      ),
                    ),
                  ),
                  Center(
                    child: ListView.separated(
                      shrinkWrap: true,
                      separatorBuilder: _buildSeparator,
                      itemBuilder: _buildCategories,
                      itemCount: CATEGORIES.length,
                    ),
                  ),
                ],
              ),
            ),
            _buildMainWidget(),
          ],
        ),
      );
}
