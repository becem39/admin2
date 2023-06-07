import 'package:admin/const/const.dart';
import 'package:admin/views/widgets/normal_text.dart';
import 'package:get/get.dart';

class ProductDetails extends StatelessWidget {
  const ProductDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.arrow_back,
              color: darkGrey,
            )),
        title: boldText(text: "Product details", color: fontGrey, size: 16),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              VxSwiper.builder(
                  autoPlay: true,
                  height: 350,
                  aspectRatio: 16 / 9,
                  viewportFraction: 1.0,
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return Image.asset(
                      imgProduct,
                      width: double.infinity,
                      fit: BoxFit.fitHeight,
                    );
                  }),
              10.heightBox,
              boldText(text: "Product title", color: fontGrey, size: 16),
              10.heightBox,
              Row(
                children: [
                  boldText(text: "Category", color: fontGrey, size: 16),
                  10.widthBox,
                  boldText(text: "SubCategory", color: fontGrey, size: 16),
                ],
              ),
              10.heightBox,
              VxRating(
                isSelectable: false,
                value: 3.0,
                //double.parse(data['p_rating']),
                onRatingUpdate: (value) {},
                normalColor: textfieldGrey,
                selectionColor: golden,
                count: 5,
                size: 25,
                maxRating: 5,
              ),
              10.heightBox,
              boldText(text: "12 TND", color: red, size: 18),
              10.heightBox,
              ////////

              Column(
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 100,
                        child: normalText(text: "Quantity", color: fontGrey),
                      ),
                      normalText(text: "20", color: fontGrey),
                    ],
                  ),
                ],
              ).box.white.padding(const EdgeInsets.all(8)).make(),

              ////////
            ],
          ),
        ),
      ),
    );
  }
}
