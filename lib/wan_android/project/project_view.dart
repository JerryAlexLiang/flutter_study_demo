import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_study_demo/config/string_config.dart';
import 'package:flutter_study_demo/http/LoadState.dart';
import 'package:flutter_study_demo/wan_android/project/project_articles_view.dart';
import 'package:flutter_study_demo/widget/custom_underline_tabIndicator.dart';
import 'package:flutter_study_demo/widget/simple_empty_widget.dart';
import 'package:flutter_study_demo/widget/simple_loading_widget.dart';
import 'package:get/get.dart';

import 'project_logic.dart';

class ProjectPage extends GetView<ProjectLogic> {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.loadState.value == LoadState.loading) {
        return SimpleLoadingWidget(
          type: StringConfig.SIMPLE_CUPERTINO_LOADING_WIDGET,
        );
      } else if (controller.loadState.value == LoadState.success) {
        return Container(
          child: _wanProjectView(),
        );
      } else if (controller.loadState.value == LoadState.empty) {
        return SimpleEmptyWidget(
          type: StringConfig.SIMPLE_EMPTY_WIDGET,
          callback: () => controller.initProjectList(),
        );
      } else if (controller.loadState.value == LoadState.fail) {
        return SimpleEmptyWidget(
          type: StringConfig.SIMPLE_ERROR_WIDGET,
          callback: () => controller.initProjectList(),
        );
      }
      return null;
    });
  }

  Widget _wanProjectView() {
    return Scaffold(
      appBar: AppBar(
        /// AppBar总高度 = 导航栏高度（默认56）+ bottom preferredSize高度（默认0）
        /// TabBar不带icon默认高度为48，因此指定导航栏高度为48
        toolbarHeight: 48,
        title: _buildProjectTab(),
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: _buildProjectPages(),
      ),
    );
  }

  _buildProjectTab() {
    var projects = controller.projects;

    var tabList = projects
        .map((element) => Tab(
              text: element?.name,
            ))
        .toList();

    return TabBar(
      tabs: tabList,
      isScrollable: true,
      indicatorColor: Colors.red,
      indicatorSize: TabBarIndicatorSize.label,
      indicatorWeight: 3,
      //自定义indicator指示器
      indicator: CustomUnderlineTabIndicator(
        borderSide: BorderSide(
          width: 5,
          color: Colors.red,
        ),
        insets: EdgeInsets.only(
          left: 18,
          right: 18,
          top: 10,
          // bottom: 3,
        ),
      ),
      automaticIndicatorColorAdjustment: true,
      labelStyle: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
      unselectedLabelStyle: TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.normal,
      ),
      controller: controller.tabController,
    );
  }

  Widget _buildProjectPages() {
    var projects = controller.projects;

    var tabPagesList = projects
        .map((element) => Center(
              child: ProjectArticlesPage(
                id: element.id,
              ),
            ))
        .toList();

    return TabBarView(
      controller: controller.tabController,
      children: tabPagesList,
    );
  }
}
