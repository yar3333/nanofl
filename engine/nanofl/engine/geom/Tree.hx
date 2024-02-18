package nanofl.engine.geom;

typedef Tree<T> =
{
	var parent: T;
	var children: Array<Tree<T>>;
}
