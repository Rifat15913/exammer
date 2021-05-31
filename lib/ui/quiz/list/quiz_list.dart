import 'package:exammer/common.dart';
import 'package:exammer/constants.dart';
import 'package:exammer/data/remote/model/quiz/quiz.dart';
import 'package:exammer/ui/quiz/list/quiz_list_controller.dart';
import 'package:exammer/ui/quiz/view/quiz.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

class QuizListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: systemUiOverlayStyleGlobal,
      child: Scaffold(
        backgroundColor: colorPageBackground,
        extendBodyBehindAppBar: true,
        body: GetBuilder<QuizListController>(
          id: "body",
          init: QuizListController(),
          builder: (controller) {
            return controller.isLoading
                ? centralProgressIndicator
                : SafeArea(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        buildContainerTopHood(),
                        Expanded(
                          child: buildSegment(controller),
                        ),
                      ],
                    ),
                  );
          },
        ),
      ),
    );
  }

  Widget buildSegment(QuizListController controller) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: StaggeredGridView.countBuilder(
        crossAxisCount: 4,
        itemCount: controller.quizList.length,
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemBuilder: (BuildContext context, int index) {
          return buildItem(
            index,
            controller.quizList[index],
          );
        },
        staggeredTileBuilder: (int index) {
          return StaggeredTile.fit(2);
        },
        mainAxisSpacing: 4.0,
        crossAxisSpacing: 4.0,
      ),
    );
  }

  Widget buildItem(int index, Quiz item) {
    return InkWell(
      onTap: () {
        Get.to(
          () => QuizPage(quiz: item),
        );
      },
      child: Card(
        shape: shapeCardItemRectangle,
        child: Container(
          child: Column(
            children: [
              Stack(
                children: [
                  ClipRRect(
                    child: Image.network(
                      "https://edu.google.com/images/social_image.jpg",
                      fit: BoxFit.cover,
                      height: 150,
                    ),
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6.0),
                      color: colorAccent,
                    ),
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                      "${item.totalQuestions} questions",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12.0,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.start,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ).marginOnly(
                    left: 8.0,
                    top: 8.0,
                  ),
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      item.name,
                      style: textStyleRegularBody,
                      textAlign: TextAlign.start,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 12.0,
                      right: 16.0,
                      top: 4.0,
                    ),
                    child: Row(
                      children: [
                        Image.asset(
                          "images/ic_clock.png",
                          fit: BoxFit.cover,
                          height: 24,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 4.0),
                          child: Text(
                            "${(item.totalTime ~/ 60)} Minutes ${(item.totalTime % 60)} Seconds",
                            style: textStyleSmallestBody,
                            textAlign: TextAlign.start,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ).marginSymmetric(vertical: 8.0),
            ],
          ),
        ),
      ),
    );
  }
}
