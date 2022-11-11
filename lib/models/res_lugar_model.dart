import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class ResLugarModel extends Equatable{
  final String id;
  final String tourname;
  final String filename;
  final String description;
  final String latitude;
  final String longitude;
  final String fileUrl;
  final String user;
  final String v;

  const ResLugarModel({
    required this.id,
    required this.tourname,
    required this.filename,
    required this.description,
    required this.latitude,
    required this.longitude,
    required this.fileUrl,
    required this.user,
    required this.v,
  });

  @override
  List<Object> get props => [
    id,
    tourname,
    filename,
    description,
    latitude,
    longitude,
    fileUrl,
    user,
    v,
  ];

  factory ResLugarModel.fromJson(Map<String, dynamic> json) {
    return ResLugarModel(
      id: json['_id'],
      tourname: json['tourname'],
      filename: json['filename'],
      description: json['description'],
      latitude: json['latitude'].toString(),
      longitude: json['longitude'].toString(),
      fileUrl: json['fileUrl'],
      user: json['user'],
      v: json['__v'].toString(),
    );
  }

  String get gtourname => tourname;
  String get gfilename => filename;
  String get glatitude => latitude;
  String get glongitude => longitude;
  String get gfileUrl => fileUrl;

}