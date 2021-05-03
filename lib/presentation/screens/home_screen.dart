import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:paperopoli_terminal/core/utils/constants.dart';
import 'package:paperopoli_terminal/cubits/authentication/authentication_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paperopoli_terminal/presentation/widgets/shipsWidget.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Map<String, dynamic> _selectedCategory = CATEGORIES[0];

  User _getUser() =>
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
                    CATEGORIES[index]['name'],
                    style: TextStyle(
                      color: _selectedCategory == CATEGORIES[index]
                          ? Colors.white
                          : Colors.white54,
                    ),
                  ),
                  leading: Icon(
                    CATEGORIES[index]['icon'],
                    color: _selectedCategory == CATEGORIES[index]
                        ? Colors.red
                        : Colors.white54,
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
                CATEGORIES[index]['name'],
                style: TextStyle(
                  color: _selectedCategory == CATEGORIES[index]
                      ? Colors.white
                      : Colors.white54,
                ),
              ),
              leading: Icon(
                CATEGORIES[index]['icon'],
                color: _selectedCategory == CATEGORIES[index]
                    ? Colors.red
                    : Colors.white54,
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
                  color: Colors.red,
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                ),
              ),
            )
          : SizedBox();

  Widget _buildMainWidget() {
    switch (_selectedCategory['name']) {
      case 'Dashboard':
        return Center();
      case 'Calendario':
        return Center();
      case 'Navi':
        return ShipsWidget();
      case 'Merci':
        return Center();
      case 'Veicoli':
        return Center();
      default:
        return SizedBox();
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Color(0xffE0E8F5),
        appBar: AppBar(
          title: Container(
            color: Color(0xffF44235),
            height: 40,
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.widgets,
                ),
                SizedBox(
                  width: 16,
                ),
                Text(
                  'Paperopoli Terminal'.toUpperCase(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          actions: [
            IconButton(
              icon: Icon(
                Icons.account_circle_outlined,
              ),
              onPressed: () {}, //TODO
            ),
            IconButton(
              icon: Icon(
                Ionicons.log_out_outline,
              ),
              onPressed: () async =>
                  await context.read<AuthenticationCubit>().logOut(),
            ),
          ],
        ),
        body: Row(
          children: [
            Drawer(
              child: Stack(
                children: [
                  SizedBox.expand(
                    child: Material(
                      color: Color(0xff1F2837),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 16,
                    ),
                    child: ListView.separated(
                      separatorBuilder: _buildSeparator,
                      shrinkWrap: true,
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
