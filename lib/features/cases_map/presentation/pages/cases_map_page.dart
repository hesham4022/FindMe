import 'package:find_me_app/core/resources/colors.dart';
import 'package:find_me_app/features/all_cases/data/model/case_model_info.dart';
import 'package:find_me_app/features/all_cases/presentation/cubits/cubit/all_cases_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:find_me_app/core/helpers/extensions/translation_ex.dart';

class CasesMapView extends StatelessWidget {
  const CasesMapView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<AllCasesCubit, AllCasesState>(
          builder: (context, state) {
            final casesWithLocation = state.filtered.where((caseItem) {
              return caseItem.latitude != null && caseItem.longitude != null;
            }).toList();

            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () => Navigator.pop(context),
                        child: const Icon(
                          Icons.arrow_back_ios_new,
                          color: AppColors.mainColor,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          'casesMap'.ts,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.mainColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                        ),
                        child: Text(
                          'allCases'.ts,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: FlutterMap(
                    options: const MapOptions(
                      initialCenter: LatLng(26.8206, 30.8025), // Egypt
                      initialZoom: 5.5,
                    ),
                    children: [
                      TileLayer(
                        urlTemplate:
                            'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                        userAgentPackageName: 'com.findme.app',
                      ),
                      MarkerLayer(
                        markers: casesWithLocation.map((caseItem) {
                          return Marker(
                            width: 55,
                            height: 55,
                            point: LatLng(
                              caseItem.latitude!,
                              caseItem.longitude!,
                            ),
                            child: GestureDetector(
                              onTap: () {
                                _showCaseBottomSheet(context, caseItem);
                              },
                              child: const Icon(
                                Icons.location_on,
                                color: Colors.red,
                                size: 42,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  void _showCaseBottomSheet(BuildContext context, CaseInfoModel caseItem) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              CircleAvatar(
                radius: 32,
                backgroundImage: caseItem.photos.isNotEmpty &&
                        caseItem.photos.first.url != null
                    ? NetworkImage(caseItem.photos.first.url!)
                    : null,
                child:
                    caseItem.photos.isEmpty ? const Icon(Icons.person) : null,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${caseItem.firstName ?? ''} ${caseItem.lastName ?? ''}",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text("${'Age'.ts}: ${caseItem.age ?? '-'}"),
                    Text("${'address'.ts}: ${caseItem.address ?? '-'}"),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
