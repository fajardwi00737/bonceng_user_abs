
import 'package:absen_online/bloc/absen_cubit/absen_cubit.dart';
import 'package:absen_online/bloc/cuti_cubit/cuti_cubit.dart';
import 'package:absen_online/bloc/cuti_list_cubit/cuti_list_cubit.dart';
import 'package:absen_online/bloc/dashboard_sumary_cubit/dashboard_sumary_cubit.dart';
import 'package:absen_online/bloc/login_cubit/login_cubit.dart';
import 'package:absen_online/bloc/presence_list_bloc/presence_list_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final List<BlocProvider> blocList = [

  BlocProvider<AbsenCubit>(create: (_) => AbsenCubit()),
  BlocProvider<CutiCubit>(create: (_) => CutiCubit()),
  BlocProvider<LoginCubit>(create: (_) => LoginCubit()),
  BlocProvider<PresenceListCubit>(create: (_) => PresenceListCubit()),
  BlocProvider<CutiListCubit>(create: (_) => CutiListCubit()),
  BlocProvider<DashboardSumaryCubit>(create: (_) => DashboardSumaryCubit()),
];