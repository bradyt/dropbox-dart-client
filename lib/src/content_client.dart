part of dropbox;

class ContentClient {
    String _endpoint;
    Future<http.Client> _client;
  
    ContentClient(this._endpoint, this._client);
  
    Future<JsonObject> downloadFile({String root: "dropbox", String path, String locale: "en", String revision: null}) {
        var completer = new Completer();
        var fields = new Map();
        fields['locale'] = locale;
        if(revision != null)
            fields['rev'] = revision;
                
        http.Request req = new http.Request("GET", Uri.parse(_endpoint + "/files/" + root + "/" + path));
        req.bodyFields = fields;

        _client.then((_) {
            _.send(req).then((response) {
                response.stream.bytesToString().then((responseText) {
                    var jo = new JsonObject.fromJsonString(responseText);
                    completer.complete(jo);  
                });
            });
        });
        
        return completer.future;
    }
    
    Future<JsonObject> uploadFile({String root: "dropbox", String path, String locale: "en", 
            String parent_rev: null, List<int> content}) {
        var completer = new Completer();
        
        String params = "?" + "locale=" + locale;
        if(parent_rev != null)
            params += "&parent_rev=" + parent_rev;
        
        http.Request req = new http.Request("PUT", Uri.parse(_endpoint + "/files_put/" + root + "/" + path + params));
        req.bodyBytes = content;
    
        _client.then((_) {
            _.send(req).then((response) {
                response.stream.bytesToString().then((responseText) {
                    var jo = new JsonObject.fromJsonString(responseText);
                    completer.complete(jo);  
                });
            });
        });
        
        return completer.future;
    }
}