package nanofl.engine;

interface IInstance {
	var namePath(default, null) : String;
	function getFilters():datatools.ArrayRO<nanofl.engine.FilterDef>;
	function setFilters(filters:Array<nanofl.engine.FilterDef>):Void;
}