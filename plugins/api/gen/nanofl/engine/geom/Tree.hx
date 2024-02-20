package nanofl.engine.geom;

typedef Tree<T> = {
	var children : Array<nanofl.engine.geom.Tree<T>>;
	var parent : T;
};