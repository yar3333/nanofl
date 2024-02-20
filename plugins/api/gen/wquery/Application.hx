package wquery;

extern class Application {
	static function run<T:(wquery.Component)>(selector:Dynamic, componentClass:Class<T>, ?params:Dynamic):T;
}