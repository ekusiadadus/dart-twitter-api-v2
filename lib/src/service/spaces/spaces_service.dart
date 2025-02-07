// Copyright 2022 Kato Shinya. All rights reserved.
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided the conditions.

// Project imports:
import '../../client/client_context.dart';
import '../../client/user_context.dart';
import '../base_service.dart';
import '../tweets/tweet_data.dart';
import '../tweets/tweet_meta.dart';
import '../twitter_response.dart';
import '../users/user_data.dart';
import 'space_data.dart';
import 'space_meta.dart';

abstract class SpacesService {
  /// Returns the new instance of [SpacesService].
  factory SpacesService({required ClientContext context}) =>
      _SpacesService(context: context);

  /// Return live or scheduled Spaces matching your specified search terms.
  ///
  /// This endpoint performs a keyword search, meaning that it will return
  /// Spaces that are an exact case-insensitive match of the specified search
  /// term.
  ///
  /// The search term will match the original title of the Space.
  ///
  /// ## Parameters
  ///
  /// - [query]: Your search term. This can be any text (including mentions and
  ///            Hashtags) present in the title of the Space.
  ///
  /// ## Endpoint Url
  ///
  /// - https://api.twitter.com/2/spaces/search
  ///
  /// ## Rate Limits
  ///
  /// - **User rate limit (OAuth 2.0 user Access Token)**:
  ///    300 requests per 15-minute window per each authenticated user
  ///
  /// - **App rate limit (OAuth 2.0 App Access Token)**:
  ///    300 requests per 15-minute window shared among all users of your app
  ///
  /// ## Reference
  ///
  /// - https://developer.twitter.com/en/docs/twitter-api/spaces/search/api-reference/get-spaces-search
  Future<TwitterResponse<List<SpaceData>, SpaceMeta>> search(
      {required String query});

  /// Returns a variety of information about a single Space specified by the
  /// requested ID.
  ///
  /// ## Parameters
  ///
  /// - [spaceId]: Unique identifier of the Space to request.
  ///
  /// ## Endpoint Url
  ///
  /// - https://api.twitter.com/2/spaces/:id
  ///
  /// ## Rate Limits
  ///
  /// - **User rate limit (OAuth 2.0 user Access Token)**:
  ///    300 requests per 15-minute window per each authenticated user
  ///
  /// - **App rate limit (OAuth 2.0 App Access Token)**:
  ///    300 requests per 15-minute window shared among all users of your app
  ///
  /// ## Reference
  ///
  /// - https://developer.twitter.com/en/docs/twitter-api/spaces/lookup/api-reference/get-spaces-id
  Future<TwitterResponse<SpaceData, void>> lookupById(
      {required String spaceId});

  /// Returns details about multiple Spaces. Up to 100 comma-separated Spaces
  /// IDs can be looked up using this endpoint.
  ///
  /// ## Parameters
  ///
  /// - [spaceIds]: Unique identifiers of the Space to request.
  ///
  /// ## Endpoint Url
  ///
  /// - https://api.twitter.com/2/spaces
  ///
  /// ## Rate Limits
  ///
  /// - **User rate limit (OAuth 2.0 user Access Token)**:
  ///    300 requests per 15-minute window per each authenticated user
  ///
  /// - **App rate limit (OAuth 2.0 App Access Token)**:
  ///    300 requests per 15-minute window shared among all users of your app
  ///
  /// ## Reference
  ///
  /// - https://developer.twitter.com/en/docs/twitter-api/spaces/lookup/api-reference/get-spaces
  Future<TwitterResponse<List<SpaceData>, void>> lookupByIds(
      {required List<String> spaceIds});

  /// Returns a list of user who purchased a ticket to the requested Space.
  /// You must authenticate the request using the Access Token of the creator
  /// of the requested Space.
  ///
  /// ## Parameters
  ///
  /// - [spaceId]: Unique identifier of the Space for which you want to request
  ///              Tweets.
  ///
  /// ## Endpoint Url
  ///
  /// - https://api.twitter.com/2/spaces/:id/buyers
  ///
  /// ## Rate Limits
  ///
  /// - **User rate limit (OAuth 2.0 user Access Token)**:
  ///    300 requests per 15-minute window per each authenticated user
  ///
  /// ## Reference
  ///
  /// - https://developer.twitter.com/en/docs/twitter-api/spaces/lookup/api-reference/get-spaces-id-buyers
  Future<TwitterResponse<List<UserData>, void>> lookupBuyers(
      {required String spaceId});

  /// Returns Tweets shared in the requested Spaces.
  ///
  /// ## Parameters
  ///
  /// - [spaceId]: Unique identifier of the Space containing the Tweets you'd
  ///              like to access.
  ///
  /// ## Endpoint Url
  ///
  /// - https://api.twitter.com/2/spaces/:id/tweets
  ///
  /// ## Rate Limits
  ///
  /// - **User rate limit (OAuth 2.0 user Access Token)**:
  ///    300 requests per 15-minute window per each authenticated user
  ///
  /// ## Reference
  ///
  /// - https://developer.twitter.com/en/docs/twitter-api/spaces/lookup/api-reference/get-spaces-id-tweets
  Future<TwitterResponse<List<TweetData>, TweetMeta>> lookupTweets(
      {required String spaceId});

  /// Returns live or scheduled Spaces created by the specified user IDs.
  /// Up to 100 comma-separated IDs can be looked up using this endpoint.
  ///
  /// ## Parameters
  ///
  /// - [userIds]: Unique identifiers of the User.
  ///
  /// ## Endpoint Url
  ///
  /// - https://api.twitter.com/2/spaces/by/creator_ids
  ///
  /// ## Rate Limits
  ///
  /// - **User rate limit (OAuth 2.0 user Access Token)**:
  ///    300 requests per 15-minute window per each authenticated user
  ///
  /// - **App rate limit (OAuth 2.0 App Access Token)**:
  ///    300 requests per 15-minute window shared among all users of your app
  ///
  /// - **Shared rate limit**:
  ///    1 request per second among all users of your app
  ///
  /// ## Reference
  ///
  /// - https://developer.twitter.com/en/docs/twitter-api/spaces/lookup/api-reference/get-spaces-by-creator-ids
  Future<TwitterResponse<List<SpaceData>, SpaceMeta>> lookupByCreatorIds(
      {required List<String> userIds});
}

class _SpacesService extends BaseService implements SpacesService {
  /// Returns the new instance of [_SpacesService].
  _SpacesService({required ClientContext context}) : super(context: context);

  @override
  Future<TwitterResponse<List<SpaceData>, SpaceMeta>> search(
      {required String query}) async {
    final response = await super.get(
      UserContext.oauth2Only,
      '/2/spaces/search',
      queryParameters: {'query': query},
    );

    return TwitterResponse(
      data: response['data']
          .map<SpaceData>((space) => SpaceData.fromJson(space))
          .toList(),
      meta: SpaceMeta.fromJson(response['meta']),
    );
  }

  @override
  Future<TwitterResponse<SpaceData, void>> lookupById(
      {required String spaceId}) async {
    final response = await super.get(
      UserContext.oauth2Only,
      '/2/spaces/$spaceId',
    );

    return TwitterResponse(
      data: SpaceData.fromJson(response['data']),
    );
  }

  @override
  Future<TwitterResponse<List<SpaceData>, void>> lookupByIds(
      {required List<String> spaceIds}) async {
    final response = await super.get(
      UserContext.oauth2Only,
      '/2/spaces',
      queryParameters: {'ids': spaceIds.join(',')},
    );

    return TwitterResponse(
      data: response['data']
          .map<SpaceData>((space) => SpaceData.fromJson(space))
          .toList(),
    );
  }

  @override
  Future<TwitterResponse<List<UserData>, void>> lookupBuyers(
      {required String spaceId}) async {
    final response = await super.get(
      UserContext.oauth2Only,
      '/2/spaces/$spaceId/buyers',
    );

    return TwitterResponse(
      data: response['data']
          .map<UserData>((user) => UserData.fromJson(user))
          .toList(),
    );
  }

  @override
  Future<TwitterResponse<List<TweetData>, TweetMeta>> lookupTweets(
      {required String spaceId}) async {
    final response = await super.get(
      UserContext.oauth2Only,
      '/2/spaces/$spaceId/tweets',
    );

    return TwitterResponse(
      data: response['data']
          .map<TweetData>((tweet) => TweetData.fromJson(tweet))
          .toList(),
      meta: TweetMeta.fromJson(response['meta']),
    );
  }

  @override
  Future<TwitterResponse<List<SpaceData>, SpaceMeta>> lookupByCreatorIds(
      {required List<String> userIds}) async {
    final response = await super.get(
      UserContext.oauth2Only,
      '/2/spaces/by/creator_ids',
      queryParameters: {'user_ids': userIds.join(',')},
    );

    return TwitterResponse(
      data: response['data']
          .map<SpaceData>((space) => SpaceData.fromJson(space))
          .toList(),
      meta: SpaceMeta.fromJson(response['meta']),
    );
  }
}
