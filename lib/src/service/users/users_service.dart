// Copyright 2022 Kato Shinya. All rights reserved.
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided the conditions.

// Project imports:
import '../../client/client_context.dart';
import '../../client/user_context.dart';
import '../base_service.dart';
import '../twitter_response.dart';
import 'user_data.dart';
import 'user_meta.dart';

abstract class UsersService {
  /// Returns the new instance of [UsersService].
  factory UsersService({required ClientContext context}) =>
      _UsersService(context: context);

  /// Allows a user ID to follow another user.
  ///
  /// If the target user does not have public Tweets, this endpoint will send a
  /// follow request.
  ///
  /// The request succeeds with no action when the authenticated user sends
  /// a request to a user they're already following, or if they're sending
  /// a follower request to a user that does not have public Tweets.
  ///
  /// ## Parameters
  ///
  /// - [userId]: The authenticated user ID who you would like to initiate the
  ///             follow on behalf of. You must pass the Access Tokens that
  ///             relate to this user when authenticating the request.
  ///
  /// - [targetUserId]: The user ID of the user that you would like the id to
  ///                   follow.
  ///
  /// ## Endpoint Url
  ///
  /// - https://api.twitter.com/2/users/:id/following
  ///
  /// ## Rate Limits
  ///
  /// - **User rate limit (OAuth 2.0 user Access Token)**:
  ///    50 requests per 15-minute window per each authenticated user
  ///
  /// ## Reference
  ///
  /// - https://developer.twitter.com/en/docs/twitter-api/users/follows/api-reference/post-users-source_user_id-following
  Future<bool> createFollow(
      {required String userId, required String targetUserId});

  /// Allows a user ID to unfollow another user.
  ///
  /// The request succeeds with no action when the authenticated user ends a
  /// request to a user they're not following or have already unfollowed.
  ///
  /// ## Parameters
  ///
  /// - [userId]: The user ID who you would like to initiate the unfollow on
  ///             behalf of. You must pass the Access Tokens that relate to this
  ///             user when authenticating the request.
  ///
  /// - [targetUserId]: The user ID of the user that you would like the user id
  ///                   to unfollow.
  ///
  /// ## Endpoint Url
  ///
  /// - https://api.twitter.com/2/users/:source_user_id/following/:target_user_id
  ///
  /// ## Rate Limits
  ///
  /// - **User rate limit (OAuth 2.0 user Access Token)**:
  ///    50 requests per 15-minute window per each authenticated user
  ///
  /// ## Reference
  ///
  /// - https://developer.twitter.com/en/docs/twitter-api/users/follows/api-reference/delete-users-source_id-following
  Future<bool> destroyFollow(
      {required String userId, required String targetUserId});

  /// Returns a list of users who are followers of the specified user ID.
  ///
  /// ## Parameters
  ///
  /// - [userId]: The user ID whose followers you would like to retrieve.
  ///
  /// - [maxResults]: The maximum number of results to be returned per page.
  ///                 This can be a number between 1 and the 1000. By default,
  ///                 each page will return 100 results.
  ///
  /// - [paginationToken]: Used to request the next page of results if all
  ///                      results weren't returned with the latest request, or
  ///                      to go back to the previous page of results. To return
  ///                      the next page, pass the `next_token` returned
  ///                      in your previous response. To go back one page, pass
  ///                      the `previous_token` returned in your previous
  ///                      response.
  ///
  /// ## Endpoint Url
  ///
  /// - https://api.twitter.com/2/users/:id/followers
  ///
  /// ## Rate Limits
  ///
  /// - **App rate limit (OAuth 2.0 App Access Token)**:
  ///    15 requests per 15-minute window shared among all users of your app
  ///
  /// - **User rate limit (OAuth 2.0 user Access Token)**:
  ///    15 requests per 15-minute window per each authenticated user
  ///
  /// ## Reference
  ///
  /// - https://developer.twitter.com/en/docs/twitter-api/users/follows/api-reference/get-users-id-followers
  Future<TwitterResponse<List<UserData>, UserMeta>> lookupFollowers(
      {required String userId, int? maxResults, String? paginationToken});

  /// Returns a list of users the specified user ID is following.
  ///
  /// ## Parameters
  ///
  /// - [userId]: The user ID whose following you would like to retrieve.
  ///
  /// - [maxResults]: The maximum number of results to be returned per page.
  ///                 This can be a number between 1 and the 1000. By default,
  ///                 each page will return 100 results.
  ///
  /// - [paginationToken]: Used to request the next page of results if all
  ///                      results weren't returned with the latest request, or
  ///                      to go back to the previous page of results. To return
  ///                      the next page, pass the `next_token` returned
  ///                      in your previous response. To go back one page, pass
  ///                      the `previous_token` returned in your previous
  ///                      response.
  ///
  /// ## Endpoint Url
  ///
  /// - https://api.twitter.com/2/users/:id/following
  ///
  /// ## Rate Limits
  ///
  /// - **App rate limit (OAuth 2.0 App Access Token):
  ///    15 requests per 15-minute window shared among all users of your app
  ///
  /// - **User rate limit (OAuth 2.0 user Access Token)**:
  ///    15 requests per 15-minute window per each authenticated user
  ///
  /// ## Reference
  ///
  /// - https://developer.twitter.com/en/docs/twitter-api/users/follows/api-reference/get-users-id-following
  Future<TwitterResponse<List<UserData>, UserMeta>> lookupFollowings(
      {required String userId, int? maxResults, String? paginationToken});

  /// Returns a variety of information about a single user specified by the
  /// requested ID.
  ///
  /// ## Parameters
  ///
  /// - [userId]: The ID of the user to lookup.
  ///
  /// ## Endpoint Url
  ///
  /// - https://api.twitter.com/2/users/:id
  ///
  /// ## Rate Limits
  ///
  /// - **App rate limit (OAuth 2.0 App Access Token)**:
  ///    900 requests per 15-minute window shared among all users of your app
  ///
  /// - **User rate limit (OAuth 2.0 user Access Token)**:
  ///    900 requests per 15-minute window per each authenticated user
  ///
  /// ## Reference
  ///
  /// - https://developer.twitter.com/en/docs/twitter-api/users/lookup/api-reference/get-users-id
  Future<TwitterResponse<UserData, void>> lookupById({required String userId});

  /// Returns a variety of information about one or more users specified by the
  /// requested IDs.
  ///
  /// ## Parameters
  ///
  /// - [userIds]: 	A list of user IDs.
  ///               Up to 100 are allowed in a single request.
  ///
  /// ## Endpoint Url
  ///
  /// - https://api.twitter.com/2/users
  ///
  /// ## Rate Limits
  ///
  /// - **App rate limit (OAuth 2.0 App Access Token)**:
  ///    900 requests per 15-minute window shared among all users of your app
  ///
  /// - **User rate limit (OAuth 2.0 user Access Token)**:
  ///    900 requests per 15-minute window per each authenticated user
  ///
  /// ## Reference
  ///
  /// - https://developer.twitter.com/en/docs/twitter-api/users/lookup/api-reference/get-users
  Future<TwitterResponse<List<UserData>, void>> lookupByIds(
      {required List<String> userIds});

  /// Returns a variety of information about one or more users specified by
  /// their usernames.
  ///
  /// ## Parameters
  ///
  /// - [username]: The Twitter username (handle) of the user.
  ///
  /// ## Endpoint Url
  ///
  /// - https://api.twitter.com/2/users/by/username/:username
  ///
  /// ## Rate Limits
  ///
  /// - **App rate limit (OAuth 2.0 App Access Token)**:
  ///    900 requests per 15-minute window shared among all users of your app
  ///
  /// - **User rate limit (OAuth 2.0 user Access Token)**:
  ///    900 requests per 15-minute window per each authenticated user
  ///
  /// ## Reference
  ///
  /// - https://developer.twitter.com/en/docs/twitter-api/users/lookup/api-reference/get-users-by-username-username
  Future<TwitterResponse<UserData, void>> lookupByName(
      {required String username});

  /// Returns a variety of information about one or more users specified by
  /// their usernames.
  ///
  /// ## Parameters
  ///
  /// - [usernames]: A list of Twitter usernames (handles).
  ///                Up to 100 are allowed in a single request.
  ///
  /// ## Endpoint Url
  ///
  /// - https://api.twitter.com/2/users/by
  ///
  /// ## Rate Limits
  ///
  /// - **App rate limit (OAuth 2.0 App Access Token)**:
  ///    900 requests per 15-minute window shared among all users of your app
  ///
  /// - **User rate limit (OAuth 2.0 user Access Token)**:
  ///    900 requests per 15-minute window per each authenticated user
  ///
  /// ## Reference
  ///
  /// - https://developer.twitter.com/en/docs/twitter-api/users/lookup/api-reference/get-users-by
  Future<TwitterResponse<List<UserData>, void>> lookupByNames(
      {required List<String> usernames});

  /// Returns information about an authorized user.
  ///
  /// ## Endpoint Url
  ///
  /// - https://api.twitter.com/2/users/me
  ///
  /// ## Rate Limits
  ///
  /// - **User rate limit (OAuth 2.0 user Access Token)**:
  ///     75 requests per 15-minute window per each authenticated user
  ///
  /// ## Reference
  ///
  /// - https://developer.twitter.com/en/docs/twitter-api/users/lookup/api-reference/get-users-me
  Future<TwitterResponse<UserData, void>> lookupMe();

  /// Allows an authenticated user ID to mute the target user.
  ///
  /// ## Parameters
  ///
  /// - [userId]: The user ID who you would like to initiate the mute on behalf
  ///             of. It must match your own user ID or that of an
  ///             authenticating user, meaning that you must pass the Access
  ///             Tokens associated with the user ID when authenticating your
  ///             request.
  ///
  /// - [targetUserId]: The user ID of the user that you would like the id to
  ///                   mute. The body should contain a string of the user ID
  ///                   inside of a JSON object.
  ///
  /// ## Endpoint Url
  ///
  /// - https://api.twitter.com/2/users/:id/muting
  ///
  /// ## Rate Limits
  ///
  /// - **User rate limit (OAuth 2.0 user Access Token)**:
  ///    50 requests per 15-minute window per each authenticated user
  ///
  /// ## Reference
  ///
  /// - https://developer.twitter.com/en/docs/twitter-api/users/mutes/api-reference/post-users-user_id-muting
  Future<bool> createMute(
      {required String userId, required String targetUserId});

  /// Allows an authenticated user ID to unmute the target user.
  ///
  /// The request succeeds with no action when the user sends a request to a
  /// user they're not muting or have already unmuted.
  ///
  /// ## Parameters
  ///
  /// - [userId]: The user ID who you would like to initiate an unmute on
  ///             behalf of. The user’s ID must correspond to the user ID of the
  ///             authenticating user, meaning that you must pass the Access
  ///             Tokens associated with the user ID when authenticating your
  ///             request.
  ///
  /// - [targetUserId]: The user ID of the user that you would like the `userId`
  ///                   to unmute.
  ///
  /// ## Endpoint Url
  ///
  /// - https://api.twitter.com/2/users/:source_user_id/muting/:target_user_id
  ///
  /// ## Rate Limits
  ///
  /// - **User rate limit (OAuth 2.0 user Access Token)**:
  ///    50 requests per 15-minute window per each authenticated user
  ///
  /// ## Reference
  ///
  /// - https://developer.twitter.com/en/docs/twitter-api/users/mutes/api-reference/delete-users-user_id-muting
  Future<bool> destroyMute(
      {required String userId, required String targetUserId});

  /// Returns a list of users who are muted by the specified user ID.
  ///
  /// ## Parameters
  ///
  /// - [userId]: The user ID whose muted users you would like to retrieve.
  ///             The user’s ID must correspond to the user ID of the
  ///             authenticating user, meaning that you must pass the Access
  ///             Tokens associated with the user ID when authenticating your
  ///             request.
  ///
  /// - [maxResults]: The maximum number of results to be returned per page.
  ///                 This can be a number between 1 and 1000. By default, each
  ///                 page will return 100 results.
  ///
  /// - [paginationToken]: Used to request the next page of results if all
  ///                      results weren't returned with the latest request,
  ///                      or to go back to the previous page of results.
  ///
  /// ## Endpoint Url
  ///
  /// - https://api.twitter.com/2/users/:id/muting
  ///
  /// ## Rate Limits
  ///
  /// - **User rate limit (OAuth 2.0 user Access Token)**:
  ///    15 requests per 15-minute window per each authenticated user
  ///
  /// ## Reference
  ///
  /// - https://developer.twitter.com/en/docs/twitter-api/users/mutes/api-reference/get-users-muting
  Future<TwitterResponse<List<UserData>, UserMeta>> lookupMutingUsers(
      {required String userId, int? maxResults, String? paginationToken});

  /// Causes the user (in the path) to block the target user.
  /// The user (in the path) must match the user Access Tokens being used to
  /// authorize the request.
  ///
  /// ## Parameters
  ///
  /// - [userId]: The user ID who you would like to initiate the block on behalf
  ///             of. It must match your own user ID or that of an
  ///             authenticating user, meaning that you must pass the Access
  ///             Tokens associated with the user ID when authenticating your
  ///             request.
  ///
  /// - [targetUserId]: The user ID of the user that you would like the id to
  ///                   block. The body should contain a string of the user ID
  ///                   inside of a JSON object.
  ///
  /// ## Endpoint Url
  ///
  /// - https://api.twitter.com/2/users/:id/blocking
  ///
  /// ## Rate Limits
  ///
  /// - **User rate limit (OAuth 2.0 user Access Token)**:
  ///    50 requests per 15-minute window per each authenticated user
  ///
  /// ## Reference
  ///
  /// - https://developer.twitter.com/en/docs/twitter-api/users/blocks/api-reference/post-users-user_id-blocking
  Future<bool> createBlock(
      {required String userId, required String targetUserId});

  /// Allows a user or authenticated user ID to unblock another user.
  ///
  /// The request succeeds with no action when the user sends a request to a
  /// user they're not blocking or have already unblocked.
  ///
  /// ## Parameters
  ///
  /// - [userId]: The user ID who you would like to initiate an unblock on
  ///             behalf of. The user’s ID must correspond to the user ID of the
  ///             authenticating user, meaning that you must pass the Access
  ///             Tokens associated with the user ID when authenticating your
  ///             request.
  ///
  /// - [targetUserId]: The user ID of the user that you would like to unblock.
  ///
  /// ## Endpoint Url
  ///
  /// - https://api.twitter.com/2/users/:id/blocking
  ///
  /// ## Rate Limits
  ///
  /// - **User rate limit (OAuth 2.0 user Access Token)**:
  ///    50 requests per 15-minute window per each authenticated user
  ///
  /// ## Reference
  ///
  /// - https://developer.twitter.com/en/docs/twitter-api/users/blocks/api-reference/delete-users-user_id-blocking
  Future<bool> destroyBlock(
      {required String userId, required String targetUserId});

  /// Returns a list of users who are blocked by the specified user ID.
  ///
  /// ## Parameters
  ///
  /// - [userId]: The user ID whose blocked users you would like to retrieve.
  ///             The user’s ID must correspond to the user ID of the
  ///             authenticating user, meaning that you must pass the Access
  ///             Tokens associated with the user ID when authenticating your
  ///             request.
  ///
  /// - [maxResults]: The maximum number of results to be returned per page.
  ///                 This can be a number between 1 and 1000. By default,
  ///                 each page will return 100 results.
  ///
  /// - [paginationToken]: Used to request the next page of results if all
  ///                      results weren't returned with the latest request,
  ///                      or to go back to the previous page of results.
  ///
  /// ## Endpoint Url
  ///
  /// - https://api.twitter.com/2/users/:id/blocking
  ///
  /// ## Rate Limits
  ///
  /// - **User rate limit (OAuth 2.0 user Access Token)**:
  ///    15 requests per 15-minute window per each authenticated user
  ///
  /// ## Reference
  ///
  /// - https://developer.twitter.com/en/docs/twitter-api/users/blocks/api-reference/get-users-blocking
  Future<TwitterResponse<List<UserData>, UserMeta>> lookupBlockingUsers(
      {required String userId, int? maxResults, String? paginationToken});
}

class _UsersService extends BaseService implements UsersService {
  /// Returns the new instance of [_UsersService].
  _UsersService({required ClientContext context}) : super(context: context);

  @override
  Future<bool> createFollow({
    required String userId,
    required String targetUserId,
  }) async {
    final response = await super.post(
      UserContext.oauth2OrOAuth1,
      '/2/users/$userId/following',
      body: {'target_user_id': targetUserId},
    );

    return response['data']['following'];
  }

  @override
  Future<bool> destroyFollow({
    required String userId,
    required String targetUserId,
  }) async {
    final response = await super.delete(
      UserContext.oauth2OrOAuth1,
      '/2/users/$userId/following/$targetUserId',
    );

    return !response['data']['following'];
  }

  @override
  Future<TwitterResponse<List<UserData>, UserMeta>> lookupFollowers({
    required String userId,
    int? maxResults,
    String? paginationToken,
  }) async {
    final response = await super.get(
      UserContext.oauth2OrOAuth1,
      '/2/users/$userId/followers',
      queryParameters: {
        'max_results': maxResults,
        'pagination_token': paginationToken,
      },
    );

    return TwitterResponse(
      data: response['data']
          .map<UserData>((user) => UserData.fromJson(user))
          .toList(),
      meta: UserMeta.fromJson(response['meta']),
    );
  }

  @override
  Future<TwitterResponse<List<UserData>, UserMeta>> lookupFollowings({
    required String userId,
    int? maxResults,
    String? paginationToken,
  }) async {
    final response = await super.get(
      UserContext.oauth2OrOAuth1,
      '/2/users/$userId/following',
      queryParameters: {
        'max_results': maxResults,
        'pagination_token': paginationToken,
      },
    );

    return TwitterResponse(
      data: response['data']
          .map<UserData>((user) => UserData.fromJson(user))
          .toList(),
      meta: UserMeta.fromJson(response['meta']),
    );
  }

  @override
  Future<TwitterResponse<UserData, void>> lookupById(
      {required String userId}) async {
    final response = await super.get(
      UserContext.oauth2OrOAuth1,
      '/2/users/$userId',
    );

    return TwitterResponse(data: UserData.fromJson(response['data']));
  }

  @override
  Future<TwitterResponse<List<UserData>, void>> lookupByIds(
      {required List<String> userIds}) async {
    final response = await super.get(
      UserContext.oauth2OrOAuth1,
      '/2/users',
      queryParameters: {'ids': userIds.join(',')},
    );

    return TwitterResponse(
      data: response['data']
          .map<UserData>((user) => UserData.fromJson(user))
          .toList(),
    );
  }

  @override
  Future<TwitterResponse<UserData, void>> lookupByName(
      {required String username}) async {
    final response = await super.get(
      UserContext.oauth2OrOAuth1,
      '/2/users/by/username/$username',
    );

    return TwitterResponse(data: UserData.fromJson(response['data']));
  }

  @override
  Future<TwitterResponse<List<UserData>, void>> lookupByNames(
      {required List<String> usernames}) async {
    final response = await super.get(
      UserContext.oauth2OrOAuth1,
      '/2/users/by',
      queryParameters: {'usernames': usernames.join(',')},
    );

    return TwitterResponse(
      data: response['data']
          .map<UserData>((user) => UserData.fromJson(user))
          .toList(),
    );
  }

  @override
  Future<TwitterResponse<UserData, void>> lookupMe() async {
    final response = await super.get(
      UserContext.oauth2OrOAuth1,
      '/2/users/me',
    );

    return TwitterResponse(data: UserData.fromJson(response['data']));
  }

  @override
  Future<bool> createMute(
      {required String userId, required String targetUserId}) async {
    final response = await super.post(
      UserContext.oauth2OrOAuth1,
      '/2/users/$userId/muting',
      body: {'target_user_id': targetUserId},
    );

    return response['data']['muting'];
  }

  @override
  Future<bool> destroyMute(
      {required String userId, required String targetUserId}) async {
    final response = await super.delete(
      UserContext.oauth2OrOAuth1,
      '/2/users/$userId/muting/$targetUserId',
    );

    return !response['data']['muting'];
  }

  @override
  Future<TwitterResponse<List<UserData>, UserMeta>> lookupMutingUsers({
    required String userId,
    int? maxResults,
    String? paginationToken,
  }) async {
    final response = await super.get(
      UserContext.oauth2OrOAuth1,
      '/2/users/$userId/muting',
      queryParameters: {
        'max_results': maxResults,
        'pagination_token': paginationToken,
      },
    );

    return TwitterResponse(
      data: response['data']
          .map<UserData>((user) => UserData.fromJson(user))
          .toList(),
      meta: UserMeta.fromJson(response['meta']),
    );
  }

  @override
  Future<bool> createBlock(
      {required String userId, required String targetUserId}) async {
    final response = await super.post(
      UserContext.oauth2OrOAuth1,
      '/2/users/$userId/blocking',
      body: {'target_user_id': targetUserId},
    );

    return response['data']['blocking'];
  }

  @override
  Future<bool> destroyBlock(
      {required String userId, required String targetUserId}) async {
    final response = await super.delete(
      UserContext.oauth2OrOAuth1,
      '/2/users/$userId/blocking/$targetUserId',
    );

    return !response['data']['blocking'];
  }

  @override
  Future<TwitterResponse<List<UserData>, UserMeta>> lookupBlockingUsers({
    required String userId,
    int? maxResults,
    String? paginationToken,
  }) async {
    final response = await super.get(
      UserContext.oauth2OrOAuth1,
      '/2/users/$userId/blocking',
      queryParameters: {
        'max_results': maxResults,
        'pagination_token': paginationToken,
      },
    );

    return TwitterResponse(
      data: response['data']
          .map<UserData>((user) => UserData.fromJson(user))
          .toList(),
      meta: UserMeta.fromJson(response['meta']),
    );
  }
}
