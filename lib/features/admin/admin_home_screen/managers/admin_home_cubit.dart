import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:mozart_flutter_app/features/auth/data/data_provider/local/cach_keys.dart';
import 'package:mozart_flutter_app/features/auth/data/data_provider/local/cache.dart';
import 'package:mozart_flutter_app/features/auth/data/data_provider/remote/dio_helper.dart';
import 'package:mozart_flutter_app/utils/constants/constants.dart';
part 'admin_home_state.dart';

class AdminHomeCubit extends Cubit<AdminHomeState> {
  AdminHomeCubit() : super(AdminHomeInitialState());

  static AdminHomeCubit get(context) => BlocProvider.of(context);

  DioHelper dioHelper = DioHelper();

  /// ---------------------------------- Banner ---------------------------------- ///

  /// Create Banner
  Future<void> createBannerFunction(
      File image1,
      File image2,
      File image3,
      File image4,
      File image5,
      File image6,
      File image7,
      ) async {
    emit(CreateBannerLoadingState());

    FormData formData = FormData();

    formData.files.addAll([
      MapEntry(
        'images',
        await MultipartFile.fromFile(
          image1.path,
          filename: Uri.file(image1.path).pathSegments.last,
        ),
      ),
      MapEntry(
        'images',
        await MultipartFile.fromFile(
          image2.path,
          filename: Uri.file(image2.path).pathSegments.last,
        ),
      ),
      MapEntry(
        'images',
        await MultipartFile.fromFile(
          image3.path,
          filename: Uri.file(image3.path).pathSegments.last,
        ),
      ),
      MapEntry(
        'images',
        await MultipartFile.fromFile(
          image4.path,
          filename: Uri.file(image4.path).pathSegments.last,
        ),
      ),
      MapEntry(
        'images',
        await MultipartFile.fromFile(
          image5.path,
          filename: Uri.file(image5.path).pathSegments.last,
        ),
      ),
      MapEntry(
        'images',
        await MultipartFile.fromFile(
          image6.path,
          filename: Uri.file(image6.path).pathSegments.last,
        ),
      ),
      MapEntry(
        'images',
        await MultipartFile.fromFile(
          image7.path,
          filename: Uri.file(image7.path).pathSegments.last,
        ),
      ),
    ]);

    Options options = Options(
      headers: {
        'authorization': "Bearer ${MyCache.getString(key: CacheKeys.token)}",
      },
    );

    try {
      await Dio().post(
        '${AppConstants.baseUrl}${AppConstants.createBannerUrl}',
        data: formData,
        options: options,
      );

      emit(CreateBannerSuccessState());
    } catch (error) {
      if (error is DioError) {
        print('DioError response: ${error.response}');
      } else {
        print('Error in create image to server: $error');
      }

      emit(CreateBannerErrorState());
    }
  }

  /// Delete All Images in Banner
  Future<void> deleteAllImagesInBannerFunction({
    required String bannerId,
  }) async {
    emit(DeleteAllImagesInBannerLoadingState());
    await dioHelper
        .deleteData(
            endPoint: '${AppConstants.deleteAllImagesInBannerUrl}$bannerId')
        .then((response) {
      emit(DeleteAllImagesInBannerSuccessState());
    }).catchError((error) {
      print('Error in delete all images in banner in $error');
      emit(DeleteAllImagesInBannerErrorState());
    });
  }

  /// Update Image in Banner
  Future<void> updateImageInBannerFunction({
    required String bannerId,
    required File image,
    required String imageId,
  }) async {
    emit(UpdateImageInBannerLoadingState());
    FormData formData = FormData.fromMap({
      'images': await MultipartFile.fromFile(
        image.path,
        filename: Uri.file(image.path).pathSegments.last,
      ),
      'imagesIds[0]': imageId,
    });
    Options options = Options(
      headers: {
        'authorization': "Bearer ${MyCache.getString(key: CacheKeys.token)}",
      },
    );
    await Dio()
        .put(
      '${AppConstants.baseUrl}${AppConstants.deleteAllImagesInBannerUrl}$bannerId',
      data: formData,
      options: options,
    )
        .then((value) {
      emit(UpdateImageInBannerSuccessState());
    }).catchError((error) {
      if (error is DioError) {
        print('DioError response: ${error.response}');
      } else {
        print('Error in upload image to server: $error');
      }
      emit(UpdateImageInBannerErrorState());
    });
  }

  /// Update Specific Product
  Future<void> updateSpecificProductFunction({
    required String productId,
    required File image,
    required String imageId,
    required String title,
    required String titleAr,
    required String description,
    required String descriptionAr,
    required String quantity,
    required String priceNormal,
    required String priceWholesale,
  }) async {
    emit(EditSpecificProductLoadingState());
    FormData formData = FormData.fromMap({
      'image': await MultipartFile.fromFile(
        image.path,
        filename: Uri.file(image.path).pathSegments.last,
      ),
      'imageId': imageId,
      'title': title,
      'titleAr': titleAr,
      'description': description,
      'descriptionAr': descriptionAr,
      'quantity': quantity,
      'priceNormal': priceNormal,
      'priceWholesale': priceWholesale,
    });
    Options options = Options(
      headers: {
        'authorization': "Bearer ${MyCache.getString(key: CacheKeys.token)}",
      },
    );
    await Dio()
        .put(
      '${AppConstants.baseUrl}api/v1/products/$productId',
      data: formData,
      options: options,
    )
        .then((value) {
      emit(EditSpecificProductSuccessState());
    }).catchError((error) {
      if (error is DioError) {
        print('DioError response: ${error.response}');
      } else {
        print('Error in upload image to server: $error');
      }
      emit(EditSpecificProductErrorState());
    });
  }

  /// Delete One Image In Banner
  Future<void> deleteOneImageInBannerFunction({
    required String bannerId,
    required String imageIdsToDelete,
  }) async {
    emit(DeleteOneImageInBannerLoadingState());
    await dioHelper.putData(
        endPoint: '${AppConstants.deleteAllImagesInBannerUrl}$bannerId',
        body: {
          'imageIdsToDelete[0]': imageIdsToDelete,
        }).then((response) {
      emit(DeleteOneImageInBannerSuccessState());
    }).catchError((error) {
      print('Error in delete one image in banner in $error');
      emit(DeleteOneImageInBannerErrorState());
    });
  }

  /// ---------------------------------- Category ---------------------------------- ///
  /// Create Category
  Future<void> createCategoryFunction({
    required File image,
    required String name,
    required String nameAr,
  }) async {
    emit(CreateCategoryLoadingState());
    FormData formData = FormData.fromMap({
      'image': await MultipartFile.fromFile(
        image.path,
        filename: Uri.file(image.path).pathSegments.last,
      ),
      'name': name,
      'nameAr': nameAr,
    });
    Options options = Options(
      headers: {
        'authorization': "Bearer ${MyCache.getString(key: CacheKeys.token)}",
      },
    );
    await Dio()
        .post(
      '${AppConstants.baseUrl}${AppConstants.createCategoryUrl}',
      data: formData,
      options: options,
    )
        .then((response) {
      emit(CreateCategorySuccessState());
    }).catchError((error) {
      if (error is DioError) {
        print('DioError response: ${error.response}');
      } else {
        print('Error in create category to server: $error');
      }
      emit(CreateCategoryErrorState());
    });
  }

  /// Update Name Of Category
  Future<void> updateNameOfCategoryFunction({
    required String name,
    required String nameAr,
    required String categoryId,
  }) async {
    emit(UpdateImagesOfCategoryLoadingState());
    await dioHelper.putData(
        endPoint: '${AppConstants.updateAndDeleteCategoryUrl}$categoryId',
        body: {
          'name': name,
          'nameAr': nameAr,
        }).then((value) {
      emit(UpdateImagesOfCategorySuccessState());
    }).catchError((error) {
      print('Error in Update name of category is $error');
      emit(UpdateImagesOfCategoryLoadingState());
    });
  }

  /// Update Category Image
  Future<void> updateCategoryImageFunction({
    required String categoryId,
    required File image,
    required String name,
    required String nameAr,
  }) async {
    emit(UpdateImageOfCategoryLoadingState());
    FormData formData = FormData.fromMap({
      'image': await MultipartFile.fromFile(
        image.path,
        filename: Uri.file(image.path).pathSegments.last,
      ),
      'name': name,
      'nameAr': nameAr,
    });
    Options options = Options(
      headers: {
        'authorization': "Bearer ${MyCache.getString(key: CacheKeys.token)}",
      },
    );
    await Dio()
        .put(
      '${AppConstants.baseUrl}${AppConstants.updateAndDeleteCategoryUrl}$categoryId',
      data: formData,
      options: options,
    )
        .then((value) {
      emit(UpdateImageOfCategorySuccessState());
    }).catchError((error) {
      if (error is DioError) {
        print('DioError response: ${error.response}');
      } else {
        print('Error in update image in category to server: $error');
      }
      emit(UpdateImageOfCategoryErrorState());
    });
  }

  /// Delete Category
  Future<void> deleteCategoryFunction({
    required String categoryId,
  }) async {
    emit(DeleteCategoryLoadingState());
    await dioHelper
        .deleteData(
            endPoint: '${AppConstants.updateAndDeleteCategoryUrl}$categoryId')
        .then((response) {
      emit(DeleteCategorySuccessState());
    }).catchError((error) {
      print('Error in delete category is $error');
      emit(DeleteCategoryErrorState());
    });
  }

  /// ---------------------------------- Product ---------------------------------- ///
  /// Create Product
  Future<void> createProductFunction({
    required String title,
    required String titleAr,
    required String description,
    required String descriptionAr,
    required String quantity,
    required String priceNormal,
    required String priceWholesale,
    required String categoryId,
    required File image,
  }) async {
    emit(CreateProductLoadingState());
    FormData formData = FormData.fromMap({
      'title': title,
      'titleAr': titleAr,
      'description': description,
      'descriptionAr': descriptionAr,
      'quantity': quantity,
      'priceNormal': priceNormal,
      'priceWholesale': priceWholesale,
      "category": categoryId,
      'image': await MultipartFile.fromFile(
        image.path,
        filename: Uri.file(image.path).pathSegments.last,
      ),
    });
    Options options = Options(
      headers: {
        'authorization': "Bearer ${MyCache.getString(key: CacheKeys.token)}",
      },
    );
    await Dio()
        .post(
      '${AppConstants.baseUrl}${AppConstants.createProductUrl}',
      data: formData,
      options: options,
    )
        .then((response) {
      emit(CreateProductSuccessState());
    }).catchError((error) {
      if (error is DioError) {
        print('DioError response: ${error.response}');
      } else {
        print('Error in create category to server: $error');
      }
      emit(CreateProductErrorState());
    });
  }

  /// Delete Product
  Future<void> deleteProductFunction({
    required String productId,
  }) async {
    emit(DeleteOneProductLoadingState());
    await dioHelper
        .deleteData(endPoint: '${AppConstants.deleteProductUrl}$productId')
        .then((response) {
      emit(DeleteOneProductSuccessState());
    }).catchError((error) {
      print('Error in delete product is $error');
      emit(DeleteOneProductErrorState());
    });
  }


  Future<void> updateProduct({
    required String id,
    required String titleAr,
    required String description,
    required String descriptionAr,
    required String quantity,
    required String priceNormal,
    required String priceWholesale,

  }) async {
    try {
      Dio dio = Dio();

      String url = 'https://onlinestore-xors.onrender.com/api/v1/products/$id';

      Map<String, dynamic> data = {
        "titleAr": titleAr,
        "description": description,
        "descriptionAr": descriptionAr,
        "quantity": quantity,
        "priceNormal": priceNormal,
        "priceWholesale": priceWholesale
      };


      Options options = Options(
        headers: {
          'Authorization': 'Bearer ${MyCache.getString(key: CacheKeys.token)}',

        },
      );

      Response response = await dio.put(url, data: data, options: options);

      // Handle the response
      if (response.statusCode == 200) {
        print('Product updated successfully.');
        emit(EditSpecificProductSuccessState());

      } else {
        print('Failed to update product: ${response.statusCode}');
        emit(EditSpecificProductErrorState());
      }
    } catch (error) {
      print('Error updating product: $error');
    }
  }
}
