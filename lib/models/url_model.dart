import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class UrlModel extends Equatable {
  final String message;
  final String url;

  UrlModel({
    required this.message,
    required this.url,
  });

  @override
  List<Object?> get props => [
    message,
    url,
  ];

  factory UrlModel.fromJson(Map<String, dynamic> json) {
    return UrlModel(
      message: json['message'],
      url: json['url'],
    );
  }

  String get _message => message;
  String get _url => url;

}
