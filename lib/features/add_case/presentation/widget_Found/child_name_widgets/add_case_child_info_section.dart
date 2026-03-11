import 'package:find_me_app/core/helpers/formfield_validator.dart';
import 'package:find_me_app/features/add_case/presentation/cubits/cubit/add_case_cubit.dart';
import 'package:find_me_app/features/add_case/presentation/widgets_Missing/child_name_widgets/header_of_child_Info.dart';
import 'package:find_me_app/features/add_case/presentation/widgets_Missing/child_name_widgets/select_gender.dart';
import 'package:find_me_app/features/add_case/presentation/widgets_Missing/child_name_widgets/weight_height_feilds.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'child_info_view.dart';
import 'shared_child_info_fields.dart';

class AddCaseChildInfoSection extends StatelessWidget {
  const AddCaseChildInfoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddCaseCubit, AddCaseState>(
      builder: (context, state) {
        return ChildInfoView(
          header: const HeaderOfChildInfo(),
          firstNameField: AppChildNameField(
            errorText: state.firstNameErrorText,
            onChanged: (value) {
              context.read<AddCaseCubit>().firstNameChanged(value);
            },
            onValidate: (value) {
              final err = AppValidators.validateUsername(value);
              context.read<AddCaseCubit>().firstNameErrorTextChanged(err ?? "");
              return err;
            },
          ),
          lastNameField: AppChildLastNameField(
            errorText: state.lastNameErrorText,
            onChanged: (value) {
              context.read<AddCaseCubit>().lastNameChanged(value);
            },
            onValidate: (value) {
              final err = AppValidators.validateLastName(value);
              context.read<AddCaseCubit>().lastNameErrorTextChanged(err ?? "");
              return err;
            },
          ),
          addressField: AppLabeledTextField(
            label: "Address",
            hint: "Cairo , Giza",
            errorText: state.addressErrorText,
            onChanged: (value) {
              context.read<AddCaseCubit>().addressChanged(value);
            },
            onValidate: (value) {
              final err = AppValidators.validateAddress(value);
              context.read<AddCaseCubit>().addressErrorChanged(err ?? "");
              return err;
            },
          ),
          ageField: AppLabeledTextField(
            label: "Age:",
            hint: "Age",
            errorText: state.ageErrorText,
            onChanged: (value) {
              context.read<AddCaseCubit>().ageChanged(value);
            },
            onValidate: (value) {
              final err = AppValidators.validateAge(value);
              context.read<AddCaseCubit>().ageErrorChanged(err ?? "");
              return err;
            },
          ),
          genderWidget: const SelectedGender(labels: ['male', 'female']),
          weightHeightWidget: const WeightHeightFeilds(),
          otherDetailsField: AppLabeledTextField(
            label: "Other Identifying Details:",
            hint: "birthmarks, scars, accessories, hairstyle",
            maxLines: 3,
            radius: 13,
            errorText: state.descriptionErrorText,
            onChanged: (value) {
              context.read<AddCaseCubit>().descriptionChanged(value);
            },
            onValidate: (value) {
              final err = AppValidators.validateUsername(value);
              context.read<AddCaseCubit>().descriptionErrorChanged(err ?? "");
              return err;
            },
          ),
        );
      },
    );
  }
}
