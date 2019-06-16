part of dropbox;

class Dropbox {
  Future<http.Client> _client;

  final authorizationEndpoint =
      Uri.parse("https://www.dropbox.com/1/oauth2/authorize");
  final tokenEndpoint = Uri.parse("https://api.dropbox.com/1/oauth2/token");

  final apiEndpoint = "https://api.dropbox.com/1";
  final apiContentEndpoint = "https://api-content.dropbox.com/1";

  final Uri redirectUrl = Uri.parse("https://localhost");

  ServiceClient _serviceClient;
  ContentClient _contentClient;

  Map _intro() {
    var oauth2Attributes = new Map();
    oauth2Attributes['redirect'] = "http://localhost";

    print("This library uses the oauth2 authentication system.");
    print(
        "Go to https://www.dropbox.com/developers/apps and create a Dropbox API app.");
    print("Insert the app key:");
    oauth2Attributes['key'] = stdin.readLineSync();
    print("Insert the app secret:");
    oauth2Attributes['secret'] = stdin.readLineSync();
    print("OAuth redirect URIs [${oauth2Attributes['redirect']}]:");
    String redirect = stdin.readLineSync();
    if (redirect.isNotEmpty) oauth2Attributes['redirect'] = redirect;
    print(" ");

    return oauth2Attributes;
  }

  Dropbox() {
    // Print instructions
    var o2 = _intro();

    // Retrieving oauth2 url
    print("Go to:");
    var grant = new oauth2.AuthorizationCodeGrant(
        o2['key'], authorizationEndpoint, tokenEndpoint,
        secret: o2['secret']);
    print(grant.getAuthorizationUrl(Uri.parse(o2['redirect'])));

    print(
        "Insert the full redirect url like ${o2['redirect']}/?code=something:");
    String input = stdin.readLineSync(); // Waiting for token

    Uri uri = Uri.parse(input); // String to URI

    // Validating token
    _client = grant.handleAuthorizationResponse(uri.queryParameters);
  }

  ServiceClient getServiceClient() {
    if (_serviceClient == null)
      _serviceClient = new ServiceClient(apiEndpoint, _client);
    return _serviceClient;
  }

  ContentClient getContentClient() {
    if (_contentClient == null)
      _contentClient = new ContentClient(apiContentEndpoint, _client);
    return _contentClient;
  }
}
