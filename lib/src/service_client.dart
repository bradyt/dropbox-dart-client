part of dropbox;

class ServiceClient {
  String _endpoint;
  Future<http.Client> _client;

  ServiceClient(this._endpoint, this._client);

  Future getMedatada(
      {String root: "dropbox", String path: "", String locale: "en"}) {
    var completer = new Completer();
    var fields = new Map();
    fields['locale'] = locale;

    http.Request req = new http.Request(
        "GET", Uri.parse(_endpoint + "/metadata/" + root + "/" + path));
    req.bodyFields = fields;

    _client.then((_) {
      _.send(req).then((response) {
        response.stream.bytesToString().then((responseText) {
          var jo = json.decode(responseText);
          completer.complete(jo);
        });
      });
    });

    return completer.future;
  }

  Future getAccountInfo({String locale: "en"}) {
    var completer = new Completer();
    var fields = new Map();
    fields['locale'] = locale;

    http.Request req =
        new http.Request("GET", Uri.parse(_endpoint + "/account/info"));
    req.bodyFields = fields;

    _client.then((_) {
      _.send(req).then((response) {
        response.stream.bytesToString().then((responseText) {
          var jo = json.decode(responseText);
          completer.complete(jo);
        });
      });
    });

    return completer.future;
  }

  Future getDeltaEntries(
      {String cursor, String locale: "en", String path_prefix: null}) {
    var completer = new Completer();
    var fields = new Map();
    fields['cursor'] = cursor;
    fields['locale'] = locale;
    if (path_prefix != null) fields['path_prefix'] = path_prefix;

    http.Request req =
        new http.Request("POST", Uri.parse(_endpoint + "/delta"));
    req.bodyFields = fields;

    _client.then((_) {
      _.send(req).then((response) {
        response.stream.bytesToString().then((responseText) {
          var jo = json.decode(responseText);
          completer.complete(jo);
        });
      });
    });

    return completer.future;
  }
}
