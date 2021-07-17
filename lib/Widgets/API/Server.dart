
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:hypd/Widgets/API/API.dart';
import 'package:hypd/global.dart';

class Server
{
	// new registrartion customer
	static customerRegistration(email, phone, password, dob) async
	{
		try
		{
			var response = await  http.post
			(
				Uri.parse(APIData.registration),
				body:
				{
					"email": email,
					"password": password,
					"phone": phone,
					"dob": dob,
					"type": "customer"
				}
			);

			var responseJson = jsonDecode(response.body);

			if(responseJson["status"] == 0)
			{
				return responseJson["response"];
			}
			else
			{
				return false;
			}
		}
		catch(e)
		{
			print(e);
		}
	}

	// login with email
	static loginWithEmail(email, password) async
	{
		try
		{
			var response = await  http.post
			(
				Uri.parse(APIData.loginWithEmail),
				body:
				{
					"email": email,
					"password": password,
				}
			);

			var responseJson = jsonDecode(response.body);

			if(responseJson["status"] == 0)
			{
				print(response.statusCode);
				print(response);
				return responseJson["response"];
			}
			else
			{
				return false;
			}
		}
		catch(e)
		{
			print(e);
		}
	}

	// login with phone
	static loginWithPhone(phone) async
	{
		print(phone);
		try
		{
			var response = await  http.post
			(
				Uri.parse(APIData.loginWithPhone),
				body:
				{
					"phone": phone
				}
			);

			var responseJson = jsonDecode(response.body);

			if(responseJson["status"] == 0)
			{
				return responseJson;
			}
			else
			{
				return false;
			}
		}
		catch(e)
		{
			print(e);
		}
	}

	// send otp
	static sendOTP(otp, userId) async
	{
		try
		{
			var response = await  http.post
			(
				Uri.parse(APIData.sendOTP),
				body:
				{
					"userId": userId,
					"otp": otp
				}
			);

			var responseJson = jsonDecode(response.body);

			if(responseJson["status"] == 0)
			{
				return responseJson;
			}
			else
			{
				return false;
			}
		}
		catch(e)
		{
			print(e);
		}
	}

	// influencer registration
	static influencerRegistration(name, email, phone, dob, city, facebookLink, youtubeLink, instaLink, twitterLink, password) async
	{
		try
		{
			var response = await  http.post
			(
				Uri.parse(APIData.influencerRegistration),
				body:
				{
					"name": name,
					"email": email,
					"phone": phone,
					"dob": dob,
					"city": city,
					"type": "influencer",
					"facebbokLink": facebookLink,
					"youtubeLink": youtubeLink,
					"twitterLink": instaLink,
					"instagramLink": twitterLink,
					"password":  password

				}
			);

			var responseJson = jsonDecode(response.body);

			print(responseJson);

			if(responseJson["status"] == 0)
			{
				return responseJson["response"];
			}
			else
			{
				return false;
			}
		}
		catch(e)
		{
			print(e);
		}
	}

	// add user details
	static addUserDetails(name, phone, dob, userId, gender, image) async
	{

		var map = new Map<String, dynamic>();

		map["name"] = name;
		map["dob"] = dob;
		map["userId"] = user["id"];
		map["gender"] = gender;
		map["image"] = "";

		try
		{
			var formData = FormData.fromMap(map);

			var dio = Dio();

			var response = await dio.post(APIData.addUserDetails, data: formData);
			var responseData = json.decode(response.data);

			if(responseData["status"] == 0)
			{
				var userData = await getUserDetails(user["id"]);

				print(userData);

				user["image"] = userData["image"];
				user["name"] = userData["name"];
				user["phone"] = userData["phone"];
				user["gender"] = userData["gender"];

				if(userData != null)
				{
					return responseData["response"];
				}
				else
				{
					return false;
				}
			}
			else
			{
				return false;
			}
		}
		catch(e)
		{
			print(e);
		}
	}

	static getUserDetails(id) async
	{
		try
		{
			var response = await http.get(Uri.parse(APIData.getUserDetails + "/" + id));

			var responseJson = jsonDecode(response.body);

			if(responseJson["status"] == 0)
			{
				return responseJson["response"];
			}
			else
			{
				return false;
			}
		}
		catch(e)
		{
			print(e);
		}
	}

	static editUserDetails(name, gender, dob, image) async
	{
		var map = new Map<String, dynamic>();

		map["name"] = name;
		map["dob"] = dob;
		map["userId"] = user["id"];
		map["gender"] = gender;
		map["image"] = await MultipartFile.fromFile(image, filename: 'file.jpg');

		try
		{
			var formData = FormData.fromMap(map);

			var dio = Dio();

			var response = await dio.post(APIData.addUserDetails, data: formData);
			var responseData = json.decode(response.data);

			print(responseData);

			if(responseData["status"] == 0)
			{
				var userData = await getUserDetails(user["id"]);

				print(userData);

				user["image"] = userData["image"];
				user["name"] = userData["name"];
				user["phone"] = userData["phone"];
				user["gender"] = userData["gender"];

				if(userData != null)
				{
					return responseData["response"];
				}
				else
				{
					return false;
				}
			}
			else
			{
				return false;
			}
		}
		catch(e)
		{
			print(e);
		}
	}


	// -----------------------------------------------PRODUCTS----------------------------------------------------------------

	// get all categoris
	static getAllCategories() async
	{
		try
		{
			var response = await http.get(Uri.parse(APIData.getAllCategories));

			var responseJson = jsonDecode(response.body);

			if(responseJson["status"] == 0)
			{
				return responseJson["categoryList"];
			}
			else
			{
				return false;
			}
		}
		catch(e)
		{
			print(e);
		}
	}

	// get all sub categoris
	static getSubCategories(id) async
	{
		try
		{
			var response = await http.get(Uri.parse(APIData.getSubCategory + "/" + id.toString()));

			var responseJson = jsonDecode(response.body);

			if(responseJson["status"] == 0)
			{
				return responseJson["subCategoryList"];
			}
			else
			{
				return false;
			}
		}
		catch(e)
		{
			print(e);
		}
	}

	// get all sub categoris products
	static getAllProducts(categoryId, subCategoryId) async
	{
		try
		{
			var response = await http.get(Uri.parse(APIData.getProductList + "/" + categoryId.toString() + "/" + subCategoryId.toString()));

			var responseJson = jsonDecode(response.body);

			if(responseJson["status"] == 0)
			{
				return responseJson["productList"];
			}
			else
			{
				return false;
			}
		}
		catch(e)
		{
			print(e);
		}
	}

	// get all brands
	static getAllBrands() async
	{
		try
		{
			var response = await http.get(Uri.parse(APIData.getBrandList));

			var responseJson = jsonDecode(response.body);

			print(responseJson);

			if(responseJson["status"] == 0)
			{
				return responseJson["brandList"];
			}
			else
			{
				return false;
			}
		}
		catch(e)
		{
			print(e);
		}
	}

	// get products by brands
	static getProductsByBrands(productId) async
	{
		try
		{
			var response = await http.get(Uri.parse(APIData.getProductsByBrands + "/" + productId.toString()));

			var responseJson = jsonDecode(response.body);

			print(responseJson);

			if(responseJson["status"] == 0)
			{
				return responseJson["productList"];
			}
			else
			{
				return false;
			}
		}
		catch(e)
		{
			print(e);
		}
	}

	// get new arrived products
	static getNewArrivedProducts() async
	{
		try
		{
			var response = await http.get(Uri.parse(APIData.getNewArrivedProducts));

			var responseJson = jsonDecode(response.body);


			if(responseJson["status"] == 0)
			{
				return responseJson["productList"];
			}
			else
			{
				return false;
			}
		}
		catch(e)
		{
			print(e);
		}
	}

	// get product details
	static getProductDetails(productId) async
	{
		try
		{
			var response = await http.get(Uri.parse(APIData.getProductDetails + "/" + productId.toString()));

			var responseJson = jsonDecode(response.body);

			print(responseJson);

			if(responseJson["status"] == 0)
			{
				return responseJson;
			}
			else
			{
				return false;
			}
		}
		catch(e)
		{
			print(e);
		}
	}

	// ----------------------------------------------------------------WISHLIST------------------------------------------------------------//

	// add to wishlist
	static addProductsToWishlist(userId, productId) async
	{
		try
		{
			var response = await http.post(Uri.parse(APIData.addToWishlist),
			body: 
			{
				"userId": userId,
				"productId": productId
			});

			var responseJson = jsonDecode(response.body);

			print(responseJson);

			if(responseJson["status"] == 0)
			{
				return responseJson["response"];
			}
			else
			{
				return false;
			}
		}
		catch(e)
		{
			print(e);
		}
	}

	// get wishlist products
	static getWishlistProducts(userId) async
	{
		try
		{
			var response = await http.get(Uri.parse(APIData.getWishlist + "/" + userId.toString()));

			var responseJson = jsonDecode(response.body);

			print(responseJson);

			if(responseJson["status"] == 0)
			{
				return responseJson["wishList"];
			}
			else
			{
				return false;
			}
		}
		catch(e)
		{
			print(e);
		}
	}

	// ------------------------------------------------------------------------CART----------------------------------------------------------//

	// add to cart
	static addToCart(userId, productId, quantity) async
	{
		try
		{
			var response = await http.post(Uri.parse(APIData.addToCart),
			body: 
			{
				"userId": userId,
				"productId": productId,
				"quantity": quantity.toString()
			});

			var responseJson = jsonDecode(response.body);

			print(responseJson);

			if(responseJson["status"] == 0)
			{
				return responseJson["response"];
			}
			else
			{
				return false;
			}
		}
		catch(e)
		{
			print(e);
		}
	}

	// get wishlist products
	static getCartProducts(userId) async
	{
		try
		{
			var response = await http.get(Uri.parse(APIData.getCartProducts + "/" + userId.toString()));

			var responseJson = jsonDecode(response.body);

			print(responseJson);

			if(responseJson["status"] == 0)
			{
				return responseJson;
			}
			else
			{
				return false;
			}
		}
		catch(e)
		{
			print(e);
		}
	}

	// search
	static searchResults(searchWord) async
	{
		try
		{
			var response = await http.get(Uri.parse(APIData.search + searchWord.toString()));

			var responseJson = jsonDecode(response.body);

			print(responseJson);

			if(responseJson["status"] == 0)
			{
				return responseJson;
			}
			else
			{
				return false;
			}
		}
		catch(e)
		{
			print(e);
		}
	}

}