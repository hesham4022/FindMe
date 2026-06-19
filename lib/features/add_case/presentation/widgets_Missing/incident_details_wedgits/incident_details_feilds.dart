import 'package:find_me_app/core/helpers/egypt_locations.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:find_me_app/core/helpers/extensions/translation_ex.dart';
import 'package:find_me_app/core/helpers/formfield_validator.dart';
import 'package:find_me_app/core/resources/colors.dart';
import 'package:find_me_app/core/resources/themes.dart';
import 'package:find_me_app/core/shared/widgets/custom_textfield.dart';
import 'package:find_me_app/core/shared/widgets/sizes.dart';
import 'package:find_me_app/features/add_case/presentation/cubits/cubit/add_case_cubit.dart';
import 'package:find_me_app/features/profile/presentation/profile_view/widgets/show_calendar_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DateTimeLastSeenField extends StatefulWidget {
  const DateTimeLastSeenField({super.key});

  @override
  State<DateTimeLastSeenField> createState() => _DateTimeLastSeenFieldState();
}

class _DateTimeLastSeenFieldState extends State<DateTimeLastSeenField> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    final initialDate = context.read<AddCaseCubit>().state.dateLastSeen;
    _controller = TextEditingController(text: initialDate ?? "");
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Text(
            "Date & Time Last Seen:".ts,
            style: Theme.of(context).textTheme.kSubheadingRegular.copyWith(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                ),
          ),
        ),
        const VSpace(5),
        CustomTextField(
          controller: _controller,
          readOnly: true,
          radius: 20,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 7,
            horizontal: 12,
          ),
          height: 30,
          hint: "DD / MM / YY",
          suffixIcon: const Icon(
            Icons.calendar_month_outlined,
            color: AppColors.saltBox900,
          ),
          onTap: () => kShowCalendarBottomSheet(
            context,
            onSelected: (value) {
              final formattedDate =
                  DateFormat('yyyy-MM-dd', 'en_US').format(value);
              _controller.text = formattedDate;
              context.read<AddCaseCubit>().dateLastseenChanged(formattedDate);
            },
          ),
        ),
      ],
    );
  }
}

class LastKnownLocation extends StatelessWidget {
  const LastKnownLocation({
    super.key,
    this.onSubmit,
  });

  final Function(String)? onSubmit;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddCaseCubit, AddCaseState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Text(
                "Last Known Location".ts,
                style: Theme.of(context).textTheme.kSubheadingRegular.copyWith(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                    ),
              ),
            ),
            VSpace(5),
            CustomTextField(
              radius: 30,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 7, horizontal: 12),
              hint: "Street And Area".ts,
              errorText: state.lastSeenLocationError,
              // errorText: "Feild is required",
              onSubmit: onSubmit,
              onChanged: (value) {
                context.read<AddCaseCubit>().lastseenLocationChanged(value);
              },
              onValidate: (value) {
                final err = AppValidators.validatInGeneralStringFielfs(value);
                context
                    .read<AddCaseCubit>()
                    .lastseenLocationErrorChanged(err ?? "");

                return (err == null || err.trim().isEmpty) ? null : err;
              },
            ),
          ],
        );
      },
    );
  }
}

class FullBreakdownOfTheincidentField extends StatelessWidget {
  const FullBreakdownOfTheincidentField({
    super.key,
    this.onSubmit,
  });

  final Function(String)? onSubmit;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddCaseCubit, AddCaseState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Text(
                "Full breakdown of the incident:".ts,
                style: Theme.of(context).textTheme.kHeadingH3SmallBold.copyWith(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                    ),
              ),
            ),
            VSpace(5),
            CustomTextField(
              maxLines: 5,
              radius: 13,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 7, horizontal: 12),
              hint: "Describe what happened. The more details the better.".ts,
              errorText: state.fullBreakdownDetailsError,
              // errorText: "Feild is required",
              onSubmit: onSubmit,
              onChanged: (value) {
                context.read<AddCaseCubit>().breakdownDetailsChanged(value);
              },
              onValidate: (value) {
                final err = AppValidators.validatInGeneralStringFielfs(value);
                context
                    .read<AddCaseCubit>()
                    .breakdownDetailsErrorChanged(err ?? "");

                return (err == null || err.trim().isEmpty) ? null : err;
              },
            ),
          ],
        );
      },
    );
  }
}

class VehicleDetailsField extends StatelessWidget {
  const VehicleDetailsField({
    super.key,
    this.onSubmit,
  });

  final Function(String)? onSubmit;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddCaseCubit, AddCaseState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Text(
                "Vehicle details:".ts,
                style: Theme.of(context).textTheme.kHeadingH3SmallBold.copyWith(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                    ),
              ),
            ),
            VSpace(5),
            CustomTextField(
              maxLines: 5,
              radius: 13,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 7, horizontal: 12),
              hint:
                  "If a vehicle was involved. What is the model, plate number, and color if you know."
                      .ts,
              errorText: state.vehicleDetailsError,
              // errorText: "Feild is required",
              onSubmit: onSubmit,
              onChanged: (value) {
                context.read<AddCaseCubit>().vehicleDetailsChanged(value);
              },
              onValidate: (value) {
                final err = AppValidators.validatInGeneralStringFielfs(value);
                context
                    .read<AddCaseCubit>()
                    .vehicleDetailsErrorChanged(err ?? "");

                return (err == null || err.trim().isEmpty) ? null : err;
              },
            ),
          ],
        );
      },
    );
  }
}

class CurrentChildLocationField extends StatelessWidget {
  const CurrentChildLocationField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddCaseCubit, AddCaseState>(
      builder: (context, state) {
        final governorates = EgyptLocations.governorates.keys.toList();
        final policeStations = state.governorate != null
            ? EgyptLocations.governorates[state.governorate] ?? []
            : <String>[];

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Text(
                "Governorate:".ts,
                style: Theme.of(context).textTheme.kHeadingH3SmallBold.copyWith(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                    ),
              ),
            ),
            VSpace(5),
            DropdownButtonFormField<String>(
              isExpanded: true,
              value: state.governorate,
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color(0xffECF1FF),
                contentPadding: const EdgeInsets.symmetric(vertical: 7, horizontal: 12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(13),
                  borderSide: const BorderSide(color: Colors.transparent, width: 0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(13),
                  borderSide: const BorderSide(color: Colors.transparent, width: 0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(13),
                  borderSide: const BorderSide(color: Colors.transparent, width: 0),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(13),
                  borderSide: const BorderSide(color: Colors.red, width: 1.5),
                ),
                errorText: state.governorateErrorText,
              ),
              hint: Text(
                "Select Governorate".ts,
                style: Theme.of(context).textTheme.kCaptionRegular.copyWith(
                      color: AppColors.saltBox300,
                      fontSize: 14,
                    ),
              ),
              items: governorates.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: Theme.of(context).textTheme.kCaptionRegular.copyWith(fontSize: 14),
                  ),
                );
              }).toList(),
              onChanged: (newValue) {
                if (newValue != null) {
                  context.read<AddCaseCubit>().governorateChanged(newValue);
                }
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Governorate is required".ts;
                }
                return null;
              },
            ),
            VSpace(10),
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Text(
                "Police station details:".ts,
                style: Theme.of(context).textTheme.kHeadingH3SmallBold.copyWith(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                    ),
              ),
            ),
            VSpace(5),
            DropdownButtonFormField<String>(
              isExpanded: true,
              value: state.policeStation,
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color(0xffECF1FF),
                contentPadding: const EdgeInsets.symmetric(vertical: 7, horizontal: 12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(13),
                  borderSide: const BorderSide(color: Colors.transparent, width: 0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(13),
                  borderSide: const BorderSide(color: Colors.transparent, width: 0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(13),
                  borderSide: const BorderSide(color: Colors.transparent, width: 0),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(13),
                  borderSide: const BorderSide(color: Colors.red, width: 1.5),
                ),
                errorText: state.policeStationErrorText,
              ),
              hint: Text(
                "Select Police Station".ts,
                style: Theme.of(context).textTheme.kCaptionRegular.copyWith(
                      color: AppColors.saltBox300,
                      fontSize: 14,
                    ),
              ),
              items: policeStations.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: Theme.of(context).textTheme.kCaptionRegular.copyWith(fontSize: 14),
                  ),
                );
              }).toList(),
              onChanged: state.governorate == null
                  ? null
                  : (newValue) {
                      if (newValue != null) {
                        context.read<AddCaseCubit>().policeStationChanged(newValue);
                      }
                    },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Police Station is required".ts;
                }
                return null;
              },
            ),
          ],
        );
      },
    );
  }
}
