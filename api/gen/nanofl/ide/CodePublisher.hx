package nanofl.ide;

extern class CodePublisher extends nanofl.ide.InjectContainer {
	static function publishHtmlAndJsFiles(destDir:String, properties:nanofl.ide.DocumentProperties, addLinkToThreeJs:Bool, addLinkToApplicationJs:Bool):Void;
}