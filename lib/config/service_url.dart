const serviceUrl = 'https://www.wanandroid.com/';

const servicePath = {
  //首页Banner
  'homePageBanner': serviceUrl + 'banner/json',
};

class WanAndroidApi {
  //首页Banner https://www.wanandroid.com/banner/json
  static String homePageBanner = '${serviceUrl}banner/json';

  //首页文章列表 https://www.wanandroid.com/article/list/0/json
  static String homeArticleList = '${serviceUrl}article/list/';

}

const eyeServiceUrl = 'http://baobab.kaiyanapp.com/api/';

class EyeApi {
  //开眼-分类 http://baobab.kaiyanapp.com/api/v4/categories
  static String categoryUrl = '${eyeServiceUrl}v4/categories';

  //开眼-专题 http://baobab.kaiyanapp.com/api/v3/specialTopics
  static String specialTopicsUrl = '${eyeServiceUrl}v3/specialTopics';
}
