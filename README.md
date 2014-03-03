dropbox-dart-client
===================

A RESTful dropbox client written in dart

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
