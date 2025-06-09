import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';
import 'package:teslo_shop/features/products/presentation/providers/providers.dart';
import 'package:teslo_shop/features/shared/shared.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      drawer: SideMenu( scaffoldKey: scaffoldKey ),
      appBar: AppBar(
        title: const Text('Products'),
        actions: [
          IconButton(
            onPressed: (){}, 
            icon: const Icon( Icons.search_rounded)
          )
        ],
      ),
      body: const _ProductsView(),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text('Nuevo producto'),
        icon: const Icon( Icons.add ),
        onPressed: () {},
      ),
    );
  }
}


class _ProductsView extends ConsumerStatefulWidget {
  const _ProductsView();

  @override
  _ProductsViewState createState() => _ProductsViewState();
}

class _ProductsViewState extends ConsumerState {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scrollController.addListener(() {
     if((scrollController.position.pixels + 400) >= scrollController.position.maxScrollExtent){
       ref.read(productsProvider.notifier).loadNextPage();
     }
    });
    ref.read(productsProvider.notifier).loadNextPage();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    scrollController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final productsState = ref.watch(productsProvider);
    return Padding(padding: EdgeInsets.symmetric(horizontal: 10),
    child: MasonryGridView.count(
      controller: scrollController,
      physics: BouncingScrollPhysics(),
      crossAxisCount: 2, 
      mainAxisSpacing: 20,
      crossAxisSpacing: 35,
      itemCount: productsState.products.length,
      itemBuilder: (context, index){
        final product = productsState.products[index];
        return GestureDetector(
          onTap: () => context.push('/product/${product.id}'),
          child: Column(
            children: [
              _ImageViewer(images: product.images),
              Text(product.title,textAlign: TextAlign.center,),
              SizedBox(height: 20,)
            ],
          ),
        );

      }),
    );
  }
}

class _ImageViewer extends StatelessWidget {
  final List<String> images;

  const _ImageViewer({super.key, required this.images});
  
  @override
  Widget build(BuildContext context) {
    if(images.isEmpty){
      return ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.asset('assets/no-image.jpg', fit: BoxFit.cover,
        height: 250,
        ),
      );
    }
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: FadeInImage(
        fit: BoxFit.cover,
        height: 250,
        fadeOutDuration: Duration(milliseconds: 100),
        fadeInDuration:  Duration(milliseconds: 200),
        placeholder: AssetImage('assets/loaders/bottle-loader.gif'), 
        image: NetworkImage(images.first)
        
        ),
    );
  }
  
}

