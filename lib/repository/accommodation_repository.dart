import 'dart:io';

import 'package:edirne_gezgini_ui/constants.dart' as constants;
import 'package:edirne_gezgini_ui/model/api_response.dart';
import 'package:edirne_gezgini_ui/util/auth_credential_store.dart';
import 'package:edirne_gezgini_ui/util/http_request/client_entity.dart';
import 'package:edirne_gezgini_ui/util/http_request/rest_client.dart';
import 'package:get_it/get_it.dart';

import '../model/dto/create_accommodation_dto.dart';
import '../model/dto/update_accommodation_dto.dart';
import '../model/enum/accommodation_category.dart';

class AccommodationRepository {
  final String accommodationApiUrl = constants.accommodationApiUrl;
  final GetIt getIt = GetIt.instance;

  Future<APIResponse> getAccommodation(String id) async {
    final String url = "$accommodationApiUrl/getAccommodation/$id";
    final String? token = getIt<AuthCredentialStore>().token;

    if (token == null) {
      return APIResponse(
        httpStatus: HttpStatus.internalServerError,
        message: "error while retrieving token",
      );
    }

    final ClientEntity clientEntity = ClientEntity.httpGet(url, token);
    return await RestClient().send(clientEntity);
  }

  Future<APIResponse> getAll() async {
    final String url = "$accommodationApiUrl/getAll";
    final String? token = getIt<AuthCredentialStore>().token;

    if (token == null) {
      return APIResponse(
        httpStatus: HttpStatus.internalServerError,
        message: "error while retrieving token",
      );
    }

    final ClientEntity clientEntity = ClientEntity.httpGet(url, token);
    return await RestClient().send(clientEntity);
  }

  Future<APIResponse> getAllByCategory(AccommodationCategory category) async {
    final String categoryString = AccommodationExtension.categoryToString(category);
    final String url = "$accommodationApiUrl/getAllByCategory?category=$categoryString";
    final String? token = getIt<AuthCredentialStore>().token;

    if (token == null) {
      return APIResponse(
        httpStatus: HttpStatus.internalServerError,
        message: "error while retrieving token",
      );
    }

    final ClientEntity clientEntity = ClientEntity.httpGet(url, token);
    return await RestClient().send(clientEntity);
  }

  Future<APIResponse> createAccommodation(CreateAccommodationDto createAccommodationDto) async {
    final String url = '$accommodationApiUrl/createAccommodation';
    final Map<String, dynamic> body = createAccommodationDto.toMap();
    final String? token = getIt<AuthCredentialStore>().token;

    if (token == null) {
      return APIResponse(
        httpStatus: HttpStatus.internalServerError,
        message: "error while retrieving token",
      );
    }

    final ClientEntity clientEntity = ClientEntity.httpPostWithToken(url, token, body);
    return await RestClient().send(clientEntity);
  }

  Future<APIResponse> updateAccommodation(UpdateAccommodationDto updateAccommodationDto) async {
    final String url = "$accommodationApiUrl/updateAccommodation";
    final Map<String, dynamic> body = updateAccommodationDto.toMap();
    final String? token = getIt<AuthCredentialStore>().token;

    if (token == null) {
      return APIResponse(
        httpStatus: HttpStatus.internalServerError,
        message: "error while retrieving token",
      );
    }

    final ClientEntity clientEntity = ClientEntity.httpPut(url, token, body);
    return await RestClient().send(clientEntity);
  }

  Future<APIResponse> deleteAccommodation(String id) async {
    final String url = "$accommodationApiUrl/deleteAccommodation/$id";
    final String? token = getIt<AuthCredentialStore>().token;

    if (token == null) {
      return APIResponse(
        httpStatus: HttpStatus.internalServerError,
        message: "error while retrieving token",
      );
    }

    final ClientEntity clientEntity = ClientEntity.httpDelete(url, token);
    return await RestClient().send(clientEntity);
  }
}