// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

import 'package:admin/graphql/__generated__/schema.schema.gql.dart'
    show
        GAddNewConnectionInput,
        GCreateNewMessageRoomInput,
        GCreateNewNotificationInput,
        GCreateNewOfferInput,
        GCreateNewUserDataInput,
        GDeleteNotificationInput,
        GDeleteOfferInput,
        GSendMessageInput,
        GUpdateNotificationInput,
        GUpdateOfferInput;
import 'package:admin/graphql/mutation/__generated__/mutation.data.gql.dart'
    show
        GAddNewConnectionData,
        GAddNewConnectionData_addNewConnection,
        GCreateNewMessageRoomData,
        GCreateNewMessageRoomData_createNewMessageRoom,
        GCreateNewOfferData,
        GCreateNewOfferData_createNewOffer,
        GDeleteOfferData,
        GDeleteOfferData_deleteOffer,
        GSendMessageData,
        GSendMessageData_sendMessage,
        GUpdateOfferData,
        GUpdateOfferData_updateOffer;
import 'package:admin/graphql/mutation/__generated__/mutation.req.gql.dart'
    show
        GAddNewConnectionReq,
        GCreateNewMessageRoomReq,
        GCreateNewOfferReq,
        GDeleteOfferReq,
        GSendMessageReq,
        GUpdateOfferReq;
import 'package:admin/graphql/mutation/__generated__/mutation.var.gql.dart'
    show
        GAddNewConnectionVars,
        GCreateNewMessageRoomVars,
        GCreateNewOfferVars,
        GDeleteOfferVars,
        GSendMessageVars,
        GUpdateOfferVars;
import 'package:admin/graphql/query/__generated__/query.data.gql.dart'
    show
        GGetAllOffersData,
        GGetAllOffersData_getAllOffers,
        GGetMessageRoomsData,
        GGetMessageRoomsData_getMessageRooms,
        GGetMessagesByMessageRoomIdData,
        GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId,
        GGetNotificationsData,
        GGetNotificationsData_getNotifications,
        GGetUserDataData,
        GGetUserDataData_getUserData,
        GGetUserInfoData,
        GGetUserInfoData_getUserInfo,
        GHealthCheckData,
        GHealthCheckData_healthCheck;
import 'package:admin/graphql/query/__generated__/query.req.gql.dart'
    show
        GGetAllOffersReq,
        GGetMessageRoomsReq,
        GGetMessagesByMessageRoomIdReq,
        GGetNotificationsReq,
        GGetUserDataReq,
        GGetUserInfoReq,
        GHealthCheckReq;
import 'package:admin/graphql/query/__generated__/query.var.gql.dart'
    show
        GGetAllOffersVars,
        GGetMessageRoomsVars,
        GGetMessagesByMessageRoomIdVars,
        GGetNotificationsVars,
        GGetUserDataVars,
        GGetUserInfoVars,
        GHealthCheckVars;
import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart' show StandardJsonPlugin;
import 'package:ferry_exec/ferry_exec.dart';
import 'package:gql_code_builder/src/serializers/operation_serializer.dart'
    show OperationSerializer;

part 'serializers.gql.g.dart';

final SerializersBuilder _serializersBuilder = _$serializers.toBuilder()
  ..add(OperationSerializer())
  ..addPlugin(StandardJsonPlugin());
@SerializersFor([
  GAddNewConnectionData,
  GAddNewConnectionData_addNewConnection,
  GAddNewConnectionInput,
  GAddNewConnectionReq,
  GAddNewConnectionVars,
  GCreateNewMessageRoomData,
  GCreateNewMessageRoomData_createNewMessageRoom,
  GCreateNewMessageRoomInput,
  GCreateNewMessageRoomReq,
  GCreateNewMessageRoomVars,
  GCreateNewNotificationInput,
  GCreateNewOfferData,
  GCreateNewOfferData_createNewOffer,
  GCreateNewOfferInput,
  GCreateNewOfferReq,
  GCreateNewOfferVars,
  GCreateNewUserDataInput,
  GDeleteNotificationInput,
  GDeleteOfferData,
  GDeleteOfferData_deleteOffer,
  GDeleteOfferInput,
  GDeleteOfferReq,
  GDeleteOfferVars,
  GGetAllOffersData,
  GGetAllOffersData_getAllOffers,
  GGetAllOffersReq,
  GGetAllOffersVars,
  GGetMessageRoomsData,
  GGetMessageRoomsData_getMessageRooms,
  GGetMessageRoomsReq,
  GGetMessageRoomsVars,
  GGetMessagesByMessageRoomIdData,
  GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId,
  GGetMessagesByMessageRoomIdReq,
  GGetMessagesByMessageRoomIdVars,
  GGetNotificationsData,
  GGetNotificationsData_getNotifications,
  GGetNotificationsReq,
  GGetNotificationsVars,
  GGetUserDataData,
  GGetUserDataData_getUserData,
  GGetUserDataReq,
  GGetUserDataVars,
  GGetUserInfoData,
  GGetUserInfoData_getUserInfo,
  GGetUserInfoReq,
  GGetUserInfoVars,
  GHealthCheckData,
  GHealthCheckData_healthCheck,
  GHealthCheckReq,
  GHealthCheckVars,
  GSendMessageData,
  GSendMessageData_sendMessage,
  GSendMessageInput,
  GSendMessageReq,
  GSendMessageVars,
  GUpdateNotificationInput,
  GUpdateOfferData,
  GUpdateOfferData_updateOffer,
  GUpdateOfferInput,
  GUpdateOfferReq,
  GUpdateOfferVars,
])
final Serializers serializers = _serializersBuilder.build();
