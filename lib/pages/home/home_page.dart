
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ulearning_app/common/values/colors.dart';
import 'package:ulearning_app/pages/home/bloc/home_page_bloc.dart';
import 'package:ulearning_app/pages/home/bloc/home_page_states.dart';
import 'package:ulearning_app/pages/home/home_controller.dart';
import 'package:ulearning_app/pages/home/widgets/home_page_widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  late HomeController? _homeController;
  GlobalKey _scaffoldKey = GlobalKey <ScaffoldState> ();

  @override
  void initState() {
    super.initState();
    _homeController = HomeController(context: context);
    _homeController?.init();
  }

  @override
  Widget build(BuildContext context) {
    if (_homeController?.userProfile == null) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(
                  Colors.white
                ),
                foregroundColor: WidgetStatePropertyAll(
                  Colors.black
                ),
                overlayColor: WidgetStatePropertyAll(
                  Colors.black.withAlpha(20),
                ),
              ),
              onPressed: () {
                setState(() {
                  _homeController = HomeController(context: context);
                  _homeController?.init();
                });
              },
              child: Center(
                child: Text(
                  "Something Went Wrong\nClick to refresh",
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        )
      );
    }

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: buildHomePageAppBar(_homeController!),
      body: Container(
        margin: EdgeInsets.only(
          top: 10.h,
          left: 22.w,
          right: 22.w,
        ),
        child: RefreshIndicator(
          onRefresh: () async {
            setState(() {
              _scaffoldKey = GlobalKey <ScaffoldState> ();
              _homeController?.init();
            });
          },
          backgroundColor: AppColors.primaryBackground,
          color: AppColors.primaryText,
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: homePageText(
                  "Hello",
                  color: AppColors.primaryThirdElementText,
                ),
              ),
              
              SliverToBoxAdapter(
                child: homePageText(
                  _homeController!.userProfile.name!,
                ),
              ),
              
              SliverToBoxAdapter(child: searchView()),
              
              SliverToBoxAdapter(
                child: BlocBuilder <HomePageBloc, HomePageStates> (
                  builder: (context, state) {
                    return slidersView(
                      state: state,
                      context: context,
                    );
                  },
                ),
              ),
          
              SliverToBoxAdapter(
                child: BlocBuilder <HomePageBloc, HomePageStates> (
                  builder: (context, state) {
                    return menuView(
                      state: state,
                      context: context,
                    );
                  },
                ),
              ),
          
              BlocBuilder <HomePageBloc, HomePageStates>(
                builder: (context, state) {
          
                  if (state.courseItem.isEmpty) {    
                    return SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 32.h,
                        ),
                        child: Center(
                          child: Text(
                            "There are no course right now",
                            style: TextStyle(
                              color: AppColors.primaryFourthElementText,
                            ),
                          ),
                        ),
                      ),
                    );
                  }
          
                  return SliverPadding(
                    padding: EdgeInsets.symmetric(
                      vertical: 18.h,
                    ),
                    sliver: SliverGrid(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 15,
                        crossAxisSpacing: 15,
                        childAspectRatio: 1.6
                      ),
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          return courseGrid(
                            state: state.courseItem.elementAt(index),
                          );
                        },
                        childCount: state.courseItem.length,
                      ),
                    ),
                  );
                }
              ),
            ],
          ),
        ),
      ),
    );
  }
}