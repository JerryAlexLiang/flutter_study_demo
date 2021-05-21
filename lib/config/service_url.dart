const serviceUrl = 'https://www.wanandroid.com/';

const servicePath = {
  //首页Banner
  'homePageBanner': serviceUrl + 'banner/json',
};

const eyeServiceUrl = 'http://baobab.kaiyanapp.com/api/';

class EyeApi {
  //开眼-分类
  static String categoryUrl = '${eyeServiceUrl}v4/categories';

  //开眼-专题
  static String specialTopicsUrl = '${eyeServiceUrl}v3/specialTopics';
}
