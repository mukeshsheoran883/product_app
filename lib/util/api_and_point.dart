

class ApiEndpoints{
//static const String baseURL = "http://192.168.118.15:3000/";
static const String baseURL = "https://api.escuelajs.co/api/v1/";
// static const String baseURL = "http://192.168.1.70:3000/";
static const String product = "${baseURL}products";

static String getProductUrl(String id) {
  return '${baseURL}products/$id';
}

static String updateProductUrl(int id) {
  return '${baseURL}products/$id';
}

static String addProductUrl(){
  return '${baseURL}addProduct';
}
}

