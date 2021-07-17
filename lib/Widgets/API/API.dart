class APIData
{
	static const String domainLink = "https://projects.sapco.digital/baby-munchkins/";
	static const String domainApiLink = domainLink+"api/";

	// API Links

	// user module
	static const String registration = domainApiLink + "registration";
	static const String loginWithEmail = domainApiLink + "loginWithEmail";
	static const String loginWithPhone = domainApiLink + "loginWithPhone";
	static const String influencerRegistration = domainApiLink + "influncerRegistration";
	static const String addUserDetails = domainApiLink + "addUserDetails";
	static const String getUserDetails = domainApiLink + "getUserDetails";
	static const String sendOTP = domainApiLink + "otpLogin";

	// products module
	static const String getAllCategories = domainApiLink + "getCategoryList";
	static const String getSubCategory = domainApiLink + "getSubCategoryList";
	static const String getProductList = domainApiLink + "getProductList";
	static const String getBrandList = domainApiLink + "getBrandList";
	static const String getProductsByBrands = domainApiLink + "getProductByBrand";
	static const String getNewArrivedProducts = domainApiLink + "getNewArrivedProducts";
	static const String getProductDetails = domainApiLink + "getProductDetails";

	// wishlist
	static const String getWishlist = domainApiLink + "getWishList";
	static const String addToWishlist = domainApiLink + "productAddWishlist";

	// cart
	static const String addToCart = domainApiLink + "productAddToCart";
	static const String getCartProducts = domainApiLink + "getCartList";

	// search
	static const String search = domainApiLink + "searchProductList?search=";
}