package htmlparser;

typedef HtmlLexem = {
	var all : String;
	var allPos : Int;
	var attrs : String;
	var close : String;
	var comment : String;
	var elem : String;
	var script : String;
	var scriptAttrs : String;
	var scriptText : String;
	var style : String;
	var styleAttrs : String;
	var styleText : String;
	var tagClose : String;
	var tagCloseLC : String;
	var tagEnd : String;
	var tagOpen : String;
	var tagOpenLC : String;
};