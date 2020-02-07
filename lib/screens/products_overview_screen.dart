import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import '../screens/cart_screen.dart';
import '../widgets/products_grid.dart';
import '../widgets/main_drawer.dart';
import '../widgets/badge.dart';
import '../providers/cart.dart';
import '../providers/products.dart';

enum FilterOptions {
  Favourites,
  All,
}

class ProductsOverviewScreen extends StatefulWidget {
  static const routeName = '/products-main-screen';
  @override
  _ProductsOverviewScreenState createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  bool _showOnlyFavourites = false;
  // var _isInit = true;

  /*
  @override
  void initState() {
    // if used without listen: false, it won't work.
    // setState(() {
    //   _isLoading = true;
    // });

    // Provider.of<Products>(context, listen: false)
    //     .fetchAndSetProducts()
    //     .then((_) {
    //   setState(() {
    //     _isLoading = false;
    //   });
    // });
    /*
    // if you still want to use it then use the following.
    // of context things dont work in init method but one can use it by replacing the code of provider below. for eg. ModalRoute
    */
    Future.delayed(Duration.zero).then((_) {
      if (_isInit) {
        setState(() {
          _isLoading = true;
        });

        Provider.of<Products>(context, listen: false)
            .fetchAndSetProducts()
            .then((_) {
          setState(() {
            _isLoading = false;
          });
        });
      }
      _isInit = false;
    });

    //If u are not happy with this then you can use didChangeDependencies lifecycle method, since it runs multiple times remember to run it only once by setting up a boolean.
    super.initState();
  }
  */
  // @override
  // void didChangeDependencies() {
  //   if (_isInit) {
  //     setState(() {
  //       _isLoading = true;
  //     });

  //     Provider.of<Products>(context).fetchAndSetProducts().then((_) {
  //       setState(() {
  //         _isLoading = false;
  //       });
  //     });
  //   }
  //   _isInit = false;
  //   super.didChangeDependencies();
  // }
  Future<void> _refreshProducts(BuildContext context) async {
    await Provider.of<Products>(context, listen: false).fetchAndSetProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "MyShop",
        ),
        actions: <Widget>[
          PopupMenuButton(
            onSelected: (FilterOptions selectedValue) {
              setState(
                () {
                  if (selectedValue == FilterOptions.Favourites) {
                    _showOnlyFavourites = true;
                  } else {
                    _showOnlyFavourites = false;
                  }
                },
              );
            },
            icon: Icon(Icons.more_vert),
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text('Only Favourites!'),
                value: FilterOptions.Favourites,
              ),
              PopupMenuItem(
                child: Text('Show all'),
                value: FilterOptions.All,
              ),
            ],
          ),
          Consumer<Cart>(
            builder: (_, cart, ch) => Badge(
              child: ch,
              value: cart.itemCount.toString(),
            ),
            child: IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.of(context).pushNamed(CartScreen.routeName);
              },
            ),
          ),
        ],
      ),
      drawer: MainDrawer(),
      body: RefreshIndicator(
        onRefresh: () => _refreshProducts(context),
        child: FutureBuilder(
          future: Provider.of<Products>(context, listen: false)
              .fetchAndSetProducts(),
          builder: (ctx, dataSnapshot) {
            if (dataSnapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              if (dataSnapshot.error != null) {
                return Center(
                  child: Text('An error occured!'),
                );
              } else {
                return ProductsGrid(_showOnlyFavourites);
              }
            }
          },
        ),
      ),
    );
  }
}
