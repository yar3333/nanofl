package nanofl.engine;

import datatools.ArrayRO;

interface IInstance 
{
	var namePath(default, null) : String;
	
	function getFilters() : ArrayRO<FilterDef>;
	function setFilters(filters:Array<FilterDef>) : Void;
}