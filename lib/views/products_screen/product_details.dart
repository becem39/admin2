import 'package:admin/const/const.dart';
import 'package:admin/views/widgets/normal_text.dart';
import 'package:get/get.dart';

class ProductDetails extends StatelessWidget {
  final dynamic data;
  const ProductDetails({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: darkGrey,
            )),
        title: boldText(text: data['p_name'], color: fontGrey, size: 16),
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
                  itemCount: data['p_images'].length,
                  itemBuilder: (context, index) {
                    return Image.network(
                      data['p_images'][index],
                      width: double.infinity,
                      fit: BoxFit.fitHeight,
                    );
                  }),
              10.heightBox,
              boldText(text: data['p_name'], color: fontGrey, size: 16),
              10.heightBox,
              Row(
                children: [
                  boldText(text: data['p_category'], color: fontGrey, size: 16),
                  10.widthBox,
                  boldText(
                      text: data["p_subCategory"], color: fontGrey, size: 16),
                ],
              ),
              10.heightBox,
              VxRating(
                isSelectable: false,
                value: double.parse(data['p_rating']),
                onRatingUpdate: (value) {},
                normalColor: textfieldGrey,
                selectionColor: golden,
                count: 5,
                size: 25,
                maxRating: 5,
              ),
              10.heightBox,
              boldText(text: "${data['p_price']} TND", color: red, size: 18),
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
                      normalText(text: data['p_quantity'], color: fontGrey),
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
