dropbox-dart-client
===================

A RESTful dropbox client written in dart

__You need the bleeding edge oath2 pkg__
Clone the bleeding edge repo and symlink oauth2 folder in the root folder of this lib.

https://github.com/dart-lang/bleeding_edge/tree/master/dart/pkg/oauth2

Then change the dependency:


oauth2:

  path: oauth2



Simple usage

	Dropbox dropbox = new Dropbox();
	
	ServiceClient serviceclient = dropbox.getServiceClient();
	ContentClient contentClient = dropbox.getContentClient();
	
	serviceclient.getMedatada().then((_) {
	    print _.size;
	});
	serviceclient.getAccountInfo().then((_) {});
	
	var file = new File("/home/manuel/tothemooooon.png");
	var content = file.readAsBytesSync();
	contentClient.uploadFile(path: "tothemooooon.png", content: content);
