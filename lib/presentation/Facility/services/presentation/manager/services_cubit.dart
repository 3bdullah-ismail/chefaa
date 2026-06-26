
import 'package:chefaa/presentation/Facility/services/data/models/get_services_response.dart';
import 'package:chefaa/presentation/Facility/services/data/models/service_model.dart';
import 'package:chefaa/presentation/Facility/services/data/repositories/services_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'services_state.dart';

@injectable
class ServicesCubit extends Cubit<ServicesState> {
  final ServicesRepository _servicesRepository;

  final List<ServiceModel> addedServices = [];
  List<ServiceModel> labTests = [];
  List<ServiceModel> radiologyScans = [];
  
  List<ServiceModel> allLabTests = [];
  List<ServiceModel> allRadiologyScans = [];
  
  String? aiInsight;

  ServicesCubit(this._servicesRepository) : super(ServicesInitial());

  static ServicesCubit get(BuildContext context) => BlocProvider.of(context);

  Future<void> getMyServices({String? search}) async {
    emit(GetServicesLoading());
    try {
      final response = await _servicesRepository.getMyServices(search: search);
      labTests = response.labTests ?? [];
      radiologyScans = response.radiology ?? [];
      aiInsight = response.aiInsight;
      
      if (search == null || search.trim().isEmpty) {
        allLabTests = List.from(labTests);
        allRadiologyScans = List.from(radiologyScans);
      }
      
      emit(GetServicesSuccess(response));
    } catch (e) {
      emit(GetServicesFailure(e.toString()));
    }
  }

  void searchServicesLocally(String query) {
    if (query.trim().isEmpty) {
      labTests = List.from(allLabTests);
      radiologyScans = List.from(allRadiologyScans);
    } else {
      final lowercaseQuery = query.toLowerCase();
      labTests = allLabTests.where((item) {
        return (item.name ?? '').toLowerCase().contains(lowercaseQuery) ||
               (item.instructions ?? '').toLowerCase().contains(lowercaseQuery);
      }).toList();
      radiologyScans = allRadiologyScans.where((item) {
        return (item.name ?? '').toLowerCase().contains(lowercaseQuery);
      }).toList();
    }
    emit(GetServicesSuccess(GetServicesResponse(
      success: true,
      labTests: labTests,
      radiology: radiologyScans,
      aiInsight: aiInsight,
    )));
  }

  Future<void> addService({
    required String name,
    required String category,
    required num price,
    required String estimatedTime,
    String? sessionDuration,
    String? instructions,
    String? imagePath,
  }) async {
    emit(AddServiceLoading());
    try {
      final response = await _servicesRepository.addService(
        name: name,
        category: category,
        price: price,
        estimatedTime: estimatedTime,
        sessionDuration: sessionDuration,
        instructions: instructions,
        imagePath: imagePath,
      );

      final service =
          response.service ??
          ServiceModel(
            name: name,
            category: category,
            price: price,
            estimatedTime: estimatedTime,
            sessionDuration: sessionDuration,
            instructions: instructions,
            imageUrl: imagePath,
          );

      if (service.category?.toLowerCase() == 'test') {
        labTests.add(service);
        allLabTests.add(service);
      } else if (service.category?.toLowerCase() == 'scan') {
        radiologyScans.add(service);
        allRadiologyScans.add(service);
      }

      addedServices.add(service);
      emit(AddServiceSuccess(service));
    } catch (e) {
      emit(AddServiceFailure(e.toString()));
    }
  }

  Future<void> toggleService(String serviceId) async {
    emit(ToggleServiceLoading());
    try {
      final response = await _servicesRepository.toggleService(serviceId);
      final updatedService = response.service;
      if (updatedService != null) {
        if (updatedService.category?.toLowerCase() == 'test') {
          final index = labTests.indexWhere(
            (element) => element.id == serviceId,
          );
          if (index != -1) {
            labTests[index] = updatedService;
          }
          final allIndex = allLabTests.indexWhere(
            (element) => element.id == serviceId,
          );
          if (allIndex != -1) {
            allLabTests[allIndex] = updatedService;
          }
        } else {
          final index = radiologyScans.indexWhere(
            (element) => element.id == serviceId,
          );
          if (index != -1) {
            radiologyScans[index] = updatedService;
          }
          final allIndex = allRadiologyScans.indexWhere(
            (element) => element.id == serviceId,
          );
          if (allIndex != -1) {
            allRadiologyScans[allIndex] = updatedService;
          }
        }
        emit(ToggleServiceSuccess(updatedService));
      } else {
        emit(ToggleServiceFailure("Failed to toggle service status"));
      }
    } catch (e) {
      emit(ToggleServiceFailure(e.toString()));
    }
  }
}
