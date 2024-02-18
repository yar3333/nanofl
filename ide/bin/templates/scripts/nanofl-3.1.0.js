(function (console, $hx_exports) { "use strict";
$hx_exports.nanofl = $hx_exports.nanofl || {};
$hx_exports.nanofl.engine = $hx_exports.nanofl.engine || {};
$hx_exports.nanofl.engine.plugins = $hx_exports.nanofl.engine.plugins || {};
var $hxClasses = {},$estr = function() { return js_Boot.__string_rec(this,''); };
function $extend(from, fields) {
	function Inherit() {} Inherit.prototype = from; var proto = new Inherit();
	for (var name in fields) proto[name] = fields[name];
	if( fields.toString !== Object.prototype.toString ) proto.toString = fields.toString;
	return proto;
}
var EReg = function(r,opt) {
	opt = opt.split("u").join("");
	this.r = new RegExp(r,opt);
};
$hxClasses["EReg"] = EReg;
EReg.__name__ = ["EReg"];
EReg.prototype = {
	r: null
	,match: function(s) {
		if(this.r.global) this.r.lastIndex = 0;
		this.r.m = this.r.exec(s);
		this.r.s = s;
		return this.r.m != null;
	}
	,matched: function(n) {
		if(this.r.m != null && n >= 0 && n < this.r.m.length) return this.r.m[n]; else throw new js__$Boot_HaxeError("EReg::matched");
	}
	,matchedPos: function() {
		if(this.r.m == null) throw new js__$Boot_HaxeError("No string matched");
		return { pos : this.r.m.index, len : this.r.m[0].length};
	}
	,matchSub: function(s,pos,len) {
		if(len == null) len = -1;
		if(this.r.global) {
			this.r.lastIndex = pos;
			this.r.m = this.r.exec(len < 0?s:HxOverrides.substr(s,0,pos + len));
			var b = this.r.m != null;
			if(b) this.r.s = s;
			return b;
		} else {
			var b1 = this.match(len < 0?HxOverrides.substr(s,pos,null):HxOverrides.substr(s,pos,len));
			if(b1) {
				this.r.s = s;
				this.r.m.index += pos;
			}
			return b1;
		}
	}
	,split: function(s) {
		var d = "#__delim__#";
		return s.replace(this.r,d).split(d);
	}
	,replace: function(s,by) {
		return s.replace(this.r,by);
	}
	,map: function(s,f) {
		var offset = 0;
		var buf = new StringBuf();
		do {
			if(offset >= s.length) break; else if(!this.matchSub(s,offset)) {
				buf.add(HxOverrides.substr(s,offset,null));
				break;
			}
			var p = this.matchedPos();
			buf.add(HxOverrides.substr(s,offset,p.pos - offset));
			buf.add(f(this));
			if(p.len == 0) {
				buf.add(HxOverrides.substr(s,p.pos,1));
				offset = p.pos + 1;
			} else offset = p.pos + p.len;
		} while(this.r.global);
		if(!this.r.global && offset > 0 && offset < s.length) buf.add(HxOverrides.substr(s,offset,null));
		return buf.b;
	}
	,__class__: EReg
};
var HxOverrides = function() { };
$hxClasses["HxOverrides"] = HxOverrides;
HxOverrides.__name__ = ["HxOverrides"];
HxOverrides.strDate = function(s) {
	var _g = s.length;
	switch(_g) {
	case 8:
		var k = s.split(":");
		var d = new Date();
		d.setTime(0);
		d.setUTCHours(k[0]);
		d.setUTCMinutes(k[1]);
		d.setUTCSeconds(k[2]);
		return d;
	case 10:
		var k1 = s.split("-");
		return new Date(k1[0],k1[1] - 1,k1[2],0,0,0);
	case 19:
		var k2 = s.split(" ");
		var y = k2[0].split("-");
		var t = k2[1].split(":");
		return new Date(y[0],y[1] - 1,y[2],t[0],t[1],t[2]);
	default:
		throw new js__$Boot_HaxeError("Invalid date format : " + s);
	}
};
HxOverrides.cca = function(s,index) {
	var x = s.charCodeAt(index);
	if(x != x) return undefined;
	return x;
};
HxOverrides.substr = function(s,pos,len) {
	if(pos != null && pos != 0 && len != null && len < 0) return "";
	if(len == null) len = s.length;
	if(pos < 0) {
		pos = s.length + pos;
		if(pos < 0) pos = 0;
	} else if(len < 0) len = s.length + len - pos;
	return s.substr(pos,len);
};
HxOverrides.indexOf = function(a,obj,i) {
	var len = a.length;
	if(i < 0) {
		i += len;
		if(i < 0) i = 0;
	}
	while(i < len) {
		if(a[i] === obj) return i;
		i++;
	}
	return -1;
};
HxOverrides.lastIndexOf = function(a,obj,i) {
	var len = a.length;
	if(i >= len) i = len - 1; else if(i < 0) i += len;
	while(i >= 0) {
		if(a[i] === obj) return i;
		i--;
	}
	return -1;
};
HxOverrides.remove = function(a,obj) {
	var i = HxOverrides.indexOf(a,obj,0);
	if(i == -1) return false;
	a.splice(i,1);
	return true;
};
HxOverrides.iter = function(a) {
	return { cur : 0, arr : a, hasNext : function() {
		return this.cur < this.arr.length;
	}, next : function() {
		return this.arr[this.cur++];
	}};
};
var Lambda = function() { };
$hxClasses["Lambda"] = Lambda;
Lambda.__name__ = ["Lambda"];
Lambda.array = function(it) {
	var a = [];
	var $it0 = $iterator(it)();
	while( $it0.hasNext() ) {
		var i = $it0.next();
		a.push(i);
	}
	return a;
};
Lambda.exists = function(it,f) {
	var $it0 = $iterator(it)();
	while( $it0.hasNext() ) {
		var x = $it0.next();
		if(f(x)) return true;
	}
	return false;
};
Lambda.foreach = function(it,f) {
	var $it0 = $iterator(it)();
	while( $it0.hasNext() ) {
		var x = $it0.next();
		if(!f(x)) return false;
	}
	return true;
};
Lambda.count = function(it,pred) {
	var n = 0;
	if(pred == null) {
		var $it0 = $iterator(it)();
		while( $it0.hasNext() ) {
			var _ = $it0.next();
			n++;
		}
	} else {
		var $it1 = $iterator(it)();
		while( $it1.hasNext() ) {
			var x = $it1.next();
			if(pred(x)) n++;
		}
	}
	return n;
};
Lambda.indexOf = function(it,v) {
	var i = 0;
	var $it0 = $iterator(it)();
	while( $it0.hasNext() ) {
		var v2 = $it0.next();
		if(v == v2) return i;
		i++;
	}
	return -1;
};
Lambda.find = function(it,f) {
	var $it0 = $iterator(it)();
	while( $it0.hasNext() ) {
		var v = $it0.next();
		if(f(v)) return v;
	}
	return null;
};
var List = function() {
	this.length = 0;
};
$hxClasses["List"] = List;
List.__name__ = ["List"];
List.prototype = {
	h: null
	,q: null
	,length: null
	,add: function(item) {
		var x = [item];
		if(this.h == null) this.h = x; else this.q[1] = x;
		this.q = x;
		this.length++;
	}
	,iterator: function() {
		return new _$List_ListIterator(this.h);
	}
	,__class__: List
};
var _$List_ListIterator = function(head) {
	this.head = head;
	this.val = null;
};
$hxClasses["_List.ListIterator"] = _$List_ListIterator;
_$List_ListIterator.__name__ = ["_List","ListIterator"];
_$List_ListIterator.prototype = {
	head: null
	,val: null
	,hasNext: function() {
		return this.head != null;
	}
	,next: function() {
		this.val = this.head[0];
		this.head = this.head[1];
		return this.val;
	}
	,__class__: _$List_ListIterator
};
Math.__name__ = ["Math"];
var Reflect = function() { };
$hxClasses["Reflect"] = Reflect;
Reflect.__name__ = ["Reflect"];
Reflect.hasField = function(o,field) {
	return Object.prototype.hasOwnProperty.call(o,field);
};
Reflect.field = function(o,field) {
	try {
		return o[field];
	} catch( e ) {
		haxe_CallStack.lastException = e;
		if (e instanceof js__$Boot_HaxeError) e = e.val;
		return null;
	}
};
Reflect.setField = function(o,field,value) {
	o[field] = value;
};
Reflect.callMethod = function(o,func,args) {
	return func.apply(o,args);
};
Reflect.fields = function(o) {
	var a = [];
	if(o != null) {
		var hasOwnProperty = Object.prototype.hasOwnProperty;
		for( var f in o ) {
		if(f != "__id__" && f != "hx__closures__" && hasOwnProperty.call(o,f)) a.push(f);
		}
	}
	return a;
};
Reflect.isFunction = function(f) {
	return typeof(f) == "function" && !(f.__name__ || f.__ename__);
};
Reflect.compare = function(a,b) {
	if(a == b) return 0; else if(a > b) return 1; else return -1;
};
Reflect.isObject = function(v) {
	if(v == null) return false;
	var t = typeof(v);
	return t == "string" || t == "object" && v.__enum__ == null || t == "function" && (v.__name__ || v.__ename__) != null;
};
Reflect.deleteField = function(o,field) {
	if(!Object.prototype.hasOwnProperty.call(o,field)) return false;
	delete(o[field]);
	return true;
};
Reflect.copy = function(o) {
	var o2 = { };
	var _g = 0;
	var _g1 = Reflect.fields(o);
	while(_g < _g1.length) {
		var f = _g1[_g];
		++_g;
		Reflect.setField(o2,f,Reflect.field(o,f));
	}
	return o2;
};
Reflect.makeVarArgs = function(f) {
	return function() {
		var a = Array.prototype.slice.call(arguments);
		return f(a);
	};
};
var Slambda = function() { };
$hxClasses["Slambda"] = Slambda;
Slambda.__name__ = ["Slambda"];
var Slambda1 = function() { };
$hxClasses["Slambda1"] = Slambda1;
Slambda1.__name__ = ["Slambda1"];
var Slambda2 = function() { };
$hxClasses["Slambda2"] = Slambda2;
Slambda2.__name__ = ["Slambda2"];
var Slambda3 = function() { };
$hxClasses["Slambda3"] = Slambda3;
Slambda3.__name__ = ["Slambda3"];
var Slambda4 = function() { };
$hxClasses["Slambda4"] = Slambda4;
Slambda4.__name__ = ["Slambda4"];
var Std = function() { };
$hxClasses["Std"] = Std;
Std.__name__ = ["Std"];
Std.string = function(s) {
	return js_Boot.__string_rec(s,"");
};
Std["int"] = function(x) {
	return x | 0;
};
Std.parseInt = function(x) {
	var v = parseInt(x,10);
	if(v == 0 && (HxOverrides.cca(x,1) == 120 || HxOverrides.cca(x,1) == 88)) v = parseInt(x);
	if(isNaN(v)) return null;
	return v;
};
Std.parseFloat = function(x) {
	return parseFloat(x);
};
Std.random = function(x) {
	if(x <= 0) return 0; else return Math.floor(Math.random() * x);
};
var StringBuf = function() {
	this.b = "";
};
$hxClasses["StringBuf"] = StringBuf;
StringBuf.__name__ = ["StringBuf"];
StringBuf.prototype = {
	b: null
	,add: function(x) {
		this.b += Std.string(x);
	}
	,__class__: StringBuf
};
var StringTools = function() { };
$hxClasses["StringTools"] = StringTools;
StringTools.__name__ = ["StringTools"];
StringTools.htmlEscape = function(s,quotes) {
	s = s.split("&").join("&amp;").split("<").join("&lt;").split(">").join("&gt;");
	if(quotes) return s.split("\"").join("&quot;").split("'").join("&#039;"); else return s;
};
StringTools.htmlUnescape = function(s) {
	return s.split("&gt;").join(">").split("&lt;").join("<").split("&quot;").join("\"").split("&#039;").join("'").split("&amp;").join("&");
};
StringTools.startsWith = function(s,start) {
	return s.length >= start.length && HxOverrides.substr(s,0,start.length) == start;
};
StringTools.endsWith = function(s,end) {
	var elen = end.length;
	var slen = s.length;
	return slen >= elen && HxOverrides.substr(s,slen - elen,elen) == end;
};
StringTools.isSpace = function(s,pos) {
	var c = HxOverrides.cca(s,pos);
	return c > 8 && c < 14 || c == 32;
};
StringTools.ltrim = function(s) {
	var l = s.length;
	var r = 0;
	while(r < l && StringTools.isSpace(s,r)) r++;
	if(r > 0) return HxOverrides.substr(s,r,l - r); else return s;
};
StringTools.rtrim = function(s) {
	var l = s.length;
	var r = 0;
	while(r < l && StringTools.isSpace(s,l - r - 1)) r++;
	if(r > 0) return HxOverrides.substr(s,0,l - r); else return s;
};
StringTools.trim = function(s) {
	return StringTools.ltrim(StringTools.rtrim(s));
};
StringTools.lpad = function(s,c,l) {
	if(c.length <= 0) return s;
	while(s.length < l) s = c + s;
	return s;
};
StringTools.rpad = function(s,c,l) {
	if(c.length <= 0) return s;
	while(s.length < l) s = s + c;
	return s;
};
StringTools.replace = function(s,sub,by) {
	return s.split(sub).join(by);
};
StringTools.hex = function(n,digits) {
	var s = "";
	var hexChars = "0123456789ABCDEF";
	do {
		s = hexChars.charAt(n & 15) + s;
		n >>>= 4;
	} while(n > 0);
	if(digits != null) while(s.length < digits) s = "0" + s;
	return s;
};
StringTools.fastCodeAt = function(s,index) {
	return s.charCodeAt(index);
};
var ValueType = $hxClasses["ValueType"] = { __ename__ : ["ValueType"], __constructs__ : ["TNull","TInt","TFloat","TBool","TObject","TFunction","TClass","TEnum","TUnknown"] };
ValueType.TNull = ["TNull",0];
ValueType.TNull.toString = $estr;
ValueType.TNull.__enum__ = ValueType;
ValueType.TInt = ["TInt",1];
ValueType.TInt.toString = $estr;
ValueType.TInt.__enum__ = ValueType;
ValueType.TFloat = ["TFloat",2];
ValueType.TFloat.toString = $estr;
ValueType.TFloat.__enum__ = ValueType;
ValueType.TBool = ["TBool",3];
ValueType.TBool.toString = $estr;
ValueType.TBool.__enum__ = ValueType;
ValueType.TObject = ["TObject",4];
ValueType.TObject.toString = $estr;
ValueType.TObject.__enum__ = ValueType;
ValueType.TFunction = ["TFunction",5];
ValueType.TFunction.toString = $estr;
ValueType.TFunction.__enum__ = ValueType;
ValueType.TClass = function(c) { var $x = ["TClass",6,c]; $x.__enum__ = ValueType; $x.toString = $estr; return $x; };
ValueType.TEnum = function(e) { var $x = ["TEnum",7,e]; $x.__enum__ = ValueType; $x.toString = $estr; return $x; };
ValueType.TUnknown = ["TUnknown",8];
ValueType.TUnknown.toString = $estr;
ValueType.TUnknown.__enum__ = ValueType;
var Type = function() { };
$hxClasses["Type"] = Type;
Type.__name__ = ["Type"];
Type.getClass = function(o) {
	if(o == null) return null; else return js_Boot.getClass(o);
};
Type.getClassName = function(c) {
	var a = c.__name__;
	if(a == null) return null;
	return a.join(".");
};
Type.getEnumName = function(e) {
	var a = e.__ename__;
	return a.join(".");
};
Type.resolveClass = function(name) {
	var cl = $hxClasses[name];
	if(cl == null || !cl.__name__) return null;
	return cl;
};
Type.resolveEnum = function(name) {
	var e = $hxClasses[name];
	if(e == null || !e.__ename__) return null;
	return e;
};
Type.createInstance = function(cl,args) {
	var _g = args.length;
	switch(_g) {
	case 0:
		return new cl();
	case 1:
		return new cl(args[0]);
	case 2:
		return new cl(args[0],args[1]);
	case 3:
		return new cl(args[0],args[1],args[2]);
	case 4:
		return new cl(args[0],args[1],args[2],args[3]);
	case 5:
		return new cl(args[0],args[1],args[2],args[3],args[4]);
	case 6:
		return new cl(args[0],args[1],args[2],args[3],args[4],args[5]);
	case 7:
		return new cl(args[0],args[1],args[2],args[3],args[4],args[5],args[6]);
	case 8:
		return new cl(args[0],args[1],args[2],args[3],args[4],args[5],args[6],args[7]);
	default:
		throw new js__$Boot_HaxeError("Too many arguments");
	}
	return null;
};
Type.createEmptyInstance = function(cl) {
	function empty() {}; empty.prototype = cl.prototype;
	return new empty();
};
Type.createEnum = function(e,constr,params) {
	var f = Reflect.field(e,constr);
	if(f == null) throw new js__$Boot_HaxeError("No such constructor " + constr);
	if(Reflect.isFunction(f)) {
		if(params == null) throw new js__$Boot_HaxeError("Constructor " + constr + " need parameters");
		return Reflect.callMethod(e,f,params);
	}
	if(params != null && params.length != 0) throw new js__$Boot_HaxeError("Constructor " + constr + " does not need parameters");
	return f;
};
Type.getInstanceFields = function(c) {
	var a = [];
	for(var i in c.prototype) a.push(i);
	HxOverrides.remove(a,"__class__");
	HxOverrides.remove(a,"__properties__");
	return a;
};
Type.getEnumConstructs = function(e) {
	var a = e.__constructs__;
	return a.slice();
};
Type["typeof"] = function(v) {
	var _g = typeof(v);
	switch(_g) {
	case "boolean":
		return ValueType.TBool;
	case "string":
		return ValueType.TClass(String);
	case "number":
		if(Math.ceil(v) == v % 2147483648.0) return ValueType.TInt;
		return ValueType.TFloat;
	case "object":
		if(v == null) return ValueType.TNull;
		var e = v.__enum__;
		if(e != null) return ValueType.TEnum(e);
		var c = js_Boot.getClass(v);
		if(c != null) return ValueType.TClass(c);
		return ValueType.TObject;
	case "function":
		if(v.__name__ || v.__ename__) return ValueType.TObject;
		return ValueType.TFunction;
	case "undefined":
		return ValueType.TNull;
	default:
		return ValueType.TUnknown;
	}
};
Type.enumConstructor = function(e) {
	return e[0];
};
Type.enumIndex = function(e) {
	return e[1];
};
var haxe_StackItem = $hxClasses["haxe.StackItem"] = { __ename__ : ["haxe","StackItem"], __constructs__ : ["CFunction","Module","FilePos","Method","LocalFunction"] };
haxe_StackItem.CFunction = ["CFunction",0];
haxe_StackItem.CFunction.toString = $estr;
haxe_StackItem.CFunction.__enum__ = haxe_StackItem;
haxe_StackItem.Module = function(m) { var $x = ["Module",1,m]; $x.__enum__ = haxe_StackItem; $x.toString = $estr; return $x; };
haxe_StackItem.FilePos = function(s,file,line) { var $x = ["FilePos",2,s,file,line]; $x.__enum__ = haxe_StackItem; $x.toString = $estr; return $x; };
haxe_StackItem.Method = function(classname,method) { var $x = ["Method",3,classname,method]; $x.__enum__ = haxe_StackItem; $x.toString = $estr; return $x; };
haxe_StackItem.LocalFunction = function(v) { var $x = ["LocalFunction",4,v]; $x.__enum__ = haxe_StackItem; $x.toString = $estr; return $x; };
var haxe_CallStack = function() { };
$hxClasses["haxe.CallStack"] = haxe_CallStack;
haxe_CallStack.__name__ = ["haxe","CallStack"];
haxe_CallStack.getStack = function(e) {
	if(e == null) return [];
	var oldValue = Error.prepareStackTrace;
	Error.prepareStackTrace = function(error,callsites) {
		var stack = [];
		var _g = 0;
		while(_g < callsites.length) {
			var site = callsites[_g];
			++_g;
			if(haxe_CallStack.wrapCallSite != null) site = haxe_CallStack.wrapCallSite(site);
			var method = null;
			var fullName = site.getFunctionName();
			if(fullName != null) {
				var idx = fullName.lastIndexOf(".");
				if(idx >= 0) {
					var className = HxOverrides.substr(fullName,0,idx);
					var methodName = HxOverrides.substr(fullName,idx + 1,null);
					method = haxe_StackItem.Method(className,methodName);
				}
			}
			stack.push(haxe_StackItem.FilePos(method,site.getFileName(),site.getLineNumber()));
		}
		return stack;
	};
	var a = haxe_CallStack.makeStack(e.stack);
	Error.prepareStackTrace = oldValue;
	return a;
};
haxe_CallStack.callStack = function() {
	try {
		throw new Error();
	} catch( e ) {
		haxe_CallStack.lastException = e;
		if (e instanceof js__$Boot_HaxeError) e = e.val;
		var a = haxe_CallStack.getStack(e);
		a.shift();
		return a;
	}
};
haxe_CallStack.exceptionStack = function() {
	return haxe_CallStack.getStack(haxe_CallStack.lastException);
};
haxe_CallStack.toString = function(stack) {
	var b = new StringBuf();
	var _g = 0;
	while(_g < stack.length) {
		var s = stack[_g];
		++_g;
		b.b += "\nCalled from ";
		haxe_CallStack.itemToString(b,s);
	}
	return b.b;
};
haxe_CallStack.itemToString = function(b,s) {
	switch(s[1]) {
	case 0:
		b.b += "a C function";
		break;
	case 1:
		var m = s[2];
		b.b += "module ";
		if(m == null) b.b += "null"; else b.b += "" + m;
		break;
	case 2:
		var line = s[4];
		var file = s[3];
		var s1 = s[2];
		if(s1 != null) {
			haxe_CallStack.itemToString(b,s1);
			b.b += " (";
		}
		if(file == null) b.b += "null"; else b.b += "" + file;
		b.b += " line ";
		if(line == null) b.b += "null"; else b.b += "" + line;
		if(s1 != null) b.b += ")";
		break;
	case 3:
		var meth = s[3];
		var cname = s[2];
		if(cname == null) b.b += "null"; else b.b += "" + cname;
		b.b += ".";
		if(meth == null) b.b += "null"; else b.b += "" + meth;
		break;
	case 4:
		var n = s[2];
		b.b += "local function #";
		if(n == null) b.b += "null"; else b.b += "" + n;
		break;
	}
};
haxe_CallStack.makeStack = function(s) {
	if(s == null) return []; else if(typeof(s) == "string") {
		var stack = s.split("\n");
		if(stack[0] == "Error") stack.shift();
		var m = [];
		var rie10 = new EReg("^   at ([A-Za-z0-9_. ]+) \\(([^)]+):([0-9]+):([0-9]+)\\)$","");
		var _g = 0;
		while(_g < stack.length) {
			var line = stack[_g];
			++_g;
			if(rie10.match(line)) {
				var path = rie10.matched(1).split(".");
				var meth = path.pop();
				var file = rie10.matched(2);
				var line1 = Std.parseInt(rie10.matched(3));
				m.push(haxe_StackItem.FilePos(meth == "Anonymous function"?haxe_StackItem.LocalFunction():meth == "Global code"?null:haxe_StackItem.Method(path.join("."),meth),file,line1));
			} else m.push(haxe_StackItem.Module(StringTools.trim(line)));
		}
		return m;
	} else return s;
};
var haxe_IMap = function() { };
$hxClasses["haxe.IMap"] = haxe_IMap;
haxe_IMap.__name__ = ["haxe","IMap"];
haxe_IMap.prototype = {
	get: null
	,set: null
	,keys: null
	,iterator: null
	,__class__: haxe_IMap
};
var haxe__$Int64__$_$_$Int64 = function(high,low) {
	this.high = high;
	this.low = low;
};
$hxClasses["haxe._Int64.___Int64"] = haxe__$Int64__$_$_$Int64;
haxe__$Int64__$_$_$Int64.__name__ = ["haxe","_Int64","___Int64"];
haxe__$Int64__$_$_$Int64.prototype = {
	high: null
	,low: null
	,__class__: haxe__$Int64__$_$_$Int64
};
var haxe_Log = function() { };
$hxClasses["haxe.Log"] = haxe_Log;
haxe_Log.__name__ = ["haxe","Log"];
haxe_Log.trace = function(v,infos) {
	js_Boot.__trace(v,infos);
};
var haxe_Serializer = function() {
	this.buf = new StringBuf();
	this.cache = [];
	this.useCache = haxe_Serializer.USE_CACHE;
	this.useEnumIndex = haxe_Serializer.USE_ENUM_INDEX;
	this.shash = new haxe_ds_StringMap();
	this.scount = 0;
};
$hxClasses["haxe.Serializer"] = haxe_Serializer;
haxe_Serializer.__name__ = ["haxe","Serializer"];
haxe_Serializer.prototype = {
	buf: null
	,cache: null
	,shash: null
	,scount: null
	,useCache: null
	,useEnumIndex: null
	,toString: function() {
		return this.buf.b;
	}
	,serializeString: function(s) {
		var x = this.shash.get(s);
		if(x != null) {
			this.buf.b += "R";
			if(x == null) this.buf.b += "null"; else this.buf.b += "" + x;
			return;
		}
		this.shash.set(s,this.scount++);
		this.buf.b += "y";
		s = encodeURIComponent(s);
		if(s.length == null) this.buf.b += "null"; else this.buf.b += "" + s.length;
		this.buf.b += ":";
		if(s == null) this.buf.b += "null"; else this.buf.b += "" + s;
	}
	,serializeRef: function(v) {
		var vt = typeof(v);
		var _g1 = 0;
		var _g = this.cache.length;
		while(_g1 < _g) {
			var i = _g1++;
			var ci = this.cache[i];
			if(typeof(ci) == vt && ci == v) {
				this.buf.b += "r";
				if(i == null) this.buf.b += "null"; else this.buf.b += "" + i;
				return true;
			}
		}
		this.cache.push(v);
		return false;
	}
	,serializeFields: function(v) {
		var _g = 0;
		var _g1 = Reflect.fields(v);
		while(_g < _g1.length) {
			var f = _g1[_g];
			++_g;
			this.serializeString(f);
			this.serialize(Reflect.field(v,f));
		}
		this.buf.b += "g";
	}
	,serialize: function(v) {
		{
			var _g = Type["typeof"](v);
			switch(_g[1]) {
			case 0:
				this.buf.b += "n";
				break;
			case 1:
				var v1 = v;
				if(v1 == 0) {
					this.buf.b += "z";
					return;
				}
				this.buf.b += "i";
				if(v1 == null) this.buf.b += "null"; else this.buf.b += "" + v1;
				break;
			case 2:
				var v2 = v;
				if(isNaN(v2)) this.buf.b += "k"; else if(!isFinite(v2)) if(v2 < 0) this.buf.b += "m"; else this.buf.b += "p"; else {
					this.buf.b += "d";
					if(v2 == null) this.buf.b += "null"; else this.buf.b += "" + v2;
				}
				break;
			case 3:
				if(v) this.buf.b += "t"; else this.buf.b += "f";
				break;
			case 6:
				var c = _g[2];
				if(c == String) {
					this.serializeString(v);
					return;
				}
				if(this.useCache && this.serializeRef(v)) return;
				switch(c) {
				case Array:
					var ucount = 0;
					this.buf.b += "a";
					var l = v.length;
					var _g1 = 0;
					while(_g1 < l) {
						var i = _g1++;
						if(v[i] == null) ucount++; else {
							if(ucount > 0) {
								if(ucount == 1) this.buf.b += "n"; else {
									this.buf.b += "u";
									if(ucount == null) this.buf.b += "null"; else this.buf.b += "" + ucount;
								}
								ucount = 0;
							}
							this.serialize(v[i]);
						}
					}
					if(ucount > 0) {
						if(ucount == 1) this.buf.b += "n"; else {
							this.buf.b += "u";
							if(ucount == null) this.buf.b += "null"; else this.buf.b += "" + ucount;
						}
					}
					this.buf.b += "h";
					break;
				case List:
					this.buf.b += "l";
					var v3 = v;
					var _g1_head = v3.h;
					var _g1_val = null;
					while(_g1_head != null) {
						var i1;
						_g1_val = _g1_head[0];
						_g1_head = _g1_head[1];
						i1 = _g1_val;
						this.serialize(i1);
					}
					this.buf.b += "h";
					break;
				case Date:
					var d = v;
					this.buf.b += "v";
					this.buf.add(d.getTime());
					break;
				case haxe_ds_StringMap:
					this.buf.b += "b";
					var v4 = v;
					var $it0 = v4.keys();
					while( $it0.hasNext() ) {
						var k = $it0.next();
						this.serializeString(k);
						this.serialize(__map_reserved[k] != null?v4.getReserved(k):v4.h[k]);
					}
					this.buf.b += "h";
					break;
				case haxe_ds_IntMap:
					this.buf.b += "q";
					var v5 = v;
					var $it1 = v5.keys();
					while( $it1.hasNext() ) {
						var k1 = $it1.next();
						this.buf.b += ":";
						if(k1 == null) this.buf.b += "null"; else this.buf.b += "" + k1;
						this.serialize(v5.h[k1]);
					}
					this.buf.b += "h";
					break;
				case haxe_ds_ObjectMap:
					this.buf.b += "M";
					var v6 = v;
					var $it2 = v6.keys();
					while( $it2.hasNext() ) {
						var k2 = $it2.next();
						var id = Reflect.field(k2,"__id__");
						Reflect.deleteField(k2,"__id__");
						this.serialize(k2);
						k2.__id__ = id;
						this.serialize(v6.h[k2.__id__]);
					}
					this.buf.b += "h";
					break;
				case haxe_io_Bytes:
					var v7 = v;
					var i2 = 0;
					var max = v7.length - 2;
					var charsBuf = new StringBuf();
					var b64 = haxe_Serializer.BASE64;
					while(i2 < max) {
						var b1 = v7.get(i2++);
						var b2 = v7.get(i2++);
						var b3 = v7.get(i2++);
						charsBuf.add(b64.charAt(b1 >> 2));
						charsBuf.add(b64.charAt((b1 << 4 | b2 >> 4) & 63));
						charsBuf.add(b64.charAt((b2 << 2 | b3 >> 6) & 63));
						charsBuf.add(b64.charAt(b3 & 63));
					}
					if(i2 == max) {
						var b11 = v7.get(i2++);
						var b21 = v7.get(i2++);
						charsBuf.add(b64.charAt(b11 >> 2));
						charsBuf.add(b64.charAt((b11 << 4 | b21 >> 4) & 63));
						charsBuf.add(b64.charAt(b21 << 2 & 63));
					} else if(i2 == max + 1) {
						var b12 = v7.get(i2++);
						charsBuf.add(b64.charAt(b12 >> 2));
						charsBuf.add(b64.charAt(b12 << 4 & 63));
					}
					var chars = charsBuf.b;
					this.buf.b += "s";
					if(chars.length == null) this.buf.b += "null"; else this.buf.b += "" + chars.length;
					this.buf.b += ":";
					if(chars == null) this.buf.b += "null"; else this.buf.b += "" + chars;
					break;
				default:
					if(this.useCache) this.cache.pop();
					if(v.hxSerialize != null) {
						this.buf.b += "C";
						this.serializeString(Type.getClassName(c));
						if(this.useCache) this.cache.push(v);
						v.hxSerialize(this);
						this.buf.b += "g";
					} else {
						this.buf.b += "c";
						this.serializeString(Type.getClassName(c));
						if(this.useCache) this.cache.push(v);
						this.serializeFields(v);
					}
				}
				break;
			case 4:
				if(js_Boot.__instanceof(v,Class)) {
					var className = Type.getClassName(v);
					this.buf.b += "A";
					this.serializeString(className);
				} else if(js_Boot.__instanceof(v,Enum)) {
					this.buf.b += "B";
					this.serializeString(Type.getEnumName(v));
				} else {
					if(this.useCache && this.serializeRef(v)) return;
					this.buf.b += "o";
					this.serializeFields(v);
				}
				break;
			case 7:
				var e = _g[2];
				if(this.useCache) {
					if(this.serializeRef(v)) return;
					this.cache.pop();
				}
				if(this.useEnumIndex) this.buf.b += "j"; else this.buf.b += "w";
				this.serializeString(Type.getEnumName(e));
				if(this.useEnumIndex) {
					this.buf.b += ":";
					this.buf.b += Std.string(v[1]);
				} else this.serializeString(v[0]);
				this.buf.b += ":";
				var l1 = v.length;
				this.buf.b += Std.string(l1 - 2);
				var _g11 = 2;
				while(_g11 < l1) {
					var i3 = _g11++;
					this.serialize(v[i3]);
				}
				if(this.useCache) this.cache.push(v);
				break;
			case 5:
				throw new js__$Boot_HaxeError("Cannot serialize function");
				break;
			default:
				throw new js__$Boot_HaxeError("Cannot serialize " + Std.string(v));
			}
		}
	}
	,__class__: haxe_Serializer
};
var haxe_Timer = function(time_ms) {
	var me = this;
	this.id = setInterval(function() {
		me.run();
	},time_ms);
};
$hxClasses["haxe.Timer"] = haxe_Timer;
haxe_Timer.__name__ = ["haxe","Timer"];
haxe_Timer.delay = function(f,time_ms) {
	var t = new haxe_Timer(time_ms);
	t.run = function() {
		t.stop();
		f();
	};
	return t;
};
haxe_Timer.prototype = {
	id: null
	,stop: function() {
		if(this.id == null) return;
		clearInterval(this.id);
		this.id = null;
	}
	,run: function() {
	}
	,__class__: haxe_Timer
};
var haxe_Unserializer = function(buf) {
	this.buf = buf;
	this.length = buf.length;
	this.pos = 0;
	this.scache = [];
	this.cache = [];
	var r = haxe_Unserializer.DEFAULT_RESOLVER;
	if(r == null) {
		r = Type;
		haxe_Unserializer.DEFAULT_RESOLVER = r;
	}
	this.setResolver(r);
};
$hxClasses["haxe.Unserializer"] = haxe_Unserializer;
haxe_Unserializer.__name__ = ["haxe","Unserializer"];
haxe_Unserializer.initCodes = function() {
	var codes = [];
	var _g1 = 0;
	var _g = haxe_Unserializer.BASE64.length;
	while(_g1 < _g) {
		var i = _g1++;
		codes[haxe_Unserializer.BASE64.charCodeAt(i)] = i;
	}
	return codes;
};
haxe_Unserializer.prototype = {
	buf: null
	,pos: null
	,length: null
	,cache: null
	,scache: null
	,resolver: null
	,setResolver: function(r) {
		if(r == null) this.resolver = { resolveClass : function(_) {
			return null;
		}, resolveEnum : function(_1) {
			return null;
		}}; else this.resolver = r;
	}
	,get: function(p) {
		return this.buf.charCodeAt(p);
	}
	,readDigits: function() {
		var k = 0;
		var s = false;
		var fpos = this.pos;
		while(true) {
			var c = this.buf.charCodeAt(this.pos);
			if(c != c) break;
			if(c == 45) {
				if(this.pos != fpos) break;
				s = true;
				this.pos++;
				continue;
			}
			if(c < 48 || c > 57) break;
			k = k * 10 + (c - 48);
			this.pos++;
		}
		if(s) k *= -1;
		return k;
	}
	,readFloat: function() {
		var p1 = this.pos;
		while(true) {
			var c = this.buf.charCodeAt(this.pos);
			if(c >= 43 && c < 58 || c == 101 || c == 69) this.pos++; else break;
		}
		return Std.parseFloat(HxOverrides.substr(this.buf,p1,this.pos - p1));
	}
	,unserializeObject: function(o) {
		while(true) {
			if(this.pos >= this.length) throw new js__$Boot_HaxeError("Invalid object");
			if(this.buf.charCodeAt(this.pos) == 103) break;
			var k = this.unserialize();
			if(!(typeof(k) == "string")) throw new js__$Boot_HaxeError("Invalid object key");
			var v = this.unserialize();
			o[k] = v;
		}
		this.pos++;
	}
	,unserializeEnum: function(edecl,tag) {
		if(this.get(this.pos++) != 58) throw new js__$Boot_HaxeError("Invalid enum format");
		var nargs = this.readDigits();
		if(nargs == 0) return Type.createEnum(edecl,tag);
		var args = [];
		while(nargs-- > 0) args.push(this.unserialize());
		return Type.createEnum(edecl,tag,args);
	}
	,unserialize: function() {
		var _g = this.get(this.pos++);
		switch(_g) {
		case 110:
			return null;
		case 116:
			return true;
		case 102:
			return false;
		case 122:
			return 0;
		case 105:
			return this.readDigits();
		case 100:
			return this.readFloat();
		case 121:
			var len = this.readDigits();
			if(this.get(this.pos++) != 58 || this.length - this.pos < len) throw new js__$Boot_HaxeError("Invalid string length");
			var s = HxOverrides.substr(this.buf,this.pos,len);
			this.pos += len;
			s = decodeURIComponent(s.split("+").join(" "));
			this.scache.push(s);
			return s;
		case 107:
			return NaN;
		case 109:
			return -Infinity;
		case 112:
			return Infinity;
		case 97:
			var buf = this.buf;
			var a = [];
			this.cache.push(a);
			while(true) {
				var c = this.buf.charCodeAt(this.pos);
				if(c == 104) {
					this.pos++;
					break;
				}
				if(c == 117) {
					this.pos++;
					var n = this.readDigits();
					a[a.length + n - 1] = null;
				} else a.push(this.unserialize());
			}
			return a;
		case 111:
			var o = { };
			this.cache.push(o);
			this.unserializeObject(o);
			return o;
		case 114:
			var n1 = this.readDigits();
			if(n1 < 0 || n1 >= this.cache.length) throw new js__$Boot_HaxeError("Invalid reference");
			return this.cache[n1];
		case 82:
			var n2 = this.readDigits();
			if(n2 < 0 || n2 >= this.scache.length) throw new js__$Boot_HaxeError("Invalid string reference");
			return this.scache[n2];
		case 120:
			throw new js__$Boot_HaxeError(this.unserialize());
			break;
		case 99:
			var name = this.unserialize();
			var cl = this.resolver.resolveClass(name);
			if(cl == null) throw new js__$Boot_HaxeError("Class not found " + name);
			var o1 = Type.createEmptyInstance(cl);
			this.cache.push(o1);
			this.unserializeObject(o1);
			return o1;
		case 119:
			var name1 = this.unserialize();
			var edecl = this.resolver.resolveEnum(name1);
			if(edecl == null) throw new js__$Boot_HaxeError("Enum not found " + name1);
			var e = this.unserializeEnum(edecl,this.unserialize());
			this.cache.push(e);
			return e;
		case 106:
			var name2 = this.unserialize();
			var edecl1 = this.resolver.resolveEnum(name2);
			if(edecl1 == null) throw new js__$Boot_HaxeError("Enum not found " + name2);
			this.pos++;
			var index = this.readDigits();
			var tag = Type.getEnumConstructs(edecl1)[index];
			if(tag == null) throw new js__$Boot_HaxeError("Unknown enum index " + name2 + "@" + index);
			var e1 = this.unserializeEnum(edecl1,tag);
			this.cache.push(e1);
			return e1;
		case 108:
			var l = new List();
			this.cache.push(l);
			var buf1 = this.buf;
			while(this.buf.charCodeAt(this.pos) != 104) l.add(this.unserialize());
			this.pos++;
			return l;
		case 98:
			var h = new haxe_ds_StringMap();
			this.cache.push(h);
			var buf2 = this.buf;
			while(this.buf.charCodeAt(this.pos) != 104) {
				var s1 = this.unserialize();
				h.set(s1,this.unserialize());
			}
			this.pos++;
			return h;
		case 113:
			var h1 = new haxe_ds_IntMap();
			this.cache.push(h1);
			var buf3 = this.buf;
			var c1 = this.get(this.pos++);
			while(c1 == 58) {
				var i = this.readDigits();
				h1.set(i,this.unserialize());
				c1 = this.get(this.pos++);
			}
			if(c1 != 104) throw new js__$Boot_HaxeError("Invalid IntMap format");
			return h1;
		case 77:
			var h2 = new haxe_ds_ObjectMap();
			this.cache.push(h2);
			var buf4 = this.buf;
			while(this.buf.charCodeAt(this.pos) != 104) {
				var s2 = this.unserialize();
				h2.set(s2,this.unserialize());
			}
			this.pos++;
			return h2;
		case 118:
			var d;
			if(this.buf.charCodeAt(this.pos) >= 48 && this.buf.charCodeAt(this.pos) <= 57 && this.buf.charCodeAt(this.pos + 1) >= 48 && this.buf.charCodeAt(this.pos + 1) <= 57 && this.buf.charCodeAt(this.pos + 2) >= 48 && this.buf.charCodeAt(this.pos + 2) <= 57 && this.buf.charCodeAt(this.pos + 3) >= 48 && this.buf.charCodeAt(this.pos + 3) <= 57 && this.buf.charCodeAt(this.pos + 4) == 45) {
				var s3 = HxOverrides.substr(this.buf,this.pos,19);
				d = HxOverrides.strDate(s3);
				this.pos += 19;
			} else {
				var t = this.readFloat();
				var d1 = new Date();
				d1.setTime(t);
				d = d1;
			}
			this.cache.push(d);
			return d;
		case 115:
			var len1 = this.readDigits();
			var buf5 = this.buf;
			if(this.get(this.pos++) != 58 || this.length - this.pos < len1) throw new js__$Boot_HaxeError("Invalid bytes length");
			var codes = haxe_Unserializer.CODES;
			if(codes == null) {
				codes = haxe_Unserializer.initCodes();
				haxe_Unserializer.CODES = codes;
			}
			var i1 = this.pos;
			var rest = len1 & 3;
			var size;
			size = (len1 >> 2) * 3 + (rest >= 2?rest - 1:0);
			var max = i1 + (len1 - rest);
			var bytes = haxe_io_Bytes.alloc(size);
			var bpos = 0;
			while(i1 < max) {
				var c11 = codes[StringTools.fastCodeAt(buf5,i1++)];
				var c2 = codes[StringTools.fastCodeAt(buf5,i1++)];
				bytes.set(bpos++,c11 << 2 | c2 >> 4);
				var c3 = codes[StringTools.fastCodeAt(buf5,i1++)];
				bytes.set(bpos++,c2 << 4 | c3 >> 2);
				var c4 = codes[StringTools.fastCodeAt(buf5,i1++)];
				bytes.set(bpos++,c3 << 6 | c4);
			}
			if(rest >= 2) {
				var c12 = codes[StringTools.fastCodeAt(buf5,i1++)];
				var c21 = codes[StringTools.fastCodeAt(buf5,i1++)];
				bytes.set(bpos++,c12 << 2 | c21 >> 4);
				if(rest == 3) {
					var c31 = codes[StringTools.fastCodeAt(buf5,i1++)];
					bytes.set(bpos++,c21 << 4 | c31 >> 2);
				}
			}
			this.pos += len1;
			this.cache.push(bytes);
			return bytes;
		case 67:
			var name3 = this.unserialize();
			var cl1 = this.resolver.resolveClass(name3);
			if(cl1 == null) throw new js__$Boot_HaxeError("Class not found " + name3);
			var o2 = Type.createEmptyInstance(cl1);
			this.cache.push(o2);
			o2.hxUnserialize(this);
			if(this.get(this.pos++) != 103) throw new js__$Boot_HaxeError("Invalid custom data");
			return o2;
		case 65:
			var name4 = this.unserialize();
			var cl2 = this.resolver.resolveClass(name4);
			if(cl2 == null) throw new js__$Boot_HaxeError("Class not found " + name4);
			return cl2;
		case 66:
			var name5 = this.unserialize();
			var e2 = this.resolver.resolveEnum(name5);
			if(e2 == null) throw new js__$Boot_HaxeError("Enum not found " + name5);
			return e2;
		default:
		}
		this.pos--;
		throw new js__$Boot_HaxeError("Invalid char " + this.buf.charAt(this.pos) + " at position " + this.pos);
	}
	,__class__: haxe_Unserializer
};
var haxe_Utf8 = function(size) {
	this.__b = "";
};
$hxClasses["haxe.Utf8"] = haxe_Utf8;
haxe_Utf8.__name__ = ["haxe","Utf8"];
haxe_Utf8.iter = function(s,chars) {
	var _g1 = 0;
	var _g = s.length;
	while(_g1 < _g) {
		var i = _g1++;
		chars(HxOverrides.cca(s,i));
	}
};
haxe_Utf8.encode = function(s) {
	throw new js__$Boot_HaxeError("Not implemented");
};
haxe_Utf8.decode = function(s) {
	throw new js__$Boot_HaxeError("Not implemented");
};
haxe_Utf8.compare = function(a,b) {
	if(a > b) return 1; else if(a == b) return 0; else return -1;
};
haxe_Utf8.prototype = {
	__b: null
	,addChar: function(c) {
		this.__b += String.fromCharCode(c);
	}
	,__class__: haxe_Utf8
};
var haxe_ds_IntMap = function() {
	this.h = { };
};
$hxClasses["haxe.ds.IntMap"] = haxe_ds_IntMap;
haxe_ds_IntMap.__name__ = ["haxe","ds","IntMap"];
haxe_ds_IntMap.__interfaces__ = [haxe_IMap];
haxe_ds_IntMap.prototype = {
	h: null
	,set: function(key,value) {
		this.h[key] = value;
	}
	,get: function(key) {
		return this.h[key];
	}
	,keys: function() {
		var a = [];
		for( var key in this.h ) {
		if(this.h.hasOwnProperty(key)) a.push(key | 0);
		}
		return HxOverrides.iter(a);
	}
	,iterator: function() {
		return { ref : this.h, it : this.keys(), hasNext : function() {
			return this.it.hasNext();
		}, next : function() {
			var i = this.it.next();
			return this.ref[i];
		}};
	}
	,__class__: haxe_ds_IntMap
};
var haxe_ds_ObjectMap = function() {
	this.h = { };
	this.h.__keys__ = { };
};
$hxClasses["haxe.ds.ObjectMap"] = haxe_ds_ObjectMap;
haxe_ds_ObjectMap.__name__ = ["haxe","ds","ObjectMap"];
haxe_ds_ObjectMap.__interfaces__ = [haxe_IMap];
haxe_ds_ObjectMap.prototype = {
	h: null
	,set: function(key,value) {
		var id = key.__id__ || (key.__id__ = ++haxe_ds_ObjectMap.count);
		this.h[id] = value;
		this.h.__keys__[id] = key;
	}
	,get: function(key) {
		return this.h[key.__id__];
	}
	,remove: function(key) {
		var id = key.__id__;
		if(this.h.__keys__[id] == null) return false;
		delete(this.h[id]);
		delete(this.h.__keys__[id]);
		return true;
	}
	,keys: function() {
		var a = [];
		for( var key in this.h.__keys__ ) {
		if(this.h.hasOwnProperty(key)) a.push(this.h.__keys__[key]);
		}
		return HxOverrides.iter(a);
	}
	,iterator: function() {
		return { ref : this.h, it : this.keys(), hasNext : function() {
			return this.it.hasNext();
		}, next : function() {
			var i = this.it.next();
			return this.ref[i.__id__];
		}};
	}
	,__class__: haxe_ds_ObjectMap
};
var haxe_ds__$StringMap_StringMapIterator = function(map,keys) {
	this.map = map;
	this.keys = keys;
	this.index = 0;
	this.count = keys.length;
};
$hxClasses["haxe.ds._StringMap.StringMapIterator"] = haxe_ds__$StringMap_StringMapIterator;
haxe_ds__$StringMap_StringMapIterator.__name__ = ["haxe","ds","_StringMap","StringMapIterator"];
haxe_ds__$StringMap_StringMapIterator.prototype = {
	map: null
	,keys: null
	,index: null
	,count: null
	,hasNext: function() {
		return this.index < this.count;
	}
	,next: function() {
		return this.map.get(this.keys[this.index++]);
	}
	,__class__: haxe_ds__$StringMap_StringMapIterator
};
var haxe_ds_StringMap = function() {
	this.h = { };
};
$hxClasses["haxe.ds.StringMap"] = haxe_ds_StringMap;
haxe_ds_StringMap.__name__ = ["haxe","ds","StringMap"];
haxe_ds_StringMap.__interfaces__ = [haxe_IMap];
haxe_ds_StringMap.prototype = {
	h: null
	,rh: null
	,set: function(key,value) {
		if(__map_reserved[key] != null) this.setReserved(key,value); else this.h[key] = value;
	}
	,get: function(key) {
		if(__map_reserved[key] != null) return this.getReserved(key);
		return this.h[key];
	}
	,exists: function(key) {
		if(__map_reserved[key] != null) return this.existsReserved(key);
		return this.h.hasOwnProperty(key);
	}
	,setReserved: function(key,value) {
		if(this.rh == null) this.rh = { };
		this.rh["$" + key] = value;
	}
	,getReserved: function(key) {
		if(this.rh == null) return null; else return this.rh["$" + key];
	}
	,existsReserved: function(key) {
		if(this.rh == null) return false;
		return this.rh.hasOwnProperty("$" + key);
	}
	,remove: function(key) {
		if(__map_reserved[key] != null) {
			key = "$" + key;
			if(this.rh == null || !this.rh.hasOwnProperty(key)) return false;
			delete(this.rh[key]);
			return true;
		} else {
			if(!this.h.hasOwnProperty(key)) return false;
			delete(this.h[key]);
			return true;
		}
	}
	,keys: function() {
		var _this = this.arrayKeys();
		return HxOverrides.iter(_this);
	}
	,arrayKeys: function() {
		var out = [];
		for( var key in this.h ) {
		if(this.h.hasOwnProperty(key)) out.push(key);
		}
		if(this.rh != null) {
			for( var key in this.rh ) {
			if(key.charCodeAt(0) == 36) out.push(key.substr(1));
			}
		}
		return out;
	}
	,iterator: function() {
		return new haxe_ds__$StringMap_StringMapIterator(this,this.arrayKeys());
	}
	,__class__: haxe_ds_StringMap
};
var haxe_io_Bytes = function(data) {
	this.length = data.byteLength;
	this.b = new Uint8Array(data);
	this.b.bufferValue = data;
	data.hxBytes = this;
	data.bytes = this.b;
};
$hxClasses["haxe.io.Bytes"] = haxe_io_Bytes;
haxe_io_Bytes.__name__ = ["haxe","io","Bytes"];
haxe_io_Bytes.alloc = function(length) {
	return new haxe_io_Bytes(new ArrayBuffer(length));
};
haxe_io_Bytes.prototype = {
	length: null
	,b: null
	,get: function(pos) {
		return this.b[pos];
	}
	,set: function(pos,v) {
		this.b[pos] = v & 255;
	}
	,__class__: haxe_io_Bytes
};
var haxe_io_Error = $hxClasses["haxe.io.Error"] = { __ename__ : ["haxe","io","Error"], __constructs__ : ["Blocked","Overflow","OutsideBounds","Custom"] };
haxe_io_Error.Blocked = ["Blocked",0];
haxe_io_Error.Blocked.toString = $estr;
haxe_io_Error.Blocked.__enum__ = haxe_io_Error;
haxe_io_Error.Overflow = ["Overflow",1];
haxe_io_Error.Overflow.toString = $estr;
haxe_io_Error.Overflow.__enum__ = haxe_io_Error;
haxe_io_Error.OutsideBounds = ["OutsideBounds",2];
haxe_io_Error.OutsideBounds.toString = $estr;
haxe_io_Error.OutsideBounds.__enum__ = haxe_io_Error;
haxe_io_Error.Custom = function(e) { var $x = ["Custom",3,e]; $x.__enum__ = haxe_io_Error; $x.toString = $estr; return $x; };
var haxe_io_FPHelper = function() { };
$hxClasses["haxe.io.FPHelper"] = haxe_io_FPHelper;
haxe_io_FPHelper.__name__ = ["haxe","io","FPHelper"];
haxe_io_FPHelper.i32ToFloat = function(i) {
	var sign = 1 - (i >>> 31 << 1);
	var exp = i >>> 23 & 255;
	var sig = i & 8388607;
	if(sig == 0 && exp == 0) return 0.0;
	return sign * (1 + Math.pow(2,-23) * sig) * Math.pow(2,exp - 127);
};
haxe_io_FPHelper.floatToI32 = function(f) {
	if(f == 0) return 0;
	var af;
	if(f < 0) af = -f; else af = f;
	var exp = Math.floor(Math.log(af) / 0.6931471805599453);
	if(exp < -127) exp = -127; else if(exp > 128) exp = 128;
	var sig = Math.round((af / Math.pow(2,exp) - 1) * 8388608) & 8388607;
	return (f < 0?-2147483648:0) | exp + 127 << 23 | sig;
};
haxe_io_FPHelper.i64ToDouble = function(low,high) {
	var sign = 1 - (high >>> 31 << 1);
	var exp = (high >> 20 & 2047) - 1023;
	var sig = (high & 1048575) * 4294967296. + (low >>> 31) * 2147483648. + (low & 2147483647);
	if(sig == 0 && exp == -1023) return 0.0;
	return sign * (1.0 + Math.pow(2,-52) * sig) * Math.pow(2,exp);
};
haxe_io_FPHelper.doubleToI64 = function(v) {
	var i64 = haxe_io_FPHelper.i64tmp;
	if(v == 0) {
		i64.low = 0;
		i64.high = 0;
	} else {
		var av;
		if(v < 0) av = -v; else av = v;
		var exp = Math.floor(Math.log(av) / 0.6931471805599453);
		var sig;
		var v1 = (av / Math.pow(2,exp) - 1) * 4503599627370496.;
		sig = Math.round(v1);
		var sig_l = sig | 0;
		var sig_h = sig / 4294967296.0 | 0;
		i64.low = sig_l;
		i64.high = (v < 0?-2147483648:0) | exp + 1023 << 20 | sig_h;
	}
	return i64;
};
var haxe_io_Path = function(path) {
	switch(path) {
	case ".":case "..":
		this.dir = path;
		this.file = "";
		return;
	}
	var c1 = path.lastIndexOf("/");
	var c2 = path.lastIndexOf("\\");
	if(c1 < c2) {
		this.dir = HxOverrides.substr(path,0,c2);
		path = HxOverrides.substr(path,c2 + 1,null);
		this.backslash = true;
	} else if(c2 < c1) {
		this.dir = HxOverrides.substr(path,0,c1);
		path = HxOverrides.substr(path,c1 + 1,null);
	} else this.dir = null;
	var cp = path.lastIndexOf(".");
	if(cp != -1) {
		this.ext = HxOverrides.substr(path,cp + 1,null);
		this.file = HxOverrides.substr(path,0,cp);
	} else {
		this.ext = null;
		this.file = path;
	}
};
$hxClasses["haxe.io.Path"] = haxe_io_Path;
haxe_io_Path.__name__ = ["haxe","io","Path"];
haxe_io_Path.withoutDirectory = function(path) {
	var s = new haxe_io_Path(path);
	s.dir = null;
	return s.toString();
};
haxe_io_Path.directory = function(path) {
	var s = new haxe_io_Path(path);
	if(s.dir == null) return "";
	return s.dir;
};
haxe_io_Path.join = function(paths) {
	var paths1 = paths.filter(function(s) {
		return s != null && s != "";
	});
	if(paths1.length == 0) return "";
	var path = paths1[0];
	var _g1 = 1;
	var _g = paths1.length;
	while(_g1 < _g) {
		var i = _g1++;
		path = haxe_io_Path.addTrailingSlash(path);
		path += paths1[i];
	}
	return haxe_io_Path.normalize(path);
};
haxe_io_Path.normalize = function(path) {
	var slash = "/";
	path = path.split("\\").join("/");
	if(path == null || path == slash) return slash;
	var target = [];
	var _g = 0;
	var _g1 = path.split(slash);
	while(_g < _g1.length) {
		var token = _g1[_g];
		++_g;
		if(token == ".." && target.length > 0 && target[target.length - 1] != "..") target.pop(); else if(token != ".") target.push(token);
	}
	var tmp = target.join(slash);
	var regex = new EReg("([^:])/+","g");
	var result = regex.replace(tmp,"$1" + slash);
	var acc = new StringBuf();
	var colon = false;
	var slashes = false;
	var _g11 = 0;
	var _g2 = tmp.length;
	while(_g11 < _g2) {
		var i = _g11++;
		var _g21 = HxOverrides.cca(tmp,i);
		var i1 = _g21;
		if(_g21 != null) switch(_g21) {
		case 58:
			acc.b += ":";
			colon = true;
			break;
		case 47:
			if(colon == false) slashes = true; else {
				colon = false;
				if(slashes) {
					acc.b += "/";
					slashes = false;
				}
				acc.add(String.fromCharCode(i1));
			}
			break;
		default:
			colon = false;
			if(slashes) {
				acc.b += "/";
				slashes = false;
			}
			acc.add(String.fromCharCode(i1));
		} else {
			colon = false;
			if(slashes) {
				acc.b += "/";
				slashes = false;
			}
			acc.add(String.fromCharCode(i1));
		}
	}
	var result1 = acc.b;
	return result1;
};
haxe_io_Path.addTrailingSlash = function(path) {
	if(path.length == 0) return "/";
	var c1 = path.lastIndexOf("/");
	var c2 = path.lastIndexOf("\\");
	if(c1 < c2) {
		if(c2 != path.length - 1) return path + "\\"; else return path;
	} else if(c1 != path.length - 1) return path + "/"; else return path;
};
haxe_io_Path.prototype = {
	dir: null
	,file: null
	,ext: null
	,backslash: null
	,toString: function() {
		return (this.dir == null?"":this.dir + (this.backslash?"\\":"/")) + this.file + (this.ext == null?"":"." + this.ext);
	}
	,__class__: haxe_io_Path
};
var htmlparser_CssSelector = function(type) {
	this.classes = [];
	this.type = type;
};
$hxClasses["htmlparser.CssSelector"] = htmlparser_CssSelector;
htmlparser_CssSelector.__name__ = ["htmlparser","CssSelector"];
htmlparser_CssSelector.parse = function(selector) {
	var r = [];
	var selectors = new EReg("\\s*,\\s*","g").split(selector);
	var _g = 0;
	while(_g < selectors.length) {
		var s = selectors[_g];
		++_g;
		if(s != "") r.push(htmlparser_CssSelector.parseInner(s));
	}
	return r;
};
htmlparser_CssSelector.parseInner = function(selector) {
	var rr = [];
	selector = " " + selector;
	var r = null;
	var re = new EReg(htmlparser_CssSelector.reSelector,"gi");
	var pos = 0;
	while(re.matchSub(selector,pos)) {
		var type1;
		try {
			type1 = re.matched(1);
		} catch( _ ) {
			haxe_CallStack.lastException = _;
			if (_ instanceof js__$Boot_HaxeError) _ = _.val;
			type1 = null;
		}
		if(type1 == null) type1 = "";
		var type2;
		try {
			type2 = re.matched(2);
		} catch( _1 ) {
			haxe_CallStack.lastException = _1;
			if (_1 instanceof js__$Boot_HaxeError) _1 = _1.val;
			type2 = null;
		}
		if(type2 == null) type2 = "";
		if(type1.length > 0 || type2.length > 0) {
			if(r != null) rr.push(r);
			r = new htmlparser_CssSelector(type2.length > 0?">":" ");
		}
		var name = re.matched(4);
		if(name != "*") {
			var s = re.matched(3);
			if(s == "#") r.id = name; else if(s == ".") r.classes.push(name); else r.tagNameLC = name.toLowerCase();
			var sIndex;
			try {
				sIndex = re.matched(5);
			} catch( _2 ) {
				haxe_CallStack.lastException = _2;
				if (_2 instanceof js__$Boot_HaxeError) _2 = _2.val;
				sIndex = null;
			}
			if(sIndex != null && sIndex != "") {
				r.index = Std.parseInt(sIndex.substring(1,sIndex.length - 1));
				if(isNaN(r.index)) r.index = null;
			}
		}
		var p = re.matchedPos();
		pos = p.pos + p.len;
	}
	if(r != null) rr.push(r);
	return rr;
};
htmlparser_CssSelector.getMatched = function(re,n) {
	try {
		return re.matched(n);
	} catch( _ ) {
		haxe_CallStack.lastException = _;
		if (_ instanceof js__$Boot_HaxeError) _ = _.val;
		return null;
	}
};
htmlparser_CssSelector.prototype = {
	type: null
	,tagNameLC: null
	,id: null
	,classes: null
	,index: null
	,__class__: htmlparser_CssSelector
};
var htmlparser_HtmlAttribute = function(name,value,quote) {
	this.name = name;
	this.value = value;
	this.quote = quote;
};
$hxClasses["htmlparser.HtmlAttribute"] = htmlparser_HtmlAttribute;
htmlparser_HtmlAttribute.__name__ = ["htmlparser","HtmlAttribute"];
htmlparser_HtmlAttribute.prototype = {
	name: null
	,value: null
	,quote: null
	,toString: function() {
		return this.name + "=" + this.quote + htmlparser_HtmlTools.escape(this.value,"\r\n" + (this.quote == "'"?"\"":"'")) + this.quote;
	}
	,__class__: htmlparser_HtmlAttribute
};
var htmlparser_HtmlNode = function() { };
$hxClasses["htmlparser.HtmlNode"] = htmlparser_HtmlNode;
htmlparser_HtmlNode.__name__ = ["htmlparser","HtmlNode"];
htmlparser_HtmlNode.prototype = {
	parent: null
	,remove: function() {
		if(this.parent != null) this.parent.removeChild(this);
	}
	,getPrevSiblingNode: function() {
		if(this.parent == null) return null;
		var siblings = this.parent.nodes;
		var n = Lambda.indexOf(siblings,this);
		if(n <= 0) return null;
		if(n > 0) return siblings[n - 1];
		return null;
	}
	,getNextSiblingNode: function() {
		if(this.parent == null) return null;
		var siblings = this.parent.nodes;
		var n = Lambda.indexOf(siblings,this);
		if(n <= 0) return null;
		if(n + 1 < siblings.length) return siblings[n + 1];
		return null;
	}
	,toString: function() {
		return "";
	}
	,toText: function() {
		return "";
	}
	,hxSerialize: function(s) {
	}
	,hxUnserialize: function(s) {
	}
	,__class__: htmlparser_HtmlNode
};
var htmlparser_HtmlNodeElement = function(name,attributes) {
	var _g = this;
	Object.defineProperty(this,"innerHTML",{ get : function() {
		return _g.get_innerHTML();
	}, set : function(v) {
		_g.set_innerHTML(v);
	}});
	Object.defineProperty(this,"innerText",{ get : function() {
		return _g.get_innerText();
	}, set : function(v1) {
		_g.set_innerText(v1);
	}});
	this.name = name;
	this.attributes = attributes;
	this.nodes = [];
	this.children = [];
};
$hxClasses["htmlparser.HtmlNodeElement"] = htmlparser_HtmlNodeElement;
htmlparser_HtmlNodeElement.__name__ = ["htmlparser","HtmlNodeElement"];
htmlparser_HtmlNodeElement.__super__ = htmlparser_HtmlNode;
htmlparser_HtmlNodeElement.prototype = $extend(htmlparser_HtmlNode.prototype,{
	name: null
	,attributes: null
	,nodes: null
	,children: null
	,getPrevSiblingElement: function() {
		if(this.parent == null) return null;
		var n = HxOverrides.indexOf(this.parent.children,this,0);
		if(n < 0) return null;
		if(n > 0) return this.parent.children[n - 1];
		return null;
	}
	,getNextSiblingElement: function() {
		if(this.parent == null) return null;
		var n = HxOverrides.indexOf(this.parent.children,this,0);
		if(n < 0) return null;
		if(n + 1 < this.parent.children.length) return this.parent.children[n + 1];
		return null;
	}
	,addChild: function(node,beforeNode) {
		node.parent = this;
		if(beforeNode == null) {
			this.nodes.push(node);
			if(js_Boot.__instanceof(node,htmlparser_HtmlNodeElement)) this.children.push(node);
		} else {
			var n = HxOverrides.indexOf(this.nodes,beforeNode,0);
			if(n >= 0) {
				this.nodes.splice(n,0,node);
				if(js_Boot.__instanceof(node,htmlparser_HtmlNodeElement)) {
					n = HxOverrides.indexOf(this.children,beforeNode,0);
					if(n >= 0) this.children.splice(n,0,node);
				}
			}
		}
	}
	,toString: function() {
		var sAttrs = new StringBuf();
		var _g = 0;
		var _g1 = this.attributes;
		while(_g < _g1.length) {
			var a = _g1[_g];
			++_g;
			sAttrs.b += " ";
			sAttrs.add(a.toString());
		}
		var innerBuf = new StringBuf();
		var _g2 = 0;
		var _g11 = this.nodes;
		while(_g2 < _g11.length) {
			var node = _g11[_g2];
			++_g2;
			innerBuf.add(node.toString());
		}
		var inner = innerBuf.b;
		if(inner == "" && this.isSelfClosing()) return "<" + this.name + sAttrs.b + " />";
		if(this.name != null && this.name != "") return "<" + this.name + sAttrs.b + ">" + inner + "</" + this.name + ">"; else return inner;
	}
	,getAttribute: function(name) {
		var nameLC = name.toLowerCase();
		var _g = 0;
		var _g1 = this.attributes;
		while(_g < _g1.length) {
			var a = _g1[_g];
			++_g;
			if(a.name.toLowerCase() == nameLC) return a.value;
		}
		return null;
	}
	,setAttribute: function(name,value) {
		var nameLC = name.toLowerCase();
		var _g = 0;
		var _g1 = this.attributes;
		while(_g < _g1.length) {
			var a = _g1[_g];
			++_g;
			if(a.name.toLowerCase() == nameLC) {
				a.value = value;
				return;
			}
		}
		this.attributes.push(new htmlparser_HtmlAttribute(name,value,"\""));
	}
	,removeAttribute: function(name) {
		var nameLC = name.toLowerCase();
		var _g1 = 0;
		var _g = this.attributes.length;
		while(_g1 < _g) {
			var i = _g1++;
			var a = this.attributes[i];
			if(a.name.toLowerCase() == nameLC) {
				this.attributes.splice(i,1);
				return;
			}
		}
	}
	,hasAttribute: function(name) {
		var nameLC = name.toLowerCase();
		var _g = 0;
		var _g1 = this.attributes;
		while(_g < _g1.length) {
			var a = _g1[_g];
			++_g;
			if(a.name.toLowerCase() == nameLC) return true;
		}
		return false;
	}
	,innerHTML: null
	,get_innerHTML: function() {
		var r = new StringBuf();
		var _g = 0;
		var _g1 = this.nodes;
		while(_g < _g1.length) {
			var node = _g1[_g];
			++_g;
			r.add(node.toString());
		}
		return r.b;
	}
	,set_innerHTML: function(value) {
		var newNodes = htmlparser_HtmlParser.run(value);
		this.nodes = [];
		this.children = [];
		var _g = 0;
		while(_g < newNodes.length) {
			var node = newNodes[_g];
			++_g;
			this.addChild(node);
		}
		return value;
	}
	,innerText: null
	,get_innerText: function() {
		return this.toText();
	}
	,set_innerText: function(text) {
		this.fastSetInnerHTML(htmlparser_HtmlTools.escape(text));
		return text;
	}
	,fastSetInnerHTML: function(html) {
		this.nodes = [];
		this.children = [];
		this.addChild(new htmlparser_HtmlNodeText(html));
	}
	,toText: function() {
		var r = new StringBuf();
		var _g = 0;
		var _g1 = this.nodes;
		while(_g < _g1.length) {
			var node = _g1[_g];
			++_g;
			r.add(node.toText());
		}
		return r.b;
	}
	,find: function(selector) {
		var parsedSelectors = htmlparser_CssSelector.parse(selector);
		var resNodes = [];
		var _g = 0;
		while(_g < parsedSelectors.length) {
			var s = parsedSelectors[_g];
			++_g;
			var _g1 = 0;
			var _g2 = this.children;
			while(_g1 < _g2.length) {
				var node = _g2[_g1];
				++_g1;
				var nodesToAdd = node.findInner(s);
				var _g3 = 0;
				while(_g3 < nodesToAdd.length) {
					var nodeToAdd = nodesToAdd[_g3];
					++_g3;
					if(HxOverrides.indexOf(resNodes,nodeToAdd,0) < 0) resNodes.push(nodeToAdd);
				}
			}
		}
		return resNodes;
	}
	,findInner: function(selectors) {
		if(selectors.length == 0) return [];
		var nodes = [];
		if(selectors[0].type == " ") {
			var _g = 0;
			var _g1 = this.children;
			while(_g < _g1.length) {
				var child = _g1[_g];
				++_g;
				nodes = nodes.concat(child.findInner(selectors));
			}
		}
		if(this.isSelectorTrue(selectors[0])) {
			if(selectors.length > 1) {
				var subSelectors = selectors.slice(1);
				var _g2 = 0;
				var _g11 = this.children;
				while(_g2 < _g11.length) {
					var child1 = _g11[_g2];
					++_g2;
					nodes = nodes.concat(child1.findInner(subSelectors));
				}
			} else if(selectors.length == 1) {
				if(this.parent != null) nodes.push(this);
			}
		}
		return nodes;
	}
	,isSelectorTrue: function(selector) {
		if(selector.tagNameLC != null && this.name.toLowerCase() != selector.tagNameLC) return false;
		if(selector.id != null && this.getAttribute("id") != selector.id) return false;
		var _g = 0;
		var _g1 = selector.classes;
		while(_g < _g1.length) {
			var clas = _g1[_g];
			++_g;
			var reg = new EReg("(?:^|\\s)" + clas + "(?:$|\\s)","");
			var classAttr = this.getAttribute("class");
			if(classAttr == null || !reg.match(classAttr)) return false;
		}
		if(selector.index != null && (this.parent == null || HxOverrides.indexOf(this.parent.children,this,0) + 1 != selector.index)) return false;
		return true;
	}
	,replaceChild: function(node,newNode) {
		newNode.parent = this;
		var n = HxOverrides.indexOf(this.nodes,node,0);
		this.nodes[n] = newNode;
		var n1 = HxOverrides.indexOf(this.children,node,0);
		if(js_Boot.__instanceof(newNode,htmlparser_HtmlNodeElement)) this.children[n1] = newNode; else this.children.splice(n1,1);
	}
	,replaceChildWithInner: function(node,nodeContainer) {
		var _g = 0;
		var _g1 = nodeContainer.nodes;
		while(_g < _g1.length) {
			var n2 = _g1[_g];
			++_g;
			n2.parent = this;
		}
		var n = HxOverrides.indexOf(this.nodes,node,0);
		var lastNodes = this.nodes.slice(n + 1,this.nodes.length);
		this.nodes = (n != 0?this.nodes.slice(0,n):[]).concat(nodeContainer.nodes).concat(lastNodes);
		var n1 = HxOverrides.indexOf(this.children,node,0);
		var lastChildren = this.children.slice(n1 + 1,this.children.length);
		this.children = (n1 != 0?this.children.slice(0,n1):[]).concat(nodeContainer.children).concat(lastChildren);
	}
	,removeChild: function(node) {
		var n = HxOverrides.indexOf(this.nodes,node,0);
		if(n >= 0) {
			this.nodes.splice(n,1);
			if(js_Boot.__instanceof(node,htmlparser_HtmlNodeElement)) {
				n = HxOverrides.indexOf(this.children,node,0);
				if(n >= 0) this.children.splice(n,1);
			}
		}
	}
	,getAttributesAssoc: function() {
		var attrs = new haxe_ds_StringMap();
		var _g = 0;
		var _g1 = this.attributes;
		while(_g < _g1.length) {
			var attr = _g1[_g];
			++_g;
			attrs.set(attr.name,attr.value);
		}
		return attrs;
	}
	,getAttributesObject: function() {
		var attrs = { };
		var _g = 0;
		var _g1 = this.attributes;
		while(_g < _g1.length) {
			var attr = _g1[_g];
			++_g;
			attrs[attr.name] = attr.value;
		}
		return attrs;
	}
	,isSelfClosing: function() {
		return Object.prototype.hasOwnProperty.call(htmlparser_HtmlParser.SELF_CLOSING_TAGS_HTML,this.name) || this.name.indexOf(":") >= 0;
	}
	,hxSerialize: function(s) {
		s.serialize(this.name);
		s.serialize(this.attributes);
		s.serialize(this.nodes);
	}
	,hxUnserialize: function(s) {
		var _g = this;
		Object.defineProperty(this,"innerHTML",{ get : function() {
			return _g.get_innerHTML();
		}, set : function(v) {
			_g.set_innerHTML(v);
		}});
		Object.defineProperty(this,"innerText",{ get : function() {
			return _g.get_innerText();
		}, set : function(v1) {
			_g.set_innerText(v1);
		}});
		this.name = s.unserialize();
		this.attributes = s.unserialize();
		this.nodes = [];
		this.children = [];
		var ns = s.unserialize();
		var _g1 = 0;
		while(_g1 < ns.length) {
			var n = ns[_g1];
			++_g1;
			this.addChild(n);
		}
	}
	,__class__: htmlparser_HtmlNodeElement
});
var htmlparser_HtmlNodeText = function(text) {
	this.text = text;
};
$hxClasses["htmlparser.HtmlNodeText"] = htmlparser_HtmlNodeText;
htmlparser_HtmlNodeText.__name__ = ["htmlparser","HtmlNodeText"];
htmlparser_HtmlNodeText.__super__ = htmlparser_HtmlNode;
htmlparser_HtmlNodeText.prototype = $extend(htmlparser_HtmlNode.prototype,{
	text: null
	,toString: function() {
		return this.text;
	}
	,toText: function() {
		return htmlparser_HtmlTools.unescape(this.text);
	}
	,hxSerialize: function(s) {
		s.serialize(this.text);
	}
	,hxUnserialize: function(s) {
		this.text = s.unserialize();
	}
	,__class__: htmlparser_HtmlNodeText
});
var htmlparser_HtmlParser = function() {
};
$hxClasses["htmlparser.HtmlParser"] = htmlparser_HtmlParser;
htmlparser_HtmlParser.__name__ = ["htmlparser","HtmlParser"];
htmlparser_HtmlParser.run = function(str,tolerant) {
	if(tolerant == null) tolerant = false;
	return new htmlparser_HtmlParser().parse(str,tolerant);
};
htmlparser_HtmlParser.parseAttrs = function(str) {
	var attributes = [];
	var pos = 0;
	while(pos < str.length && htmlparser_HtmlParser.reParseAttrs.matchSub(str,pos)) {
		var name = htmlparser_HtmlParser.reParseAttrs.matched(1);
		var value = htmlparser_HtmlParser.reParseAttrs.matched(2);
		var quote = HxOverrides.substr(value,0,1);
		if(quote == "\"" || quote == "'") value = HxOverrides.substr(value,1,value.length - 2); else quote = "";
		attributes.push(new htmlparser_HtmlAttribute(name,htmlparser_HtmlTools.unescape(value),quote));
		var p = htmlparser_HtmlParser.reParseAttrs.matchedPos();
		pos = p.pos + p.len;
	}
	return attributes;
};
htmlparser_HtmlParser.getMatched = function(re,n) {
	try {
		return re.matched(n);
	} catch( _ ) {
		haxe_CallStack.lastException = _;
		if (_ instanceof js__$Boot_HaxeError) _ = _.val;
		return null;
	}
};
htmlparser_HtmlParser.prototype = {
	tolerant: null
	,matches: null
	,str: null
	,i: null
	,parse: function(str,tolerant) {
		if(tolerant == null) tolerant = false;
		this.tolerant = tolerant;
		this.matches = [];
		var pos = 0;
		while(pos < str.length && htmlparser_HtmlParser.reMain.matchSub(str,pos)) {
			var p = htmlparser_HtmlParser.reMain.matchedPos();
			var cdata;
			try {
				cdata = htmlparser_HtmlParser.reMain.matched(1);
			} catch( _ ) {
				haxe_CallStack.lastException = _;
				if (_ instanceof js__$Boot_HaxeError) _ = _.val;
				cdata = null;
			}
			if(cdata == null || cdata == "") {
				var r = { all : htmlparser_HtmlParser.reMain.matched(0), allPos : p.pos, script : (function($this) {
					var $r;
					try {
						$r = htmlparser_HtmlParser.reMain.matched(2);
					} catch( _1 ) {
						haxe_CallStack.lastException = _1;
						if (_1 instanceof js__$Boot_HaxeError) _1 = _1.val;
						$r = null;
					}
					return $r;
				}(this)), scriptAttrs : (function($this) {
					var $r;
					try {
						$r = htmlparser_HtmlParser.reMain.matched(3);
					} catch( _2 ) {
						haxe_CallStack.lastException = _2;
						if (_2 instanceof js__$Boot_HaxeError) _2 = _2.val;
						$r = null;
					}
					return $r;
				}(this)), scriptText : (function($this) {
					var $r;
					try {
						$r = htmlparser_HtmlParser.reMain.matched(4);
					} catch( _3 ) {
						haxe_CallStack.lastException = _3;
						if (_3 instanceof js__$Boot_HaxeError) _3 = _3.val;
						$r = null;
					}
					return $r;
				}(this)), style : (function($this) {
					var $r;
					try {
						$r = htmlparser_HtmlParser.reMain.matched(5);
					} catch( _4 ) {
						haxe_CallStack.lastException = _4;
						if (_4 instanceof js__$Boot_HaxeError) _4 = _4.val;
						$r = null;
					}
					return $r;
				}(this)), styleAttrs : (function($this) {
					var $r;
					try {
						$r = htmlparser_HtmlParser.reMain.matched(6);
					} catch( _5 ) {
						haxe_CallStack.lastException = _5;
						if (_5 instanceof js__$Boot_HaxeError) _5 = _5.val;
						$r = null;
					}
					return $r;
				}(this)), styleText : (function($this) {
					var $r;
					try {
						$r = htmlparser_HtmlParser.reMain.matched(7);
					} catch( _6 ) {
						haxe_CallStack.lastException = _6;
						if (_6 instanceof js__$Boot_HaxeError) _6 = _6.val;
						$r = null;
					}
					return $r;
				}(this)), elem : (function($this) {
					var $r;
					try {
						$r = htmlparser_HtmlParser.reMain.matched(8);
					} catch( _7 ) {
						haxe_CallStack.lastException = _7;
						if (_7 instanceof js__$Boot_HaxeError) _7 = _7.val;
						$r = null;
					}
					return $r;
				}(this)), tagOpen : (function($this) {
					var $r;
					try {
						$r = htmlparser_HtmlParser.reMain.matched(9);
					} catch( _8 ) {
						haxe_CallStack.lastException = _8;
						if (_8 instanceof js__$Boot_HaxeError) _8 = _8.val;
						$r = null;
					}
					return $r;
				}(this)), attrs : (function($this) {
					var $r;
					try {
						$r = htmlparser_HtmlParser.reMain.matched(10);
					} catch( _9 ) {
						haxe_CallStack.lastException = _9;
						if (_9 instanceof js__$Boot_HaxeError) _9 = _9.val;
						$r = null;
					}
					return $r;
				}(this)), tagEnd : (function($this) {
					var $r;
					try {
						$r = htmlparser_HtmlParser.reMain.matched(11);
					} catch( _10 ) {
						haxe_CallStack.lastException = _10;
						if (_10 instanceof js__$Boot_HaxeError) _10 = _10.val;
						$r = null;
					}
					return $r;
				}(this)), close : (function($this) {
					var $r;
					try {
						$r = htmlparser_HtmlParser.reMain.matched(12);
					} catch( _11 ) {
						haxe_CallStack.lastException = _11;
						if (_11 instanceof js__$Boot_HaxeError) _11 = _11.val;
						$r = null;
					}
					return $r;
				}(this)), tagClose : (function($this) {
					var $r;
					try {
						$r = htmlparser_HtmlParser.reMain.matched(13);
					} catch( _12 ) {
						haxe_CallStack.lastException = _12;
						if (_12 instanceof js__$Boot_HaxeError) _12 = _12.val;
						$r = null;
					}
					return $r;
				}(this)), comment : (function($this) {
					var $r;
					try {
						$r = htmlparser_HtmlParser.reMain.matched(14);
					} catch( _13 ) {
						haxe_CallStack.lastException = _13;
						if (_13 instanceof js__$Boot_HaxeError) _13 = _13.val;
						$r = null;
					}
					return $r;
				}(this)), tagOpenLC : null, tagCloseLC : null};
				if(r.tagOpen != null) r.tagOpenLC = r.tagOpen.toLowerCase();
				if(r.tagClose != null) r.tagCloseLC = r.tagClose.toLowerCase();
				this.matches.push(r);
			}
			pos = p.pos + p.len;
		}
		if(this.matches.length > 0) {
			this.str = str;
			this.i = 0;
			var nodes = this.processMatches([]).nodes;
			if(this.i < this.matches.length) throw new js__$Boot_HaxeError(new htmlparser_HtmlParserException("Not all nodes processed.",this.getPosition(this.i)));
			return nodes;
		}
		if(str.length > 0) return [new htmlparser_HtmlNodeText(str)]; else return [];
	}
	,processMatches: function(openedTagsLC) {
		var nodes = [];
		var prevEnd;
		if(this.i > 0) prevEnd = this.matches[this.i - 1].allPos + this.matches[this.i - 1].all.length; else prevEnd = 0;
		var curStart = this.matches[this.i].allPos;
		if(prevEnd < curStart) nodes.push(new htmlparser_HtmlNodeText(HxOverrides.substr(this.str,prevEnd,curStart - prevEnd)));
		while(this.i < this.matches.length) {
			var m = this.matches[this.i];
			if(m.elem != null && m.elem != "") {
				var ee = this.parseElement(openedTagsLC);
				nodes.push(ee.element);
				if(ee.closeTagLC != "") return { nodes : nodes, closeTagLC : ee.closeTagLC};
			} else if(m.script != null && m.script != "") {
				var scriptNode = this.newElement("script",htmlparser_HtmlParser.parseAttrs(m.scriptAttrs));
				scriptNode.addChild(new htmlparser_HtmlNodeText(m.scriptText));
				nodes.push(scriptNode);
			} else if(m.style != null && m.style != "") {
				var styleNode = this.newElement("style",htmlparser_HtmlParser.parseAttrs(m.styleAttrs));
				styleNode.addChild(new htmlparser_HtmlNodeText(m.styleText));
				nodes.push(styleNode);
			} else if(m.close != null && m.close != "") {
				if(m.tagCloseLC == openedTagsLC[openedTagsLC.length - 1]) break;
				if(this.tolerant) {
					if(HxOverrides.lastIndexOf(openedTagsLC,m.tagCloseLC,openedTagsLC.length - 1) >= 0) break;
				} else throw new js__$Boot_HaxeError(new htmlparser_HtmlParserException("Closed tag <" + m.tagClose + "> don't match to open tag <" + openedTagsLC[openedTagsLC.length - 1] + ">.",this.getPosition(this.i)));
			} else if(m.comment != null && m.comment != "") nodes.push(new htmlparser_HtmlNodeText(m.comment)); else throw new js__$Boot_HaxeError(new htmlparser_HtmlParserException("Unexpected XML node.",this.getPosition(this.i)));
			if(this.tolerant && this.i >= this.matches.length) break;
			var curEnd = this.matches[this.i].allPos + this.matches[this.i].all.length;
			var nextStart;
			if(this.i + 1 < this.matches.length) nextStart = this.matches[this.i + 1].allPos; else nextStart = this.str.length;
			if(curEnd < nextStart) nodes.push(new htmlparser_HtmlNodeText(HxOverrides.substr(this.str,curEnd,nextStart - curEnd)));
			this.i++;
		}
		return { nodes : nodes, closeTagLC : ""};
	}
	,parseElement: function(openedTagsLC) {
		var tag = this.matches[this.i].tagOpen;
		var tagLC = this.matches[this.i].tagOpenLC;
		var attrs = this.matches[this.i].attrs;
		var isWithClose = this.matches[this.i].tagEnd != null && this.matches[this.i].tagEnd != "" || this.isSelfClosingTag(tagLC);
		var elem = this.newElement(tag,htmlparser_HtmlParser.parseAttrs(attrs));
		var closeTagLC = "";
		if(!isWithClose) {
			this.i++;
			openedTagsLC.push(tagLC);
			var m = this.processMatches(openedTagsLC);
			var _g = 0;
			var _g1 = m.nodes;
			while(_g < _g1.length) {
				var node = _g1[_g];
				++_g;
				elem.addChild(node);
			}
			openedTagsLC.pop();
			if(m.closeTagLC != tagLC) closeTagLC = m.closeTagLC; else closeTagLC = "";
			if(this.i < this.matches.length || !this.tolerant) {
				if(this.matches[this.i].close == null || this.matches[this.i].close == "" || this.matches[this.i].tagCloseLC != tagLC) {
					if(!this.tolerant) throw new js__$Boot_HaxeError(new htmlparser_HtmlParserException("Tag <" + tag + "> not closed.",this.getPosition(this.i))); else closeTagLC = this.matches[this.i].tagCloseLC;
				}
			}
		}
		return { element : elem, closeTagLC : closeTagLC};
	}
	,isSelfClosingTag: function(tag) {
		return Object.prototype.hasOwnProperty.call(htmlparser_HtmlParser.SELF_CLOSING_TAGS_HTML,tag);
	}
	,newElement: function(name,attributes) {
		return new htmlparser_HtmlNodeElement(name,attributes);
	}
	,getPosition: function(matchIndex) {
		var m = this.matches[matchIndex];
		var line = 1;
		var lastNewLinePos = -1;
		var i = 0;
		while(i < m.allPos) {
			var chars;
			if(i + 1 < this.str.length) chars = this.str.substring(i,i + 2); else chars = this.str.charAt(i);
			if(chars == "\r\n") {
				i += 2;
				lastNewLinePos = i;
				line++;
			} else if(chars.charAt(0) == "\n" || chars.charAt(0) == "\r") {
				i++;
				lastNewLinePos = i;
				line++;
			} else i++;
		}
		return { line : line, column : m.allPos - lastNewLinePos, length : m.all.length};
	}
	,__class__: htmlparser_HtmlParser
};
var htmlparser_HtmlParserException = function(message,pos) {
	this.message = message;
	this.line = pos.line;
	this.column = pos.column;
	this.length = pos.length;
};
$hxClasses["htmlparser.HtmlParserException"] = htmlparser_HtmlParserException;
htmlparser_HtmlParserException.__name__ = ["htmlparser","HtmlParserException"];
htmlparser_HtmlParserException.prototype = {
	message: null
	,line: null
	,column: null
	,length: null
	,toString: function() {
		return "Parse error at " + this.line + ":" + this.column + ". " + this.message;
	}
	,__class__: htmlparser_HtmlParserException
};
var htmlparser_HtmlParserTools = function() { };
$hxClasses["htmlparser.HtmlParserTools"] = htmlparser_HtmlParserTools;
htmlparser_HtmlParserTools.__name__ = ["htmlparser","HtmlParserTools"];
htmlparser_HtmlParserTools.getAttr = function(node,attrName,defaultValue) {
	if(node == null || !node.hasAttribute(attrName)) if((defaultValue instanceof Array) && defaultValue.__enum__ == null) return null; else return defaultValue;
	return htmlparser_HtmlParserTools.parseValue(node.getAttribute(attrName),defaultValue);
};
htmlparser_HtmlParserTools.getAttrString = function(node,attrName,defaultValue) {
	var r = node.getAttribute(attrName);
	if(r == null) return defaultValue; else return r;
};
htmlparser_HtmlParserTools.getAttrInt = function(node,attrName,defaultValue) {
	var r = Std.parseInt(node.getAttribute(attrName));
	if(r == null || isNaN(r)) return defaultValue; else return r;
};
htmlparser_HtmlParserTools.getAttrFloat = function(node,attrName,defaultValue) {
	var r = Std.parseFloat(node.getAttribute(attrName));
	if(r == null || isNaN(r)) return defaultValue; else return r;
};
htmlparser_HtmlParserTools.getAttrBool = function(node,attrName,defaultValue) {
	var r = node.getAttribute(attrName);
	if(r == null || r == "") return defaultValue; else return r != "0" && r.toLowerCase() != "false" && r.toLowerCase() != "no";
};
htmlparser_HtmlParserTools.findOne = function(node,selector) {
	var nodes = node.find(selector);
	if(nodes.length > 0) return nodes[0]; else return null;
};
htmlparser_HtmlParserTools.parseValue = function(value,defaultValue) {
	if(typeof(defaultValue) == "number") return parseFloat(value);
	if(typeof(defaultValue) == "boolean") return stdlib_Std.bool(value);
	if((defaultValue instanceof Array) && defaultValue.__enum__ == null) {
		var elems = [];
		var parCounter = 0;
		var lastCommaIndex = -1;
		var _g1 = 0;
		var _g = value.length;
		while(_g1 < _g) {
			var i = _g1++;
			var c = value.charAt(i);
			if(c == "(" || c == "[" || c == "{") parCounter++; else if(c == ")" || c == "]" || c == "}") parCounter--; else if(c == "," && parCounter == 0) {
				elems.push(value.substring(lastCommaIndex + 1,i));
				lastCommaIndex = i;
			}
		}
		elems.push(value.substring(lastCommaIndex + 1,value.length));
		if(defaultValue.length > 0) return elems.map(function(item) {
			return htmlparser_HtmlParserTools.parseValue(item,defaultValue[0]);
		}); else return elems;
	}
	return value;
};
var htmlparser_HtmlTools = function() { };
$hxClasses["htmlparser.HtmlTools"] = htmlparser_HtmlTools;
htmlparser_HtmlTools.__name__ = ["htmlparser","HtmlTools"];
htmlparser_HtmlTools.get_htmlUnescapeMap = function() {
	if(htmlparser_HtmlTools.htmlUnescapeMap == null) {
		var _g = new haxe_ds_StringMap();
		if(__map_reserved.nbsp != null) _g.setReserved("nbsp"," "); else _g.h["nbsp"] = " ";
		if(__map_reserved.amp != null) _g.setReserved("amp","&"); else _g.h["amp"] = "&";
		if(__map_reserved.lt != null) _g.setReserved("lt","<"); else _g.h["lt"] = "<";
		if(__map_reserved.gt != null) _g.setReserved("gt",">"); else _g.h["gt"] = ">";
		if(__map_reserved.quot != null) _g.setReserved("quot","\""); else _g.h["quot"] = "\"";
		if(__map_reserved.apos != null) _g.setReserved("apos","'"); else _g.h["apos"] = "'";
		if(__map_reserved.euro != null) _g.setReserved("euro","€"); else _g.h["euro"] = "€";
		if(__map_reserved.iexcl != null) _g.setReserved("iexcl","¡"); else _g.h["iexcl"] = "¡";
		if(__map_reserved.cent != null) _g.setReserved("cent","¢"); else _g.h["cent"] = "¢";
		if(__map_reserved.pound != null) _g.setReserved("pound","£"); else _g.h["pound"] = "£";
		if(__map_reserved.curren != null) _g.setReserved("curren","¤"); else _g.h["curren"] = "¤";
		if(__map_reserved.yen != null) _g.setReserved("yen","¥"); else _g.h["yen"] = "¥";
		if(__map_reserved.brvbar != null) _g.setReserved("brvbar","¦"); else _g.h["brvbar"] = "¦";
		if(__map_reserved.sect != null) _g.setReserved("sect","§"); else _g.h["sect"] = "§";
		if(__map_reserved.uml != null) _g.setReserved("uml","¨"); else _g.h["uml"] = "¨";
		if(__map_reserved.copy != null) _g.setReserved("copy","©"); else _g.h["copy"] = "©";
		if(__map_reserved.ordf != null) _g.setReserved("ordf","ª"); else _g.h["ordf"] = "ª";
		if(__map_reserved.not != null) _g.setReserved("not","¬"); else _g.h["not"] = "¬";
		if(__map_reserved.shy != null) _g.setReserved("shy","­"); else _g.h["shy"] = "­";
		if(__map_reserved.reg != null) _g.setReserved("reg","®"); else _g.h["reg"] = "®";
		if(__map_reserved.macr != null) _g.setReserved("macr","¯"); else _g.h["macr"] = "¯";
		if(__map_reserved.deg != null) _g.setReserved("deg","°"); else _g.h["deg"] = "°";
		if(__map_reserved.plusmn != null) _g.setReserved("plusmn","±"); else _g.h["plusmn"] = "±";
		if(__map_reserved.sup2 != null) _g.setReserved("sup2","²"); else _g.h["sup2"] = "²";
		if(__map_reserved.sup3 != null) _g.setReserved("sup3","³"); else _g.h["sup3"] = "³";
		if(__map_reserved.acute != null) _g.setReserved("acute","´"); else _g.h["acute"] = "´";
		if(__map_reserved.micro != null) _g.setReserved("micro","µ"); else _g.h["micro"] = "µ";
		if(__map_reserved.para != null) _g.setReserved("para","¶"); else _g.h["para"] = "¶";
		if(__map_reserved.middot != null) _g.setReserved("middot","·"); else _g.h["middot"] = "·";
		if(__map_reserved.cedil != null) _g.setReserved("cedil","¸"); else _g.h["cedil"] = "¸";
		if(__map_reserved.sup1 != null) _g.setReserved("sup1","¹"); else _g.h["sup1"] = "¹";
		if(__map_reserved.ordm != null) _g.setReserved("ordm","º"); else _g.h["ordm"] = "º";
		if(__map_reserved.raquo != null) _g.setReserved("raquo","»"); else _g.h["raquo"] = "»";
		if(__map_reserved.frac14 != null) _g.setReserved("frac14","¼"); else _g.h["frac14"] = "¼";
		if(__map_reserved.frac12 != null) _g.setReserved("frac12","½"); else _g.h["frac12"] = "½";
		if(__map_reserved.frac34 != null) _g.setReserved("frac34","¾"); else _g.h["frac34"] = "¾";
		if(__map_reserved.iquest != null) _g.setReserved("iquest","¿"); else _g.h["iquest"] = "¿";
		if(__map_reserved.Agrave != null) _g.setReserved("Agrave","À"); else _g.h["Agrave"] = "À";
		if(__map_reserved.Aacute != null) _g.setReserved("Aacute","Á"); else _g.h["Aacute"] = "Á";
		if(__map_reserved.Acirc != null) _g.setReserved("Acirc","Â"); else _g.h["Acirc"] = "Â";
		if(__map_reserved.Atilde != null) _g.setReserved("Atilde","Ã"); else _g.h["Atilde"] = "Ã";
		if(__map_reserved.Auml != null) _g.setReserved("Auml","Ä"); else _g.h["Auml"] = "Ä";
		if(__map_reserved.Aring != null) _g.setReserved("Aring","Å"); else _g.h["Aring"] = "Å";
		if(__map_reserved.AElig != null) _g.setReserved("AElig","Æ"); else _g.h["AElig"] = "Æ";
		if(__map_reserved.Ccedil != null) _g.setReserved("Ccedil","Ç"); else _g.h["Ccedil"] = "Ç";
		if(__map_reserved.Egrave != null) _g.setReserved("Egrave","È"); else _g.h["Egrave"] = "È";
		if(__map_reserved.Eacute != null) _g.setReserved("Eacute","É"); else _g.h["Eacute"] = "É";
		if(__map_reserved.Ecirc != null) _g.setReserved("Ecirc","Ê"); else _g.h["Ecirc"] = "Ê";
		if(__map_reserved.Euml != null) _g.setReserved("Euml","Ë"); else _g.h["Euml"] = "Ë";
		if(__map_reserved.Igrave != null) _g.setReserved("Igrave","Ì"); else _g.h["Igrave"] = "Ì";
		if(__map_reserved.Iacute != null) _g.setReserved("Iacute","Í"); else _g.h["Iacute"] = "Í";
		if(__map_reserved.Icirc != null) _g.setReserved("Icirc","Î"); else _g.h["Icirc"] = "Î";
		if(__map_reserved.Iuml != null) _g.setReserved("Iuml","Ï"); else _g.h["Iuml"] = "Ï";
		if(__map_reserved.ETH != null) _g.setReserved("ETH","Ð"); else _g.h["ETH"] = "Ð";
		if(__map_reserved.Ntilde != null) _g.setReserved("Ntilde","Ñ"); else _g.h["Ntilde"] = "Ñ";
		if(__map_reserved.Ograve != null) _g.setReserved("Ograve","Ò"); else _g.h["Ograve"] = "Ò";
		if(__map_reserved.Oacute != null) _g.setReserved("Oacute","Ó"); else _g.h["Oacute"] = "Ó";
		if(__map_reserved.Ocirc != null) _g.setReserved("Ocirc","Ô"); else _g.h["Ocirc"] = "Ô";
		if(__map_reserved.Otilde != null) _g.setReserved("Otilde","Õ"); else _g.h["Otilde"] = "Õ";
		if(__map_reserved.Ouml != null) _g.setReserved("Ouml","Ö"); else _g.h["Ouml"] = "Ö";
		if(__map_reserved.times != null) _g.setReserved("times","×"); else _g.h["times"] = "×";
		if(__map_reserved.Oslash != null) _g.setReserved("Oslash","Ø"); else _g.h["Oslash"] = "Ø";
		if(__map_reserved.Ugrave != null) _g.setReserved("Ugrave","Ù"); else _g.h["Ugrave"] = "Ù";
		if(__map_reserved.Uacute != null) _g.setReserved("Uacute","Ú"); else _g.h["Uacute"] = "Ú";
		if(__map_reserved.Ucirc != null) _g.setReserved("Ucirc","Û"); else _g.h["Ucirc"] = "Û";
		if(__map_reserved.Uuml != null) _g.setReserved("Uuml","Ü"); else _g.h["Uuml"] = "Ü";
		if(__map_reserved.Yacute != null) _g.setReserved("Yacute","Ý"); else _g.h["Yacute"] = "Ý";
		if(__map_reserved.THORN != null) _g.setReserved("THORN","Þ"); else _g.h["THORN"] = "Þ";
		if(__map_reserved.szlig != null) _g.setReserved("szlig","ß"); else _g.h["szlig"] = "ß";
		if(__map_reserved.agrave != null) _g.setReserved("agrave","à"); else _g.h["agrave"] = "à";
		if(__map_reserved.aacute != null) _g.setReserved("aacute","á"); else _g.h["aacute"] = "á";
		if(__map_reserved.acirc != null) _g.setReserved("acirc","â"); else _g.h["acirc"] = "â";
		if(__map_reserved.atilde != null) _g.setReserved("atilde","ã"); else _g.h["atilde"] = "ã";
		if(__map_reserved.auml != null) _g.setReserved("auml","ä"); else _g.h["auml"] = "ä";
		if(__map_reserved.aring != null) _g.setReserved("aring","å"); else _g.h["aring"] = "å";
		if(__map_reserved.aelig != null) _g.setReserved("aelig","æ"); else _g.h["aelig"] = "æ";
		if(__map_reserved.ccedil != null) _g.setReserved("ccedil","ç"); else _g.h["ccedil"] = "ç";
		if(__map_reserved.egrave != null) _g.setReserved("egrave","è"); else _g.h["egrave"] = "è";
		if(__map_reserved.eacute != null) _g.setReserved("eacute","é"); else _g.h["eacute"] = "é";
		if(__map_reserved.ecirc != null) _g.setReserved("ecirc","ê"); else _g.h["ecirc"] = "ê";
		if(__map_reserved.euml != null) _g.setReserved("euml","ë"); else _g.h["euml"] = "ë";
		if(__map_reserved.igrave != null) _g.setReserved("igrave","ì"); else _g.h["igrave"] = "ì";
		if(__map_reserved.iacute != null) _g.setReserved("iacute","í"); else _g.h["iacute"] = "í";
		if(__map_reserved.icirc != null) _g.setReserved("icirc","î"); else _g.h["icirc"] = "î";
		if(__map_reserved.iuml != null) _g.setReserved("iuml","ï"); else _g.h["iuml"] = "ï";
		if(__map_reserved.eth != null) _g.setReserved("eth","ð"); else _g.h["eth"] = "ð";
		if(__map_reserved.ntilde != null) _g.setReserved("ntilde","ñ"); else _g.h["ntilde"] = "ñ";
		if(__map_reserved.ograve != null) _g.setReserved("ograve","ò"); else _g.h["ograve"] = "ò";
		if(__map_reserved.oacute != null) _g.setReserved("oacute","ó"); else _g.h["oacute"] = "ó";
		if(__map_reserved.ocirc != null) _g.setReserved("ocirc","ô"); else _g.h["ocirc"] = "ô";
		if(__map_reserved.otilde != null) _g.setReserved("otilde","õ"); else _g.h["otilde"] = "õ";
		if(__map_reserved.ouml != null) _g.setReserved("ouml","ö"); else _g.h["ouml"] = "ö";
		if(__map_reserved.divide != null) _g.setReserved("divide","÷"); else _g.h["divide"] = "÷";
		if(__map_reserved.oslash != null) _g.setReserved("oslash","ø"); else _g.h["oslash"] = "ø";
		if(__map_reserved.ugrave != null) _g.setReserved("ugrave","ù"); else _g.h["ugrave"] = "ù";
		if(__map_reserved.uacute != null) _g.setReserved("uacute","ú"); else _g.h["uacute"] = "ú";
		if(__map_reserved.ucirc != null) _g.setReserved("ucirc","û"); else _g.h["ucirc"] = "û";
		if(__map_reserved.uuml != null) _g.setReserved("uuml","ü"); else _g.h["uuml"] = "ü";
		if(__map_reserved.yacute != null) _g.setReserved("yacute","ý"); else _g.h["yacute"] = "ý";
		if(__map_reserved.thorn != null) _g.setReserved("thorn","þ"); else _g.h["thorn"] = "þ";
		htmlparser_HtmlTools.htmlUnescapeMap = _g;
	}
	return htmlparser_HtmlTools.htmlUnescapeMap;
};
htmlparser_HtmlTools.escape = function(text,chars) {
	if(chars == null) chars = "";
	var r = text.split("&").join("&amp;");
	r = r.split("<").join("&lt;");
	r = r.split(">").join("&gt;");
	if(chars.indexOf("\"") >= 0) r = r.split("\"").join("&quot;");
	if(chars.indexOf("'") >= 0) r = r.split("'").join("&apos;");
	if(chars.indexOf(" ") >= 0) r = r.split(" ").join("&nbsp;");
	if(chars.indexOf("\n") >= 0) r = r.split("\n").join("&#xA;");
	if(chars.indexOf("\r") >= 0) r = r.split("\r").join("&#xD;");
	return r;
};
htmlparser_HtmlTools.unescape = function(text) {
	return new EReg("[<]!\\[CDATA\\[((?:.|[\r\n])*?)\\]\\][>]|&[^;]+;","g").map(text,function(re) {
		var s = re.matched(0);
		if(s.charAt(0) == "&") {
			if(s.charAt(1) == "#") {
				var numbers = s.substring(2,s.length - 1);
				if(numbers.charAt(0) == "x") numbers = "0" + numbers;
				var code = Std.parseInt(numbers);
				if(code != null && code != 0) return String.fromCharCode(code); else return s;
			} else {
				var r;
				var this1 = htmlparser_HtmlTools.get_htmlUnescapeMap();
				var key = s.substring(1,s.length - 1);
				r = this1.get(key);
				if(r != null) return r; else return s;
			}
		}
		return re.matched(1);
	});
};
var htmlparser_XmlBuilder = function(indent,newLine) {
	if(newLine == null) newLine = "\n";
	if(indent == null) indent = "\t";
	this.level = 0;
	this.indent = indent;
	this.newLine = newLine;
	this.cur = this.xml = new htmlparser_XmlDocument();
};
$hxClasses["htmlparser.XmlBuilder"] = htmlparser_XmlBuilder;
htmlparser_XmlBuilder.__name__ = ["htmlparser","XmlBuilder"];
htmlparser_XmlBuilder.prototype = {
	indent: null
	,newLine: null
	,cur: null
	,level: null
	,xml: null
	,begin: function(tag,attrs) {
		if(this.indent != null) {
			if(this.level > 0 || this.cur.nodes.length > 0) this.cur.addChild(new htmlparser_HtmlNodeText(this.newLine + StringTools.rpad("",this.indent,this.level * this.indent.length)));
			this.level++;
		}
		var node = new htmlparser_XmlNodeElement(tag,attrs != null?attrs.map(function(a) {
			return new htmlparser_HtmlAttribute(a.name,a.value,"\"");
		}):[]);
		this.cur.addChild(node);
		this.cur = node;
		return this;
	}
	,end: function() {
		if(this.indent != null) {
			this.level--;
			if(Lambda.exists(this.cur.nodes,function(e) {
				return !js_Boot.__instanceof(e,htmlparser_HtmlNodeText);
			})) this.cur.addChild(new htmlparser_HtmlNodeText(this.newLine + StringTools.rpad("",this.indent,this.level * this.indent.length)));
		}
		this.cur = this.cur.parent;
		return this;
	}
	,attr: function(name,value,defValue) {
		if(value != null && (!(typeof(value) == "number") || !(function($this) {
			var $r;
			var f = value;
			$r = isNaN(f);
			return $r;
		}(this))) && value != defValue) {
			if((value instanceof Array) && value.__enum__ == null) value = value.join(",");
			this.cur.setAttribute(name,Std.string(value));
		}
		return this;
	}
	,content: function(s) {
		this.cur.addChild(new htmlparser_HtmlNodeText(s));
		return this;
	}
	,toString: function() {
		return this.xml.toString();
	}
	,__class__: htmlparser_XmlBuilder
};
var htmlparser_XmlNodeElement = function(name,attributes) {
	htmlparser_HtmlNodeElement.call(this,name,attributes);
};
$hxClasses["htmlparser.XmlNodeElement"] = htmlparser_XmlNodeElement;
htmlparser_XmlNodeElement.__name__ = ["htmlparser","XmlNodeElement"];
htmlparser_XmlNodeElement.__super__ = htmlparser_HtmlNodeElement;
htmlparser_XmlNodeElement.prototype = $extend(htmlparser_HtmlNodeElement.prototype,{
	isSelfClosing: function() {
		return true;
	}
	,set_innerHTML: function(value) {
		var newNodes = htmlparser_XmlParser.run(value);
		this.nodes = [];
		this.children = [];
		var _g = 0;
		while(_g < newNodes.length) {
			var node = newNodes[_g];
			++_g;
			this.addChild(node);
		}
		return value;
	}
	,__class__: htmlparser_XmlNodeElement
});
var htmlparser_XmlDocument = function(str) {
	if(str == null) str = "";
	htmlparser_XmlNodeElement.call(this,"",[]);
	var nodes = htmlparser_XmlParser.run(str);
	var _g = 0;
	while(_g < nodes.length) {
		var node = nodes[_g];
		++_g;
		this.addChild(node);
	}
};
$hxClasses["htmlparser.XmlDocument"] = htmlparser_XmlDocument;
htmlparser_XmlDocument.__name__ = ["htmlparser","XmlDocument"];
htmlparser_XmlDocument.__super__ = htmlparser_XmlNodeElement;
htmlparser_XmlDocument.prototype = $extend(htmlparser_XmlNodeElement.prototype,{
	__class__: htmlparser_XmlDocument
});
var htmlparser_XmlParser = function() {
	htmlparser_HtmlParser.call(this);
};
$hxClasses["htmlparser.XmlParser"] = htmlparser_XmlParser;
htmlparser_XmlParser.__name__ = ["htmlparser","XmlParser"];
htmlparser_XmlParser.run = function(str) {
	return new htmlparser_XmlParser().parse(str);
};
htmlparser_XmlParser.__super__ = htmlparser_HtmlParser;
htmlparser_XmlParser.prototype = $extend(htmlparser_HtmlParser.prototype,{
	isSelfClosingTag: function(tag) {
		return false;
	}
	,newElement: function(name,attributes) {
		return new htmlparser_XmlNodeElement(name,attributes);
	}
	,__class__: htmlparser_XmlParser
});
var js__$Boot_HaxeError = function(val) {
	Error.call(this);
	this.val = val;
	this.message = String(val);
	if(Error.captureStackTrace) Error.captureStackTrace(this,js__$Boot_HaxeError);
};
$hxClasses["js._Boot.HaxeError"] = js__$Boot_HaxeError;
js__$Boot_HaxeError.__name__ = ["js","_Boot","HaxeError"];
js__$Boot_HaxeError.__super__ = Error;
js__$Boot_HaxeError.prototype = $extend(Error.prototype,{
	val: null
	,__class__: js__$Boot_HaxeError
});
var js_Boot = function() { };
$hxClasses["js.Boot"] = js_Boot;
js_Boot.__name__ = ["js","Boot"];
js_Boot.__unhtml = function(s) {
	return s.split("&").join("&amp;").split("<").join("&lt;").split(">").join("&gt;");
};
js_Boot.__trace = function(v,i) {
	var msg;
	if(i != null) msg = i.fileName + ":" + i.lineNumber + ": "; else msg = "";
	msg += js_Boot.__string_rec(v,"");
	if(i != null && i.customParams != null) {
		var _g = 0;
		var _g1 = i.customParams;
		while(_g < _g1.length) {
			var v1 = _g1[_g];
			++_g;
			msg += "," + js_Boot.__string_rec(v1,"");
		}
	}
	var d;
	if(typeof(document) != "undefined" && (d = document.getElementById("haxe:trace")) != null) d.innerHTML += js_Boot.__unhtml(msg) + "<br/>"; else if(typeof console != "undefined" && console.log != null) console.log(msg);
};
js_Boot.getClass = function(o) {
	if((o instanceof Array) && o.__enum__ == null) return Array; else {
		var cl = o.__class__;
		if(cl != null) return cl;
		var name = js_Boot.__nativeClassName(o);
		if(name != null) return js_Boot.__resolveNativeClass(name);
		return null;
	}
};
js_Boot.__string_rec = function(o,s) {
	if(o == null) return "null";
	if(s.length >= 5) return "<...>";
	var t = typeof(o);
	if(t == "function" && (o.__name__ || o.__ename__)) t = "object";
	switch(t) {
	case "object":
		if(o instanceof Array) {
			if(o.__enum__) {
				if(o.length == 2) return o[0];
				var str2 = o[0] + "(";
				s += "\t";
				var _g1 = 2;
				var _g = o.length;
				while(_g1 < _g) {
					var i1 = _g1++;
					if(i1 != 2) str2 += "," + js_Boot.__string_rec(o[i1],s); else str2 += js_Boot.__string_rec(o[i1],s);
				}
				return str2 + ")";
			}
			var l = o.length;
			var i;
			var str1 = "[";
			s += "\t";
			var _g2 = 0;
			while(_g2 < l) {
				var i2 = _g2++;
				str1 += (i2 > 0?",":"") + js_Boot.__string_rec(o[i2],s);
			}
			str1 += "]";
			return str1;
		}
		var tostr;
		try {
			tostr = o.toString;
		} catch( e ) {
			haxe_CallStack.lastException = e;
			if (e instanceof js__$Boot_HaxeError) e = e.val;
			return "???";
		}
		if(tostr != null && tostr != Object.toString && typeof(tostr) == "function") {
			var s2 = o.toString();
			if(s2 != "[object Object]") return s2;
		}
		var k = null;
		var str = "{\n";
		s += "\t";
		var hasp = o.hasOwnProperty != null;
		for( var k in o ) {
		if(hasp && !o.hasOwnProperty(k)) {
			continue;
		}
		if(k == "prototype" || k == "__class__" || k == "__super__" || k == "__interfaces__" || k == "__properties__") {
			continue;
		}
		if(str.length != 2) str += ", \n";
		str += s + k + " : " + js_Boot.__string_rec(o[k],s);
		}
		s = s.substring(1);
		str += "\n" + s + "}";
		return str;
	case "function":
		return "<function>";
	case "string":
		return o;
	default:
		return String(o);
	}
};
js_Boot.__interfLoop = function(cc,cl) {
	if(cc == null) return false;
	if(cc == cl) return true;
	var intf = cc.__interfaces__;
	if(intf != null) {
		var _g1 = 0;
		var _g = intf.length;
		while(_g1 < _g) {
			var i = _g1++;
			var i1 = intf[i];
			if(i1 == cl || js_Boot.__interfLoop(i1,cl)) return true;
		}
	}
	return js_Boot.__interfLoop(cc.__super__,cl);
};
js_Boot.__instanceof = function(o,cl) {
	if(cl == null) return false;
	switch(cl) {
	case Int:
		return (o|0) === o;
	case Float:
		return typeof(o) == "number";
	case Bool:
		return typeof(o) == "boolean";
	case String:
		return typeof(o) == "string";
	case Array:
		return (o instanceof Array) && o.__enum__ == null;
	case Dynamic:
		return true;
	default:
		if(o != null) {
			if(typeof(cl) == "function") {
				if(o instanceof cl) return true;
				if(js_Boot.__interfLoop(js_Boot.getClass(o),cl)) return true;
			} else if(typeof(cl) == "object" && js_Boot.__isNativeObj(cl)) {
				if(o instanceof cl) return true;
			}
		} else return false;
		if(cl == Class && o.__name__ != null) return true;
		if(cl == Enum && o.__ename__ != null) return true;
		return o.__enum__ == cl;
	}
};
js_Boot.__cast = function(o,t) {
	if(js_Boot.__instanceof(o,t)) return o; else throw new js__$Boot_HaxeError("Cannot cast " + Std.string(o) + " to " + Std.string(t));
};
js_Boot.__nativeClassName = function(o) {
	var name = js_Boot.__toStr.call(o).slice(8,-1);
	if(name == "Object" || name == "Function" || name == "Math" || name == "JSON") return null;
	return name;
};
js_Boot.__isNativeObj = function(o) {
	return js_Boot.__nativeClassName(o) != null;
};
js_Boot.__resolveNativeClass = function(name) {
	return (Function("return typeof " + name + " != \"undefined\" ? " + name + " : null"))();
};
var js_html_compat_ArrayBuffer = function(a) {
	if((a instanceof Array) && a.__enum__ == null) {
		this.a = a;
		this.byteLength = a.length;
	} else {
		var len = a;
		this.a = [];
		var _g = 0;
		while(_g < len) {
			var i = _g++;
			this.a[i] = 0;
		}
		this.byteLength = len;
	}
};
$hxClasses["js.html.compat.ArrayBuffer"] = js_html_compat_ArrayBuffer;
js_html_compat_ArrayBuffer.__name__ = ["js","html","compat","ArrayBuffer"];
js_html_compat_ArrayBuffer.sliceImpl = function(begin,end) {
	var u = new Uint8Array(this,begin,end == null?null:end - begin);
	var result = new ArrayBuffer(u.byteLength);
	var resultArray = new Uint8Array(result);
	resultArray.set(u);
	return result;
};
js_html_compat_ArrayBuffer.prototype = {
	byteLength: null
	,a: null
	,slice: function(begin,end) {
		return new js_html_compat_ArrayBuffer(this.a.slice(begin,end));
	}
	,__class__: js_html_compat_ArrayBuffer
};
var js_html_compat_DataView = function(buffer,byteOffset,byteLength) {
	this.buf = buffer;
	if(byteOffset == null) this.offset = 0; else this.offset = byteOffset;
	if(byteLength == null) this.length = buffer.byteLength - this.offset; else this.length = byteLength;
	if(this.offset < 0 || this.length < 0 || this.offset + this.length > buffer.byteLength) throw new js__$Boot_HaxeError(haxe_io_Error.OutsideBounds);
};
$hxClasses["js.html.compat.DataView"] = js_html_compat_DataView;
js_html_compat_DataView.__name__ = ["js","html","compat","DataView"];
js_html_compat_DataView.prototype = {
	buf: null
	,offset: null
	,length: null
	,getInt8: function(byteOffset) {
		var v = this.buf.a[this.offset + byteOffset];
		if(v >= 128) return v - 256; else return v;
	}
	,getUint8: function(byteOffset) {
		return this.buf.a[this.offset + byteOffset];
	}
	,getInt16: function(byteOffset,littleEndian) {
		var v = this.getUint16(byteOffset,littleEndian);
		if(v >= 32768) return v - 65536; else return v;
	}
	,getUint16: function(byteOffset,littleEndian) {
		if(littleEndian) return this.buf.a[this.offset + byteOffset] | this.buf.a[this.offset + byteOffset + 1] << 8; else return this.buf.a[this.offset + byteOffset] << 8 | this.buf.a[this.offset + byteOffset + 1];
	}
	,getInt32: function(byteOffset,littleEndian) {
		var p = this.offset + byteOffset;
		var a = this.buf.a[p++];
		var b = this.buf.a[p++];
		var c = this.buf.a[p++];
		var d = this.buf.a[p++];
		if(littleEndian) return a | b << 8 | c << 16 | d << 24; else return d | c << 8 | b << 16 | a << 24;
	}
	,getUint32: function(byteOffset,littleEndian) {
		var v = this.getInt32(byteOffset,littleEndian);
		if(v < 0) return v + 4294967296.; else return v;
	}
	,getFloat32: function(byteOffset,littleEndian) {
		return haxe_io_FPHelper.i32ToFloat(this.getInt32(byteOffset,littleEndian));
	}
	,getFloat64: function(byteOffset,littleEndian) {
		var a = this.getInt32(byteOffset,littleEndian);
		var b = this.getInt32(byteOffset + 4,littleEndian);
		return haxe_io_FPHelper.i64ToDouble(littleEndian?a:b,littleEndian?b:a);
	}
	,setInt8: function(byteOffset,value) {
		if(value < 0) this.buf.a[byteOffset + this.offset] = value + 128 & 255; else this.buf.a[byteOffset + this.offset] = value & 255;
	}
	,setUint8: function(byteOffset,value) {
		this.buf.a[byteOffset + this.offset] = value & 255;
	}
	,setInt16: function(byteOffset,value,littleEndian) {
		this.setUint16(byteOffset,value < 0?value + 65536:value,littleEndian);
	}
	,setUint16: function(byteOffset,value,littleEndian) {
		var p = byteOffset + this.offset;
		if(littleEndian) {
			this.buf.a[p] = value & 255;
			this.buf.a[p++] = value >> 8 & 255;
		} else {
			this.buf.a[p++] = value >> 8 & 255;
			this.buf.a[p] = value & 255;
		}
	}
	,setInt32: function(byteOffset,value,littleEndian) {
		this.setUint32(byteOffset,value,littleEndian);
	}
	,setUint32: function(byteOffset,value,littleEndian) {
		var p = byteOffset + this.offset;
		if(littleEndian) {
			this.buf.a[p++] = value & 255;
			this.buf.a[p++] = value >> 8 & 255;
			this.buf.a[p++] = value >> 16 & 255;
			this.buf.a[p++] = value >>> 24;
		} else {
			this.buf.a[p++] = value >>> 24;
			this.buf.a[p++] = value >> 16 & 255;
			this.buf.a[p++] = value >> 8 & 255;
			this.buf.a[p++] = value & 255;
		}
	}
	,setFloat32: function(byteOffset,value,littleEndian) {
		this.setUint32(byteOffset,haxe_io_FPHelper.floatToI32(value),littleEndian);
	}
	,setFloat64: function(byteOffset,value,littleEndian) {
		var i64 = haxe_io_FPHelper.doubleToI64(value);
		if(littleEndian) {
			this.setUint32(byteOffset,i64.low);
			this.setUint32(byteOffset,i64.high);
		} else {
			this.setUint32(byteOffset,i64.high);
			this.setUint32(byteOffset,i64.low);
		}
	}
	,__class__: js_html_compat_DataView
};
var js_html_compat_Uint8Array = function() { };
$hxClasses["js.html.compat.Uint8Array"] = js_html_compat_Uint8Array;
js_html_compat_Uint8Array.__name__ = ["js","html","compat","Uint8Array"];
js_html_compat_Uint8Array._new = function(arg1,offset,length) {
	var arr;
	if(typeof(arg1) == "number") {
		arr = [];
		var _g = 0;
		while(_g < arg1) {
			var i = _g++;
			arr[i] = 0;
		}
		arr.byteLength = arr.length;
		arr.byteOffset = 0;
		arr.buffer = new js_html_compat_ArrayBuffer(arr);
	} else if(js_Boot.__instanceof(arg1,js_html_compat_ArrayBuffer)) {
		var buffer = arg1;
		if(offset == null) offset = 0;
		if(length == null) length = buffer.byteLength - offset;
		if(offset == 0) arr = buffer.a; else arr = buffer.a.slice(offset,offset + length);
		arr.byteLength = arr.length;
		arr.byteOffset = offset;
		arr.buffer = buffer;
	} else if((arg1 instanceof Array) && arg1.__enum__ == null) {
		arr = arg1.slice();
		arr.byteLength = arr.length;
		arr.byteOffset = 0;
		arr.buffer = new js_html_compat_ArrayBuffer(arr);
	} else throw new js__$Boot_HaxeError("TODO " + Std.string(arg1));
	arr.subarray = js_html_compat_Uint8Array._subarray;
	arr.set = js_html_compat_Uint8Array._set;
	return arr;
};
js_html_compat_Uint8Array._set = function(arg,offset) {
	var t = this;
	if(js_Boot.__instanceof(arg.buffer,js_html_compat_ArrayBuffer)) {
		var a = arg;
		if(arg.byteLength + offset > t.byteLength) throw new js__$Boot_HaxeError("set() outside of range");
		var _g1 = 0;
		var _g = arg.byteLength;
		while(_g1 < _g) {
			var i = _g1++;
			t[i + offset] = a[i];
		}
	} else if((arg instanceof Array) && arg.__enum__ == null) {
		var a1 = arg;
		if(a1.length + offset > t.byteLength) throw new js__$Boot_HaxeError("set() outside of range");
		var _g11 = 0;
		var _g2 = a1.length;
		while(_g11 < _g2) {
			var i1 = _g11++;
			t[i1 + offset] = a1[i1];
		}
	} else throw new js__$Boot_HaxeError("TODO");
};
js_html_compat_Uint8Array._subarray = function(start,end) {
	var t = this;
	var a = js_html_compat_Uint8Array._new(t.slice(start,end));
	a.byteOffset = start;
	return a;
};
var js_three_ObjectType = function() { };
$hxClasses["js.three.ObjectType"] = js_three_ObjectType;
js_three_ObjectType.__name__ = ["js","three","ObjectType"];
var nanofl_IInstance = function() { };
$hxClasses["nanofl.IInstance"] = nanofl_IInstance;
nanofl_IInstance.__name__ = ["nanofl","IInstance"];
nanofl_IInstance.prototype = {
	onEnterFrame: null
	,onMouseDown: null
	,onMouseMove: null
	,onMouseUp: null
	,__class__: nanofl_IInstance
};
var nanofl_Bitmap = $hx_exports.nanofl.Bitmap = function(symbol) {
	createjs.Bitmap.call(this,null);
	this.symbol = symbol;
	symbol.updateDisplayObject(this,null);
	nanofl_InstanceTools.bindEventHandlers(this);
};
$hxClasses["nanofl.Bitmap"] = nanofl_Bitmap;
nanofl_Bitmap.__name__ = ["nanofl","Bitmap"];
nanofl_Bitmap.__interfaces__ = [nanofl_IInstance];
nanofl_Bitmap.__super__ = createjs.Bitmap;
nanofl_Bitmap.prototype = $extend(createjs.Bitmap.prototype,{
	symbol: null
	,clone: function(recursive) {
		return this._cloneProps(new nanofl_Bitmap(this.symbol));
	}
	,toString: function() {
		return this.symbol.toString();
	}
	,onEnterFrame: function() {
	}
	,onMouseDown: function(e) {
	}
	,onMouseMove: function(e) {
	}
	,onMouseUp: function(e) {
	}
	,__class__: nanofl_Bitmap
});
var nanofl_MovieClip = $hx_exports.nanofl.MovieClip = function(symbol,initFrameIndex,childFrameIndexes) {
	this.currentFrame = 0;
	this.layerOfChild = new haxe_ds_ObjectMap();
	stdlib_Debug.assert(js_Boot.__instanceof(symbol,nanofl_engine_libraryitems_MovieClipItem),null,{ fileName : "MovieClip.hx", lineNumber : 28, className : "nanofl.MovieClip", methodName : "new"});
	createjs.Container.call(this);
	this.symbol = symbol;
	if(initFrameIndex != null) this.currentFrame = initFrameIndex;
	symbol.updateDisplayObject(this,childFrameIndexes);
	this.paused = !symbol.autoPlay;
	this.loop = symbol.loop;
	nanofl_InstanceTools.bindEventHandlers(this);
};
$hxClasses["nanofl.MovieClip"] = nanofl_MovieClip;
nanofl_MovieClip.__name__ = ["nanofl","MovieClip"];
nanofl_MovieClip.__interfaces__ = [nanofl_IInstance];
nanofl_MovieClip.applyMask = function(mask,obj) {
	var objBounds = nanofl_DisplayObjectTools.getOuterBounds(obj);
	if(objBounds == null || objBounds.width == 0 || objBounds.height == 0) return false;
	mask = mask.clone(true);
	mask.transformMatrix = obj.getMatrix().invert();
	mask.visible = true;
	var maskContainer = new createjs.Container();
	maskContainer.addChild(mask);
	var maskContainerBounds = nanofl_DisplayObjectTools.getOuterBounds(maskContainer);
	if(maskContainerBounds == null || maskContainerBounds.width == 0 || maskContainerBounds.height == 0) {
		obj.visible = false;
		return false;
	}
	nanofl_DisplayObjectTools.smartCache(mask);
	if(js_Boot.__instanceof(obj,createjs.Container)) {
		var _g = 0;
		var _g1 = obj.children;
		while(_g < _g1.length) {
			var child = _g1[_g];
			++_g;
			nanofl_DisplayObjectTools.smartCache(child);
		}
	}
	var intersection = maskContainerBounds.intersection(objBounds);
	if(intersection == null || intersection.width == 0 || intersection.height == 0) {
		obj.visible = false;
		return false;
	}
	var union = objBounds.union(intersection);
	maskContainer.cache(union.x,union.y,union.width,union.height);
	var objBounds2 = nanofl_DisplayObjectTools.getOuterBounds(obj,true);
	obj.cache(objBounds2.x,objBounds2.y,objBounds2.width,objBounds2.height);
	new createjs.AlphaMaskFilter(maskContainer.cacheCanvas).applyFilter(obj.cacheCanvas.getContext("2d",null),0,0,objBounds.width,objBounds.height);
	return true;
};
nanofl_MovieClip.__super__ = createjs.Container;
nanofl_MovieClip.prototype = $extend(createjs.Container.prototype,{
	layerOfChild: null
	,symbol: null
	,currentFrame: null
	,paused: null
	,loop: null
	,addChildToLayer: function(child,layerIndex) {
		this.layerOfChild.set(child,layerIndex);
		var _g1 = 0;
		var _g = this.children.length;
		while(_g1 < _g) {
			var i = _g1++;
			if((function($this) {
				var $r;
				var key = $this.children[i];
				$r = $this.layerOfChild.h[key.__id__];
				return $r;
			}(this)) < layerIndex) return this.addChildAt(child,i);
		}
		return this.addChild(child);
	}
	,removeAllChildren: function() {
		createjs.Container.prototype.removeAllChildren.call(this);
		this.layerOfChild = new haxe_ds_ObjectMap();
	}
	,removeChild: function(child) {
		this.layerOfChild.remove(child);
		return createjs.Container.prototype.removeChild.call(this,child);
	}
	,removeChildAt: function(index) {
		var key = this.children[index];
		this.layerOfChild.remove(key);
		return createjs.Container.prototype.removeChildAt.call(this,index);
	}
	,play: function() {
		this.paused = false;
	}
	,stop: function() {
		this.paused = true;
	}
	,gotoAndStop: function(labelOrIndex) {
		this.gotoFrame(labelOrIndex);
		this.stop();
	}
	,gotoAndPlay: function(labelOrIndex) {
		this.gotoFrame(labelOrIndex);
		this.play();
	}
	,getTotalFrames: function() {
		return this.symbol.getTotalFrames();
	}
	,maskChild: function(child) {
		var n = this.layerOfChild.h[child.__id__];
		if(n != null) {
			var parentLayerIndex = this.symbol.layers[n].parentIndex;
			if(parentLayerIndex != null && this.symbol.layers[parentLayerIndex].type == "mask") {
				var mask = new createjs.Container();
				var _g = 0;
				var _g1 = this.getLayerChildren(parentLayerIndex);
				while(_g < _g1.length) {
					var obj = _g1[_g];
					++_g;
					var clonedObj = obj.clone(true);
					clonedObj.visible = true;
					nanofl_DisplayObjectTools.smartCache(clonedObj);
					mask.addChild(clonedObj);
				}
				return nanofl_MovieClip.applyMask(mask,child);
			}
		}
		return false;
	}
	,uncacheChild: function(child) {
		child.uncache();
		if(nanofl_DisplayObjectTools.autoHitArea) child.hitArea = null;
		var layerIndex = this.layerOfChild.h[child.__id__];
		if(layerIndex != null && this.symbol.layers[layerIndex].type == "mask") {
			var _g = 0;
			var _g1 = this.children;
			while(_g < _g1.length) {
				var c = _g1[_g];
				++_g;
				var n;
				var key = c;
				n = this.layerOfChild.h[key.__id__];
				if(n != null && this.symbol.layers[n].parentIndex == layerIndex) {
					c.uncache();
					if(nanofl_DisplayObjectTools.autoHitArea) c.hitArea = null;
				}
			}
		}
	}
	,getLayerChildren: function(layerIndex) {
		var r = [];
		var _g = 0;
		var _g1 = this.children;
		while(_g < _g1.length) {
			var child = _g1[_g];
			++_g;
			if((function($this) {
				var $r;
				var key = child;
				$r = $this.layerOfChild.h[key.__id__];
				return $r;
			}(this)) == layerIndex) r.push(child);
		}
		return r;
	}
	,gotoFrame: function(labelOrIndex) {
		var frameIndex = this.getFrameIndexByLabel(labelOrIndex);
		if(this.currentFrame == frameIndex) return null;
		var movieClipChanged = false;
		var createdDisplayObjects = [];
		var keepedChildMovieClips = [];
		var _g1 = 0;
		var _g = this.symbol.layers.length;
		while(_g1 < _g) {
			var i = _g1++;
			var layerChanged = false;
			var layer = this.symbol.layers[i];
			var oldFrame = layer.getFrame(this.currentFrame);
			var newFrame = layer.getFrame(frameIndex);
			if(oldFrame != null && newFrame != null && oldFrame.keyFrame == newFrame.keyFrame) {
				if(newFrame.keyFrame.motionTween != null) {
					var tweenedElements = layer.getTweenedElements(frameIndex);
					var layerChildren = this.getLayerChildren(i);
					stdlib_Debug.assert(tweenedElements.length == layerChildren.length,"tweenedElements.length=" + tweenedElements.length + " != layerChildren.length=" + layerChildren.length,{ fileName : "MovieClip.hx", lineNumber : 232, className : "nanofl.MovieClip", methodName : "gotoFrame"});
					var _g3 = 0;
					var _g2 = tweenedElements.length;
					while(_g3 < _g2) {
						var i1 = _g3++;
						tweenedElements[i1].current.updateDisplayObject(layerChildren[i1],null);
						layerChildren[i1].visible = layer.type == "normal";
						if(js_Boot.__instanceof(tweenedElements[i1].current,nanofl_MovieClip) || js_Boot.__instanceof(tweenedElements[i1].current,createjs.Sprite)) keepedChildMovieClips.push(tweenedElements[i1].current);
					}
					layerChanged = true;
				}
			} else if(oldFrame != null || newFrame != null) {
				if(oldFrame != null) {
					var j = 0;
					while(j < this.children.length) if((function($this) {
						var $r;
						var key = $this.children[j];
						$r = $this.layerOfChild.h[key.__id__];
						return $r;
					}(this)) == i) this.removeChildAt(j); else j++;
				}
				if(newFrame != null) {
					var _g21 = 0;
					var _g31 = layer.getTweenedElements(frameIndex);
					while(_g21 < _g31.length) {
						var tweenedElement = _g31[_g21];
						++_g21;
						var obj = tweenedElement.current.createDisplayObject(null);
						obj.visible = layer.type == "normal";
						this.addChildToLayer(obj,i);
						createdDisplayObjects.push(obj);
					}
				}
				layerChanged = true;
			}
			if(layerChanged) {
				movieClipChanged = true;
				if(layer.type == "mask") {
					var _g32 = 0;
					var _g22 = this.symbol.layers.length;
					while(_g32 < _g22) {
						var j1 = _g32++;
						if(this.symbol.layers[j1].parentIndex == i) {
							var _g4 = 0;
							var _g5 = this.getLayerChildren(j1);
							while(_g4 < _g5.length) {
								var child = _g5[_g4];
								++_g4;
								child.uncache();
							}
						}
					}
				}
			}
		}
		if(movieClipChanged) nanofl_DisplayObjectTools.smartUncache(this);
		this.currentFrame = frameIndex;
		var _g6 = 0;
		while(_g6 < createdDisplayObjects.length) {
			var obj1 = createdDisplayObjects[_g6];
			++_g6;
			nanofl_DisplayObjectTools.callMethod(obj1,"init");
		}
		return keepedChildMovieClips;
	}
	,getFrameIndexByLabel: function(labelOrIndex) {
		if(((labelOrIndex | 0) === labelOrIndex)) return labelOrIndex;
		var $it0 = HxOverrides.iter(this.symbol.layers);
		while( $it0.hasNext() ) {
			var layer = $it0.next();
			var $it1 = HxOverrides.iter(layer.keyFrames);
			while( $it1.hasNext() ) {
				var keyFrame = $it1.next();
				if(keyFrame.label == labelOrIndex) return keyFrame.getIndex();
			}
		}
		return null;
	}
	,advance: function() {
		var childrenToAdvance = null;
		if(!this.paused) childrenToAdvance = this.gotoFrame(this.loop?(this.currentFrame + 1) % this.getTotalFrames():stdlib_Std.min(this.currentFrame + 1,this.getTotalFrames() - 1));
		if(childrenToAdvance == null) {
			var _g = 0;
			var _g1 = this.children;
			while(_g < _g1.length) {
				var child = _g1[_g];
				++_g;
				if(js_Boot.__instanceof(child,nanofl_MovieClip)) child.advance(); else if(js_Boot.__instanceof(child,createjs.Sprite)) child.advance();
			}
		} else {
			var _g2 = 0;
			while(_g2 < childrenToAdvance.length) {
				var child1 = childrenToAdvance[_g2];
				++_g2;
				child1.advance();
			}
		}
	}
	,clone: function(recursive) {
		return this._cloneProps(new nanofl_MovieClip(this.symbol,this.currentFrame,null));
	}
	,toString: function() {
		return this.symbol.toString();
	}
	,onEnterFrame: function() {
	}
	,onMouseDown: function(e) {
	}
	,onMouseMove: function(e) {
	}
	,onMouseUp: function(e) {
	}
	,__class__: nanofl_MovieClip
});
var nanofl_Button = $hx_exports.nanofl.Button = function(symbol) {
	nanofl_MovieClip.call(this,symbol,0,null);
	this.stop();
	if(this.getTotalFrames() >= 4) {
		var hitSymbol;
		hitSymbol = js_Boot.__cast(symbol.duplicate("__nanofl_temp") , nanofl_engine_libraryitems_MovieClipItem);
		hitSymbol.likeButton = false;
		hitSymbol.linkedClass = "";
		this.hitArea = hitSymbol.createDisplayObject(3,null);
		hitSymbol.remove();
	}
	this.cursor = "pointer";
};
$hxClasses["nanofl.Button"] = nanofl_Button;
nanofl_Button.__name__ = ["nanofl","Button"];
nanofl_Button.__super__ = nanofl_MovieClip;
nanofl_Button.prototype = $extend(nanofl_MovieClip.prototype,{
	onMouseDown: function(e) {
		if(this.getTotalFrames() >= 3 && this.currentFrame != 2) {
			if((this.hitArea != null?this.hitArea:this).hitTest(e.localX,e.localY)) this.gotoAndStop(2);
		}
	}
	,onMouseMove: function(e) {
		if(this.getTotalFrames() >= 2 && this.currentFrame != 2) this.gotoAndStop((this.hitArea != null?this.hitArea:this).hitTest(e.localX,e.localY)?1:0);
	}
	,onMouseUp: function(e) {
		if(this.getTotalFrames() > 0 && this.currentFrame != 0) this.gotoAndStop(0);
	}
	,__class__: nanofl_Button
});
var nanofl_DataTools = $hx_exports.nanofl.DataTools = function() { };
$hxClasses["nanofl.DataTools"] = nanofl_DataTools;
nanofl_DataTools.__name__ = ["nanofl","DataTools"];
nanofl_DataTools.serialize = function(obj) {
	return stdlib_Serializer.run(obj,true);
};
nanofl_DataTools.unserialize = function(s) {
	return stdlib_Unserializer.run(s);
};
var nanofl_DisplayObjectTools = $hx_exports.nanofl.DisplayObjectTools = function() { };
$hxClasses["nanofl.DisplayObjectTools"] = nanofl_DisplayObjectTools;
nanofl_DisplayObjectTools.__name__ = ["nanofl","DisplayObjectTools"];
nanofl_DisplayObjectTools.smartCache = function(obj) {
	if(obj.visible && obj.cacheCanvas == null) {
		if(js_Boot.__instanceof(obj,createjs.Container) && !js_Boot.__instanceof(obj,nanofl_SolidContainer)) {
			var _g = 0;
			var _g1 = obj.children;
			while(_g < _g1.length) {
				var child = _g1[_g];
				++_g;
				nanofl_DisplayObjectTools.smartCache(child);
			}
		}
		if(obj.parent == null || !js_Boot.__instanceof(obj.parent,nanofl_MovieClip) || !obj.parent.maskChild(obj)) {
			if(obj.filters != null && obj.filters.length > 0) {
				var bounds = nanofl_DisplayObjectTools.getInnerBounds(obj);
				if(bounds != null && bounds.width > 0 && bounds.height > 0) {
					obj.cache(bounds.x,bounds.y,bounds.width,bounds.height);
					if(nanofl_DisplayObjectTools.autoHitArea) {
						var hitArea = new createjs.Container();
						var hitBmp = new createjs.Bitmap(obj.cacheCanvas);
						hitBmp.x = obj._cacheOffsetX + obj._filterOffsetX;
						hitBmp.y = obj._cacheOffsetY + obj._filterOffsetY;
						hitArea.addChild(hitBmp);
						obj.hitArea = hitArea;
					}
				}
			}
		}
	}
};
nanofl_DisplayObjectTools.smartUncache = function(obj) {
	var inspiredByChild = null;
	while(obj != null) {
		obj.uncache();
		if(nanofl_DisplayObjectTools.autoHitArea) obj.hitArea = null;
		if(js_Boot.__instanceof(obj,nanofl_MovieClip) && inspiredByChild != null) obj.uncacheChild(inspiredByChild);
		inspiredByChild = obj;
		obj = obj.parent;
	}
};
nanofl_DisplayObjectTools.getOuterBounds = function(obj,ignoreSelf) {
	if(ignoreSelf == null) ignoreSelf = false;
	var r = null;
	if(js_Boot.__instanceof(obj,createjs.Container) && !js_Boot.__instanceof(obj,nanofl_SolidContainer)) {
		var _g = 0;
		var _g1 = obj.children;
		while(_g < _g1.length) {
			var child = _g1[_g];
			++_g;
			var b = nanofl_engine_geom_BoundsTools.transform(nanofl_DisplayObjectTools.getOuterBounds(child),child.getMatrix());
			if(b != null) {
				if(r != null) r = r.union(b); else r = b;
			}
		}
	} else r = nanofl_DisplayObjectTools.getInnerBounds(obj);
	if(r == null) return null;
	if(!ignoreSelf && obj.filters != null) {
		var _g2 = 0;
		var _g11 = obj.filters;
		while(_g2 < _g11.length) {
			var f = _g11[_g2];
			++_g2;
			f.getBounds(r);
		}
	}
	return r;
};
nanofl_DisplayObjectTools.getInnerBounds = function(obj) {
	var r = null;
	if(js_Boot.__instanceof(obj,createjs.Container) && !js_Boot.__instanceof(obj,nanofl_SolidContainer)) {
		var _g = 0;
		var _g1 = obj.children;
		while(_g < _g1.length) {
			var child = _g1[_g];
			++_g;
			var b = nanofl_engine_geom_BoundsTools.transform(nanofl_DisplayObjectTools.getInnerBounds(child),child.getMatrix());
			if(b != null) {
				if(r != null) r = r.union(b); else r = b;
			}
		}
		if(r == null) return null;
	} else {
		if(obj.cacheCanvas == null) r = obj.getBounds(); else {
			var savedCacheCanvas = obj.cacheCanvas;
			obj.cacheCanvas = null;
			r = obj.getBounds();
			obj.cacheCanvas = savedCacheCanvas;
		}
		if(r == null) return null;
		r = r.clone();
	}
	return r;
};
nanofl_DisplayObjectTools.callMethod = function(parent,name) {
	if(js_Boot.__instanceof(parent,createjs.Container)) {
		var _g = 0;
		var _g1 = parent.children;
		while(_g < _g1.length) {
			var child = _g1[_g];
			++_g;
			nanofl_DisplayObjectTools.callMethod(child,name);
		}
	}
	var method = Reflect.field(parent,name);
	if(Reflect.isFunction(method)) method.apply(parent,[]);
};
nanofl_DisplayObjectTools.smartHitTest = function(obj,x,y,minAlpha) {
	if(minAlpha == null) minAlpha = 1;
	if(obj.cacheCanvas == null) return obj.hitTest(x,y); else {
		if(x < obj._cacheOffsetX || y < obj._cacheOffsetY || x > obj._cacheOffsetX + obj._cacheWidth || y > obj._cacheOffsetY + obj._cacheHeight) return false;
		x = Math.round((x - obj._cacheOffsetX - obj._filterOffsetX) * obj._cacheScale);
		y = Math.round((y - obj._cacheOffsetY - obj._filterOffsetY) * obj._cacheScale);
		var alpha = obj.cacheCanvas.getContext("2d",null).getImageData(x,y,1,1).data[3];
		return alpha >= minAlpha;
	}
};
nanofl_DisplayObjectTools.dump = function(obj,level) {
	if(level == null) level = 0;
	var s = StringTools.rpad("","\t",level);
	if(js_Boot.__instanceof(obj,nanofl_MovieClip)) s += "MovieClip(" + obj.symbol.namePath + ")"; else if(js_Boot.__instanceof(obj,nanofl_Mesh)) s += "Mesh(" + obj.symbol.namePath + ")"; else if(js_Boot.__instanceof(obj,nanofl_TextField)) s += "TextField"; else if(js_Boot.__instanceof(obj,nanofl_Bitmap)) s += "Bitmap(" + obj.symbol.namePath + ")"; else if(js_Boot.__instanceof(obj,createjs.Container)) s += "Container"; else if(js_Boot.__instanceof(obj,createjs.Shape)) s += "Shape"; else s += "Unknow";
	if(obj.cacheCanvas != null) s += " cached";
	if(obj._bounds != null) s += " fixed";
	s += " bounds(" + nanofl_DisplayObjectTools.rectToString(obj.getBounds()) + ")";
	s += " outers(" + nanofl_DisplayObjectTools.rectToString(nanofl_DisplayObjectTools.getOuterBounds(obj)) + ")";
	if(js_Boot.__instanceof(obj,nanofl_TextField)) s += " '" + StringTools.replace(StringTools.replace(obj.text,"\r"," "),"\n"," ") + "'";
	haxe_Log.trace(s,{ fileName : "DisplayObjectTools.hx", lineNumber : 216, className : "nanofl.DisplayObjectTools", methodName : "dump"});
	if(js_Boot.__instanceof(obj,createjs.Container) && !js_Boot.__instanceof(obj,nanofl_SolidContainer)) {
		var _g = 0;
		var _g1 = obj.children;
		while(_g < _g1.length) {
			var child = _g1[_g];
			++_g;
			nanofl_DisplayObjectTools.dump(child,level + 1);
		}
	}
};
nanofl_DisplayObjectTools.rectToString = function(rect) {
	if(rect == null) return "null";
	return rect.x + "," + rect.y + " " + rect.width + " x " + rect.height;
};
var nanofl_InstanceTools = function() { };
$hxClasses["nanofl.InstanceTools"] = nanofl_InstanceTools;
nanofl_InstanceTools.__name__ = ["nanofl","InstanceTools"];
nanofl_InstanceTools.bindEventHandlers = function(instance) {
	var handler = (function(f1,a1,f) {
		return function(e) {
			f1(a1,f,e);
		};
	})(nanofl_InstanceTools.stageMouseEventProxy,instance,$bind(instance,instance.onMouseDown));
	nanofl_Player.stage.addEventListener("stagemousedown",handler,null);
	var handler1 = (function(f11,a11,f2) {
		return function(e1) {
			f11(a11,f2,e1);
		};
	})(nanofl_InstanceTools.stageMouseEventProxy,instance,$bind(instance,instance.onMouseMove));
	nanofl_Player.stage.addEventListener("stagemousemove",handler1,null);
	var handler2 = (function(f12,a12,f3) {
		return function(e2) {
			f12(a12,f3,e2);
		};
	})(nanofl_InstanceTools.stageMouseEventProxy,instance,$bind(instance,instance.onMouseUp));
	nanofl_Player.stage.addEventListener("stagemouseup",handler2,null);
};
nanofl_InstanceTools.stageMouseEventProxy = function(instance,f,e) {
	var t = e.currentTarget;
	e.currentTarget = instance;
	f(e);
	e.currentTarget = t;
};
var nanofl_SolidContainer = function() {
	createjs.Container.call(this);
};
$hxClasses["nanofl.SolidContainer"] = nanofl_SolidContainer;
nanofl_SolidContainer.__name__ = ["nanofl","SolidContainer"];
nanofl_SolidContainer.__super__ = createjs.Container;
nanofl_SolidContainer.prototype = $extend(createjs.Container.prototype,{
	__class__: nanofl_SolidContainer
});
var nanofl_Mesh = $hx_exports.nanofl.Mesh = function(symbol) {
	this.directionalLight = new THREE.DirectionalLight(8421504,1);
	this.ambientLight = new THREE.AmbientLight(14737632);
	this.autoCamera = true;
	this.camera = new THREE.PerspectiveCamera(70,1,0,1e7);
	this.rotationZ = 0.0;
	this.rotationY = 0.0;
	this.rotationX = 0.0;
	nanofl_SolidContainer.call(this);
	this.symbol = symbol;
	var d = symbol.renderAreaSize >> 1;
	if(symbol.renderAreaSize % 2 != 0) d++;
	this.setBounds(-d,-d,d,d);
	symbol.updateDisplayObject(this,null);
	nanofl_InstanceTools.bindEventHandlers(this);
};
$hxClasses["nanofl.Mesh"] = nanofl_Mesh;
nanofl_Mesh.__name__ = ["nanofl","Mesh"];
nanofl_Mesh.__interfaces__ = [nanofl_IInstance];
nanofl_Mesh.__super__ = nanofl_SolidContainer;
nanofl_Mesh.prototype = $extend(nanofl_SolidContainer.prototype,{
	symbol: null
	,rotationX: null
	,rotationY: null
	,rotationZ: null
	,scene: null
	,group: null
	,camera: null
	,autoCamera: null
	,ambientLight: null
	,directionalLight: null
	,clone: function(recursive) {
		return this._cloneProps(new nanofl_Mesh(this.symbol));
	}
	,toString: function() {
		return this.symbol.toString();
	}
	,draw: function(ctx,ignoreCache) {
		this.update();
		return nanofl_SolidContainer.prototype.draw.call(this,ctx,ignoreCache);
	}
	,update: function() {
		this.removeAllChildren();
		var bitmap = new createjs.Bitmap(this.symbol.renderer.domElement);
		this.addChild(bitmap);
		bitmap.x = bitmap.y = -this.symbol.renderAreaSize / 2;
		this.group.setRotationFromEuler(new THREE.Euler(this.rotationX * nanofl_Mesh.DEG_TO_RAD,this.rotationY * nanofl_Mesh.DEG_TO_RAD,this.rotationZ * nanofl_Mesh.DEG_TO_RAD));
		this.group.updateMatrix();
		var posZ = this.symbol.boundingRadius / Math.sin(this.camera.fov / 2 * nanofl_Mesh.DEG_TO_RAD);
		if(this.directionalLight != null) {
			this.directionalLight.position.x = 0.0;
			this.directionalLight.position.y = 0.0;
			this.directionalLight.position.z = -posZ;
			this.directionalLight.position.applyEuler(new THREE.Euler(this.directionalLight.rotation.x,this.directionalLight.rotation.y));
		}
		if(this.autoCamera) {
			this.camera.position.z = -posZ;
			this.camera.lookAt(new THREE.Vector3(0,0,0));
			this.camera.near = posZ - this.symbol.boundingRadius;
			this.camera.far = posZ + this.symbol.boundingRadius;
			this.camera.updateProjectionMatrix();
			this.camera.updateMatrix();
		}
		this.scene.add(this.ambientLight);
		this.scene.add(this.directionalLight);
		this.symbol.renderer.render(this.scene,this.camera);
	}
	,onEnterFrame: function() {
	}
	,onMouseDown: function(e) {
	}
	,onMouseMove: function(e) {
	}
	,onMouseUp: function(e) {
	}
	,__class__: nanofl_Mesh
});
var nanofl_Player = $hx_exports.nanofl.Player = function() { };
$hxClasses["nanofl.Player"] = nanofl_Player;
nanofl_Player.__name__ = ["nanofl","Player"];
nanofl_Player.init = function(canvas,library,framerate,scaleMode,textureAtlasesData) {
	if(scaleMode == null) scaleMode = "custom";
	if(framerate == null) framerate = 24.0;
	nanofl_Player.library = library;
	if(textureAtlasesData != null) {
		var _g = 0;
		while(_g < textureAtlasesData.length) {
			var textureAtlasData = textureAtlasesData[_g];
			++_g;
			var _g1 = 0;
			var _g2 = Reflect.fields(textureAtlasData);
			while(_g1 < _g2.length) {
				var namePath = _g2[_g1];
				++_g1;
				Reflect.setField(nanofl_Player.spriteSheets,namePath,new createjs.SpriteSheet(Reflect.field(textureAtlasData,namePath)));
			}
		}
	}
	createjs.Sound.alternateExtensions = ["ogg","mp3","wav"];
	createjs.Sound.registerSounds(library.getSounds().map(function(item) {
		return { src : item.getUrl(), id : item.linkage};
	}),null);
	library.preload(function() {
		nanofl_Player.stage = new nanofl_Stage(canvas);
		if(scaleMode != nanofl_engine_ScaleMode.custom) {
			var originalCanvasWidth = canvas.width;
			var originalCanvasHeight = canvas.height;
			window.addEventListener("resize",function() {
				nanofl_Player.resize(canvas,scaleMode,originalCanvasWidth,originalCanvasHeight);
			});
			nanofl_Player.resize(canvas,scaleMode,originalCanvasWidth,originalCanvasHeight);
		}
		nanofl_Player.stage.addChild(nanofl_Player.scene = library.getSceneInstance().createDisplayObject(null));
		nanofl_DisplayObjectTools.callMethod(nanofl_Player.scene,"init");
		nanofl_DisplayObjectTools.callMethod(nanofl_Player.scene,"onEnterFrame");
		nanofl_Player.stage.update();
		createjs.Ticker.framerate = framerate;
		createjs.Ticker.addEventListener("tick",function() {
			nanofl_Player.scene.advance();
			nanofl_DisplayObjectTools.callMethod(nanofl_Player.scene,"onEnterFrame");
			nanofl_Player.stage.update();
		});
	});
};
nanofl_Player.resize = function(canvas,scaleMode,originalCanvasWidth,originalCanvasHeight) {
	window.document.body.style.width = window.innerWidth + "px";
	window.document.body.style.height = window.innerHeight + "px";
	var kx;
	var ky;
	switch(scaleMode) {
	case "fit":
		kx = ky = Math.min(window.innerWidth / originalCanvasWidth,window.innerHeight / originalCanvasHeight);
		break;
	case "fill":
		kx = ky = Math.max(window.innerWidth / originalCanvasWidth,window.innerHeight / originalCanvasHeight);
		break;
	case "stretch":
		kx = window.innerWidth / originalCanvasWidth;
		ky = window.innerHeight / originalCanvasHeight;
		break;
	default:
		kx = ky = 1;
	}
	canvas.width = Math.round(originalCanvasWidth * kx);
	canvas.height = Math.round(originalCanvasHeight * ky);
	canvas.style.left = Math.round((window.innerWidth - canvas.width) / 2) + "px";
	canvas.style.top = Math.round((window.innerHeight - canvas.height) / 2) + "px";
	nanofl_Player.stage.scaleX = kx;
	nanofl_Player.stage.scaleY = ky;
};
var nanofl_SeamlessSoundLoop = $hx_exports.nanofl.SeamlessSoundLoop = function(sound) {
	this.n = 1;
	if(sound.duration == null || sound.duration == 0) return;
	if(nanofl_SeamlessSoundLoop.delay == null) nanofl_SeamlessSoundLoop.delay = this.detectDelay();
	this.sounds = [sound,createjs.Sound.createInstance(sound.src)];
	this.switchSound();
};
$hxClasses["nanofl.SeamlessSoundLoop"] = nanofl_SeamlessSoundLoop;
nanofl_SeamlessSoundLoop.__name__ = ["nanofl","SeamlessSoundLoop"];
nanofl_SeamlessSoundLoop.prototype = {
	sounds: null
	,timer: null
	,n: null
	,stop: function() {
		this.sounds[0].destroy();
		this.sounds[1].destroy();
		this.timer.stop();
	}
	,switchSound: function() {
		if(this.n == 1) this.n = 0; else this.n = 1;
		this.sounds[this.n].play();
		this.timer = haxe_Timer.delay($bind(this,this.switchSound),Math.round(this.sounds[0].duration));
	}
	,detectDelay: function() {
		var $window = window;
		var document = window.document;
		if($window.mozInnerScreenX != null && new EReg("firefox","i").match(window.navigator.userAgent)) return -25;
		if(document.all) return -30;
		if($window.chrome) return -25;
		if(new EReg("safari","i").match(window.navigator.userAgent) && $window.getComputedStyle && !$window.globalStorage) return -30;
		return 0;
	}
	,__class__: nanofl_SeamlessSoundLoop
};
var nanofl_SpriteButton = $hx_exports.nanofl.SpriteButton = function(spriteSheet) {
	createjs.Sprite.call(this,spriteSheet);
	this.stop();
	if(spriteSheet.getNumFrames() >= 4) this.hitArea = spriteSheet.getFrame(3);
	this.cursor = "pointer";
	var handler = (function(f1,f) {
		return function(e) {
			f1(f,e);
		};
	})($bind(this,this.stageMouseEventProxy),$bind(this,this.onMouseDown));
	nanofl_Player.stage.addEventListener("stagemousedown",handler,null);
	var handler1 = (function(f11,f2) {
		return function(e1) {
			f11(f2,e1);
		};
	})($bind(this,this.stageMouseEventProxy),$bind(this,this.onMouseMove));
	nanofl_Player.stage.addEventListener("stagemousemove",handler1,null);
	var handler2 = (function(f12,f3) {
		return function(e2) {
			f12(f3,e2);
		};
	})($bind(this,this.stageMouseEventProxy),$bind(this,this.onMouseUp));
	nanofl_Player.stage.addEventListener("stagemouseup",handler2,null);
};
$hxClasses["nanofl.SpriteButton"] = nanofl_SpriteButton;
nanofl_SpriteButton.__name__ = ["nanofl","SpriteButton"];
nanofl_SpriteButton.__super__ = createjs.Sprite;
nanofl_SpriteButton.prototype = $extend(createjs.Sprite.prototype,{
	onMouseDown: function(e) {
		if(this.spriteSheet.getNumFrames() >= 3 && this.currentFrame != 2) {
			if((this.hitArea != null?this.hitArea:this).hitTest(e.localX,e.localY)) this.gotoAndStop(2);
		}
	}
	,onMouseMove: function(e) {
		if(this.spriteSheet.getNumFrames() >= 2 && this.currentFrame != 2) this.gotoAndStop((this.hitArea != null?this.hitArea:this).hitTest(e.localX,e.localY)?1:0);
	}
	,onMouseUp: function(e) {
		if(this.spriteSheet.getNumFrames() > 0 && this.currentFrame != 0) this.gotoAndStop(0);
	}
	,stageMouseEventProxy: function(f,e) {
		var t = e.currentTarget;
		e.currentTarget = this;
		f(e);
		e.currentTarget = t;
	}
	,__class__: nanofl_SpriteButton
});
var nanofl_Stage = $hx_exports.nanofl.Stage = function(canvas) {
	createjs.Stage.call(this,canvas);
	this.tickOnUpdate = false;
	this.enableMouseOver(10);
};
$hxClasses["nanofl.Stage"] = nanofl_Stage;
nanofl_Stage.__name__ = ["nanofl","Stage"];
nanofl_Stage.__super__ = createjs.Stage;
nanofl_Stage.prototype = $extend(createjs.Stage.prototype,{
	update: function(params) {
		nanofl_DisplayObjectTools.smartCache(this);
		createjs.Stage.prototype.update.call(this,params);
	}
	,__class__: nanofl_Stage
});
var nanofl_TextField = $hx_exports.nanofl.TextField = function(width,height,selectable,border,dashedBorder,textRuns,newTextFormat) {
	if(dashedBorder == null) dashedBorder = false;
	if(border == null) border = false;
	if(selectable == null) selectable = false;
	if(height == null) height = 0.0;
	if(width == null) width = 0.0;
	this._dashedBorder = false;
	this._border = false;
	var _g = this;
	Object.defineProperty(this,"minWidth",{ get : function() {
		return _g.get_minWidth();
	}});
	Object.defineProperty(this,"minHeight",{ get : function() {
		return _g.get_minHeight();
	}});
	Object.defineProperty(this,"width",{ get : function() {
		return _g.get_width();
	}, set : function(v) {
		_g.set_width(v);
	}});
	Object.defineProperty(this,"height",{ get : function() {
		return _g.get_height();
	}, set : function(v1) {
		_g.set_height(v1);
	}});
	Object.defineProperty(this,"border",{ get : function() {
		return _g.get_border();
	}, set : function(v2) {
		_g.set_border(v2);
	}});
	Object.defineProperty(this,"dashedBorder",{ get : function() {
		return _g.get_dashedBorder();
	}, set : function(v3) {
		_g.set_dashedBorder(v3);
	}});
	Object.defineProperty(this,"newTextFormat",{ get : function() {
		return _g.get_newTextFormat();
	}, set : function(v4) {
		_g.set_newTextFormat(v4);
	}});
	Object.defineProperty(this,"text",{ get : function() {
		return _g.get_text();
	}, set : function(v5) {
		_g.set_text(v5);
	}});
	nanofl_SolidContainer.call(this);
	this.width = width;
	this.height = height;
	this.selectable = selectable;
	this.border = border;
	this.dashedBorder = dashedBorder;
	if(textRuns != null) this.textRuns = textRuns; else this.textRuns = [];
	this.newTextFormat = newTextFormat;
	this.resize = new stdlib_Event(this);
	this.change = new stdlib_Event(this);
	var _g1 = 0;
	var _g11 = this.textRuns;
	while(_g1 < _g11.length) {
		var textRun = _g11[_g1];
		++_g1;
		textRun.characters = StringTools.replace(StringTools.replace(textRun.characters,"\r\n","\n"),"\r","\n");
	}
	this.textLines = [];
	this.addChild(this.globalBackground = new createjs.Shape());
	this.addChild(this.background = new createjs.Shape());
	this.addChild(this.textsContainer = new createjs.Container());
	this.addChild(this.borders = new createjs.Shape());
	this.addChild(this.caret = new createjs.Shape());
	this.hitBox = new createjs.Shape();
	this.optionsChanged();
};
$hxClasses["nanofl.TextField"] = nanofl_TextField;
nanofl_TextField.__name__ = ["nanofl","TextField"];
nanofl_TextField.measureFontHeight = function(family,style,size) {
	var key = family + "|" + style + "|" + size;
	if(nanofl_TextField.fontHeightCache.exists(key)) return nanofl_TextField.fontHeightCache.get(key);
	var div = window.document.createElement("div");
	div.innerHTML = "Mp";
	div.style.position = "absolute";
	div.style.top = "0";
	div.style.left = "0";
	div.style.fontFamily = family;
	if(style.indexOf("bold") >= 0) div.style.fontWeight = "bold"; else div.style.fontWeight = "normal";
	if(style.indexOf("italic") >= 0) div.style.fontStyle = "italic"; else div.style.fontStyle = "normal";
	div.style.fontSize = size + "px";
	div.style.lineHeight = "normal";
	if(window.document.body == null) window.document.body = window.document.querySelector("body");
	window.document.body.appendChild(div);
	var r = div.offsetHeight;
	window.document.body.removeChild(div);
	nanofl_TextField.fontHeightCache.set(key,r);
	return r;
};
nanofl_TextField.measureFontBaselineCoef = function(family,style) {
	var key = family + "|" + style;
	if(nanofl_TextField.fontBaselineCoefCache.exists(key)) return nanofl_TextField.fontBaselineCoefCache.get(key);
	var container = window.document.createElement("div");
	container.style.height = "100px";
	container.style.position = "absolute";
	container.style.top = "0";
	container.style.left = "0";
	var letter = window.document.createElement("span");
	letter.style.fontFamily = family;
	if(style.indexOf("bold") >= 0) letter.style.fontWeight = "bold"; else letter.style.fontWeight = "normal";
	if(style.indexOf("italic") >= 0) letter.style.fontStyle = "italic"; else letter.style.fontStyle = "normal";
	letter.style.fontSize = "100px";
	letter.style.lineHeight = "0";
	letter.innerHTML = "A";
	var strut = window.document.createElement("span");
	strut.style.fontFamily = family;
	if(style.indexOf("bold") >= 0) strut.style.fontWeight = "bold"; else strut.style.fontWeight = "normal";
	if(style.indexOf("italic") >= 0) strut.style.fontStyle = "italic"; else strut.style.fontStyle = "normal";
	strut.style.fontSize = "999px";
	strut.style.lineHeight = "normal";
	strut.style.display = "inline-block";
	strut.style.height = "100px";
	strut.innerHTML = "";
	container.appendChild(letter);
	container.appendChild(strut);
	window.document.body.appendChild(container);
	var r = 1 - (letter.offsetTop + letter.offsetHeight - container.offsetHeight - container.offsetTop) / 100;
	container.remove();
	nanofl_TextField.fontBaselineCoefCache.set(key,r);
	return r;
};
nanofl_TextField.log = function(v,infos) {
};
nanofl_TextField.__super__ = nanofl_SolidContainer;
nanofl_TextField.prototype = $extend(nanofl_SolidContainer.prototype,{
	_minWidth: null
	,minWidth: null
	,get_minWidth: function() {
		this.update();
		return this._minWidth;
	}
	,_minHeight: null
	,minHeight: null
	,get_minHeight: function() {
		this.update();
		return this._minHeight;
	}
	,_width: null
	,width: null
	,get_width: function() {
		return this._width;
	}
	,set_width: function(v) {
		if(this._width != v) {
			this._width = v;
			this.needUpdate = true;
		}
		return v;
	}
	,_height: null
	,height: null
	,get_height: function() {
		return this._height;
	}
	,set_height: function(v) {
		if(this._height != v) {
			this._height = v;
			this.needUpdate = true;
		}
		return v;
	}
	,selectable: null
	,_border: null
	,border: null
	,get_border: function() {
		return this._border;
	}
	,set_border: function(v) {
		if(this._border != v) {
			this._border = v;
			this.optionsChanged();
		}
		return v;
	}
	,_dashedBorder: null
	,dashedBorder: null
	,get_dashedBorder: function() {
		return this._dashedBorder;
	}
	,set_dashedBorder: function(v) {
		if(this._dashedBorder != v) {
			this._dashedBorder = v;
			this.optionsChanged();
		}
		return v;
	}
	,textRunsOnLastUpdate: null
	,textRuns: null
	,needUpdate: null
	,textLines: null
	,_newTextFormat: null
	,newTextFormat: null
	,get_newTextFormat: function() {
		return this._newTextFormat;
	}
	,set_newTextFormat: function(format) {
		return format != null?this._newTextFormat = format:this._newTextFormat = new nanofl_TextRun();
	}
	,globalBackground: null
	,background: null
	,textsContainer: null
	,borders: null
	,caret: null
	,hitBox: null
	,resize: null
	,change: null
	,text: null
	,get_text: function() {
		return this.textRuns.map(function(run) {
			return run.characters;
		}).join("");
	}
	,set_text: function(v) {
		if(this.textRuns.length > 0) this.newTextFormat = this.textRuns[0];
		this.textRuns.splice(0,this.textRuns.length);
		this.textRuns.push(this.newTextFormat.duplicate(v));
		return v;
	}
	,getSplittedByPosition: function(runs,position,textToInsert) {
		if(textToInsert == null) textToInsert = "";
		var r = [];
		if(position > 0) {
			var charIndex = 0;
			var _g = 0;
			while(_g < runs.length) {
				var run = runs[_g];
				++_g;
				var len = run.characters.length;
				if(position > charIndex && position < charIndex + len) {
					r.push(run.duplicate(HxOverrides.substr(run.characters,0,position - charIndex)));
					if(textToInsert.length > 0) r.push(run.duplicate(textToInsert));
					r.push(run.duplicate(HxOverrides.substr(run.characters,position - charIndex,len - (position - charIndex))));
					len += textToInsert.length;
				} else {
					r.push(run.clone());
					if(position == charIndex + len) {
						if(textToInsert.length > 0) {
							r.push(run.duplicate(textToInsert));
							len += textToInsert.length;
						}
					}
				}
				charIndex += len;
			}
		} else {
			if(textToInsert.length > 0) r.push(runs.length > 0?runs[0].duplicate(textToInsert):this.newTextFormat.duplicate(textToInsert));
			var _g1 = 0;
			while(_g1 < runs.length) {
				var run1 = runs[_g1];
				++_g1;
				r.push(run1);
			}
		}
		return r;
	}
	,getSplittedToLines: function(runs) {
		var runLines = [];
		var runLine = [];
		var _g = 0;
		while(_g < runs.length) {
			var run = runs[_g];
			++_g;
			var lines = run.characters.split("\n");
			if(lines.length == 1) {
				if(run.characters != "") runLine.push(run);
			} else {
				var _g2 = 0;
				var _g1 = lines.length;
				while(_g2 < _g1) {
					var i = _g2++;
					if(lines[i] != "") runLine.push(run.duplicate(lines[i]));
					if(i < lines.length - 1) {
						runLine.push(run.duplicate(" "));
						runLines.push(runLine);
						runLine = [];
					}
				}
			}
		}
		if(runLine.length == 0) runLine.push(runs.length > 0?runs[runs.length - 1].duplicate(" "):this.newTextFormat.duplicate(" "));
		runLines.push(runLine);
		return runLines;
	}
	,getTextLines: function() {
		var runs = this.textRuns.slice();
		if(this.selectable && !this.dashedBorder) {
			runs = this.getSplittedByPosition(runs,0);
		}
		var lines = this.getSplittedToLines(runs);
		var r = [];
		var charIndex = 0;
		var _g1 = 0;
		var _g = lines.length;
		while(_g1 < _g) {
			var i = _g1++;
			var runsLine = [[]];
			var _g2 = 0;
			var _g3 = lines[i];
			while(_g2 < _g3.length) {
				var run = [_g3[_g2]];
				++_g2;
				if(run[0].kerning) runsLine[0].push(run[0]); else haxe_Utf8.iter(run[0].characters,(function(run,runsLine) {
					return function(c) {
						var s = new haxe_Utf8();
						s.__b += String.fromCharCode(c);
						runsLine[0].push(run[0].duplicate(s.__b));
					};
				})(run,runsLine));
			}
			var lineWidth = 0.0;
			var lineMinY = 1.0e10;
			var lineMaxY = -1.0e10;
			var lineSpacing = null;
			var chunks = [];
			var _g31 = 0;
			var _g21 = runsLine[0].length;
			while(_g31 < _g21) {
				var j = _g31++;
				var run1 = runsLine[0][j];
				var selected = this.selectable && !this.dashedBorder && charIndex >= 0 && charIndex < 0;
				var text = this.createFirstText(run1,selected);
				var bounds = text.getBounds();
				var fontHeight = nanofl_TextField.measureFontHeight(run1.family,run1.style,run1.size);
				var fontBaselineCoef = nanofl_TextField.measureFontBaselineCoef(run1.family,run1.style);
				stdlib_Debug.assert(run1.letterSpacing != null,null,{ fileName : "TextField.hx", lineNumber : 290, className : "nanofl.TextField", methodName : "getTextLines"});
				text.setBounds(bounds.x,-fontHeight * fontBaselineCoef,bounds.width + (!run1.kerning?run1.letterSpacing:0),fontHeight);
				bounds = text.getBounds();
				if(i == lines.length - 1 || j < runsLine[0].length - 1) lineWidth += bounds.width;
				lineMinY = Math.min(lineMinY,bounds.y);
				lineMaxY = Math.max(lineMaxY,bounds.y + bounds.height);
				stdlib_Debug.assert(run1.lineSpacing != null,null,{ fileName : "TextField.hx", lineNumber : 308, className : "nanofl.TextField", methodName : "getTextLines"});
				if(lineSpacing != null) lineSpacing = Math.max(lineSpacing,run1.lineSpacing); else lineSpacing = run1.lineSpacing;
				chunks.push({ text : text, textSecond : this.createSecondText(run1,selected), charIndex : charIndex, bounds : bounds, backgroundColor : !selected?run1.backgroundColor:"darkblue", format : run1});
				charIndex += run1.characters.length;
			}
			r.push({ chunks : chunks, width : lineWidth, minY : lineMinY, maxY : lineMaxY, align : StringTools.trim(runsLine[0][0].align).toLowerCase(), spacing : lineSpacing - 2});
		}
		return r;
	}
	,update: function() {
		if(!this.needUpdate && !this.isTextChanged()) return;
		this.needUpdate = false;
		nanofl_TextRun.optimize(this.textRuns);
		this.textRunsOnLastUpdate = this.textRuns.map(function(t) {
			return t.clone();
		});
		this.globalBackground.visible = false;
		this.borders.visible = false;
		var sizeChanged = false;
		this.textLines = this.getTextLines();
		this._minWidth = 0.0;
		this._minHeight = nanofl_TextField.PADDING * 2;
		var _g = 0;
		var _g1 = this.textLines;
		while(_g < _g1.length) {
			var line = _g1[_g];
			++_g;
			this._minWidth = Math.max(this._minWidth,line.width + nanofl_TextField.PADDING * 2);
			if(this._minWidth > this.width) {
				var _g2 = line.align;
				switch(_g2) {
				case "center":
					this.x -= (line.width - (this.width - nanofl_TextField.PADDING * 2)) / 2;
					break;
				case "right":
					this.x -= line.width - (this.width - nanofl_TextField.PADDING * 2);
					break;
				}
				this.width = line.width + nanofl_TextField.PADDING * 2;
				sizeChanged = true;
			}
			this._minHeight += line.maxY - line.minY + line.spacing;
		}
		if(this.textLines.length > 0) this._minHeight -= this.textLines[this.textLines.length - 1].spacing;
		if(this._minHeight > this.height) {
			this.height = this._minHeight;
			sizeChanged = true;
		}
		this.textsContainer.removeAllChildren();
		this.background.graphics.clear();
		var innerY = nanofl_TextField.PADDING;
		var _g11 = 0;
		var _g3 = this.textLines.length;
		while(_g11 < _g3) {
			var i = _g11++;
			var line1 = this.textLines[i];
			var innerX;
			innerX = nanofl_TextField.PADDING + (function($this) {
				var $r;
				var _g21 = line1.align;
				$r = (function($this) {
					var $r;
					switch(_g21) {
					case "center":
						$r = ($this.width - nanofl_TextField.PADDING * 2 - line1.width) / 2.0;
						break;
					case "right":
						$r = $this.width - nanofl_TextField.PADDING * 2 - line1.width;
						break;
					default:
						$r = 0.0;
					}
					return $r;
				}($this));
				return $r;
			}(this));
			var _g22 = 0;
			var _g31 = line1.chunks;
			while(_g22 < _g31.length) {
				var t1 = _g31[_g22];
				++_g22;
				if(t1.textSecond != null) this.textsContainer.addChild(t1.textSecond);
				this.textsContainer.addChild(t1.text);
				t1.text.x = innerX;
				t1.text.y = innerY - line1.minY;
				if(t1.backgroundColor != null) this.background.graphics.beginFill(t1.backgroundColor).rect(t1.text.x + t1.bounds.x,t1.text.y + line1.minY,t1.bounds.width,line1.maxY - line1.minY).endFill();
				if(t1.textSecond != null) {
					t1.textSecond.x = t1.text.x;
					t1.textSecond.y = t1.text.y;
				}
				innerX += t1.bounds.width;
			}
			innerY += line1.maxY - line1.minY + line1.spacing;
		}
		if(this.border || this.dashedBorder) {
			var pt0 = this.localToGlobal(0,0);
			pt0 = this.globalToLocal(Math.round(pt0.x) + 0.5,Math.round(pt0.y) + 0.5);
			var pt1 = this.localToGlobal(this.width,this.height);
			pt1 = this.globalToLocal(Math.round(pt1.x) + 0.5,Math.round(pt1.y) + 0.5);
			if(this.border) {
				this.globalBackground.visible = true;
				this.globalBackground.graphics.clear().beginFill("#FFFFFF").rect(pt0.x,pt0.y,pt1.x - pt0.x,pt1.y - pt0.y).endFill();
			}
			this.drawBorders(pt0,pt1);
		}
		if(sizeChanged) this.resize.call({ width : this.width, height : this.height});
		this.updateHitArea();
		this.setBounds(0,0,this.width,this.height);
	}
	,draw: function(ctx,ignoreCache) {
		this.update();
		return nanofl_SolidContainer.prototype.draw.call(this,ctx,ignoreCache);
	}
	,drawBorders: function(pt0,pt1) {
		if(this.border) {
			this.borders.visible = true;
			this.borders.graphics.clear().setStrokeStyle(1.0,null,null,null,true).beginStroke("#000000").rect(pt0.x,pt0.y,pt1.x - pt0.x,pt1.y - pt0.y).endStroke();
		} else if(this.dashedBorder) {
			this.borders.visible = true;
			var dashPt0 = this.globalToLocal(0,0);
			var dashPt1 = this.globalToLocal(2,2);
			var dashLen = (Math.abs(dashPt1.x - dashPt0.x) + Math.abs(dashPt1.y - dashPt0.y)) / 2;
			nanofl_engine_RenderTools.drawDashedRect(this.borders.graphics.clear().setStrokeStyle(1.0,null,null,null,true),pt0.x,pt0.y,pt1.x,pt1.y,"#000000","#FFFFFF",dashLen);
		}
	}
	,updateHitArea: function() {
		this.hitBox.graphics.clear().beginFill("#000000").rect(0,0,this.width,this.height).endFill();
	}
	,optionsChanged: function() {
		this.hitArea = this.hitBox;
		this.needUpdate = true;
	}
	,updateStage: function() {
		this.update();
		if(this.stage != null) this.stage.update();
	}
	,isTextChanged: function() {
		if(this.textRunsOnLastUpdate.length != this.textRuns.length) return true;
		var _g1 = 0;
		var _g = this.textRuns.length;
		while(_g1 < _g) {
			var i = _g1++;
			if(!this.textRunsOnLastUpdate[i].equ(this.textRuns[i])) return true;
		}
		return false;
	}
	,createFirstText: function(run,selected) {
		if(!selected && run.isStroked()) return run.createText(run.strokeColor,run.strokeSize); else return run.createText(!selected?run.fillColor:"white");
	}
	,createSecondText: function(run,selected) {
		if(!selected && run.isFilled() && run.isStroked()) return run.createText(); else return null;
	}
	,clone: function(recursive) {
		return this._cloneProps(new nanofl_TextField(this.width,this.height,this.selectable,this.border,this.dashedBorder,recursive?this.textRuns.map(function(t) {
			return t.clone();
		}):this.textRuns,recursive && this.newTextFormat != null?this.newTextFormat.clone():this.newTextFormat));
	}
	,hxUnserialize: function(s) {
		var _g = this;
		Object.defineProperty(this,"minWidth",{ get : function() {
			return _g.get_minWidth();
		}});
		Object.defineProperty(this,"minHeight",{ get : function() {
			return _g.get_minHeight();
		}});
		Object.defineProperty(this,"width",{ get : function() {
			return _g.get_width();
		}, set : function(v) {
			_g.set_width(v);
		}});
		Object.defineProperty(this,"height",{ get : function() {
			return _g.get_height();
		}, set : function(v1) {
			_g.set_height(v1);
		}});
		Object.defineProperty(this,"border",{ get : function() {
			return _g.get_border();
		}, set : function(v2) {
			_g.set_border(v2);
		}});
		Object.defineProperty(this,"dashedBorder",{ get : function() {
			return _g.get_dashedBorder();
		}, set : function(v3) {
			_g.set_dashedBorder(v3);
		}});
		Object.defineProperty(this,"newTextFormat",{ get : function() {
			return _g.get_newTextFormat();
		}, set : function(v4) {
			_g.set_newTextFormat(v4);
		}});
		Object.defineProperty(this,"text",{ get : function() {
			return _g.get_text();
		}, set : function(v5) {
			_g.set_text(v5);
		}});
		s.unserializeObject(this);
	}
	,hxSerialize: function(s) {
		s.serializeFields(this);
	}
	,__class__: nanofl_TextField
});
var nanofl_TextRun = $hx_exports.nanofl.TextRun = function(characters,fillColor,size) {
	if(size == null) size = 12.0;
	if(fillColor == null) fillColor = "#000000";
	if(characters == null) characters = "";
	this.lineSpacing = 2.0;
	this.letterSpacing = 0.0;
	this.kerning = true;
	this.strokeColor = "#000000";
	this.strokeSize = 0.0;
	this.align = "left";
	this.style = "";
	this.family = "Times";
	this.characters = characters;
	this.fillColor = fillColor;
	this.size = size;
};
$hxClasses["nanofl.TextRun"] = nanofl_TextRun;
nanofl_TextRun.__name__ = ["nanofl","TextRun"];
nanofl_TextRun.create = function(characters,fillColor,family,style,size,align,strokeSize,strokeColor,kerning,letterSpacing,lineSpacing) {
	var r = new nanofl_TextRun();
	r.characters = characters;
	r.fillColor = fillColor;
	r.family = family;
	r.style = style;
	r.size = size;
	r.align = align;
	r.strokeSize = strokeSize;
	r.strokeColor = strokeColor;
	r.kerning = kerning;
	r.letterSpacing = letterSpacing;
	r.lineSpacing = lineSpacing;
	return r;
};
nanofl_TextRun.optimize = function(textRuns) {
	var i = 0;
	while(i < textRuns.length - 1) if(textRuns[i].equFormat(textRuns[i + 1])) {
		textRuns[i].characters += textRuns[i + 1].characters;
		textRuns.splice(i + 1,1);
	} else i++;
	return textRuns;
};
nanofl_TextRun.prototype = {
	characters: null
	,fillColor: null
	,family: null
	,style: null
	,size: null
	,align: null
	,strokeSize: null
	,strokeColor: null
	,kerning: null
	,letterSpacing: null
	,lineSpacing: null
	,backgroundColor: null
	,getFontString: function() {
		return StringTools.trim((this.style != null?this.style:"") + " " + (this.size != null?this.size + "px":"") + " " + (this.family != null && this.family != ""?this.family:"serif"));
	}
	,clone: function() {
		return this.duplicate();
	}
	,duplicate: function(characters) {
		var r = nanofl_TextRun.create(characters != null?characters:this.characters,this.fillColor,this.family,this.style,this.size,this.align,this.strokeSize,this.strokeColor,this.kerning,this.letterSpacing,this.lineSpacing);
		r.backgroundColor = this.backgroundColor;
		return r;
	}
	,equ: function(textRun) {
		return this.characters == textRun.characters && this.equFormat(textRun);
	}
	,createText: function(color,outline) {
		var r = new createjs.Text(this.characters,this.getFontString(),color != null?color:this.fillColor);
		if(outline != null) r.outline = outline;
		r.textBaseline = "alphabetic";
		r.textAlign = "left";
		return r;
	}
	,isFilled: function() {
		return !this.isEmptyColor(this.fillColor);
	}
	,isStroked: function() {
		return this.strokeSize != null && this.strokeSize != 0 && !this.isEmptyColor(this.strokeColor);
	}
	,isEmptyColor: function(s) {
		return s == null || s == "" || s == "transparent" || s == "none" || new EReg("^\\s*rgba\\s*\\(\\s*\\d+\\s*,\\s*\\d+\\s*,\\s*\\d+\\s*,\\s*0(?:\\.0)?\\s*\\)$","i").match(s);
	}
	,equFormat: function(format) {
		return this.fillColor == format.fillColor && this.family == format.family && this.style == format.style && this.size == format.size && this.align == format.align && this.strokeSize == format.strokeSize && this.strokeColor == format.strokeColor && this.kerning == format.kerning && this.letterSpacing == format.letterSpacing && this.lineSpacing == format.lineSpacing;
	}
	,__class__: nanofl_TextRun
};
var nanofl_engine_ArrayTools = function() { };
$hxClasses["nanofl.engine.ArrayTools"] = nanofl_engine_ArrayTools;
nanofl_engine_ArrayTools.__name__ = ["nanofl","engine","ArrayTools"];
nanofl_engine_ArrayTools.equ = function(a,b) {
	if(a.length != b.length) return false;
	var _g1 = 0;
	var _g = a.length;
	while(_g1 < _g) {
		var i = _g1++;
		if(a[i] == null && b[i] != null) return false;
		if(a[i] != null && b[i] == null) return false;
		if(a[i] != null && !a[i].equ(b[i])) return false;
	}
	return true;
};
nanofl_engine_ArrayTools.clone = function(array) {
	var r = [];
	var _g = 0;
	while(_g < array.length) {
		var item = array[_g];
		++_g;
		r.push(item.clone());
	}
	return r;
};
nanofl_engine_ArrayTools.swap = function(arr,i,j) {
	var z = arr[i];
	arr[i] = arr[j];
	arr[j] = z;
};
nanofl_engine_ArrayTools.equFast = function(a,b) {
	if(a.length != b.length) return false;
	var _g1 = 0;
	var _g = a.length;
	while(_g1 < _g) {
		var i = _g1++;
		if(a[i] != b[i]) return false;
	}
	return true;
};
nanofl_engine_ArrayTools.appendUniqueFast = function(accum,items) {
	var _g = 0;
	while(_g < items.length) {
		var item = items[_g];
		++_g;
		if(HxOverrides.indexOf(accum,item,0) < 0) accum.push(item);
	}
	return accum;
};
nanofl_engine_ArrayTools.fromBytes = function(data) {
	return Array.prototype.slice.call(data.b);
};
var nanofl_engine_ColorTools = $hx_exports.nanofl.engine.ColorTools = function() { };
$hxClasses["nanofl.engine.ColorTools"] = nanofl_engine_ColorTools;
nanofl_engine_ColorTools.__name__ = ["nanofl","engine","ColorTools"];
nanofl_engine_ColorTools.parse = function(s) {
	nanofl_engine_ColorTools.log("parse color " + s,{ fileName : "ColorTools.hx", lineNumber : 45, className : "nanofl.engine.ColorTools", methodName : "parse"});
	var r = -1;
	var g = -1;
	var b = -1;
	var a = 1.0;
	s = StringTools.replace(s," ","");
	if(Reflect.hasField(nanofl_engine_ColorTools.colors,s.toLowerCase())) s = Reflect.field(nanofl_engine_ColorTools.colors,s.toLowerCase());
	var reRGB = new EReg("^rgb\\(([0-9]+),([0-9]+),([0-9]+)\\)$","i");
	var reRGBA = new EReg("^rgba\\(([0-9]+),([0-9]+),([0-9]+),([0-9.e+-]+)\\)$","i");
	if(new EReg("^#?[0-9A-F]{6}$","i").match(s)) {
		if(StringTools.startsWith(s,"#")) s = HxOverrides.substr(s,1,null);
		r = Std.parseInt("0x" + HxOverrides.substr(s,0,2));
		g = Std.parseInt("0x" + HxOverrides.substr(s,2,2));
		b = Std.parseInt("0x" + HxOverrides.substr(s,4,2));
	} else if(new EReg("^#?[0-9A-F]{3}$","i").match(s)) {
		if(StringTools.startsWith(s,"#")) s = HxOverrides.substr(s,1,null);
		r = Std.parseInt("0x" + HxOverrides.substr(s,0,1) + HxOverrides.substr(s,0,1));
		g = Std.parseInt("0x" + HxOverrides.substr(s,1,1) + HxOverrides.substr(s,1,1));
		b = Std.parseInt("0x" + HxOverrides.substr(s,2,1) + HxOverrides.substr(s,2,1));
	} else if(reRGB.match(s)) {
		r = Std.parseInt(reRGB.matched(1));
		g = Std.parseInt(reRGB.matched(2));
		b = Std.parseInt(reRGB.matched(3));
	} else if(reRGBA.match(s)) {
		r = Std.parseInt(reRGBA.matched(1));
		g = Std.parseInt(reRGBA.matched(2));
		b = Std.parseInt(reRGBA.matched(3));
		a = Std.parseFloat(reRGBA.matched(4));
	}
	if(r >= 0 && g >= 0 && b >= 0) return { r : r, g : g, b : b, a : a};
	return null;
};
nanofl_engine_ColorTools.joinStringAndAlpha = function(color,alpha) {
	var rgba = nanofl_engine_ColorTools.parse(color);
	if(rgba != null) {
		if(alpha != null) rgba.a = alpha;
		return nanofl_engine_ColorTools.rgbaToString(rgba);
	}
	return null;
};
nanofl_engine_ColorTools.stringToNumber = function(color,defValue) {
	var rgba = nanofl_engine_ColorTools.parse(color);
	if(rgba != null) return nanofl_engine_ColorTools.rgbaToNumber(rgba); else return defValue;
};
nanofl_engine_ColorTools.rgbaToString = function(rgba) {
	if(rgba.a == null || rgba.a == 1.0) return "#" + StringTools.hex(rgba.r,2) + StringTools.hex(rgba.g,2) + StringTools.hex(rgba.b,2); else return "rgba(" + rgba.r + "," + rgba.g + "," + rgba.b + "," + rgba.a + ")";
};
nanofl_engine_ColorTools.rgbaToNumber = function(rgba) {
	if(rgba.a == null || rgba.a == 1.0) return rgba.r << 16 | rgba.g << 8 | rgba.b; else return Math.round(rgba.a * 255) << 24 | rgba.r << 16 | rgba.g << 8 | rgba.b;
};
nanofl_engine_ColorTools.rgbToHsl = function(rgb) {
	var r = rgb.r / 255;
	var g = rgb.g / 255;
	var b = rgb.b / 255;
	var max = Math.max(r,Math.max(g,b));
	var min = Math.min(r,Math.min(g,b));
	var h;
	var s;
	var l = (max + min) / 2;
	if(max == min) h = s = 0.0; else {
		var d = max - min;
		if(l > 0.5) s = d / (2 - max - min); else s = d / (max + min);
		if(max == r) h = (g - b) / d + (g < b?6:0); else if(max == g) h = (b - r) / d + 2; else h = (r - g) / d + 4;
		h /= 6;
	}
	return { h : h, s : s, l : l};
};
nanofl_engine_ColorTools.hslToRgb = function(hsl) {
	var r;
	var g;
	var b;
	if(hsl.s == 0.0) r = g = b = hsl.l; else {
		var hue2rgb = function(p,q,t) {
			if(t < 0) t += 1;
			if(t > 1) t -= 1;
			if(t < 0.16666666666666666) return p + (q - p) * 6 * t;
			if(t < 0.5) return q;
			if(t < 0.66666666666666663) return p + (q - p) * (0.66666666666666663 - t) * 6;
			return p;
		};
		var q1;
		if(hsl.l < 0.5) q1 = hsl.l * (1 + hsl.s); else q1 = hsl.l + hsl.s - hsl.l * hsl.s;
		var p1 = 2 * hsl.l - q1;
		r = hue2rgb(p1,q1,hsl.h + 0.33333333333333331);
		g = hue2rgb(p1,q1,hsl.h);
		b = hue2rgb(p1,q1,hsl.h - 0.33333333333333331);
	}
	return { r : r * 255 | 0, g : g * 255 | 0, b : b * 255 | 0};
};
nanofl_engine_ColorTools.rgbToHsv = function(rgb) {
	var r = rgb.r / 255;
	var g = rgb.g / 255;
	var b = rgb.b / 255;
	var max = Math.max(r,Math.max(g,b));
	var min = Math.min(r,Math.min(g,b));
	var h;
	var s;
	var v = max;
	var d = max - min;
	if(max == 0) s = 0; else s = d / max;
	if(max == min) h = 0; else {
		if(max == r) h = (g - b) / d + (g < b?6:0); else if(max == g) h = (b - r) / d + 2; else h = (r - g) / d + 4;
		h /= 6;
	}
	return { h : h, s : s, v : v};
};
nanofl_engine_ColorTools.hsvToRgb = function(hsv) {
	var r;
	var g;
	var b;
	var i = Math.floor(hsv.h * 6);
	var f = hsv.h * 6 - i;
	var p = hsv.v * (1 - hsv.s);
	var q = hsv.v * (1 - f * hsv.s);
	var t = hsv.v * (1 - (1 - f) * hsv.s);
	var _g = i % 6;
	switch(_g) {
	case 0:
		r = hsv.v;
		g = t;
		b = p;
		break;
	case 1:
		r = q;
		g = hsv.v;
		b = p;
		break;
	case 2:
		r = p;
		g = hsv.v;
		b = t;
		break;
	case 3:
		r = p;
		g = q;
		b = hsv.v;
		break;
	case 4:
		r = t;
		g = p;
		b = hsv.v;
		break;
	default:
		r = hsv.v;
		g = p;
		b = q;
	}
	return { r : r * 255 | 0, g : g * 255 | 0, b : b * 255 | 0};
};
nanofl_engine_ColorTools.tweenRgba = function(start,finish,t) {
	var r = nanofl_engine_ColorTools.hslToRgb(nanofl_engine_ColorTools.tweenHsl(nanofl_engine_ColorTools.rgbToHsl(start),nanofl_engine_ColorTools.rgbToHsl(finish),t));
	if(start.a != null || finish.a != null) {
		var a1;
		if(start.a != null) a1 = start.a; else a1 = 1.0;
		var a2;
		if(finish.a != null) a2 = finish.a; else a2 = 1.0;
		r.a = a1 + (a2 - a1) * t;
	}
	return r;
};
nanofl_engine_ColorTools.tweenHsl = function(start,finish,t) {
	return { h : start.h + (finish.h - start.h) * t, s : start.s + (finish.s - start.s) * t, l : start.l + (finish.l - start.l) * t};
};
nanofl_engine_ColorTools.normalize = function(s) {
	if(s == null) return null;
	if(s == "") return "";
	return nanofl_engine_ColorTools.rgbaToString(nanofl_engine_ColorTools.parse(s));
};
nanofl_engine_ColorTools.getTweened = function(start,k,finish) {
	var rgbaStart = nanofl_engine_ColorTools.parse(start);
	var rgbaFinish = nanofl_engine_ColorTools.parse(finish);
	return nanofl_engine_ColorTools.rgbaToString({ r : rgbaStart.r + Math.round((rgbaFinish.r - rgbaStart.r) * k), g : rgbaStart.g + Math.round((rgbaFinish.g - rgbaStart.g) * k), b : rgbaStart.b + Math.round((rgbaFinish.b - rgbaStart.b) * k), a : rgbaStart.a + (rgbaFinish.a - rgbaStart.a) * k});
};
nanofl_engine_ColorTools.log = function(v,infos) {
};
var nanofl_engine_Console = function() {
};
$hxClasses["nanofl.engine.Console"] = nanofl_engine_Console;
nanofl_engine_Console.__name__ = ["nanofl","engine","Console"];
nanofl_engine_Console.filter = function(method,filter) {
	if(window.console == null) return null;
	var r = Reflect.field(window.console,method);
	Reflect.setField(window.console,method,nanofl_engine_Console.getFilterFunction(r,filter));
	return r;
};
nanofl_engine_Console.getFilterFunction = function(oldConsoleMethod,filter) {
	return Reflect.makeVarArgs(function(args) {
		if(filter(args)) Reflect.callMethod(window.console,oldConsoleMethod,args);
	});
};
nanofl_engine_Console.prototype = {
	log: function(v) {
		window.console.log(v);
	}
	,info: function(v) {
		window.console.info(v);
	}
	,warn: function(v) {
		window.console.warn(v);
	}
	,error: function(v) {
		window.console.error(v);
	}
	,__class__: nanofl_engine_Console
};
var nanofl_engine_CustomPropertiesTools = function() { };
$hxClasses["nanofl.engine.CustomPropertiesTools"] = nanofl_engine_CustomPropertiesTools;
nanofl_engine_CustomPropertiesTools.__name__ = ["nanofl","engine","CustomPropertiesTools"];
nanofl_engine_CustomPropertiesTools.equ = function(params1,params2) {
	var fields1 = Reflect.fields(params1);
	var fields2 = Reflect.fields(params2);
	if(fields1.length != fields2.length) return false;
	fields1.sort(Reflect.compare);
	fields2.sort(Reflect.compare);
	var _g1 = 0;
	var _g = fields1.length;
	while(_g1 < _g) {
		var i = _g1++;
		if(fields1[i] != fields2[i]) return false;
		if(Reflect.field(params1,fields1[i]) != Reflect.field(params2,fields1[i])) return false;
	}
	return true;
};
nanofl_engine_CustomPropertiesTools.tween = function(start,t,finish,properties) {
	if(t == 0.0 || properties == null) return;
	var _g = 0;
	while(_g < properties.length) {
		var p = properties[_g];
		++_g;
		if(p.type == "delimiter" || p.type == "info") continue;
		var startV = Reflect.field(start,p.name);
		var finishV;
		if(finish != null) finishV = Reflect.field(finish,p.name); else if(p.neutralValue != null) finishV = p.neutralValue; else finishV = startV;
		var _g1 = p.type.toLowerCase();
		switch(_g1) {
		case "int":case "float":
			start[p.name] = startV + (finishV - startV) * t;
			break;
		case "color":
			Reflect.setField(start,p.name,nanofl_engine_ColorTools.rgbaToString(nanofl_engine_ColorTools.tweenRgba(nanofl_engine_ColorTools.parse(startV),nanofl_engine_ColorTools.parse(finishV),t)));
			break;
		default:
			start[p.name] = startV;
		}
	}
};
nanofl_engine_CustomPropertiesTools.fix = function(params,properties) {
	if(properties == null) return params;
	var _g = 0;
	while(_g < properties.length) {
		var p = properties[_g];
		++_g;
		if(p.type == "delimiter" || p.type == "info") continue;
		var v = Reflect.field(params,p.name);
		if(v == null) params[p.name] = p.defaultValue; else {
			var _g1 = p.type;
			switch(_g1) {
			case "int":
				Reflect.setField(params,p.name,typeof(v) == "string"?stdlib_Std.parseInt(v):v);
				break;
			case "float":
				Reflect.setField(params,p.name,typeof(v) == "string"?stdlib_Std.parseFloat(v):v);
				break;
			case "bool":
				Reflect.setField(params,p.name,typeof(v) == "string"?stdlib_Std.bool(v):v);
				break;
			default:
				params[p.name] = v;
			}
		}
	}
	return params;
};
nanofl_engine_CustomPropertiesTools.resetToNeutral = function(params,properties) {
	var _g = 0;
	while(_g < properties.length) {
		var p = properties[_g];
		++_g;
		if(p.type == "delimiter" || p.type == "info") continue;
		if(p.neutralValue != null) params[p.name] = p.neutralValue;
	}
};
var nanofl_engine_Debug = function() { };
$hxClasses["nanofl.engine.Debug"] = nanofl_engine_Debug;
nanofl_engine_Debug.__name__ = ["nanofl","engine","Debug"];
var nanofl_engine_FileSystem = function() { };
$hxClasses["nanofl.engine.FileSystem"] = nanofl_engine_FileSystem;
nanofl_engine_FileSystem.__name__ = ["nanofl","engine","FileSystem"];
nanofl_engine_FileSystem.prototype = {
	getTempDirectory: null
	,getPluginsDirectory: null
	,getCurrentDirectory: null
	,getUserDocumentsDirectory: null
	,getToolsDirectory: null
	,isWindows: null
	,getToolPath: null
	,createDirectory: null
	,readDirectory: null
	,getContent: null
	,saveContent: null
	,getBinary: null
	,saveBinary: null
	,exists: null
	,isDirectory: null
	,run: null
	,runCaptured: null
	,copy: null
	,syncDirectory: null
	,rename: null
	,remove: null
	,findFiles: null
	,getPluginPaths: null
	,getLastModified: null
	,getSize: null
	,zip: null
	,unzip: null
	,getEnvironmentVariable: null
	,setEnvironmentVariable: null
	,convertImage: null
	,convertAudio: null
	,nativePath: null
	,absolutePath: null
	,__class__: nanofl_engine_FileSystem
};
var nanofl_engine_FilterDef = function(name,params) {
	var _g = this;
	Object.defineProperty(this,"params",{ get : function() {
		return _g.get_params();
	}});
	stdlib_Debug.assert(params != null,null,{ fileName : "FilterDef.hx", lineNumber : 32, className : "nanofl.engine.FilterDef", methodName : "new"});
	this.name = name;
	this._params = params;
};
$hxClasses["nanofl.engine.FilterDef"] = nanofl_engine_FilterDef;
nanofl_engine_FilterDef.__name__ = ["nanofl","engine","FilterDef"];
nanofl_engine_FilterDef.load = function(node,version) {
	if(node == null) return null;
	var params = { };
	var _g1 = 0;
	var _g11 = node.attributes;
	while(_g1 < _g11.length) {
		var attr = _g11[_g1];
		++_g1;
		params[attr.name] = attr.value;
	}
	var name = nanofl_engine_Version.handle(version,(function($this) {
		var $r;
		var _g = new haxe_ds_StringMap();
		if(__map_reserved["1.0.0"] != null) _g.setReserved("1.0.0",function() {
			if(node.name != "BlurFilter") return node.name;
			nanofl_engine_FilterDef.fixParam(params,"blurX",function(s) {
				return Std.string(Std.parseInt(s) * 2);
			});
			nanofl_engine_FilterDef.fixParam(params,"blurY",function(s1) {
				return Std.string(Std.parseInt(s1) * 2);
			});
			return "BoxBlurFilter";
		}); else _g.h["1.0.0"] = function() {
			if(node.name != "BlurFilter") return node.name;
			nanofl_engine_FilterDef.fixParam(params,"blurX",function(s) {
				return Std.string(Std.parseInt(s) * 2);
			});
			nanofl_engine_FilterDef.fixParam(params,"blurY",function(s1) {
				return Std.string(Std.parseInt(s1) * 2);
			});
			return "BoxBlurFilter";
		};
		if(__map_reserved["2.0.0"] != null) _g.setReserved("2.0.0",function() {
			return node.name;
		}); else _g.h["2.0.0"] = function() {
			return node.name;
		};
		$r = _g;
		return $r;
	}(this)));
	return new nanofl_engine_FilterDef(name,params);
};
nanofl_engine_FilterDef.fixParam = function(params,name,fixFunc) {
	if(Object.prototype.hasOwnProperty.call(params,name)) Reflect.setField(params,name,fixFunc(Reflect.field(params,name)));
};
nanofl_engine_FilterDef.prototype = {
	name: null
	,_params: null
	,params: null
	,isParamsFixed: null
	,get_params: function() {
		if(this.isParamsFixed || !nanofl_engine_plugins_FilterPlugins.plugins.exists(this.name)) return this._params;
		this.isParamsFixed = true;
		return nanofl_engine_CustomPropertiesTools.fix(this._params,this.getProperties());
	}
	,save: function(out) {
		out.begin(this.name);
		var names = Reflect.fields(this._params);
		names.sort(Reflect.compare);
		var _g = 0;
		while(_g < names.length) {
			var name = names[_g];
			++_g;
			out.attr(name,Reflect.field(this._params,name));
		}
		out.end();
	}
	,equ: function(filter) {
		return filter.name == this.name && nanofl_engine_CustomPropertiesTools.equ(filter.params,this.params);
	}
	,clone: function() {
		var r = new nanofl_engine_FilterDef(this.name,Reflect.copy(this._params));
		r.isParamsFixed = this.isParamsFixed;
		return r;
	}
	,tween: function(t,finish) {
		stdlib_Debug.assert(finish == null || this.name == finish.name,this.name + " != " + finish.name,{ fileName : "FilterDef.hx", lineNumber : 108, className : "nanofl.engine.FilterDef", methodName : "tween"});
		if(t == 0.0 || !nanofl_engine_plugins_FilterPlugins.plugins.exists(this.name)) return this;
		var plugin = nanofl_engine_plugins_FilterPlugins.plugins.get(this.name);
		nanofl_engine_CustomPropertiesTools.tween(this.params,t,finish != null?finish.params:null,plugin != null?plugin.properties:null);
		return this;
	}
	,getFilter: function() {
		if(nanofl_engine_plugins_FilterPlugins.plugins.exists(this.name)) return nanofl_engine_plugins_FilterPlugins.plugins.get(this.name).getFilter(this.params); else return null;
	}
	,getLabel: function() {
		if(nanofl_engine_plugins_FilterPlugins.plugins.exists(this.name)) return nanofl_engine_plugins_FilterPlugins.plugins.get(this.name).label; else return this.name;
	}
	,getProperties: function() {
		if(nanofl_engine_plugins_FilterPlugins.plugins.exists(this.name)) return nanofl_engine_plugins_FilterPlugins.plugins.get(this.name).properties; else return [];
	}
	,resetToNeutral: function() {
		var plugin = nanofl_engine_plugins_FilterPlugins.plugins.get(this.name);
		if(plugin != null) nanofl_engine_CustomPropertiesTools.resetToNeutral(this.params,plugin.properties);
		return this;
	}
	,hxUnserialize: function(s) {
		var _g = this;
		Object.defineProperty(this,"params",{ get : function() {
			return _g.get_params();
		}});
		s.unserializeObject(this);
	}
	,hxSerialize: function(s) {
		s.serializeFields(this);
	}
	,__class__: nanofl_engine_FilterDef
};
var nanofl_engine_FontVariant = function(style,weight,locals,urls) {
	if(weight == null) weight = 400;
	if(style == null) style = "normal";
	this.style = style;
	this.weight = weight;
	if(locals != null) this.locals = locals; else this.locals = [];
	if(urls != null) this.urls = urls; else this.urls = new haxe_ds_StringMap();
};
$hxClasses["nanofl.engine.FontVariant"] = nanofl_engine_FontVariant;
nanofl_engine_FontVariant.__name__ = ["nanofl","engine","FontVariant"];
nanofl_engine_FontVariant.prototype = {
	style: null
	,weight: null
	,locals: null
	,urls: null
	,equ: function(e) {
		return e.style == this.style && e.weight == this.weight && nanofl_engine_MapTools.equFast(e.urls,this.urls);
	}
	,getUrlByFormats: function(formats) {
		var _g = 0;
		while(_g < formats.length) {
			var format = formats[_g];
			++_g;
			if(this.urls.exists(format)) return this.urls.get(format);
		}
		return null;
	}
	,__class__: nanofl_engine_FontVariant
};
var nanofl_engine_Frame = function(keyFrame,subIndex) {
	this.keyFrame = keyFrame;
	this.subIndex = subIndex;
};
$hxClasses["nanofl.engine.Frame"] = nanofl_engine_Frame;
nanofl_engine_Frame.__name__ = ["nanofl","engine","Frame"];
nanofl_engine_Frame.prototype = {
	keyFrame: null
	,subIndex: null
	,getTweenedElements: function() {
		return this.keyFrame.getTweenedElements(this.subIndex);
	}
	,__class__: nanofl_engine_Frame
};
var nanofl_engine_IElementsContainer = function() { };
$hxClasses["nanofl.engine.IElementsContainer"] = nanofl_engine_IElementsContainer;
nanofl_engine_IElementsContainer.__name__ = ["nanofl","engine","IElementsContainer"];
nanofl_engine_IElementsContainer.prototype = {
	elements: null
	,addElement: null
	,removeElementAt: null
	,removeElement: null
	,toString: null
	,__class__: nanofl_engine_IElementsContainer
};
var nanofl_engine_KeyFrame = function(label,duration,motionTween,elements) {
	if(duration == null) duration = 1;
	if(label == null) label = "";
	var _g = this;
	Object.defineProperty(this,"motionTween",{ get : function() {
		return _g.get_motionTween();
	}, set : function(v) {
		_g.set_motionTween(v);
	}});
	Object.defineProperty(this,"elements",{ get : function() {
		return _g.get_elements();
	}});
	this.label = label;
	this.duration = duration;
	this.motionTween = motionTween;
	if(elements != null) this._elements = elements; else this._elements = [];
	var $it0 = HxOverrides.iter(this.elements);
	while( $it0.hasNext() ) {
		var element = $it0.next();
		element.parent = this;
	}
};
$hxClasses["nanofl.engine.KeyFrame"] = nanofl_engine_KeyFrame;
nanofl_engine_KeyFrame.__name__ = ["nanofl","engine","KeyFrame"];
nanofl_engine_KeyFrame.__interfaces__ = [nanofl_engine_IElementsContainer];
nanofl_engine_KeyFrame.parse = function(node,version) {
	stdlib_Debug.assert(node.name == "frame",null,{ fileName : "KeyFrame.hx", lineNumber : 153, className : "nanofl.engine.KeyFrame", methodName : "parse"});
	var frame = new nanofl_engine_KeyFrame(htmlparser_HtmlParserTools.getAttr(node,"label",""),Std["int"](htmlparser_HtmlParserTools.getAttr(node,"duration",1)),nanofl_engine_MotionTween.load(node));
	var _g = 0;
	var _g1 = nanofl_engine_elements_Elements.parse(node,version);
	while(_g < _g1.length) {
		var element = _g1[_g];
		++_g;
		frame.addElement(element);
	}
	return frame;
};
nanofl_engine_KeyFrame.prototype = {
	layer: null
	,label: null
	,duration: null
	,_motionTween: null
	,motionTween: null
	,get_motionTween: function() {
		return this._motionTween;
	}
	,set_motionTween: function(v) {
		if(v != null) v.keyFrame = this;
		return this._motionTween = v;
	}
	,_elements: null
	,elements: null
	,get_elements: function() {
		return this._elements;
	}
	,addElement: function(element,index) {
		if(index == null) this._elements.push(element); else this._elements.splice(index,0,element);
		element.parent = this;
	}
	,removeElementAt: function(n) {
		this._elements.splice(n,1);
	}
	,removeElement: function(element) {
		var n = HxOverrides.indexOf(this.elements,element,0);
		if(n >= 0) this.removeElementAt(n);
	}
	,swapElement: function(i,j) {
		var element = this.elements[i];
		this._elements[i] = this.elements[j];
		this._elements[j] = element;
	}
	,duplicate: function(label,duration,elements) {
		return new nanofl_engine_KeyFrame(label != null?label:this.label,duration != null?duration:this.duration,this.motionTween != null?this.motionTween.clone():null,elements != null?nanofl_engine_ArrayTools.clone(elements):nanofl_engine_ArrayTools.clone(this._elements));
	}
	,getShape: function(createIfNotExist) {
		if(this.elements.length > 0 && js_Boot.__instanceof(this.elements[0],nanofl_engine_elements_ShapeElement)) return this.elements[0];
		if(createIfNotExist) {
			var shape = new nanofl_engine_elements_ShapeElement();
			this.addElement(shape,0);
			return shape;
		}
		return null;
	}
	,clone: function() {
		return this.duplicate();
	}
	,isEmpty: function() {
		return this.elements.length == 0 || this.elements.length == 1 && js_Boot.__instanceof(this.elements[0],nanofl_engine_elements_ShapeElement) && (js_Boot.__cast(this.elements[0] , nanofl_engine_elements_ShapeElement)).isEmpty();
	}
	,getElementsState: function() {
		return { elements : this._elements.slice()};
	}
	,setElementsState: function(state) {
		this._elements = state.elements.slice();
	}
	,getTweenedElements: function(frameSubIndex) {
		if(this.motionTween != null && frameSubIndex != 0) return this.motionTween.apply(frameSubIndex); else return this.elements.map(function(element) {
			return { original : element, current : element};
		});
	}
	,getNextKeyFrame: function() {
		var n = this.getKeyIndex() + 1;
		return this.layer.keyFrames[n];
	}
	,getParentLayerFrame: function(frameSubIndex) {
		var parentLayer = this.layer.parentLayer;
		if(parentLayer == null) return null;
		return parentLayer.getFrame(this.getIndex() + frameSubIndex);
	}
	,hasGoodMotionTween: function() {
		if(this.motionTween == null) return false;
		var nextKeyFrame = this.getNextKeyFrame();
		if(nextKeyFrame == null) return false;
		return this.motionTween.isGood();
	}
	,getParentGuide: function(frameSubIndex) {
		return this.layer.getParentGuide(this.getIndex() + frameSubIndex);
	}
	,save: function(out) {
		out.begin("frame").attr("label",this.label,"").attr("duration",this.duration,1);
		if(this.motionTween != null) this.motionTween.save(out);
		nanofl_engine_elements_Elements.save(this._elements,out);
		out.end();
	}
	,getKeyIndex: function() {
		return HxOverrides.indexOf(this.layer.keyFrames,this,0);
	}
	,getIndex: function() {
		var r = 0;
		var _g1 = 0;
		var _g = this.getKeyIndex();
		while(_g1 < _g) {
			var i = _g1++;
			r += this.layer.keyFrames[i].duration;
		}
		return r;
	}
	,setLibrary: function(library) {
		var $it0 = HxOverrides.iter(this.elements);
		while( $it0.hasNext() ) {
			var element = $it0.next();
			element.setLibrary(library);
		}
	}
	,equ: function(keyFrame) {
		if(keyFrame.label != this.label) return false;
		if(keyFrame.duration != this.duration) return false;
		if(keyFrame.motionTween == null && this.motionTween != null) return false;
		if(keyFrame.motionTween != null && this.motionTween == null) return false;
		if(keyFrame.motionTween != null && this.motionTween != null && !keyFrame.motionTween.equ(this.motionTween)) return false;
		if(!nanofl_engine_ArrayTools.equ(this.getElementsWithoutEmptyShapes(keyFrame._elements),this.getElementsWithoutEmptyShapes(this._elements))) return false;
		return true;
	}
	,getElementsWithoutEmptyShapes: function(elements) {
		return elements.filter(function(e) {
			return !js_Boot.__instanceof(e,nanofl_engine_elements_ShapeElement) || !e.isEmpty();
		});
	}
	,toString: function() {
		return (this.layer != null?this.layer.toString() + " / ":"") + "frame";
	}
	,hxUnserialize: function(s) {
		var _g = this;
		Object.defineProperty(this,"motionTween",{ get : function() {
			return _g.get_motionTween();
		}, set : function(v) {
			_g.set_motionTween(v);
		}});
		Object.defineProperty(this,"elements",{ get : function() {
			return _g.get_elements();
		}});
		s.unserializeObject(this);
	}
	,hxSerialize: function(s) {
		s.serializeFields(this);
	}
	,__class__: nanofl_engine_KeyFrame
};
var nanofl_engine_GroupKeyFrame = function(group) {
	nanofl_engine_KeyFrame.call(this,null,null,null,group._elements);
	this.group = group;
	var $it0 = HxOverrides.iter(this.elements);
	while( $it0.hasNext() ) {
		var element = $it0.next();
		element.parent = group;
	}
};
$hxClasses["nanofl.engine.GroupKeyFrame"] = nanofl_engine_GroupKeyFrame;
nanofl_engine_GroupKeyFrame.__name__ = ["nanofl","engine","GroupKeyFrame"];
nanofl_engine_GroupKeyFrame.__super__ = nanofl_engine_KeyFrame;
nanofl_engine_GroupKeyFrame.prototype = $extend(nanofl_engine_KeyFrame.prototype,{
	group: null
	,addElement: function(element,index) {
		nanofl_engine_KeyFrame.prototype.addElement.call(this,element,index);
		element.parent = this.group;
	}
	,duplicate: function(label,duration,elements) {
		return stdlib_Debug.methodNotSupported(this,{ fileName : "GroupKeyFrame.hx", lineNumber : 23, className : "nanofl.engine.GroupKeyFrame", methodName : "duplicate"});
	}
	,__class__: nanofl_engine_GroupKeyFrame
});
var nanofl_engine_Guide = function(shape) {
	this.shape = shape;
	this.vectors = shape.edges.slice();
	var _g = 0;
	var _g1 = shape.edges;
	while(_g < _g1.length) {
		var edge = _g1[_g];
		++_g;
		this.vectors.push(edge.clone().reverse());
	}
	this.vectors = this.vectors.filter(function(e) {
		return e.x1 != e.x3 || e.y1 != e.y3;
	});
	this.connections = nanofl_engine_Guide.getConnectionMatrix(this.vectors);
	this.used = [];
	var _g11 = 0;
	var _g2 = shape.edges.length;
	while(_g11 < _g2) {
		var i = _g11++;
		this.used.push(false);
	}
};
$hxClasses["nanofl.engine.Guide"] = nanofl_engine_Guide;
nanofl_engine_Guide.__name__ = ["nanofl","engine","Guide"];
nanofl_engine_Guide.getConnectionMatrix = function(vectors) {
	var r = [];
	var _g = 0;
	while(_g < vectors.length) {
		var a = vectors[_g];
		++_g;
		var line = [];
		var _g1 = 0;
		while(_g1 < vectors.length) {
			var b = vectors[_g1];
			++_g1;
			line.push(a.x3 == b.x1 && a.y3 == b.y1);
		}
		r.push(line);
	}
	return r;
};
nanofl_engine_Guide.log = function(v,infos) {
};
nanofl_engine_Guide.prototype = {
	shape: null
	,vectors: null
	,connections: null
	,used: null
	,get: function(startProps,finishProps,orientToPath,t) {
		nanofl_engine_Guide.log("Guide.getPos: " + startProps.x + ", " + startProps.y + " => " + finishProps.x + ", " + finishProps.y + "; t = " + t,{ fileName : "Guide.hx", lineNumber : 47, className : "nanofl.engine.Guide", methodName : "get"});
		var path = this.findPath(startProps,finishProps);
		nanofl_engine_Guide.log("path = " + path.join("; "),{ fileName : "Guide.hx", lineNumber : 50, className : "nanofl.engine.Guide", methodName : "get"});
		if(path.length == 0) path = [new nanofl_engine_geom_Edge(startProps.x,startProps.y,finishProps.x,finishProps.y)];
		var lens = path.map(function(e) {
			return e.getLength();
		});
		var sumLen = 0.0;
		var _g = 0;
		while(_g < lens.length) {
			var len = lens[_g];
			++_g;
			sumLen += len;
		}
		if(sumLen == 0.0) return { x : path[0].x1, y : path[0].y1, rotation : startProps.rotation};
		var lenPos = sumLen * t;
		var curLen = 0.0;
		var _g1 = 0;
		var _g2 = path.length;
		while(_g1 < _g2) {
			var i = _g1++;
			if(lens[i] == 0) continue;
			curLen += lens[i];
			if(curLen >= lenPos) {
				var dLen = lenPos - (curLen - lens[i]);
				var subT = dLen / lens[i];
				var point = path[i].getPoint(path[i].getMonotoneT(subT));
				var rotation;
				if(!orientToPath) rotation = startProps.rotation + (finishProps.rotation - startProps.rotation) * t; else {
					var angleT = path[i].getTangent(subT) * 180 / Math.PI;
					var angleS = path[0].getTangent(0) * 180 / Math.PI;
					var angleF = path[path.length - 1].getTangent(1) * 180 / Math.PI;
					rotation = startProps.rotation + (angleT - angleS) + (finishProps.rotation - angleF - (startProps.rotation - angleS)) * t;
				}
				return { x : point.x, y : point.y, rotation : rotation};
			}
		}
		return Reflect.copy(finishProps);
	}
	,findPath: function(startPos,finishPos) {
		var _g = this;
		if(this.vectors.length == 0) return [];
		var start = this.shape.getNearestStrokeEdge(startPos);
		var end = this.shape.getNearestStrokeEdge(finishPos);
		nanofl_engine_Guide.log("Guide.findPath " + nanofl_engine_geom_PointTools.toString(startPos) + " (" + start.t + ") => " + nanofl_engine_geom_PointTools.toString(finishPos) + " (" + end.t + ")" + "\tend.edge = " + Std.string(end.edge),{ fileName : "Guide.hx", lineNumber : 108, className : "nanofl.engine.Guide", methodName : "findPath"});
		var params = { counter : 0, endEdge : end.edge, bestLen : 1.0e100, bestPath : [], path : [], len : 0.0};
		var startEdgeIndex = stdlib_LambdaIterable.findIndex(this.shape.edges,function(e) {
			return e.equ(start.edge);
		});
		stdlib_Debug.assert(startEdgeIndex >= 0,"startEdgeIndex = " + startEdgeIndex,{ fileName : "Guide.hx", lineNumber : 123, className : "nanofl.engine.Guide", methodName : "findPath"});
		this.findPathInner(params,startEdgeIndex);
		this.findPathInner(params,startEdgeIndex + this.shape.edges.length);
		var path = params.bestPath.map(function(i) {
			return _g.vectors[i];
		});
		if(path.length > 0) {
			var lastI = path.length - 1;
			var firstSameDir = path[0].x3 == start.edge.x3 && path[0].y3 == start.edge.y3;
			var lastSameDir = path[lastI].x1 == end.edge.x1 && path[lastI].y1 == end.edge.y1;
			if(firstSameDir) path[0] = path[0].clone().reverse().getPart(1 - start.t).reverse(); else path[0] = path[0] = path[0].getPart(start.t);
			if(lastSameDir) path[lastI] = path[lastI].getPart(end.t); else path[lastI] = path[lastI].clone().reverse().getPart(1 - end.t).reverse();
		}
		return path;
	}
	,findPathInner: function(params,nextVectorIndex) {
		params.counter++;
		var nextVector = this.vectors[nextVectorIndex];
		var edgesCount = this.vectors.length >> 1;
		params.path.push(nextVectorIndex);
		this.used[nextVectorIndex % edgesCount] = true;
		params.len += nextVector.getLength();
		if(params.len < params.bestLen) {
			if(nextVector.equ(params.endEdge)) {
				params.bestLen = params.len;
				params.bestPath = params.path.slice();
			} else {
				var _g1 = 0;
				var _g = this.vectors.length;
				while(_g1 < _g) {
					var i = _g1++;
					if(!this.used[i % edgesCount] && this.connections[nextVectorIndex][i]) this.findPathInner(params,i);
				}
			}
		}
		params.len -= nextVector.getLength();
		this.used[nextVectorIndex % edgesCount] = false;
		params.path.pop();
	}
	,__class__: nanofl_engine_Guide
};
var nanofl_engine_IFramedItem = function() { };
$hxClasses["nanofl.engine.IFramedItem"] = nanofl_engine_IFramedItem;
nanofl_engine_IFramedItem.__name__ = ["nanofl","engine","IFramedItem"];
nanofl_engine_IFramedItem.prototype = {
	likeButton: null
	,autoPlay: null
	,loop: null
	,__class__: nanofl_engine_IFramedItem
};
var nanofl_engine_ILayersContainer = function() { };
$hxClasses["nanofl.engine.ILayersContainer"] = nanofl_engine_ILayersContainer;
nanofl_engine_ILayersContainer.__name__ = ["nanofl","engine","ILayersContainer"];
nanofl_engine_ILayersContainer.prototype = {
	layers: null
	,toString: null
	,__class__: nanofl_engine_ILayersContainer
};
var nanofl_engine_IPathElement = function() { };
$hxClasses["nanofl.engine.IPathElement"] = nanofl_engine_IPathElement;
nanofl_engine_IPathElement.__name__ = ["nanofl","engine","IPathElement"];
nanofl_engine_IPathElement.__interfaces__ = [nanofl_engine_ILayersContainer];
nanofl_engine_IPathElement.prototype = {
	visible: null
	,matrix: null
	,isScene: null
	,getNavigatorName: null
	,getNavigatorIcon: null
	,getChildren: null
	,createDisplayObject: null
	,getTimeline: null
	,__class__: nanofl_engine_IPathElement
};
var nanofl_engine_ISelectable = function() { };
$hxClasses["nanofl.engine.ISelectable"] = nanofl_engine_ISelectable;
nanofl_engine_ISelectable.__name__ = ["nanofl","engine","ISelectable"];
nanofl_engine_ISelectable.prototype = {
	selected: null
	,__class__: nanofl_engine_ISelectable
};
var nanofl_engine_ISpriteSheetableItem = function() { };
$hxClasses["nanofl.engine.ISpriteSheetableItem"] = nanofl_engine_ISpriteSheetableItem;
nanofl_engine_ISpriteSheetableItem.__name__ = ["nanofl","engine","ISpriteSheetableItem"];
nanofl_engine_ISpriteSheetableItem.prototype = {
	exportAsSpriteSheet: null
	,__class__: nanofl_engine_ISpriteSheetableItem
};
var nanofl_engine_ITextureItem = function() { };
$hxClasses["nanofl.engine.ITextureItem"] = nanofl_engine_ITextureItem;
nanofl_engine_ITextureItem.__name__ = ["nanofl","engine","ITextureItem"];
nanofl_engine_ITextureItem.prototype = {
	namePath: null
	,textureAtlas: null
	,__class__: nanofl_engine_ITextureItem
};
var nanofl_engine_ITimeline = function() { };
$hxClasses["nanofl.engine.ITimeline"] = nanofl_engine_ITimeline;
nanofl_engine_ITimeline.__name__ = ["nanofl","engine","ITimeline"];
nanofl_engine_ITimeline.prototype = {
	addLayer: null
	,addLayersBlock: null
	,removeLayer: null
	,removeLayerWithChildren: null
	,__class__: nanofl_engine_ITimeline
};
var nanofl_engine_Layer = function(name,type,visible,locked,parentIndex) {
	if(locked == null) locked = false;
	if(visible == null) visible = true;
	if(type == null) type = "normal";
	var _g = this;
	Object.defineProperty(this,"parentLayer",{ get : function() {
		return _g.get_parentLayer();
	}});
	Object.defineProperty(this,"keyFrames",{ get : function() {
		return _g._keyFrames;
	}});
	this.name = name;
	this.type = type;
	this.visible = visible;
	this.locked = locked;
	this.parentIndex = parentIndex;
	this._keyFrames = [];
};
$hxClasses["nanofl.engine.Layer"] = nanofl_engine_Layer;
nanofl_engine_Layer.__name__ = ["nanofl","engine","Layer"];
nanofl_engine_Layer.parse = function(node,version) {
	var layer = new nanofl_engine_Layer(htmlparser_HtmlParserTools.getAttr(node,"name",""),htmlparser_HtmlParserTools.getAttr(node,"type","normal"),htmlparser_HtmlParserTools.getAttr(node,"visible",true),htmlparser_HtmlParserTools.getAttr(node,"locked",false),htmlparser_HtmlParserTools.getAttrInt(node,"parentIndex"));
	var _g = 0;
	var _g1 = node.children;
	while(_g < _g1.length) {
		var frameNode = _g1[_g];
		++_g;
		if(frameNode.name == "frame") layer.addKeyFrame(nanofl_engine_KeyFrame.parse(frameNode,version));
	}
	return layer;
};
nanofl_engine_Layer.prototype = {
	layersContainer: null
	,name: null
	,type: null
	,visible: null
	,locked: null
	,parentIndex: null
	,parentLayer: null
	,get_parentLayer: function() {
		if(this.parentIndex != null) return this.layersContainer.layers[this.parentIndex]; else return null;
	}
	,_keyFrames: null
	,keyFrames: null
	,get_keyFrames: function() {
		return this._keyFrames;
	}
	,getTotalFrames: function() {
		var r = 0;
		var $it0 = HxOverrides.iter(this.keyFrames);
		while( $it0.hasNext() ) {
			var frame = $it0.next();
			r += frame.duration;
		}
		return r;
	}
	,getFrame: function(frameIndex) {
		var indexes = this.getFrameIndexes(frameIndex);
		if(indexes != null) return new nanofl_engine_Frame(this.keyFrames[indexes.keyIndex],indexes.subIndex); else return null;
	}
	,getFrameIndexes: function(frameIndex) {
		var start = 0;
		var _g1 = 0;
		var _g = this.keyFrames.length;
		while(_g1 < _g) {
			var i = _g1++;
			if(frameIndex >= start && frameIndex < start + this.keyFrames[i].duration) return { keyIndex : i, subIndex : frameIndex - start};
			start += this.keyFrames[i].duration;
		}
		return null;
	}
	,addKeyFrame: function(keyFrame) {
		this._keyFrames.push(keyFrame);
		keyFrame.layer = this;
	}
	,insertKeyFrame: function(keyIndex,keyFrame) {
		this._keyFrames.splice(keyIndex,0,keyFrame);
		keyFrame.layer = this;
	}
	,insertFrame: function(frameIndex) {
		if(this.keyFrames.length > 0) {
			var indexes = this.getFrameIndexes(frameIndex);
			if(indexes != null) this.keyFrames[indexes.keyIndex].duration++; else this.keyFrames[this.keyFrames.length - 1].duration += frameIndex - this.getTotalFrames() + 1;
		} else this.addKeyFrame(new nanofl_engine_KeyFrame(null,frameIndex + 1));
	}
	,convertToKeyFrame: function(frameIndex,blank) {
		if(blank == null) blank = false;
		if(this.keyFrames.length > 0) {
			var curFrameIndex = 0;
			var _g1 = 0;
			var _g = this.keyFrames.length;
			while(_g1 < _g) {
				var i = _g1++;
				var keyFrame = this.keyFrames[i];
				if(frameIndex >= curFrameIndex && frameIndex < curFrameIndex + keyFrame.duration) {
					if(curFrameIndex == frameIndex) return false;
					this.insertKeyFrame(i + 1,keyFrame.duplicate("",keyFrame.duration - (frameIndex - curFrameIndex),blank?[]:keyFrame.getTweenedElements(frameIndex - curFrameIndex).map(function(e) {
						return e.current;
					})));
					keyFrame.duration = frameIndex - curFrameIndex;
					return true;
				}
				curFrameIndex += keyFrame.duration;
			}
			var lastKeyFrame = this.keyFrames[this.keyFrames.length - 1];
			lastKeyFrame.duration = frameIndex - curFrameIndex + lastKeyFrame.duration;
			this.addKeyFrame(lastKeyFrame.duplicate("",1));
			return true;
		} else {
			this.addKeyFrame(new nanofl_engine_KeyFrame(null,frameIndex + 1));
			return true;
		}
	}
	,removeFrame: function(frameIndex) {
		var indexes = this.getFrameIndexes(frameIndex);
		if(indexes != null) {
			this.keyFrames[indexes.keyIndex].duration--;
			if(this.keyFrames[indexes.keyIndex].duration == 0) this._keyFrames.splice(indexes.keyIndex,1);
			return true;
		}
		return false;
	}
	,getHumanType: function() {
		if(this.parentIndex == null) return this.type;
		if(this.type == "normal") {
			var parent = this.layersContainer.layers[this.parentIndex];
			if(parent.type == "mask") return "masked";
			if(parent.type == "guide") return "guided";
		}
		return this.type;
	}
	,getIcon: function() {
		var _g = this.type;
		switch(_g) {
		case "mask":
			return "custom-icon-mask";
		case "folder":
			return "custom-icon-folder-close";
		case "guide":
			return "custom-icon-layer-guide";
		default:
			return "custom-icon-page-blank";
		}
	}
	,getNestLevel: function(layers) {
		var r = 0;
		var layer = this;
		while(layer.parentIndex != null) {
			r++;
			layer = layers[layer.parentIndex];
		}
		return r;
	}
	,getParentGuide: function(frameIndex) {
		if(this.parentIndex != null) {
			var parentLayer = this.layersContainer.layers[this.parentIndex];
			if(parentLayer.type == "guide") {
				var frame = parentLayer.getFrame(frameIndex);
				var shape = frame.keyFrame.getShape(false);
				if(shape != null) return new nanofl_engine_Guide(shape);
			}
		}
		return new nanofl_engine_Guide(new nanofl_engine_elements_ShapeElement());
	}
	,getChildLayers: function() {
		var index = this.getIndex();
		return this.layersContainer.layers.filter(function(layer) {
			return layer.parentIndex == index;
		});
	}
	,getTweenedElements: function(frameIndex) {
		var frame = this.getFrame(frameIndex);
		if(frame != null) return frame.keyFrame.getTweenedElements(frame.subIndex);
		return [];
	}
	,save: function(out) {
		out.begin("layer").attr("name",this.name,"").attr("type",this.type,"normal").attr("visible",this.visible,true).attr("locked",this.locked,false).attr("parentIndex",this.parentIndex);
		var $it0 = HxOverrides.iter(this.keyFrames);
		while( $it0.hasNext() ) {
			var keyFrame = $it0.next();
			keyFrame.save(out);
		}
		out.end();
	}
	,clone: function() {
		return this.duplicate(this.keyFrames,this.parentIndex);
	}
	,duplicate: function(keyFrames,parentIndex) {
		var r = new nanofl_engine_Layer(this.name,this.type,this.visible,this.locked,parentIndex);
		var $it0 = HxOverrides.iter(keyFrames);
		while( $it0.hasNext() ) {
			var keyFrame = $it0.next();
			r.addKeyFrame(keyFrame.clone());
		}
		return r;
	}
	,getIndex: function() {
		return HxOverrides.indexOf(this.layersContainer.layers,this,0);
	}
	,setLibrary: function(library) {
		var $it0 = HxOverrides.iter(this.keyFrames);
		while( $it0.hasNext() ) {
			var keyFrame = $it0.next();
			keyFrame.setLibrary(library);
		}
	}
	,equ: function(layer) {
		if(layer.name != this.name) return false;
		if(layer.type != this.type) return false;
		if(layer.visible != this.visible) return false;
		if(layer.locked != this.locked) return false;
		if(!nanofl_engine_ArrayTools.equ(layer._keyFrames,this._keyFrames)) return false;
		return true;
	}
	,toString: function() {
		return (this.layersContainer != null?this.layersContainer.toString() + " / ":"") + "layer";
	}
	,hxUnserialize: function(s) {
		var _g = this;
		Object.defineProperty(this,"parentLayer",{ get : function() {
			return _g.get_parentLayer();
		}});
		Object.defineProperty(this,"keyFrames",{ get : function() {
			return _g._keyFrames;
		}});
		s.unserializeObject(this);
	}
	,hxSerialize: function(s) {
		s.serializeFields(this);
	}
	,__class__: nanofl_engine_Layer
};
var nanofl_engine_Library = function(libraryDir,items) {
	this.items = new haxe_ds_StringMap();
	this.libraryDir = libraryDir;
	if(items != null) {
		var _g = 0;
		while(_g < items.length) {
			var item = items[_g];
			++_g;
			this.addItem(item);
		}
	}
};
$hxClasses["nanofl.engine.Library"] = nanofl_engine_Library;
nanofl_engine_Library.__name__ = ["nanofl","engine","Library"];
nanofl_engine_Library.createSceneWithFrame = function(elements,layerName) {
	return nanofl_engine_libraryitems_MovieClipItem.createWithFrame(nanofl_engine_Library.SCENE_NAME_PATH,elements,layerName);
};
nanofl_engine_Library.prototype = {
	items: null
	,libraryDir: null
	,addSceneWithFrame: function(elements,layerName) {
		return this.addItem(nanofl_engine_Library.createSceneWithFrame(elements,layerName));
	}
	,addItem: function(item) {
		item.setLibrary(this);
		this.items.set(item.namePath,item);
		this.ensureFolderOfItemExists(item.namePath);
		return item;
	}
	,removeItem: function(namePath) {
		var _g = 0;
		var _g1 = this.getItemsInFolder(namePath);
		while(_g < _g1.length) {
			var item = _g1[_g];
			++_g;
			this.removeItemInner(item.namePath);
		}
		this.removeItemInner(namePath);
	}
	,removeItemInner: function(namePath) {
		var itemToRemove = this.getItem(namePath);
		this.items.remove(namePath);
		if(js_Boot.__instanceof(itemToRemove,nanofl_engine_libraryitems_InstancableItem)) {
			var instances = [];
			var $it0 = this.items.iterator();
			while( $it0.hasNext() ) {
				var item = $it0.next();
				if(js_Boot.__instanceof(item,nanofl_engine_libraryitems_MovieClipItem)) nanofl_engine_MovieClipItemTools.iterateInstances(item,true,null,function(instance,_) {
					if(instance.namePath == namePath) instances.push(instance);
				});
			}
			var _g = 0;
			while(_g < instances.length) {
				var instance1 = instances[_g];
				++_g;
				instance1.parent.removeElement(instance1);
			}
		}
	}
	,getSceneItem: function() {
		return js_Boot.__cast(this.items.get(nanofl_engine_Library.SCENE_NAME_PATH) , nanofl_engine_libraryitems_MovieClipItem);
	}
	,getSceneInstance: function() {
		return this.getSceneItem().newInstance();
	}
	,getInstancableItems: function() {
		return this.getItems(true).filter(function(item) {
			return js_Boot.__instanceof(item,nanofl_engine_libraryitems_InstancableItem);
		});
	}
	,getBitmaps: function() {
		return this.getItems().filter(function(item) {
			return js_Boot.__instanceof(item,nanofl_engine_libraryitems_BitmapItem);
		});
	}
	,getMeshes: function() {
		return this.getItems().filter(function(item) {
			return js_Boot.__instanceof(item,nanofl_engine_libraryitems_MeshItem);
		});
	}
	,getSounds: function() {
		return this.getItems().filter(function(item) {
			return js_Boot.__instanceof(item,nanofl_engine_libraryitems_SoundItem);
		});
	}
	,getFonts: function() {
		var fontItems = this.getItems().filter(function(item) {
			return js_Boot.__instanceof(item,nanofl_engine_libraryitems_FontItem);
		});
		var fonts = fontItems.map(function(item1) {
			return item1.toFont();
		});
		fonts.sort(function(a,b) {
			return Reflect.compare(a.family,b.family);
		});
		return fonts;
	}
	,getItem: function(namePath) {
		stdlib_Debug.assert(namePath != null,null,{ fileName : "Library.hx", lineNumber : 124, className : "nanofl.engine.Library", methodName : "getItem"});
		stdlib_Debug.assert(namePath != "",null,{ fileName : "Library.hx", lineNumber : 125, className : "nanofl.engine.Library", methodName : "getItem"});
		var r = this.items.get(namePath);
		if(r != null) return r;
		haxe_Log.trace("Symbol '" + namePath + "' is not found.",{ fileName : "Library.hx", lineNumber : 128, className : "nanofl.engine.Library", methodName : "getItem"});
		return nanofl_engine_libraryitems_MovieClipItem.createWithFrame(namePath,[new nanofl_engine_elements_TextElement("",0,0,false,true,[new nanofl_TextRun("Symbol '" + namePath + "' is not found.")])],"temp");
	}
	,hasItem: function(namePath) {
		return this.items.exists(namePath);
	}
	,save: function(fileSystem) {
		stdlib_Debug.assert(this.libraryDir != null,null,{ fileName : "Library.hx", lineNumber : 139, className : "nanofl.engine.Library", methodName : "save"});
		var $it0 = this.items.iterator();
		while( $it0.hasNext() ) {
			var item = $it0.next();
			item.save(fileSystem);
		}
	}
	,realUrl: function(url) {
		if(url.indexOf("//") >= 0) return url;
		return this.libraryDir + "/" + url;
	}
	,getItems: function(includeScene) {
		var _g = this;
		var namePaths = stdlib_LambdaIterator.array(this.items.keys());
		if(!includeScene) namePaths = namePaths.filter(function(namePath) {
			return namePath != nanofl_engine_Library.SCENE_NAME_PATH;
		});
		namePaths.sort(function(a,b) {
			return Reflect.compare(a.toLowerCase(),b.toLowerCase());
		});
		return namePaths.map(function(namePath1) {
			return _g.items.get(namePath1);
		});
	}
	,preload: function(ready) {
		var loadCount = Lambda.count(this.items);
		if(loadCount > 0) {
			var $it0 = this.items.iterator();
			while( $it0.hasNext() ) {
				var item = $it0.next();
				item.preload(function() {
					loadCount--;
					if(loadCount == 0) ready();
				});
			}
		} else ready();
	}
	,clone: function() {
		return new nanofl_engine_Library(this.libraryDir,nanofl_engine_ArrayTools.clone(this.getItems(true)));
	}
	,getItemCount: function() {
		return Lambda.count(this.items);
	}
	,ensureFolderOfItemExists: function(namePath) {
		var parts = namePath.split("/");
		var _g1 = 1;
		var _g = parts.length;
		while(_g1 < _g) {
			var i = _g1++;
			var folder = parts.slice(0,i).join("/");
			if(!this.hasItem(folder)) this.addItem(new nanofl_engine_libraryitems_FolderItem(folder));
		}
	}
	,getItemsInFolder: function(folderNamePath) {
		if(stdlib_Std["is"](this.items.get(folderNamePath),nanofl_engine_libraryitems_FolderItem)) return this.getItems().filter(function(_) {
			return StringTools.startsWith(_.namePath,folderNamePath + "/");
		});
		return [];
	}
	,equ: function(library) {
		var names1 = stdlib_LambdaIterator.array(this.items.keys());
		var names2 = stdlib_LambdaIterator.array(library.items.keys());
		if(names1.length != names2.length) return false;
		var _g = 0;
		while(_g < names1.length) {
			var name = names1[_g];
			++_g;
			if(HxOverrides.indexOf(names2,name,0) < 0) return false;
		}
		var _g1 = 0;
		while(_g1 < names1.length) {
			var name1 = names1[_g1];
			++_g1;
			if(!this.getItem(name1).equ(library.getItem(name1))) return false;
		}
		return true;
	}
	,__class__: nanofl_engine_Library
};
var nanofl_engine_Loader = function() { };
$hxClasses["nanofl.engine.Loader"] = nanofl_engine_Loader;
nanofl_engine_Loader.__name__ = ["nanofl","engine","Loader"];
nanofl_engine_Loader.image = function(url,callb) {
	var image = new Image();
	image.onload = function(_) {
		if(callb != null) callb(image);
	};
	image.onerror = function(_1) {
		nanofl_engine_Debug.console.error("Failed to load '" + url + "'.");
		image.src = "data:image/gif;base64,R0lGODlhAQABAIAAAP///wAAACwAAAAAAQABAAACAkQBADs=";
	};
	image.src = url;
};
nanofl_engine_Loader.file = function(url,callb) {
	var xmlhttp = new XMLHttpRequest();
	xmlhttp.responseType = "text";
	xmlhttp.onreadystatechange = function() {
		if(xmlhttp.readyState == 4) {
			if(xmlhttp.status == 200) callb(xmlhttp.responseText); else {
				nanofl_engine_Debug.console.error("Failed to load '" + url + "': " + xmlhttp.status + " / " + xmlhttp.statusText);
				callb(null);
			}
		}
	};
	xmlhttp.open("GET",url,true);
	xmlhttp.send();
};
nanofl_engine_Loader.queued = function(urls,load,callb) {
	if(urls.length > 0) {
		var items = [];
		var _g = 0;
		while(_g < urls.length) {
			var url = urls[_g];
			++_g;
			load(url,function(image) {
				items.push(image);
				if(items.length == urls.length) {
					if(callb != null) callb(items);
				}
			});
		}
	} else if(callb != null) callb([]);
};
var nanofl_engine_MapTools = function() { };
$hxClasses["nanofl.engine.MapTools"] = nanofl_engine_MapTools;
nanofl_engine_MapTools.__name__ = ["nanofl","engine","MapTools"];
nanofl_engine_MapTools.clone = function(m) {
	var r = Type.createInstance(m == null?null:js_Boot.getClass(m),[]);
	var $it0 = m.keys();
	while( $it0.hasNext() ) {
		var k = $it0.next();
		var value = m.get(k).clone();
		r.set(k,value);
	}
	return r;
};
nanofl_engine_MapTools.cloneFast = function(m) {
	var r = Type.createInstance(m == null?null:js_Boot.getClass(m),[]);
	var $it0 = m.keys();
	while( $it0.hasNext() ) {
		var k = $it0.next();
		var value = m.get(k);
		r.set(k,value);
	}
	return r;
};
nanofl_engine_MapTools.equ = function(a,b) {
	return nanofl_engine_MapTools.equCustom(a,b,function(e1,e2) {
		return e1 == null && e2 == null || e1 != null && e2 != null && e1.equ(e2);
	});
};
nanofl_engine_MapTools.equFast = function(a,b) {
	return nanofl_engine_MapTools.equCustom(a,b,function(e1,e2) {
		return e1 == e2;
	});
};
nanofl_engine_MapTools.equCustom = function(a,b,cmp) {
	var keysA = stdlib_LambdaIterator.array(a.keys());
	var keysB = stdlib_LambdaIterator.array(b.keys());
	if(keysA.length != keysB.length) return false;
	keysA.sort(Reflect.compare);
	keysB.sort(Reflect.compare);
	if(!nanofl_engine_ArrayTools.equFast(keysA,keysB)) return false;
	var _g = 0;
	while(_g < keysA.length) {
		var key = keysA[_g];
		++_g;
		if(!cmp(a.get(key),b.get(key))) return false;
	}
	return true;
};
var nanofl_engine_MeshParams = function() {
	this.directionalLightRotationY = 0.0;
	this.directionalLightRotationX = 0.0;
	this.directionalLightColor = "#808080";
	this.ambientLightColor = "#E0E0E0";
	this.cameraFov = 70;
	this.rotationY = 0.0;
	this.rotationX = 0.0;
};
$hxClasses["nanofl.engine.MeshParams"] = nanofl_engine_MeshParams;
nanofl_engine_MeshParams.__name__ = ["nanofl","engine","MeshParams"];
nanofl_engine_MeshParams.load = function(node) {
	var r = new nanofl_engine_MeshParams();
	r.rotationX = htmlparser_HtmlParserTools.getAttrFloat(node,"rotationX",r.rotationX);
	r.rotationY = htmlparser_HtmlParserTools.getAttrFloat(node,"rotationY",r.rotationY);
	r.cameraFov = htmlparser_HtmlParserTools.getAttrInt(node,"cameraFov",r.cameraFov);
	r.ambientLightColor = htmlparser_HtmlParserTools.getAttrString(node,"ambientLightColor",r.ambientLightColor);
	r.directionalLightColor = htmlparser_HtmlParserTools.getAttrString(node,"directionalLightColor",r.directionalLightColor);
	r.directionalLightRotationX = htmlparser_HtmlParserTools.getAttrFloat(node,"directionalLightRotationX",r.directionalLightRotationX);
	r.directionalLightRotationY = htmlparser_HtmlParserTools.getAttrFloat(node,"directionalLightRotationY",r.directionalLightRotationY);
	return r;
};
nanofl_engine_MeshParams.prototype = {
	rotationX: null
	,rotationY: null
	,cameraFov: null
	,ambientLightColor: null
	,directionalLightColor: null
	,directionalLightRotationX: null
	,directionalLightRotationY: null
	,save: function(out) {
		var def = new nanofl_engine_MeshParams();
		out.attr("rotationX",this.rotationX,def.rotationX);
		out.attr("rotationY",this.rotationY,def.rotationY);
		out.attr("cameraFov",this.cameraFov,def.cameraFov);
		out.attr("ambientLightColor",this.ambientLightColor,def.ambientLightColor);
		out.attr("directionalLightColor",this.directionalLightColor,def.directionalLightColor);
		out.attr("directionalLightRotationX",this.directionalLightRotationX,def.directionalLightRotationX);
		out.attr("directionalLightRotationY",this.directionalLightRotationY,def.directionalLightRotationY);
	}
	,equ: function(obj) {
		return obj.rotationX == this.rotationX && obj.rotationY == this.rotationY && obj.cameraFov == this.cameraFov && obj.ambientLightColor == this.ambientLightColor && obj.directionalLightColor == this.directionalLightColor && obj.directionalLightRotationX == this.directionalLightRotationX && obj.directionalLightRotationY == this.directionalLightRotationY;
	}
	,clone: function() {
		var r = new nanofl_engine_MeshParams();
		r.rotationX = this.rotationX;
		r.rotationY = this.rotationY;
		r.cameraFov = this.cameraFov;
		r.ambientLightColor = this.ambientLightColor;
		r.directionalLightColor = this.directionalLightColor;
		r.directionalLightRotationX = this.directionalLightRotationX;
		r.directionalLightRotationY = this.directionalLightRotationY;
		return r;
	}
	,applyToMesh: function(mesh) {
		mesh.rotationX = this.rotationX;
		mesh.rotationY = this.rotationY;
		mesh.camera.fov = this.cameraFov;
		mesh.ambientLight.color = new THREE.Color(nanofl_engine_ColorTools.stringToNumber(this.ambientLightColor));
		mesh.directionalLight.color = new THREE.Color(nanofl_engine_ColorTools.stringToNumber(this.directionalLightColor));
		mesh.directionalLight.setRotationFromEuler(new THREE.Euler(this.directionalLightRotationX * Math.PI / 180,this.directionalLightRotationY * Math.PI / 180));
	}
	,__class__: nanofl_engine_MeshParams
};
var nanofl_engine_MotionTween = function(easing,rotateCount,orientToPath,rotateCountX,rotateCountY,directionalLightRotateCountX,directionalLightRotateCountY) {
	this.easing = easing;
	this.rotateCount = rotateCount;
	this.orientToPath = orientToPath;
	this.rotateCountX = rotateCountX;
	this.rotateCountY = rotateCountY;
	this.directionalLightRotateCountX = directionalLightRotateCountX;
	this.directionalLightRotateCountY = directionalLightRotateCountY;
};
$hxClasses["nanofl.engine.MotionTween"] = nanofl_engine_MotionTween;
nanofl_engine_MotionTween.__name__ = ["nanofl","engine","MotionTween"];
nanofl_engine_MotionTween.load = function(node) {
	if(htmlparser_HtmlParserTools.getAttr(node,"tweenType") != "motion") return null;
	return new nanofl_engine_MotionTween(htmlparser_HtmlParserTools.getAttr(node,"motionTweenEasing",0),htmlparser_HtmlParserTools.getAttr(node,"motionTweenRotateCount",0),htmlparser_HtmlParserTools.getAttr(node,"motionTweenOrientToPath",false),htmlparser_HtmlParserTools.getAttr(node,"motionTweenRotateCountX",0),htmlparser_HtmlParserTools.getAttr(node,"motionTweenRotateCountY",0),htmlparser_HtmlParserTools.getAttr(node,"motionTweenDirectionalLightRotateCountX",0),htmlparser_HtmlParserTools.getAttr(node,"motionTweenDirectionalLightRotateCountY",0));
};
nanofl_engine_MotionTween.fixFilterSequence = function(src,dst) {
	var _g1 = 0;
	var _g = src.length;
	while(_g1 < _g) {
		var i = _g1++;
		if(i >= dst.length || dst[i].name != src[i].name) {
			var x = src[i].clone().resetToNeutral();
			dst.splice(i,0,x);
		}
	}
};
nanofl_engine_MotionTween.getInstancesMap = function(startElements,finishElements) {
	var r = new haxe_ds_ObjectMap();
	if(finishElements != null) {
		var startInstances = startElements.filter(function(e) {
			return js_Boot.__instanceof(e,nanofl_engine_elements_Instance);
		});
		var finishInstances = finishElements.filter(function(e1) {
			return js_Boot.__instanceof(e1,nanofl_engine_elements_Instance);
		});
		var _g = 0;
		while(_g < startInstances.length) {
			var instance = startInstances[_g];
			++_g;
			var _g1 = 0;
			while(_g1 < finishInstances.length) {
				var nextInstance = finishInstances[_g1];
				++_g1;
				if(nextInstance.namePath == instance.namePath) {
					r.set(instance,nextInstance);
					HxOverrides.remove(finishInstances,nextInstance);
					break;
				}
			}
		}
	}
	return r;
};
nanofl_engine_MotionTween.log = function(v,infos) {
};
nanofl_engine_MotionTween.prototype = {
	keyFrame: null
	,easing: null
	,rotateCount: null
	,orientToPath: null
	,rotateCountX: null
	,rotateCountY: null
	,directionalLightRotateCountX: null
	,directionalLightRotateCountY: null
	,save: function(out) {
		out.attr("tweenType","motion");
		out.attr("motionTweenEasing",this.easing,0);
		out.attr("motionTweenRotateCount",this.rotateCount,0);
		out.attr("motionTweenOrientToPath",this.orientToPath,false);
		out.attr("motionTweenRotateCountX",this.rotateCountX,0);
		out.attr("motionTweenRotateCountY",this.rotateCountY,0);
		out.attr("motionTweenDirectionalLightRotateCountX",this.directionalLightRotateCountX,0);
		out.attr("motionTweenDirectionalLightRotateCountY",this.directionalLightRotateCountY,0);
	}
	,apply: function(frameSubIndex) {
		var startElements = this.keyFrame.elements;
		var nextKeyFrame = this.keyFrame.getNextKeyFrame();
		var finishElements;
		if(nextKeyFrame != null) finishElements = nextKeyFrame.elements; else finishElements = null;
		var guide = this.keyFrame.getParentGuide(frameSubIndex);
		var t = frameSubIndex / this.keyFrame.duration;
		var r = [];
		if(finishElements != null) {
			var ease = createjs.Ease.get(this.easing / 100);
			var k = ease(t);
			var instancesMap = nanofl_engine_MotionTween.getInstancesMap(startElements,finishElements);
			var $it0 = HxOverrides.iter(startElements);
			while( $it0.hasNext() ) {
				var startElement = $it0.next();
				if(js_Boot.__instanceof(startElement,nanofl_engine_elements_Instance) && (function($this) {
					var $r;
					var key;
					key = js_Boot.__cast(startElement , nanofl_engine_elements_Instance);
					$r = instancesMap.h.__keys__[key.__id__] != null;
					return $r;
				}(this))) {
					var startInstance;
					startInstance = js_Boot.__cast(startElement , nanofl_engine_elements_Instance);
					var finishInstance = instancesMap.h[startInstance.__id__];
					var targetInstance;
					targetInstance = js_Boot.__cast(startInstance.clone() , nanofl_engine_elements_Instance);
					var startProps = this.translatedMatrixByLocalVector(startInstance.matrix.clone(),startInstance.regX,startInstance.regY).decompose();
					var finishProps = this.translatedMatrixByLocalVector(finishInstance.matrix.clone(),startInstance.regX,startInstance.regY).decompose();
					var props = guide.get(startProps,finishProps,this.orientToPath,k);
					targetInstance.matrix.setTransform(props.x,props.y,startProps.scaleX + (finishProps.scaleX - startProps.scaleX) * k,startProps.scaleY + (finishProps.scaleY - startProps.scaleY) * k,props.rotation + this.rotateCount * 360 * k,startProps.skewX + (finishProps.skewX - startProps.skewX) * k,startProps.skewY + (finishProps.skewY - startProps.skewY) * k);
					this.translatedMatrixByLocalVector(targetInstance.matrix,-startInstance.regX,-startInstance.regY);
					if(js_Boot.__instanceof(startInstance.symbol,nanofl_engine_libraryitems_MeshItem) && js_Boot.__instanceof(finishInstance.symbol,nanofl_engine_libraryitems_MeshItem)) {
						targetInstance.meshParams.rotationX += (finishInstance.meshParams.rotationX - startInstance.meshParams.rotationX) * k + this.rotateCountX * 360 * k;
						targetInstance.meshParams.rotationY += (finishInstance.meshParams.rotationY - startInstance.meshParams.rotationY) * k + this.rotateCountY * 360 * k;
						targetInstance.meshParams.cameraFov += Math.round((finishInstance.meshParams.cameraFov - startInstance.meshParams.cameraFov) * k);
						targetInstance.meshParams.ambientLightColor = nanofl_engine_ColorTools.getTweened(startInstance.meshParams.ambientLightColor,k,finishInstance.meshParams.ambientLightColor);
						targetInstance.meshParams.directionalLightColor = nanofl_engine_ColorTools.getTweened(startInstance.meshParams.directionalLightColor,k,finishInstance.meshParams.directionalLightColor);
						targetInstance.meshParams.directionalLightRotationX += (finishInstance.meshParams.directionalLightRotationX - startInstance.meshParams.directionalLightRotationX) * k + this.directionalLightRotateCountX * 360 * k;
						targetInstance.meshParams.directionalLightRotationY += (finishInstance.meshParams.directionalLightRotationY - startInstance.meshParams.directionalLightRotationY) * k + this.directionalLightRotateCountY * 360 * k;
					}
					if(startInstance.colorEffect != null || finishInstance.colorEffect != null) {
						var startCE;
						if(startInstance.colorEffect != null) startCE = startInstance.colorEffect; else startCE = finishInstance.colorEffect.getNeutralClone();
						var finishCE;
						if(finishInstance.colorEffect != null) finishCE = finishInstance.colorEffect; else finishCE = startInstance.colorEffect.getNeutralClone();
						if((startCE == null?null:js_Boot.getClass(startCE)) == (finishCE == null?null:js_Boot.getClass(finishCE))) targetInstance.colorEffect = startCE.getTweened(k,finishCE); else targetInstance.colorEffect = new nanofl_engine_coloreffects_ColorEffectDouble(startCE.getTweened(k,startCE.getNeutralClone()),finishCE.getNeutralClone().getTweened(k,finishCE));
					}
					var startFilters = startInstance.filters.filter(function(_) {
						return nanofl_engine_plugins_FilterPlugins.plugins.exists(_.name);
					});
					var finishFilters = finishInstance.filters.filter(function(_1) {
						return nanofl_engine_plugins_FilterPlugins.plugins.exists(_1.name);
					});
					nanofl_engine_MotionTween.fixFilterSequence(startFilters,finishFilters);
					nanofl_engine_MotionTween.fixFilterSequence(finishFilters,startFilters);
					stdlib_Debug.assert(startFilters.length == finishFilters.length,"startFilters.length = " + startFilters.length + " != finishFilters.length = " + finishFilters.length,{ fileName : "MotionTween.hx", lineNumber : 145, className : "nanofl.engine.MotionTween", methodName : "apply"});
					targetInstance.filters = [];
					var _g1 = 0;
					var _g = startFilters.length;
					while(_g1 < _g) {
						var i = _g1++;
						targetInstance.filters.push(startFilters[i].clone().tween(k,finishFilters[i]));
					}
					r.push({ original : startElement, current : targetInstance});
				} else r.push({ original : startElement, current : startElement});
			}
		} else {
			var $it1 = HxOverrides.iter(this.keyFrame.elements);
			while( $it1.hasNext() ) {
				var element = $it1.next();
				r.push({ original : element, current : element});
			}
		}
		return r;
	}
	,clone: function() {
		return new nanofl_engine_MotionTween(this.easing,this.rotateCount,this.orientToPath,this.rotateCountX,this.rotateCountY,this.directionalLightRotateCountX,this.directionalLightRotateCountY);
	}
	,isGood: function() {
		var startElements = this.keyFrame.elements;
		var nextKeyFrame = this.keyFrame.getNextKeyFrame();
		var finishElements;
		if(nextKeyFrame != null) finishElements = nextKeyFrame.elements; else finishElements = null;
		return ((function($this) {
			var $r;
			var this1 = nanofl_engine_MotionTween.getInstancesMap(startElements,finishElements);
			$r = this1.iterator();
			return $r;
		}(this))).hasNext();
	}
	,equ: function(motionTween) {
		if(motionTween.easing != this.easing) return false;
		if(motionTween.rotateCount != this.rotateCount) return false;
		if(motionTween.orientToPath != this.orientToPath) return false;
		if(motionTween.rotateCountX != this.rotateCountX) return false;
		if(motionTween.rotateCountY != this.rotateCountY) return false;
		if(motionTween.directionalLightRotateCountX != this.directionalLightRotateCountX) return false;
		if(motionTween.directionalLightRotateCountY != this.directionalLightRotateCountY) return false;
		return true;
	}
	,translatedMatrixByLocalVector: function(m,dx,dy) {
		var v = m.transformPoint(dx,dy);
		m.tx = v.x;
		m.ty = v.y;
		return m;
	}
	,__class__: nanofl_engine_MotionTween
};
var nanofl_engine_MovieClipItemTools = function() { };
$hxClasses["nanofl.engine.MovieClipItemTools"] = nanofl_engine_MovieClipItemTools;
nanofl_engine_MovieClipItemTools.__name__ = ["nanofl","engine","MovieClipItemTools"];
nanofl_engine_MovieClipItemTools.findShapes = function(item,allFrames,matrix,callb) {
	if(matrix == null) matrix = new nanofl_engine_geom_Matrix();
	nanofl_engine_MovieClipItemTools.findShapesInner(item,allFrames,matrix,false,callb);
	nanofl_engine_MovieClipItemTools.findMovieClipItems(item,allFrames,matrix,function(item1,matrix1,insideMask) {
		nanofl_engine_MovieClipItemTools.findShapesInner(item1,allFrames,matrix1,insideMask,callb);
	});
};
nanofl_engine_MovieClipItemTools.findShapesInner = function(item,allFrames,matrix,insideMask,callb) {
	nanofl_engine_MovieClipItemTools.iterateElements(item,allFrames,insideMask,function(element,e) {
		if(js_Boot.__instanceof(element,nanofl_engine_elements_ShapeElement)) callb(element,{ item : item, layerIndex : e.layerIndex, keyFrameIndex : e.keyFrameIndex, matrix : matrix, insideMask : e.insideMask});
	});
};
nanofl_engine_MovieClipItemTools.findMovieClipItems = function(item,allFrames,matrix,callb) {
	nanofl_engine_MovieClipItemTools.findInstances(item,allFrames,matrix,function(instance,e) {
		if(js_Boot.__instanceof(instance.symbol,nanofl_engine_libraryitems_MovieClipItem)) callb(instance.symbol,matrix.clone().appendMatrix(instance.matrix),e.insideMask);
	});
};
nanofl_engine_MovieClipItemTools.findInstances = function(item,allFrames,matrix,callb,insideMask) {
	if(insideMask == null) insideMask = false;
	if(matrix == null) matrix = new nanofl_engine_geom_Matrix();
	nanofl_engine_MovieClipItemTools.iterateInstances(item,allFrames,insideMask,function(instance,e) {
		callb(instance,{ item : item, layerIndex : e.layerIndex, keyFrameIndex : e.keyFrameIndex, matrix : matrix, insideMask : e.insideMask});
		if(js_Boot.__instanceof(instance.symbol,nanofl_engine_libraryitems_MovieClipItem)) nanofl_engine_MovieClipItemTools.findInstances(instance.symbol,allFrames,matrix.clone().appendMatrix(instance.matrix),callb,insideMask);
	});
};
nanofl_engine_MovieClipItemTools.iterateInstances = function(item,allFrames,insideMask,callb) {
	if(insideMask == null) insideMask = false;
	nanofl_engine_MovieClipItemTools.iterateElements(item,allFrames,insideMask,function(element,e) {
		if(js_Boot.__instanceof(element,nanofl_engine_elements_Instance)) callb(element,e);
	});
};
nanofl_engine_MovieClipItemTools.iterateElements = function(item,allFrames,insideMask,callb) {
	if(insideMask == null) insideMask = false;
	var _g1 = 0;
	var _g = item.layers.length;
	while(_g1 < _g) {
		var layerIndex = _g1++;
		var layer = item.layers[layerIndex];
		if(layer.keyFrames.length > 0) {
			var localInsideMask = insideMask || layer.type == "mask";
			var _g3 = 0;
			var _g2;
			if(allFrames) _g2 = layer.keyFrames.length; else _g2 = 1;
			while(_g3 < _g2) {
				var keyFrameIndex = _g3++;
				var keyFrame = layer.keyFrames[keyFrameIndex];
				var _g4 = 0;
				var _g5 = nanofl_engine_elements_Elements.expandGroups(keyFrame.elements);
				while(_g4 < _g5.length) {
					var element = _g5[_g4];
					++_g4;
					callb(element,{ keyFrameIndex : keyFrameIndex, layerIndex : layerIndex, insideMask : localInsideMask});
				}
			}
		}
	}
};
nanofl_engine_MovieClipItemTools.hasInstance = function(item,namePath,deep) {
	var found = false;
	if(deep) nanofl_engine_MovieClipItemTools.findInstances(item,true,null,function(instance,_) {
		if(instance.namePath == namePath) found = true;
	}); else nanofl_engine_MovieClipItemTools.iterateInstances(item,true,null,function(instance1,_1) {
		if(instance1.namePath == namePath) found = true;
	});
	return found;
};
var nanofl_engine_NullTools = function() { };
$hxClasses["nanofl.engine.NullTools"] = nanofl_engine_NullTools;
nanofl_engine_NullTools.__name__ = ["nanofl","engine","NullTools"];
nanofl_engine_NullTools.clone = function(v) {
	if(v != null) return v.clone(); else return null;
};
nanofl_engine_NullTools.equ = function(a,b) {
	return a == null && b == null || a != null && b != null && a.equ(b);
};
var nanofl_engine_RenderTools = function() { };
$hxClasses["nanofl.engine.RenderTools"] = nanofl_engine_RenderTools;
nanofl_engine_RenderTools.__name__ = ["nanofl","engine","RenderTools"];
nanofl_engine_RenderTools.drawDashedLine = function(g,x1,y1,x2,y2,color1,color2,dashLen) {
	if(dashLen == null) dashLen = 2.0;
	var dX = x2 - x1;
	var dY = y2 - y1;
	var dashes = Math.floor(Math.sqrt(dX * dX + dY * dY) / dashLen);
	var dashX = dX / dashes;
	var dashY = dY / dashes;
	g.beginStroke(color1);
	var x = x1;
	var y = y1;
	g.moveTo(x,y);
	var q = 0;
	while(q++ < dashes) {
		x += dashX;
		y += dashY;
		if(q % 2 == 0) g.moveTo(x,y); else g.lineTo(x,y);
	}
	if(q % 2 == 0) g.moveTo(x2,y2); else g.lineTo(x2,y2);
	g.endStroke();
	if(color2 != null) {
		g.beginStroke(color2);
		x = x1 + dashX;
		y = y1 + dashY;
		g.moveTo(x,y);
		q = 1;
		while(q++ < dashes) {
			x += dashX;
			y += dashY;
			if(q % 2 == 1) g.moveTo(x,y); else g.lineTo(x,y);
		}
		if(q % 2 == 1) g.moveTo(x2,y2); else g.lineTo(x2,y2);
		g.endStroke();
	}
	return g;
};
nanofl_engine_RenderTools.drawDashedRect = function(g,x1,y1,x2,y2,color1,color2,dashLen) {
	if(dashLen == null) dashLen = 2.0;
	nanofl_engine_RenderTools.drawDashedLine(g,x1,y1,x2,y1,color1,color2,dashLen);
	nanofl_engine_RenderTools.drawDashedLine(g,x2,y1,x2,y2,color1,color2,dashLen);
	nanofl_engine_RenderTools.drawDashedLine(g,x2,y2,x1,y2,color1,color2,dashLen);
	nanofl_engine_RenderTools.drawDashedLine(g,x1,y2,x1,y1,color1,color2,dashLen);
	return g;
};
var nanofl_engine_ScaleMode = function() { };
$hxClasses["nanofl.engine.ScaleMode"] = nanofl_engine_ScaleMode;
nanofl_engine_ScaleMode.__name__ = ["nanofl","engine","ScaleMode"];
var nanofl_engine_TextureItemTools = function() { };
$hxClasses["nanofl.engine.TextureItemTools"] = nanofl_engine_TextureItemTools;
nanofl_engine_TextureItemTools.__name__ = ["nanofl","engine","TextureItemTools"];
nanofl_engine_TextureItemTools.getSpriteSheet = function(item) {
	if(item.textureAtlas != null && item.textureAtlas != "" && Object.prototype.hasOwnProperty.call(nanofl_Player.spriteSheets,item.namePath)) return Reflect.field(nanofl_Player.spriteSheets,item.namePath); else return null;
};
nanofl_engine_TextureItemTools.preload = function(item,ready) {
	var spriteSheet = nanofl_engine_TextureItemTools.getSpriteSheet(item);
	if(spriteSheet != null) {
		if(spriteSheet.complete) ready(); else spriteSheet.addEventListener("complete",function(_) {
			ready();
		},null);
	} else ready();
};
var nanofl_engine_Version = function() { };
$hxClasses["nanofl.engine.Version"] = nanofl_engine_Version;
nanofl_engine_Version.__name__ = ["nanofl","engine","Version"];
nanofl_engine_Version.compare = function(v1,v2) {
	var n1 = v1.split(".").map(Std.parseInt);
	var n2 = v2.split(".").map(Std.parseInt);
	var _g = 0;
	while(_g < 3) {
		var i = _g++;
		var r = Reflect.compare(n1[i],n2[i]);
		if(r != 0) return r;
	}
	return 0;
};
nanofl_engine_Version.handle = function(version,handlers) {
	var versions = stdlib_LambdaIterable.sorted(((function(_e) {
		return function(pred) {
			return stdlib_LambdaIterator.filter(_e,pred);
		};
	})(handlers.keys()))(function(_) {
		return nanofl_engine_Version.compare(_,version) <= 0;
	}),nanofl_engine_Version.compare);
	if(versions.length == 0) versions = stdlib_LambdaIterator.sorted(handlers.keys(),nanofl_engine_Version.compare);
	return handlers.get(versions[versions.length - 1])();
};
var nanofl_engine_coloreffects_ColorEffect = function() { };
$hxClasses["nanofl.engine.coloreffects.ColorEffect"] = nanofl_engine_coloreffects_ColorEffect;
nanofl_engine_coloreffects_ColorEffect.__name__ = ["nanofl","engine","coloreffects","ColorEffect"];
nanofl_engine_coloreffects_ColorEffect.load = function(node) {
	if(node != null) {
		stdlib_Debug.assert(node.name == "color",node.name,{ fileName : "ColorEffect.hx", lineNumber : 44, className : "nanofl.engine.coloreffects.ColorEffect", methodName : "load"});
		var _g = node.getAttribute("type");
		switch(_g) {
		case "brightness":
			return nanofl_engine_coloreffects_ColorEffectBrightness.load(node);
		case "tint":
			return nanofl_engine_coloreffects_ColorEffectTint.load(node);
		case "advanced":
			return nanofl_engine_coloreffects_ColorEffectAdvanced.load(node);
		case "alpha":
			return nanofl_engine_coloreffects_ColorEffectAlpha.load(node);
		}
	}
	return null;
};
nanofl_engine_coloreffects_ColorEffect.prototype = {
	apply: function(obj) {
		throw new js__$Boot_HaxeError("Unsupported.");
	}
	,clone: function() {
		throw new js__$Boot_HaxeError("Unsupported.");
		return null;
	}
	,getNeutralClone: function() {
		throw new js__$Boot_HaxeError("Unsupported.");
		return null;
	}
	,getTweened: function(k,finish) {
		throw new js__$Boot_HaxeError("Unsupported.");
		return null;
	}
	,save: function(out) {
		stdlib_Debug.methodMustBeOverriden(this,{ fileName : "ColorEffect.hx", lineNumber : 56, className : "nanofl.engine.coloreffects.ColorEffect", methodName : "save"});
	}
	,equ: function(c) {
		return stdlib_Debug.methodMustBeOverriden(this,{ fileName : "ColorEffect.hx", lineNumber : 58, className : "nanofl.engine.coloreffects.ColorEffect", methodName : "equ"});
	}
	,__class__: nanofl_engine_coloreffects_ColorEffect
};
var nanofl_engine_coloreffects_ColorEffectAdvanced = function(alphaMultiplier,redMultiplier,greenMultiplier,blueMultiplier,alphaOffset,redOffset,greenOffset,blueOffset) {
	this.alphaMultiplier = alphaMultiplier;
	this.redMultiplier = redMultiplier;
	this.greenMultiplier = greenMultiplier;
	this.blueMultiplier = blueMultiplier;
	this.alphaOffset = alphaOffset;
	this.redOffset = redOffset;
	this.greenOffset = greenOffset;
	this.blueOffset = blueOffset;
};
$hxClasses["nanofl.engine.coloreffects.ColorEffectAdvanced"] = nanofl_engine_coloreffects_ColorEffectAdvanced;
nanofl_engine_coloreffects_ColorEffectAdvanced.__name__ = ["nanofl","engine","coloreffects","ColorEffectAdvanced"];
nanofl_engine_coloreffects_ColorEffectAdvanced.load = function(node) {
	return new nanofl_engine_coloreffects_ColorEffectAdvanced(htmlparser_HtmlParserTools.getAttr(node,"alphaMultiplier",1.0),htmlparser_HtmlParserTools.getAttr(node,"redMultiplier",1.0),htmlparser_HtmlParserTools.getAttr(node,"greenMultiplier",1.0),htmlparser_HtmlParserTools.getAttr(node,"blueMultiplier",1.0),htmlparser_HtmlParserTools.getAttr(node,"alphaOffset",0.0),htmlparser_HtmlParserTools.getAttr(node,"redOffset",0.0),htmlparser_HtmlParserTools.getAttr(node,"greenOffset",0.0),htmlparser_HtmlParserTools.getAttr(node,"blueOffset",0.0));
};
nanofl_engine_coloreffects_ColorEffectAdvanced.__super__ = nanofl_engine_coloreffects_ColorEffect;
nanofl_engine_coloreffects_ColorEffectAdvanced.prototype = $extend(nanofl_engine_coloreffects_ColorEffect.prototype,{
	redMultiplier: null
	,greenMultiplier: null
	,blueMultiplier: null
	,alphaMultiplier: null
	,redOffset: null
	,greenOffset: null
	,blueOffset: null
	,alphaOffset: null
	,save: function(out) {
		out.begin("color").attr("type","advanced");
		out.attr("alphaMultiplier",this.alphaMultiplier);
		out.attr("redMultiplier",this.redMultiplier);
		out.attr("greenMultiplier",this.greenMultiplier);
		out.attr("blueMultiplier",this.blueMultiplier);
		out.attr("alphaOffset",this.alphaOffset);
		out.attr("redOffset",this.redOffset);
		out.attr("greenOffset",this.greenOffset);
		out.attr("blueOffset",this.blueOffset);
		out.end();
	}
	,apply: function(obj) {
		if(obj.filters == null) obj.filters = [];
		obj.filters.push(new createjs.ColorFilter(this.redMultiplier,this.greenMultiplier,this.blueMultiplier,this.alphaMultiplier,this.redOffset,this.greenOffset,this.blueOffset,this.alphaOffset));
	}
	,clone: function() {
		return new nanofl_engine_coloreffects_ColorEffectAdvanced(this.alphaMultiplier,this.redMultiplier,this.greenMultiplier,this.blueMultiplier,this.alphaOffset,this.redOffset,this.greenOffset,this.blueOffset);
	}
	,getNeutralClone: function() {
		return new nanofl_engine_coloreffects_ColorEffectAdvanced(1,1,1,1,0,0,0,0);
	}
	,getTweened: function(k,finish) {
		stdlib_Debug.assert(js_Boot.__instanceof(finish,nanofl_engine_coloreffects_ColorEffectAdvanced),null,{ fileName : "ColorEffectAdvanced.hx", lineNumber : 92, className : "nanofl.engine.coloreffects.ColorEffectAdvanced", methodName : "getTweened"});
		return new nanofl_engine_coloreffects_ColorEffectAdvanced(this.alphaMultiplier + (finish.alphaMultiplier - this.alphaMultiplier) * k,this.redMultiplier + (finish.redMultiplier - this.redMultiplier) * k,this.greenMultiplier + (finish.greenMultiplier - this.greenMultiplier) * k,this.blueMultiplier + (finish.blueMultiplier - this.blueMultiplier) * k,this.alphaOffset + (finish.alphaOffset - this.alphaOffset) * k,this.redOffset + (finish.redOffset - this.redOffset) * k,this.greenOffset + (finish.greenOffset - this.greenOffset) * k,this.blueOffset + (finish.blueOffset - this.blueOffset) * k);
	}
	,equ: function(c) {
		return js_Boot.__instanceof(c,nanofl_engine_coloreffects_ColorEffectAdvanced) && this.redMultiplier == c.redMultiplier && this.greenMultiplier == c.greenMultiplier && this.blueMultiplier == c.blueMultiplier && this.alphaMultiplier == c.alphaMultiplier && this.redOffset == c.redOffset && this.greenOffset == c.greenOffset && this.blueOffset == c.blueOffset && this.alphaOffset == c.alphaOffset;
	}
	,__class__: nanofl_engine_coloreffects_ColorEffectAdvanced
});
var nanofl_engine_coloreffects_ColorEffectAlpha = function(value) {
	this.value = value;
};
$hxClasses["nanofl.engine.coloreffects.ColorEffectAlpha"] = nanofl_engine_coloreffects_ColorEffectAlpha;
nanofl_engine_coloreffects_ColorEffectAlpha.__name__ = ["nanofl","engine","coloreffects","ColorEffectAlpha"];
nanofl_engine_coloreffects_ColorEffectAlpha.load = function(node) {
	return new nanofl_engine_coloreffects_ColorEffectAlpha(htmlparser_HtmlParserTools.getAttr(node,"value",1.0));
};
nanofl_engine_coloreffects_ColorEffectAlpha.__super__ = nanofl_engine_coloreffects_ColorEffect;
nanofl_engine_coloreffects_ColorEffectAlpha.prototype = $extend(nanofl_engine_coloreffects_ColorEffect.prototype,{
	value: null
	,save: function(out) {
		out.begin("color").attr("type","alpha");
		out.attr("value",this.value);
		out.end();
	}
	,apply: function(obj) {
		obj.alpha = this.value;
	}
	,clone: function() {
		return new nanofl_engine_coloreffects_ColorEffectAlpha(this.value);
	}
	,getNeutralClone: function() {
		return new nanofl_engine_coloreffects_ColorEffectAlpha(1);
	}
	,getTweened: function(k,finish) {
		return new nanofl_engine_coloreffects_ColorEffectAlpha(this.value + ((js_Boot.__cast(finish , nanofl_engine_coloreffects_ColorEffectAlpha)).value - this.value) * k);
	}
	,equ: function(c) {
		return js_Boot.__instanceof(c,nanofl_engine_coloreffects_ColorEffectAlpha) && this.value == c.value;
	}
	,__class__: nanofl_engine_coloreffects_ColorEffectAlpha
});
var nanofl_engine_coloreffects_ColorEffectBrightness = function(value) {
	this.value = value;
};
$hxClasses["nanofl.engine.coloreffects.ColorEffectBrightness"] = nanofl_engine_coloreffects_ColorEffectBrightness;
nanofl_engine_coloreffects_ColorEffectBrightness.__name__ = ["nanofl","engine","coloreffects","ColorEffectBrightness"];
nanofl_engine_coloreffects_ColorEffectBrightness.load = function(node) {
	return new nanofl_engine_coloreffects_ColorEffectBrightness(htmlparser_HtmlParserTools.getAttr(node,"value",0.0));
};
nanofl_engine_coloreffects_ColorEffectBrightness.__super__ = nanofl_engine_coloreffects_ColorEffect;
nanofl_engine_coloreffects_ColorEffectBrightness.prototype = $extend(nanofl_engine_coloreffects_ColorEffect.prototype,{
	value: null
	,save: function(out) {
		out.begin("color").attr("type","brightness");
		out.attr("value",this.value);
		out.end();
	}
	,apply: function(obj) {
		if(obj.filters == null) obj.filters = [];
		if(this.value > 0) obj.filters.push(new createjs.ColorFilter(1,1,1,1,this.value * 255,this.value * 255,this.value * 255,0)); else if(this.value < 0) obj.filters.push(new createjs.ColorFilter(1 + this.value,1 + this.value,1 + this.value,1,0,0,0,0));
	}
	,clone: function() {
		return new nanofl_engine_coloreffects_ColorEffectBrightness(this.value);
	}
	,getNeutralClone: function() {
		return new nanofl_engine_coloreffects_ColorEffectBrightness(0);
	}
	,getTweened: function(k,finish) {
		return new nanofl_engine_coloreffects_ColorEffectBrightness(this.value + ((js_Boot.__cast(finish , nanofl_engine_coloreffects_ColorEffectBrightness)).value - this.value) * k);
	}
	,equ: function(c) {
		return js_Boot.__instanceof(c,nanofl_engine_coloreffects_ColorEffectBrightness) && this.value == c.value;
	}
	,__class__: nanofl_engine_coloreffects_ColorEffectBrightness
});
var nanofl_engine_coloreffects_ColorEffectDouble = function(effect0,effect1) {
	this.effect0 = effect0;
	this.effect1 = effect1;
};
$hxClasses["nanofl.engine.coloreffects.ColorEffectDouble"] = nanofl_engine_coloreffects_ColorEffectDouble;
nanofl_engine_coloreffects_ColorEffectDouble.__name__ = ["nanofl","engine","coloreffects","ColorEffectDouble"];
nanofl_engine_coloreffects_ColorEffectDouble.__super__ = nanofl_engine_coloreffects_ColorEffect;
nanofl_engine_coloreffects_ColorEffectDouble.prototype = $extend(nanofl_engine_coloreffects_ColorEffect.prototype,{
	effect0: null
	,effect1: null
	,apply: function(obj) {
		this.effect0.apply(obj);
		this.effect1.apply(obj);
	}
	,equ: function(c) {
		return js_Boot.__instanceof(c,nanofl_engine_coloreffects_ColorEffectDouble) && this.effect0.equ(c.effect0) && this.effect1.equ(c.effect1);
	}
	,__class__: nanofl_engine_coloreffects_ColorEffectDouble
});
var nanofl_engine_coloreffects_ColorEffectTint = function(color,multiplier) {
	this.color = color;
	this.multiplier = multiplier;
};
$hxClasses["nanofl.engine.coloreffects.ColorEffectTint"] = nanofl_engine_coloreffects_ColorEffectTint;
nanofl_engine_coloreffects_ColorEffectTint.__name__ = ["nanofl","engine","coloreffects","ColorEffectTint"];
nanofl_engine_coloreffects_ColorEffectTint.load = function(node) {
	return new nanofl_engine_coloreffects_ColorEffectTint(htmlparser_HtmlParserTools.getAttr(node,"color"),htmlparser_HtmlParserTools.getAttr(node,"multiplier",1.0));
};
nanofl_engine_coloreffects_ColorEffectTint.__super__ = nanofl_engine_coloreffects_ColorEffect;
nanofl_engine_coloreffects_ColorEffectTint.prototype = $extend(nanofl_engine_coloreffects_ColorEffect.prototype,{
	color: null
	,multiplier: null
	,save: function(out) {
		out.begin("color").attr("type","tint");
		out.attr("color",this.color);
		out.attr("multiplier",this.multiplier);
		out.end();
	}
	,apply: function(obj) {
		var rgb = nanofl_engine_ColorTools.parse(this.color);
		if(obj.filters == null) obj.filters = [];
		obj.filters.push(new createjs.ColorFilter(1 - this.multiplier,1 - this.multiplier,1 - this.multiplier,1,rgb.r * this.multiplier,rgb.g * this.multiplier,rgb.b * this.multiplier,0));
	}
	,clone: function() {
		return new nanofl_engine_coloreffects_ColorEffectTint(this.color,this.multiplier);
	}
	,getNeutralClone: function() {
		return new nanofl_engine_coloreffects_ColorEffectTint(this.color,0);
	}
	,getTweened: function(k,finish) {
		return new nanofl_engine_coloreffects_ColorEffectTint(nanofl_engine_ColorTools.getTweened(this.color,k,(js_Boot.__cast(finish , nanofl_engine_coloreffects_ColorEffectTint)).color),this.multiplier + ((js_Boot.__cast(finish , nanofl_engine_coloreffects_ColorEffectTint)).multiplier - this.multiplier) * k);
	}
	,equ: function(c) {
		return js_Boot.__instanceof(c,nanofl_engine_coloreffects_ColorEffectTint) && this.color == c.color && this.multiplier == c.multiplier;
	}
	,__class__: nanofl_engine_coloreffects_ColorEffectTint
});
var nanofl_engine_elements_Element = function() {
	this.visible = true;
	this.regY = 0.0;
	this.regX = 0.0;
	this.matrix = new nanofl_engine_geom_Matrix();
};
$hxClasses["nanofl.engine.elements.Element"] = nanofl_engine_elements_Element;
nanofl_engine_elements_Element.__name__ = ["nanofl","engine","elements","Element"];
nanofl_engine_elements_Element.parse = function(node,version) {
	var element = null;
	var _g = node.name;
	switch(_g) {
	case "instance":
		element = new nanofl_engine_elements_Instance(null);
		break;
	case "text":
		element = new nanofl_engine_elements_TextElement(null,null,null,null,null,null);
		break;
	case "shape":
		element = new nanofl_engine_elements_ShapeElement();
		break;
	case "group":
		element = new nanofl_engine_elements_GroupElement([]);
		break;
	}
	if(element != null) {
		element.visible = true;
		if(!element.loadProperties(node,version)) return null;
		stdlib_Debug.assert(element.matrix != null,null,{ fileName : "Element.hx", lineNumber : 48, className : "nanofl.engine.elements.Element", methodName : "parse"});
	}
	return element;
};
nanofl_engine_elements_Element.prototype = {
	matrix: null
	,regX: null
	,regY: null
	,visible: null
	,parent: null
	,loadProperties: function(node,version) {
		this.matrix = nanofl_engine_geom_Matrix.load(node);
		this.regX = htmlparser_HtmlParserTools.getAttr(node,"regX",0.0);
		this.regY = htmlparser_HtmlParserTools.getAttr(node,"regY",0.0);
		return true;
	}
	,save: function(out) {
		this.matrix.save(out);
		out.attr("regX",this.regX,0.0);
		out.attr("regY",this.regY,0.0);
	}
	,copyBaseProperties: function(obj) {
		obj.matrix = this.matrix.clone();
		obj.regX = this.regX;
		obj.regY = this.regY;
		obj.parent = this.parent;
		obj.visible = this.visible;
	}
	,clone: function() {
		return stdlib_Debug.methodNotSupported(this,{ fileName : "Element.hx", lineNumber : 78, className : "nanofl.engine.elements.Element", methodName : "clone"});
	}
	,translate: function(dx,dy) {
		this.matrix.translate(dx,dy);
	}
	,createDisplayObject: function(frameIndexes) {
		return stdlib_Debug.methodMustBeOverriden(this,{ fileName : "Element.hx", lineNumber : 87, className : "nanofl.engine.elements.Element", methodName : "createDisplayObject"});
	}
	,updateDisplayObject: function(dispObj,frameIndexes) {
		return stdlib_Debug.methodMustBeOverriden(this,{ fileName : "Element.hx", lineNumber : 89, className : "nanofl.engine.elements.Element", methodName : "updateDisplayObject"});
	}
	,updateDisplayObjectProperties: function(dispObj) {
		dispObj.visible = this.visible;
		dispObj.set(this.matrix.decompose());
		dispObj.filters = [];
		dispObj.setBounds(null,null,null,null);
		dispObj.uncache();
	}
	,setLibrary: function(library) {
	}
	,transform: function(m,applyToStrokeAndFill) {
		if(applyToStrokeAndFill == null) applyToStrokeAndFill = true;
		this.matrix.prependMatrix(m);
	}
	,equ: function(element) {
		if((element == null?null:js_Boot.getClass(element)) != js_Boot.getClass(this)) return false;
		if(!element.matrix.equ(this.matrix)) return false;
		if(element.regX != this.regX) return false;
		if(element.regY != this.regY) return false;
		if(element.visible != this.visible) return false;
		return true;
	}
	,getNearestPoint: function(pos) {
		var pos1 = this.matrix.clone().invert().transformPointP(pos);
		var points = this.getNearestPointsLocal(pos1);
		if(points.length == 0 || points.length == 1 && points[0].x == 1e100 && points[0].y == 1e100) return { x : 1e100, y : 1e100};
		points.sort(function(a,b) {
			return Reflect.compare(nanofl_engine_geom_PointTools.getDist(pos1.x,pos1.y,a.x,a.y),nanofl_engine_geom_PointTools.getDist(pos1.x,pos1.y,b.x,b.y));
		});
		return this.matrix.transformPointP(points[0]);
	}
	,getNearestPointsLocal: function(pos) {
		return [];
	}
	,toString: function() {
		var className = Type.getClassName(js_Boot.getClass(this));
		var pos = className.lastIndexOf(".") + 1;
		className = HxOverrides.substr(className,pos,null);
		var parents;
		if(this.parent != null) parents = this.parent.toString(); else parents = "";
		if(StringTools.endsWith(parents," / layer / frame")) parents = parents.substring(0,parents.length - " / layer / frame".length);
		return (parents != ""?parents + " / ":"") + className;
	}
	,__class__: nanofl_engine_elements_Element
};
var nanofl_engine_elements_Elements = function() { };
$hxClasses["nanofl.engine.elements.Elements"] = nanofl_engine_elements_Elements;
nanofl_engine_elements_Elements.__name__ = ["nanofl","engine","elements","Elements"];
nanofl_engine_elements_Elements.parse = function(base,version) {
	var elements = [];
	var _g = 0;
	var _g1 = base.children;
	while(_g < _g1.length) {
		var node = _g1[_g];
		++_g;
		var element = nanofl_engine_elements_Element.parse(node,version);
		if(element != null) elements.push(element);
	}
	return elements;
};
nanofl_engine_elements_Elements.save = function(elements,out) {
	var $it0 = HxOverrides.iter(elements);
	while( $it0.hasNext() ) {
		var element = $it0.next();
		element.save(out);
	}
};
nanofl_engine_elements_Elements.expandGroups = function(elements) {
	var r = [];
	var $it0 = HxOverrides.iter(elements);
	while( $it0.hasNext() ) {
		var element = $it0.next();
		if(js_Boot.__instanceof(element,nanofl_engine_elements_GroupElement)) r = r.concat(nanofl_engine_elements_Elements.expandGroups(element.getChildren())); else r.push(element);
	}
	return r;
};
var nanofl_engine_elements_GroupElement = function(elements) {
	this.name = "";
	var _g = this;
	nanofl_engine_elements_Element.call(this);
	Object.defineProperty(this,"elements",{ get : function() {
		return _g.get_elements();
	}});
	Object.defineProperty(this,"currentFrame",{ get : function() {
		return _g.get_currentFrame();
	}, set : function(v) {
		_g.set_currentFrame(v);
	}});
	Object.defineProperty(this,"layers",{ get : function() {
		return _g.get_layers();
	}});
	if(elements != null) this._elements = elements; else this._elements = [];
	var $it0 = HxOverrides.iter(this.elements);
	while( $it0.hasNext() ) {
		var element = $it0.next();
		element.parent = this;
	}
};
$hxClasses["nanofl.engine.elements.GroupElement"] = nanofl_engine_elements_GroupElement;
nanofl_engine_elements_GroupElement.__name__ = ["nanofl","engine","elements","GroupElement"];
nanofl_engine_elements_GroupElement.__interfaces__ = [nanofl_engine_IElementsContainer,nanofl_engine_IPathElement];
nanofl_engine_elements_GroupElement.__super__ = nanofl_engine_elements_Element;
nanofl_engine_elements_GroupElement.prototype = $extend(nanofl_engine_elements_Element.prototype,{
	_elements: null
	,elements: null
	,get_elements: function() {
		return this._elements;
	}
	,name: null
	,currentFrame: null
	,get_currentFrame: function() {
		return 0;
	}
	,set_currentFrame: function(v) {
		return v;
	}
	,_layers: null
	,layers: null
	,get_layers: function() {
		if(this._layers == null) {
			var layer = new nanofl_engine_Layer("auto");
			layer.layersContainer = this;
			layer.addKeyFrame(new nanofl_engine_GroupKeyFrame(this));
			this._layers = [layer];
		}
		return this._layers;
	}
	,addElement: function(element,index) {
		if(index == null) this._elements.push(element); else this._elements.splice(index,0,element);
		element.parent = this;
	}
	,removeElementAt: function(n) {
		this._elements.splice(n,1);
	}
	,removeElement: function(element) {
		var n = HxOverrides.indexOf(this.elements,element,0);
		if(n >= 0) this.removeElementAt(n);
	}
	,loadProperties: function(node,version) {
		if(!nanofl_engine_elements_Element.prototype.loadProperties.call(this,node,version)) return false;
		this.name = htmlparser_HtmlParserTools.getAttr(node,"name","");
		this._elements = [];
		var _g = 0;
		var _g1 = nanofl_engine_elements_Elements.parse(node,version);
		while(_g < _g1.length) {
			var element = _g1[_g];
			++_g;
			this.addElement(element);
		}
		return this.elements.length > 0;
	}
	,save: function(out) {
		out.begin("group");
		out.attr("name",this.name,"");
		nanofl_engine_elements_Element.prototype.save.call(this,out);
		nanofl_engine_elements_Elements.save(this.elements,out);
		out.end();
	}
	,clone: function() {
		var obj = new nanofl_engine_elements_GroupElement(nanofl_engine_ArrayTools.clone(this._elements));
		this.copyBaseProperties(obj);
		obj.name = this.name;
		return obj;
	}
	,setLibrary: function(library) {
		var $it0 = HxOverrides.iter(this.elements);
		while( $it0.hasNext() ) {
			var element = $it0.next();
			element.setLibrary(library);
		}
	}
	,getChildren: function() {
		return this.elements;
	}
	,createDisplayObject: function(frameIndexes) {
		return this.updateDisplayObject(new createjs.Container(),frameIndexes);
	}
	,updateDisplayObject: function(dispObj,frameIndexes) {
		stdlib_Debug.assert(js_Boot.__instanceof(dispObj,createjs.Container),this.toString(),{ fileName : "GroupElement.hx", lineNumber : 113, className : "nanofl.engine.elements.GroupElement", methodName : "updateDisplayObject"});
		stdlib_Debug.assert(this.elements.length > 0,this.toString(),{ fileName : "GroupElement.hx", lineNumber : 114, className : "nanofl.engine.elements.GroupElement", methodName : "updateDisplayObject"});
		if(frameIndexes != null && frameIndexes.length > 0 && frameIndexes[0].element == this) frameIndexes = frameIndexes.slice(1); else frameIndexes = null;
		this.updateDisplayObjectProperties(dispObj);
		var container = dispObj;
		container.removeAllChildren();
		var topElement = null;
		var $it0 = HxOverrides.iter(this.elements);
		while( $it0.hasNext() ) {
			var element = $it0.next();
			if(frameIndexes == null || frameIndexes.length == 0 || frameIndexes[0].element != element) container.addChild(element.createDisplayObject(frameIndexes)); else if(frameIndexes != null && frameIndexes.length != 0 && frameIndexes[0].element == element) topElement = element;
		}
		if(topElement != null) container.addChild(topElement.createDisplayObject(frameIndexes));
		return container;
	}
	,getMaskFilter: function(layer,frameIndex) {
		return null;
	}
	,isScene: function() {
		return false;
	}
	,getNavigatorName: function() {
		return "group";
	}
	,getNavigatorIcon: function() {
		return "custom-icon-group";
	}
	,getTimeline: function() {
		return null;
	}
	,transform: function(m,applyToStrokeAndFill) {
		if(applyToStrokeAndFill == null) applyToStrokeAndFill = true;
		var $it0 = HxOverrides.iter(this.elements);
		while( $it0.hasNext() ) {
			var e = $it0.next();
			e.transform(m,applyToStrokeAndFill);
		}
	}
	,getNearestPointsLocal: function(pos) {
		return this.elements.map(function(element) {
			return element.getNearestPoint(pos);
		});
	}
	,equ: function(element) {
		if(!nanofl_engine_elements_Element.prototype.equ.call(this,element)) return false;
		if(element.name != this.name) return false;
		if(!nanofl_engine_ArrayTools.equ(element._elements,this._elements)) return false;
		return true;
	}
	,hxUnserialize: function(s) {
		var _g = this;
		Object.defineProperty(this,"elements",{ get : function() {
			return _g.get_elements();
		}});
		Object.defineProperty(this,"currentFrame",{ get : function() {
			return _g.get_currentFrame();
		}, set : function(v) {
			_g.set_currentFrame(v);
		}});
		Object.defineProperty(this,"layers",{ get : function() {
			return _g.get_layers();
		}});
		s.unserializeObject(this);
	}
	,hxSerialize: function(s) {
		s.serializeFields(this);
	}
	,__class__: nanofl_engine_elements_GroupElement
});
var nanofl_engine_elements_Instance = function(namePath,name,colorEffect,filters,blendMode,meshParams) {
	var _g = this;
	nanofl_engine_elements_Element.call(this);
	Object.defineProperty(this,"symbol",{ get : function() {
		return _g.get_symbol();
	}});
	Object.defineProperty(this,"layers",{ get : function() {
		return _g.get_layers();
	}});
	this.namePath = namePath;
	this.name = name;
	this.colorEffect = colorEffect;
	if(filters != null) this.filters = filters; else this.filters = [];
	if(blendMode != null) this.blendMode = blendMode; else this.blendMode = "normal";
	if(meshParams != null) this.meshParams = meshParams; else this.meshParams = new nanofl_engine_MeshParams();
};
$hxClasses["nanofl.engine.elements.Instance"] = nanofl_engine_elements_Instance;
nanofl_engine_elements_Instance.__name__ = ["nanofl","engine","elements","Instance"];
nanofl_engine_elements_Instance.__interfaces__ = [nanofl_engine_IPathElement];
nanofl_engine_elements_Instance.__super__ = nanofl_engine_elements_Element;
nanofl_engine_elements_Instance.prototype = $extend(nanofl_engine_elements_Element.prototype,{
	library: null
	,namePath: null
	,name: null
	,colorEffect: null
	,filters: null
	,blendMode: null
	,meshParams: null
	,symbol: null
	,get_symbol: function() {
		return js_Boot.__cast(this.library.getItem(this.namePath) , nanofl_engine_libraryitems_InstancableItem);
	}
	,loadProperties: function(node,version) {
		if(!nanofl_engine_elements_Element.prototype.loadProperties.call(this,node,version)) return false;
		this.namePath = htmlparser_HtmlParserTools.getAttr(node,"libraryItem");
		stdlib_Debug.assert(this.namePath != null,null,{ fileName : "Instance.hx", lineNumber : 47, className : "nanofl.engine.elements.Instance", methodName : "loadProperties"});
		stdlib_Debug.assert(this.namePath != "",null,{ fileName : "Instance.hx", lineNumber : 48, className : "nanofl.engine.elements.Instance", methodName : "loadProperties"});
		this.name = htmlparser_HtmlParserTools.getAttr(node,"name","");
		this.colorEffect = nanofl_engine_coloreffects_ColorEffect.load(htmlparser_HtmlParserTools.findOne(node,">color"));
		this.filters = node.find(">filters>*").map(function(node1) {
			return nanofl_engine_FilterDef.load(node1,version);
		});
		this.blendMode = htmlparser_HtmlParserTools.getAttr(node,"blendMode","normal");
		this.meshParams = nanofl_engine_MeshParams.load(node);
		return true;
	}
	,save: function(out) {
		out.begin("instance").attr("libraryItem",this.namePath).attr("name",this.name,"").attr("blendMode",this.blendMode,"normal");
		if(this.meshParams != null) this.meshParams.save(out);
		if(this.colorEffect != null) this.colorEffect.save(out);
		if(this.filters.length > 0) {
			out.begin("filters");
			var _g = 0;
			var _g1 = this.filters;
			while(_g < _g1.length) {
				var filter = _g1[_g];
				++_g;
				filter.save(out);
			}
			out.end();
		}
		nanofl_engine_elements_Element.prototype.save.call(this,out);
		out.end();
	}
	,clone: function() {
		var obj = new nanofl_engine_elements_Instance(this.namePath,this.name,nanofl_engine_NullTools.clone(this.colorEffect),nanofl_engine_ArrayTools.clone(this.filters),this.blendMode,nanofl_engine_NullTools.clone(this.meshParams));
		obj.library = this.library;
		this.copyBaseProperties(obj);
		return obj;
	}
	,isScene: function() {
		return this.namePath == nanofl_engine_Library.SCENE_NAME_PATH;
	}
	,toString: function() {
		return (this.parent != null?this.parent.toString() + " / ":"") + "Instance(" + this.namePath + ")";
	}
	,layers: null
	,get_layers: function() {
		if(js_Boot.__instanceof(this.symbol,nanofl_engine_ILayersContainer)) return this.symbol.layers; else return null;
	}
	,createDisplayObject: function(frameIndexes) {
		var initFrameIndex = 0;
		if(frameIndexes != null && frameIndexes.length > 0 && frameIndexes[0].element == this) {
			initFrameIndex = frameIndexes[0].frameIndex;
			frameIndexes = frameIndexes.slice(1);
		} else frameIndexes = null;
		var dispObj = this.symbol.createDisplayObject(initFrameIndex,frameIndexes);
		this.updateDisplayObjectProperties(dispObj);
		this.updateDisplayObjectInstanceProperties(dispObj);
		return dispObj;
	}
	,updateDisplayObject: function(dispObj,frameIndexes) {
		this.updateDisplayObjectProperties(dispObj);
		this.symbol.updateDisplayObject(dispObj,frameIndexes);
		this.updateDisplayObjectInstanceProperties(dispObj);
		return dispObj;
	}
	,updateDisplayObjectInstanceProperties: function(dispObj) {
		if(dispObj.filters == null) dispObj.filters = [];
		dispObj.alpha = 1.0;
		if(this.colorEffect != null) this.colorEffect.apply(dispObj);
		var _g = 0;
		var _g1 = this.filters;
		while(_g < _g1.length) {
			var filter = _g1[_g];
			++_g;
			var f = filter.getFilter();
			if(f != null) dispObj.filters.push(f);
		}
		if(this.name != "") dispObj.name = this.name;
		dispObj.compositeOperation = this.blendMode;
		if(this.meshParams != null && js_Boot.__instanceof(dispObj,nanofl_Mesh)) this.meshParams.applyToMesh(dispObj);
	}
	,getNavigatorName: function() {
		return this.namePath;
	}
	,getNavigatorIcon: function() {
		return this.symbol.getIcon();
	}
	,getChildren: function() {
		var r = [];
		var $it0 = HxOverrides.iter(this.layers);
		while( $it0.hasNext() ) {
			var layer = $it0.next();
			if(layer.keyFrames.length > 0) r = layer.keyFrames[0].elements.concat(r);
		}
		return r;
	}
	,getTimeline: function() {
		if(js_Boot.__instanceof(this.symbol,nanofl_engine_ITimeline)) return this.symbol; else return null;
	}
	,getNearestPointsLocal: function(pos) {
		return [this.symbol.getNearestPoint(pos)];
	}
	,setLibrary: function(library) {
		this.library = library;
	}
	,equ: function(element) {
		if(!nanofl_engine_elements_Element.prototype.equ.call(this,element)) return false;
		if(element.namePath != this.namePath) return false;
		if(element.name != this.name) return false;
		if(!nanofl_engine_NullTools.equ(element.colorEffect,this.colorEffect)) return false;
		if(!nanofl_engine_ArrayTools.equ(element.filters,this.filters)) return false;
		if(element.blendMode != this.blendMode) return false;
		if(!nanofl_engine_NullTools.equ(element.meshParams,this.meshParams)) return false;
		return true;
	}
	,hxUnserialize: function(s) {
		var _g = this;
		Object.defineProperty(this,"symbol",{ get : function() {
			return _g.get_symbol();
		}});
		Object.defineProperty(this,"layers",{ get : function() {
			return _g.get_layers();
		}});
		s.unserializeObject(this);
	}
	,hxSerialize: function(s) {
		s.serializeFields(this);
	}
	,__class__: nanofl_engine_elements_Instance
});
var nanofl_engine_elements_ShapeElement = function(edges,polygons,isNormalize) {
	if(isNormalize == null) isNormalize = true;
	nanofl_engine_elements_Element.call(this);
	if(edges != null) this.edges = edges; else this.edges = [];
	if(polygons != null) this.polygons = polygons; else this.polygons = [];
	if(isNormalize) this.normalize();
};
$hxClasses["nanofl.engine.elements.ShapeElement"] = nanofl_engine_elements_ShapeElement;
nanofl_engine_elements_ShapeElement.__name__ = ["nanofl","engine","elements","ShapeElement"];
nanofl_engine_elements_ShapeElement.createRectangle = function(x,y,width,height,rTopLeft,rTopRight,rBottomRight,rBottomLeft,stroke,fill) {
	var x1 = x;
	var y1 = y;
	var x2 = x + width;
	var y2 = y + height;
	var rTL = Math.abs(rTopLeft);
	var rTR = Math.abs(rTopRight);
	var rBR = Math.abs(rBottomRight);
	var rBL = Math.abs(rBottomLeft);
	var edges = [];
	var k = 0.87;
	if(rTopLeft > 0.0) edges.push(new nanofl_engine_geom_Edge(x1 + rTL,y1,x1,y1,x1,y1 + rTL)); else if(rTopLeft < 0.0) edges.push(new nanofl_engine_geom_Edge(x1 + rTL,y1,x1 + rTL * k,y1 + rTL * k,x1,y1 + rTL));
	edges.push(new nanofl_engine_geom_Edge(x1,y1 + rTL,x1,y2 - rBL));
	if(rBottomLeft > 0.0) edges.push(new nanofl_engine_geom_Edge(x1,y2 - rBL,x1,y2,x1 + rBL,y2)); else if(rBottomLeft < 0.0) edges.push(new nanofl_engine_geom_Edge(x1,y2 - rBL,x1 + rBL * k,y2 - rBL * k,x1 + rBL,y2));
	edges.push(new nanofl_engine_geom_Edge(x1 + rBL,y2,x2 - rBR,y2));
	if(rBottomRight > 0.0) edges.push(new nanofl_engine_geom_Edge(x2 - rBR,y2,x2,y2,x2,y2 - rBR)); else if(rBottomRight < 0.0) edges.push(new nanofl_engine_geom_Edge(x2 - rBR,y2,x2 - rBR * k,y2 - rBR * k,x2,y2 - rBR));
	edges.push(new nanofl_engine_geom_Edge(x2,y2 - rBR,x2,y1 + rTR));
	if(rTopRight > 0.0) edges.push(new nanofl_engine_geom_Edge(x2,y1 + rTR,x2,y1,x2 - rTR,y1)); else if(rTopRight < 0.0) edges.push(new nanofl_engine_geom_Edge(x2,y1 + rTR,x2 - rTR * k,y1 + rTR * k,x2 - rTR,y1));
	edges.push(new nanofl_engine_geom_Edge(x2 - rTR,y1,x1 + rTL,y1));
	return new nanofl_engine_elements_ShapeElement(stroke != null?edges.map(function(e) {
		return nanofl_engine_geom_StrokeEdge.fromEdge(e,stroke);
	}):[],fill != null?[new nanofl_engine_geom_Polygon(fill,[new nanofl_engine_geom_Contour(edges)])]:[]);
};
nanofl_engine_elements_ShapeElement.createOval = function(cx,cy,rx,ry,startAngle,endAngle,innerRadius,closePath,stroke,fill) {
	if(endAngle == startAngle) endAngle = startAngle + 360.0;
	if(startAngle != 0.0 || endAngle != 360.0 || innerRadius != 0.0 || !closePath) nanofl_engine_Debug.console.warn("Oval: processing startAngle, endAngle, innerRadius and closePath arguments are not implemented yet.");
	var k = 1.075;
	var edges = [];
	var da = -Math.PI / 8;
	var i = 1;
	while(i <= 16) {
		edges.push(new nanofl_engine_geom_Edge(cx + rx * Math.cos(da * i),cy + ry * Math.sin(da * i),cx + rx * Math.cos(da * (i + 1)) * k,cy + ry * Math.sin(da * (i + 1)) * k,cx + rx * Math.cos(da * (i + 2)),cy + ry * Math.sin(da * (i + 2))));
		i += 2;
	}
	return new nanofl_engine_elements_ShapeElement(stroke != null?edges.map(function(e) {
		return nanofl_engine_geom_StrokeEdge.fromEdge(e,stroke);
	}):[],fill != null?[new nanofl_engine_geom_Polygon(fill,[new nanofl_engine_geom_Contour(edges)])]:[]);
};
nanofl_engine_elements_ShapeElement.log = function(v,infos) {
};
nanofl_engine_elements_ShapeElement.__super__ = nanofl_engine_elements_Element;
nanofl_engine_elements_ShapeElement.prototype = $extend(nanofl_engine_elements_Element.prototype,{
	edges: null
	,polygons: null
	,loadProperties: function(base,version) {
		if(!nanofl_engine_elements_Element.prototype.loadProperties.call(this,base,version)) return false;
		this.edges = [];
		this.polygons = [];
		var fills = [];
		var strokes = [];
		var _g = 0;
		var _g1 = base.children;
		while(_g < _g1.length) {
			var node = _g1[_g];
			++_g;
			if(node.name == "fills") {
				var _g2 = 0;
				var _g3 = node.children;
				while(_g2 < _g3.length) {
					var node1 = [_g3[_g2]];
					++_g2;
					if(node1[0].name == "fill") {
						var _g4 = htmlparser_HtmlParserTools.getAttr(node1[0],"type","solid");
						switch(_g4) {
						case "solid":
							fills.push(nanofl_engine_fills_SolidFill.load(node1[0],version));
							break;
						case "linear":
							fills.push(nanofl_engine_fills_LinearFill.load(node1[0],version));
							break;
						case "bitmap":
							fills.push(nanofl_engine_fills_BitmapFill.load(node1[0],version));
							break;
						case "radial":
							fills.push(nanofl_engine_fills_RadialFill.load(node1[0],version));
							break;
						default:
							nanofl_engine_elements_ShapeElement.log((function(node1) {
								return function() {
									return "Unknow fill type '" + Std.string(htmlparser_HtmlParserTools.getAttr(node1[0],"type")) + "'.";
								};
							})(node1),{ fileName : "ShapeElement.hx", lineNumber : 66, className : "nanofl.engine.elements.ShapeElement", methodName : "loadProperties"});
						}
					}
				}
			} else if(node.name == "strokes") {
				var _g21 = 0;
				var _g31 = node.children;
				while(_g21 < _g31.length) {
					var node2 = _g31[_g21];
					++_g21;
					if(node2.name == "stroke") strokes.push(nanofl_engine_strokes_BaseStroke.load(node2,version));
				}
			} else if(node.name == "figure") {
				var _g22 = 0;
				var _g32 = node.children;
				while(_g22 < _g32.length) {
					var node3 = _g32[_g22];
					++_g22;
					if(node3.name == "edge") this.edges = this.edges.concat(nanofl_engine_geom_StrokeEdges.load(node3,strokes,version)); else if(node3.name == "polygon") this.polygons.push(nanofl_engine_geom_Polygon.load(node3,fills,version));
				}
			}
		}
		this.ensureNoTransform();
		return true;
	}
	,getFills: function() {
		var fills = [];
		var _g = 0;
		var _g1 = this.polygons;
		while(_g < _g1.length) {
			var p = [_g1[_g]];
			++_g;
			if(stdlib_LambdaIterable.findIndex(fills,(function(p) {
				return function(fill) {
					return fill.equ(p[0].fill);
				};
			})(p)) < 0) fills.push(p[0].fill);
		}
		return fills;
	}
	,getStrokes: function() {
		var strokes = [];
		var _g = 0;
		var _g1 = this.edges;
		while(_g < _g1.length) {
			var e = [_g1[_g]];
			++_g;
			if(stdlib_LambdaIterable.findIndex(strokes,(function(e) {
				return function(stroke) {
					return stroke.equ(e[0].stroke);
				};
			})(e)) < 0) strokes.push(e[0].stroke);
		}
		return strokes;
	}
	,save: function(out) {
		if(this.isEmpty()) return;
		out.begin("shape");
		nanofl_engine_elements_Element.prototype.save.call(this,out);
		var fills = this.getFills();
		if(fills.length > 0) {
			out.begin("fills");
			var _g = 0;
			while(_g < fills.length) {
				var fill = fills[_g];
				++_g;
				fill.save(out);
			}
			out.end();
		}
		var strokes = this.getStrokes();
		if(strokes.length > 0) {
			out.begin("strokes");
			var _g1 = 0;
			while(_g1 < strokes.length) {
				var stroke = strokes[_g1];
				++_g1;
				stroke.save(out);
			}
			out.end();
		}
		out.begin("figure");
		var _g2 = 0;
		var _g11 = this.polygons;
		while(_g2 < _g11.length) {
			var p = _g11[_g2];
			++_g2;
			p.save(fills,out);
		}
		nanofl_engine_geom_StrokeEdges.save(this.edges,strokes,out);
		out.end();
		out.end();
	}
	,ensureNoTransform: function() {
		this.transform(this.matrix);
		this.matrix.tx = 0;
		this.matrix.ty = 0;
		this.matrix.a = 1;
		this.matrix.b = 0;
		this.matrix.c = 0;
		this.matrix.d = 1;
	}
	,draw: function(g,scaleSelection) {
		var _g = 0;
		var _g1 = this.polygons;
		while(_g < _g1.length) {
			var p = _g1[_g];
			++_g;
			p.draw(g,scaleSelection);
		}
		nanofl_engine_geom_StrokeEdges.drawSorted(this.edges,g,scaleSelection);
	}
	,createDisplayObject: function(frameIndexes) {
		return this.updateDisplayObject(new createjs.Shape(),null);
	}
	,updateDisplayObject: function(dispObj,frameIndexes) {
		stdlib_Debug.assert(js_Boot.__instanceof(dispObj,createjs.Shape),null,{ fileName : "ShapeElement.hx", lineNumber : 194, className : "nanofl.engine.elements.ShapeElement", methodName : "updateDisplayObject"});
		this.updateDisplayObjectProperties(dispObj);
		var shape = dispObj;
		shape.graphics.clear();
		var m = dispObj.getConcatenatedMatrix().invert();
		this.draw(shape.graphics,(m.a + m.d) / 2);
		if(!this.isEmpty()) {
			var b = this.getBounds();
			shape.setBounds(b.minX,b.minY,b.maxX - b.minX,b.maxY - b.minY);
		}
		return shape;
	}
	,clone: function() {
		var obj = new nanofl_engine_elements_ShapeElement(nanofl_engine_ArrayTools.clone(this.edges),nanofl_engine_ArrayTools.clone(this.polygons));
		this.copyBaseProperties(obj);
		return obj;
	}
	,translate: function(dx,dy) {
		if(dx == 0 && dy == 0) return;
		var _g = 0;
		var _g1 = this.edges;
		while(_g < _g1.length) {
			var e = _g1[_g];
			++_g;
			e.translate(dx,dy);
		}
		var _g2 = 0;
		var _g11 = this.polygons;
		while(_g2 < _g11.length) {
			var p = _g11[_g2];
			++_g2;
			p.translate(dx,dy);
		}
	}
	,isEmpty: function() {
		return this.edges.length == 0 && this.polygons.length == 0;
	}
	,hasSelected: function() {
		return this.hasSelectedEdges() || this.hasSelectedPolygons();
	}
	,isAllSelected: function() {
		return Lambda.foreach(this.edges,function(e) {
			return e.selected;
		}) && Lambda.foreach(this.polygons,function(e1) {
			return e1.selected;
		});
	}
	,hasSelectedEdges: function() {
		return Lambda.exists(this.edges,function(e) {
			return e.selected;
		});
	}
	,hasSelectedPolygons: function() {
		return Lambda.exists(this.polygons,function(e) {
			return e.selected;
		});
	}
	,select: function(obj) {
		this.deselectAll();
		if(obj != null) obj.selected = true;
	}
	,selectAll: function() {
		var _g = 0;
		var _g1 = this.edges;
		while(_g < _g1.length) {
			var edge = _g1[_g];
			++_g;
			edge.selected = true;
		}
		var _g2 = 0;
		var _g11 = this.polygons;
		while(_g2 < _g11.length) {
			var polygon = _g11[_g2];
			++_g2;
			polygon.selected = true;
		}
	}
	,deselectAll: function() {
		var _g = 0;
		var _g1 = this.edges;
		while(_g < _g1.length) {
			var edge = _g1[_g];
			++_g;
			edge.selected = false;
		}
		var _g2 = 0;
		var _g11 = this.polygons;
		while(_g2 < _g11.length) {
			var polygon = _g11[_g2];
			++_g2;
			polygon.selected = false;
		}
	}
	,translateSelected: function(dx,dy) {
		var _g = 0;
		var _g1 = this.edges;
		while(_g < _g1.length) {
			var edge = _g1[_g];
			++_g;
			if(edge.selected) edge.translate(dx,dy);
		}
		var _g2 = 0;
		var _g11 = this.polygons;
		while(_g2 < _g11.length) {
			var polygon = _g11[_g2];
			++_g2;
			if(polygon.selected) polygon.translate(dx,dy);
		}
	}
	,translateVertex: function(point,dx,dy) {
		var _g = 0;
		var _g1 = this.edges;
		while(_g < _g1.length) {
			var edge = _g1[_g];
			++_g;
			edge.translateVertex(point,dx,dy);
		}
		var _g2 = 0;
		var _g11 = this.polygons;
		while(_g2 < _g11.length) {
			var polygon = _g11[_g2];
			++_g2;
			polygon.translateVertex(point,dx,dy);
		}
	}
	,removeSelected: function() {
		var edgeWasRemoved = Lambda.exists(this.edges,function(e) {
			return e.selected;
		});
		var i = 0;
		while(i < this.edges.length) if(this.edges[i].selected) this.edges.splice(i,1); else i++;
		var i1 = 0;
		while(i1 < this.polygons.length) if(this.polygons[i1].selected) this.polygons.splice(i1,1); else i1++;
		if(edgeWasRemoved) nanofl_engine_geom_Polygons.mergeByCommonEdges(this.polygons,this.edges);
	}
	,getPolygonAtPos: function(pt) {
		var _g = 0;
		var _g1 = this.polygons;
		while(_g < _g1.length) {
			var polygon = _g1[_g];
			++_g;
			if(polygon.isPointInside(pt.x,pt.y)) return polygon;
		}
		return null;
	}
	,getSameEdges: function(edge) {
		var r = [];
		if(edge == null) return r;
		var _g = 0;
		var _g1 = this.edges;
		while(_g < _g1.length) {
			var e = _g1[_g];
			++_g;
			if(e.equ(edge)) r.push(e);
		}
		var _g2 = 0;
		var _g11 = this.polygons;
		while(_g2 < _g11.length) {
			var p = _g11[_g2];
			++_g2;
			var _g21 = 0;
			var _g3 = p.contours;
			while(_g21 < _g3.length) {
				var c = _g3[_g21];
				++_g21;
				var _g4 = 0;
				var _g5 = c.edges;
				while(_g4 < _g5.length) {
					var e1 = _g5[_g4];
					++_g4;
					if(e1.equ(edge)) r.push(e1);
				}
			}
		}
		return r;
	}
	,getNearestStrokeEdge: function(pt) {
		var r = { edge : null, dist : 1e100, point : null, t : 0.0};
		var _g = 0;
		var _g1 = this.edges;
		while(_g < _g1.length) {
			var edge = _g1[_g];
			++_g;
			var pointAndT = new nanofl_engine_geom_Edge(edge.x1,edge.y1,edge.x2,edge.y2,edge.x3,edge.y3).getNearestPoint(pt.x,pt.y);
			var dist = nanofl_engine_geom_PointTools.getDistP(pt,pointAndT.point);
			if(dist < r.dist) {
				r.edge = edge;
				r.dist = dist;
				r.point = pointAndT.point;
				r.t = pointAndT.t;
			}
		}
		if(r.edge != null) return r; else return null;
	}
	,getNearestPolygonEdge: function(pt) {
		var edges = [];
		var _g = 0;
		var _g1 = this.polygons;
		while(_g < _g1.length) {
			var polygon = _g1[_g];
			++_g;
			polygon.getEdges(edges);
		}
		var bestEdge = null;
		var bestDist2 = 1.0e100;
		var bestPoint = null;
		var bestT = null;
		var _g2 = 0;
		while(_g2 < edges.length) {
			var edge = edges[_g2];
			++_g2;
			var posAndT = edge.getNearestPoint(pt.x,pt.y);
			var dist2 = nanofl_engine_geom_PointTools.getSqrDistP(pt,posAndT.point);
			if(dist2 < bestDist2) {
				bestEdge = edge;
				bestDist2 = dist2;
				bestPoint = posAndT.point;
				bestT = posAndT.t;
			}
		}
		if(bestEdge != null) return { edge : bestEdge, dist : Math.sqrt(bestDist2), point : bestPoint, t : bestT}; else return null;
	}
	,getNearestVertex: function(pt,excludeSelf) {
		if(excludeSelf == null) excludeSelf = false;
		var bestPoint = null;
		var bestDist = 1.0e100;
		var bestDistMinusEdgeThickness = 1.0e100;
		var _g = 0;
		var _g1 = this.edges;
		while(_g < _g1.length) {
			var edge = _g1[_g];
			++_g;
			var M1 = { x : edge.x1, y : edge.y1};
			if(!excludeSelf || M1.x != pt.x || M1.y != pt.y) {
				var dist = nanofl_engine_geom_PointTools.getDist(pt.x,pt.y,M1.x,M1.y);
				if(dist < bestDist) {
					bestPoint = M1;
					bestDist = dist;
					bestDistMinusEdgeThickness = Math.max(0,dist - edge.stroke.thickness / 2);
				}
			}
			var M2 = { x : edge.x3, y : edge.y3};
			if(!excludeSelf || M2.x != pt.x || M2.y != pt.y) {
				var dist1 = nanofl_engine_geom_PointTools.getSqrDist(pt.x,pt.y,M2.x,M2.y);
				if(dist1 < bestDist) {
					bestPoint = M2;
					bestDist = dist1;
					bestDistMinusEdgeThickness = Math.max(0,dist1 - edge.stroke.thickness / 2);
				}
			}
		}
		var _g2 = 0;
		var _g11 = this.polygons;
		while(_g2 < _g11.length) {
			var polygon = _g11[_g2];
			++_g2;
			var _g21 = 0;
			var _g3 = polygon.getEdges();
			while(_g21 < _g3.length) {
				var edge1 = _g3[_g21];
				++_g21;
				var M11 = { x : edge1.x1, y : edge1.y1};
				if(!excludeSelf || M11.x != pt.x || M11.y != pt.y) {
					var dist2 = nanofl_engine_geom_PointTools.getDist(pt.x,pt.y,M11.x,M11.y);
					if(dist2 < bestDist) {
						bestPoint = M11;
						bestDist = dist2;
						bestDistMinusEdgeThickness = dist2;
					}
				}
				var M21 = { x : edge1.x3, y : edge1.y3};
				if(!excludeSelf || M21.x != pt.x || M21.y != pt.y) {
					var dist3 = nanofl_engine_geom_PointTools.getDist(pt.x,pt.y,M21.x,M21.y);
					if(dist3 < bestDist) {
						bestPoint = M21;
						bestDist = dist3;
						bestDistMinusEdgeThickness = dist3;
					}
				}
			}
		}
		if(bestPoint != null) return { point : bestPoint, dist : bestDist, distMinusEdgeThickness : bestDistMinusEdgeThickness}; else return null;
	}
	,setSelectedEdgesStroke: function(stroke) {
		var _g = 0;
		var _g1 = this.edges;
		while(_g < _g1.length) {
			var edge = _g1[_g];
			++_g;
			if(edge.selected) edge.stroke = stroke;
		}
	}
	,setSelectedEdgesStrokeParams: function(params) {
		var _g = 0;
		var _g1 = this.edges;
		while(_g < _g1.length) {
			var edge = _g1[_g];
			++_g;
			if(edge.selected) {
				var stroke = edge.stroke.clone();
				if(params.thickness != null) stroke.thickness = params.thickness;
				if(params.ignoreScale != null) stroke.ignoreScale = params.ignoreScale;
				if(params.caps != null) stroke.caps = params.caps;
				if(params.joints != null) stroke.joints = params.joints;
				if(params.miterLimit != null) stroke.miterLimit = params.miterLimit;
				{
					var _g2 = stroke.getTyped();
					switch(_g2[1]) {
					case 0:
						var stroke1 = _g2[2];
						if(params.color != null) stroke1.color = params.color;
						break;
					case 1:
						var stroke2 = _g2[2];
						if(params.colors != null) stroke2.colors = params.colors;
						if(params.ratios != null) stroke2.ratios = params.ratios;
						if(params.x0 != null) stroke2.x0 = params.x0;
						if(params.y0 != null) stroke2.y0 = params.y0;
						if(params.x1 != null) stroke2.x1 = params.x1;
						if(params.y1 != null) stroke2.y1 = params.y1;
						break;
					case 2:
						var stroke3 = _g2[2];
						if(params.colors != null) stroke3.colors = params.colors;
						if(params.ratios != null) stroke3.ratios = params.ratios;
						if(params.x0 != null) stroke3.fx = params.x0;
						if(params.y0 != null) stroke3.fy = params.y0;
						if(params.x1 != null) stroke3.cx = params.x1;
						if(params.y1 != null) stroke3.cy = params.y1;
						if(params.r != null) stroke3.r = params.r;
						break;
					case 3:
						var stroke4 = _g2[2];
						if(params.bitmapPath != null) stroke4.bitmapPath = params.bitmapPath;
						break;
					}
				}
				edge.stroke = stroke;
			}
		}
	}
	,getSelectedEdgesStrokeParams: function() {
		var r = { type : null, thickness : null, ignoreScale : null, color : null, colors : null, ratios : null, x0 : null, y0 : null, x1 : null, y1 : null, r : null, bitmapPath : null, caps : null, joints : null, miterLimit : null};
		var _g = 0;
		var _g1 = this.edges;
		while(_g < _g1.length) {
			var edge = _g1[_g];
			++_g;
			if(edge.selected) {
				if(r.thickness == null || r.thickness == edge.stroke.thickness) r.thickness = edge.stroke.thickness; else r.thickness = -1;
				if(r.ignoreScale == null || r.ignoreScale == edge.stroke.ignoreScale) r.ignoreScale = edge.stroke.ignoreScale; else r.ignoreScale = false;
				if(r.caps == null || r.caps == edge.stroke.caps) r.caps = edge.stroke.caps; else r.caps = "mixed";
				if(r.joints == null || r.joints == edge.stroke.joints) r.joints = edge.stroke.joints; else r.joints = "mixed";
				if(r.miterLimit == null || r.miterLimit == edge.stroke.miterLimit) r.miterLimit = edge.stroke.miterLimit; else r.miterLimit = -1;
				{
					var _g2 = edge.stroke.getTyped();
					switch(_g2[1]) {
					case 0:
						var stroke = _g2[2];
						if(r.type == null || r.type == "solid") r.type = "solid"; else r.type = "mixed";
						r.color = stroke.color;
						break;
					case 1:
						var stroke1 = _g2[2];
						if(r.type == null || r.type == "linear") r.type = "linear"; else r.type = "mixed";
						r.colors = stroke1.colors;
						r.ratios = stroke1.ratios;
						r.x0 = stroke1.x0;
						r.y0 = stroke1.y0;
						r.x1 = stroke1.x1;
						r.y1 = stroke1.y1;
						break;
					case 2:
						var stroke2 = _g2[2];
						if(r.type == null || r.type == "radial") r.type = "radial"; else r.type = "mixed";
						r.colors = stroke2.colors;
						r.ratios = stroke2.ratios;
						r.x0 = stroke2.fx;
						r.y0 = stroke2.fy;
						r.x1 = stroke2.cx;
						r.y1 = stroke2.cy;
						r.r = stroke2.r;
						break;
					case 3:
						var stroke3 = _g2[2];
						if(r.type == null || r.type == "bitmap") r.type = "bitmap"; else r.type = "mixed";
						r.bitmapPath = stroke3.bitmapPath;
						break;
					}
				}
			}
		}
		return r;
	}
	,setSelectedPolygonsFill: function(fill,x1,y1,x2,y2) {
		var _g = 0;
		var _g1 = this.polygons;
		while(_g < _g1.length) {
			var polygon = _g1[_g];
			++_g;
			if(polygon.selected) polygon.applyFill(fill,x1,y1,x2,y2);
		}
	}
	,setSelectedPolygonsFillParams: function(params) {
		var _g = 0;
		var _g1 = this.polygons;
		while(_g < _g1.length) {
			var polygon = _g1[_g];
			++_g;
			if(polygon.selected) {
				var fill = polygon.fill.clone();
				{
					var _g2 = fill.getTyped();
					switch(_g2[1]) {
					case 0:
						var fill1 = _g2[2];
						if(params.color != null) fill1.color = params.color;
						break;
					case 1:
						var fill2 = _g2[2];
						if(params.colors != null) fill2.colors = params.colors;
						if(params.ratios != null) fill2.ratios = params.ratios;
						if(params.x0 != null) fill2.x0 = params.x0;
						if(params.y0 != null) fill2.y0 = params.y0;
						if(params.x1 != null) fill2.x1 = params.x1;
						if(params.y1 != null) fill2.y1 = params.y1;
						break;
					case 2:
						var fill3 = _g2[2];
						if(params.colors != null) fill3.colors = params.colors;
						if(params.ratios != null) fill3.ratios = params.ratios;
						if(params.x0 != null) fill3.fx = params.x0;
						if(params.y0 != null) fill3.fy = params.y0;
						if(params.x1 != null) fill3.cx = params.x1;
						if(params.y1 != null) fill3.cy = params.y1;
						if(params.r != null) fill3.r = params.r;
						break;
					case 3:
						var fill4 = _g2[2];
						if(params.bitmapPath != null) fill4.bitmapPath = params.bitmapPath;
						if(params.matrix != null) fill4.matrix = params.matrix;
						if(params.repeat != null) fill4.repeat = params.repeat;
						break;
					}
				}
				polygon.fill = fill;
			}
		}
	}
	,getSelectedPolygonsFillParams: function() {
		var r = { type : null, color : null, colors : null, ratios : null, x0 : null, y0 : null, x1 : null, y1 : null, r : null, bitmapPath : null, matrix : null, repeat : null};
		var _g = 0;
		var _g1 = this.polygons;
		while(_g < _g1.length) {
			var polygon = _g1[_g];
			++_g;
			if(polygon.selected) {
				var _g2 = polygon.fill.getTyped();
				switch(_g2[1]) {
				case 0:
					var fill = _g2[2];
					if(r.type == null || r.type == "solid") r.type = "solid"; else r.type = "mixed";
					r.color = fill.color;
					break;
				case 1:
					var fill1 = _g2[2];
					if(r.type == null || r.type == "linear") r.type = "linear"; else r.type = "mixed";
					r.colors = fill1.colors;
					r.ratios = fill1.ratios;
					r.x0 = fill1.x0;
					r.y0 = fill1.y0;
					r.x1 = fill1.x1;
					r.y1 = fill1.y1;
					break;
				case 2:
					var fill2 = _g2[2];
					if(r.type == null || r.type == "radial") r.type = "radial"; else r.type = "mixed";
					r.colors = fill2.colors;
					r.ratios = fill2.ratios;
					r.x0 = fill2.fx;
					r.y0 = fill2.fy;
					r.x1 = fill2.cx;
					r.y1 = fill2.cy;
					r.r = fill2.r;
					break;
				case 3:
					var fill3 = _g2[2];
					if(r.type == null || r.type == "bitmap") r.type = "bitmap"; else r.type = "mixed";
					r.bitmapPath = fill3.bitmapPath;
					r.matrix = fill3.matrix;
					r.repeat = fill3.repeat;
					break;
				}
			}
		}
		if(r.type == "mixed") r.type = null;
		return r;
	}
	,floodFill: function(fill,x1,y1,x2,y2) {
		var polygon = this.findOrCreatePolygonByPoint((x1 + x2) / 2,(y1 + y2) / 2);
		if(polygon != null) polygon.applyFill(fill,x1,y1,x2,y2);
	}
	,getBounds: function(bounds,useStrokeThickness) {
		if(useStrokeThickness == null) useStrokeThickness = true;
		if(this.edges.length > 0 || this.polygons.length > 0) {
			if(bounds == null) bounds = { minX : 1e100, minY : 1e100, maxX : -1e100, maxY : -1e100};
			if(useStrokeThickness) nanofl_engine_geom_StrokeEdges.getBounds(this.edges,bounds); else nanofl_engine_geom_Edges.getBounds(this.edges,bounds);
			var _g = 0;
			var _g1 = this.polygons;
			while(_g < _g1.length) {
				var polygon = _g1[_g];
				++_g;
				polygon.getBounds(bounds);
			}
		}
		return bounds;
	}
	,getSelectedBounds: function(bounds,useStrokeThickness) {
		if(useStrokeThickness == null) useStrokeThickness = true;
		var selectedEdges = [];
		var _g = 0;
		var _g1 = this.edges;
		while(_g < _g1.length) {
			var e = _g1[_g];
			++_g;
			if(e.selected) selectedEdges.push(e);
		}
		var selectedPolygons = [];
		var _g2 = 0;
		var _g11 = this.polygons;
		while(_g2 < _g11.length) {
			var p = _g11[_g2];
			++_g2;
			if(p.selected) selectedPolygons.push(p);
		}
		if(selectedEdges.length > 0 || selectedPolygons.length > 0) {
			if(bounds == null) bounds = { minX : 1e100, minY : 1e100, maxX : -1e100, maxY : -1e100};
			if(useStrokeThickness) nanofl_engine_geom_StrokeEdges.getBounds(selectedEdges,bounds); else nanofl_engine_geom_Edges.getBounds(selectedEdges,bounds);
			var _g3 = 0;
			while(_g3 < selectedPolygons.length) {
				var polygon = selectedPolygons[_g3];
				++_g3;
				polygon.getBounds(bounds);
			}
		}
		return bounds;
	}
	,findOrCreatePolygonByPoint: function(x,y,fill) {
		var polygon = nanofl_engine_geom_Polygons.findByPoint(this.polygons,x,y);
		if(polygon != null) return polygon;
		var allEdges = this.getEdges();
		stdlib_Debug.assert(!nanofl_engine_geom_Edges.hasDuplicates(allEdges),allEdges.toString(),{ fileName : "ShapeElement.hx", lineNumber : 731, className : "nanofl.engine.elements.ShapeElement", methodName : "findOrCreatePolygonByPoint"});
		var contours = nanofl_engine_geom_Contours.fromEdges(allEdges);
		var outers = [];
		var inners = [];
		var _g = 0;
		while(_g < contours.length) {
			var contour = contours[_g];
			++_g;
			if(contour.isPointInside(x,y)) outers.push(contour); else inners.push(contour);
		}
		var i = 0;
		while(i < outers.length) {
			var j = 0;
			while(j < outers.length) {
				if(i != j && outers[i].isNestedTo(outers[j])) {
					outers.splice(j,1);
					if(i > j) i--;
					j--;
				}
				j++;
			}
			i++;
		}
		if(outers.length == 0) return null;
		var outer = outers[0];
		inners = inners.filter(function(contour1) {
			return contour1.isNestedTo(outer);
		});
		var i1 = 0;
		while(i1 < inners.length) {
			var j1 = 0;
			while(j1 < inners.length) {
				if(i1 != j1 && inners[j1].isNestedTo(inners[i1])) {
					inners.splice(j1,1);
					if(i1 > j1) i1--;
					j1--;
				}
				j1++;
			}
			i1++;
		}
		stdlib_Debug.assert(outer.isClockwise(),null,{ fileName : "ShapeElement.hx", lineNumber : 785, className : "nanofl.engine.elements.ShapeElement", methodName : "findOrCreatePolygonByPoint"});
		polygon = new nanofl_engine_geom_Polygon(fill);
		polygon.contours.push(outer);
		var _g1 = 0;
		while(_g1 < inners.length) {
			var inner = inners[_g1];
			++_g1;
			inner.reverse();
			stdlib_Debug.assert(inner.isCounterClockwise(),null,{ fileName : "ShapeElement.hx", lineNumber : 792, className : "nanofl.engine.elements.ShapeElement", methodName : "findOrCreatePolygonByPoint"});
			polygon.contours.push(inner);
		}
		this.polygons.push(polygon);
		return polygon;
	}
	,transform: function(m,applyToStrokeAndFill) {
		if(applyToStrokeAndFill == null) applyToStrokeAndFill = true;
		if(m.isIdentity()) return;
		var _g = 0;
		var _g1 = this.edges;
		while(_g < _g1.length) {
			var edge = _g1[_g];
			++_g;
			edge.transform(m,applyToStrokeAndFill);
		}
		var _g2 = 0;
		var _g11 = this.polygons;
		while(_g2 < _g11.length) {
			var polygon = _g11[_g2];
			++_g2;
			polygon.transform(m,applyToStrokeAndFill);
		}
		this.normalize();
	}
	,transformSelected: function(m,applyToStrokeThickness) {
		if(applyToStrokeThickness == null) applyToStrokeThickness = true;
		var _g = 0;
		var _g1 = this.edges;
		while(_g < _g1.length) {
			var edge = _g1[_g];
			++_g;
			if(edge.selected) edge.transform(m,applyToStrokeThickness);
		}
		var _g2 = 0;
		var _g11 = this.polygons;
		while(_g2 < _g11.length) {
			var polygon = _g11[_g2];
			++_g2;
			if(polygon.selected) polygon.transform(m);
		}
		this.normalize();
	}
	,extractSelected: function() {
		return new nanofl_engine_elements_ShapeElement(nanofl_engine_ArrayTools.clone(this.edges.filter(function(e) {
			return e.selected;
		})),nanofl_engine_ArrayTools.clone(this.polygons.filter(function(p) {
			return p.selected;
		})));
	}
	,assertCorrect: function() {
	}
	,getEdges: function() {
		var r = this.edges.slice();
		var _g = 0;
		var _g1 = this.polygons;
		while(_g < _g1.length) {
			var p = _g1[_g];
			++_g;
			p.getEdges(r);
		}
		stdlib_Debug.assert(!nanofl_engine_geom_Edges.hasDuplicates(r),null,{ fileName : "ShapeElement.hx", lineNumber : 1024, className : "nanofl.engine.elements.ShapeElement", methodName : "getEdges"});
		return r;
	}
	,replaceEdge: function(search,replacement) {
		nanofl_engine_geom_StrokeEdges.replace(this.edges,search,replacement);
		stdlib_Debug.assert(search.indexIn(this.edges) < 0,"\nsearch = " + Std.string(search) + "\nreplacement = " + Std.string(replacement),{ fileName : "ShapeElement.hx", lineNumber : 1031, className : "nanofl.engine.elements.ShapeElement", methodName : "replaceEdge"});
		var _g = 0;
		var _g1 = this.polygons;
		while(_g < _g1.length) {
			var p = _g1[_g];
			++_g;
			p.replaceEdge(search,replacement);
			stdlib_Debug.assert(search.indexIn(p.getEdges()) < 0,"\nsearch = " + Std.string(search) + "\nreplacement = " + Std.string(replacement),{ fileName : "ShapeElement.hx", lineNumber : 1036, className : "nanofl.engine.elements.ShapeElement", methodName : "replaceEdge"});
		}
		stdlib_Debug.assert(search.indexIn(this.getEdges()) < 0,"\nsearch = " + Std.string(search) + "\nreplacement = " + Std.string(replacement),{ fileName : "ShapeElement.hx", lineNumber : 1039, className : "nanofl.engine.elements.ShapeElement", methodName : "replaceEdge"});
	}
	,normalize: function() {
		nanofl_engine_geom_Edges.normalize(this.edges);
		nanofl_engine_geom_Polygons.normalize(this.polygons);
	}
	,swapInstance: function(oldNamePath,newNamePath) {
		var _g = 0;
		var _g1 = this.edges;
		while(_g < _g1.length) {
			var edge = _g1[_g];
			++_g;
			edge.stroke.swapInstance(oldNamePath,newNamePath);
		}
		var _g2 = 0;
		var _g11 = this.polygons;
		while(_g2 < _g11.length) {
			var polygon = _g11[_g2];
			++_g2;
			polygon.fill.swapInstance(oldNamePath,newNamePath);
		}
	}
	,applyStrokeAlpha: function(alpha) {
		if(alpha == 1) return;
		var processed = new haxe_ds_ObjectMap();
		var _g = 0;
		var _g1 = this.edges;
		while(_g < _g1.length) {
			var edge = _g1[_g];
			++_g;
			if(!(processed.h.__keys__[edge.stroke.__id__] != null)) {
				edge.stroke.applyAlpha(alpha);
				processed.set(edge.stroke,true);
			}
		}
	}
	,applyFillAlpha: function(alpha) {
		if(alpha == 1) return;
		var processed = new haxe_ds_ObjectMap();
		var _g = 0;
		var _g1 = this.polygons;
		while(_g < _g1.length) {
			var polygon = _g1[_g];
			++_g;
			if(!(processed.h.__keys__[polygon.fill.__id__] != null)) {
				polygon.fill.applyAlpha(alpha);
				processed.set(polygon.fill,true);
			}
		}
	}
	,getEdgeCount: function() {
		var r = this.edges.length;
		var _g = 0;
		var _g1 = this.polygons;
		while(_g < _g1.length) {
			var p = _g1[_g];
			++_g;
			r += p.getEdges().length;
		}
		return r;
	}
	,setLibrary: function(library) {
		var _g = 0;
		var _g1 = this.edges;
		while(_g < _g1.length) {
			var edge = _g1[_g];
			++_g;
			edge.stroke.setLibrary(library);
		}
		var _g2 = 0;
		var _g11 = this.polygons;
		while(_g2 < _g11.length) {
			var polygon = _g11[_g2];
			++_g2;
			polygon.fill.setLibrary(library);
		}
	}
	,equ: function(element) {
		if(!nanofl_engine_elements_Element.prototype.equ.call(this,element)) return false;
		if(!nanofl_engine_ArrayTools.equ(element.edges,this.edges)) return false;
		if(!nanofl_engine_ArrayTools.equ(element.polygons,this.polygons)) return false;
		return true;
	}
	,getNearestPointsLocal: function(pos) {
		var _g = 0;
		var _g1 = this.polygons;
		while(_g < _g1.length) {
			var polygon = _g1[_g];
			++_g;
			if(polygon.isPointInside(pos.x,pos.y)) return [pos];
		}
		var points = [];
		var _g2 = 0;
		var _g11 = this.polygons;
		while(_g2 < _g11.length) {
			var polygon1 = _g11[_g2];
			++_g2;
			points = points.concat(polygon1.getEdges().map(function(edge) {
				return edge.getNearestPoint(pos.x,pos.y).point;
			}));
		}
		points = points.concat(this.edges.map(function(edge1) {
			return edge1.getNearestPointUseStrokeSize(pos.x,pos.y).point;
		}));
		return points;
	}
	,toString: function() {
		return (this.parent != null?this.parent.toString() + " / ":"") + "Shape";
	}
	,__class__: nanofl_engine_elements_ShapeElement
});
var nanofl_engine_elements_SpriteFrameElement = function(sprite,index) {
	nanofl_engine_elements_Element.call(this);
	this.sprite = sprite;
	this.index = index;
};
$hxClasses["nanofl.engine.elements.SpriteFrameElement"] = nanofl_engine_elements_SpriteFrameElement;
nanofl_engine_elements_SpriteFrameElement.__name__ = ["nanofl","engine","elements","SpriteFrameElement"];
nanofl_engine_elements_SpriteFrameElement.__super__ = nanofl_engine_elements_Element;
nanofl_engine_elements_SpriteFrameElement.prototype = $extend(nanofl_engine_elements_Element.prototype,{
	sprite: null
	,index: null
	,loadProperties: function(node,version) {
		return stdlib_Debug.methodNotSupported(this,{ fileName : "SpriteFrameElement.hx", lineNumber : 22, className : "nanofl.engine.elements.SpriteFrameElement", methodName : "loadProperties"});
	}
	,save: function(out) {
		stdlib_Debug.methodNotSupported(this,{ fileName : "SpriteFrameElement.hx", lineNumber : 24, className : "nanofl.engine.elements.SpriteFrameElement", methodName : "save"});
	}
	,clone: function() {
		return stdlib_Debug.methodNotSupported(this,{ fileName : "SpriteFrameElement.hx", lineNumber : 26, className : "nanofl.engine.elements.SpriteFrameElement", methodName : "clone"});
	}
	,createDisplayObject: function(frameIndexes) {
		var dispObj = this.sprite.createDisplayObject(this.index,null);
		this.updateDisplayObjectProperties(dispObj);
		return dispObj;
	}
	,updateDisplayObject: function(dispObj,frameIndexes) {
		this.updateDisplayObjectProperties(dispObj);
		this.sprite.updateDisplayObject(dispObj,frameIndexes);
		return dispObj;
	}
	,getNearestPointsLocal: function(pos) {
		return [this.sprite.getNearestPoint(pos)];
	}
	,equ: function(element) {
		return stdlib_Debug.methodNotSupported(this,{ fileName : "SpriteFrameElement.hx", lineNumber : 56, className : "nanofl.engine.elements.SpriteFrameElement", methodName : "equ"});
	}
	,toString: function() {
		return "SpriteFrameElement(" + this.sprite.namePath + ":" + this.index + ")";
	}
	,__class__: nanofl_engine_elements_SpriteFrameElement
});
var nanofl_engine_elements_TextElement = function(name,width,height,selectable,border,textRuns,newTextFormat) {
	nanofl_engine_elements_Element.call(this);
	this.name = name;
	this.width = width;
	this.height = height;
	this.selectable = selectable;
	this.border = border;
	this.textRuns = textRuns;
	this.newTextFormat = newTextFormat;
};
$hxClasses["nanofl.engine.elements.TextElement"] = nanofl_engine_elements_TextElement;
nanofl_engine_elements_TextElement.__name__ = ["nanofl","engine","elements","TextElement"];
nanofl_engine_elements_TextElement.__super__ = nanofl_engine_elements_Element;
nanofl_engine_elements_TextElement.prototype = $extend(nanofl_engine_elements_Element.prototype,{
	name: null
	,width: null
	,height: null
	,selectable: null
	,border: null
	,textRuns: null
	,newTextFormat: null
	,loadProperties: function(base,version) {
		if(!nanofl_engine_elements_Element.prototype.loadProperties.call(this,base,version)) return false;
		this.name = htmlparser_HtmlParserTools.getAttr(base,"name","");
		this.width = htmlparser_HtmlParserTools.getAttr(base,"width",0.0);
		this.height = htmlparser_HtmlParserTools.getAttr(base,"height",0.0);
		this.selectable = htmlparser_HtmlParserTools.getAttr(base,"selectable",false);
		this.border = htmlparser_HtmlParserTools.getAttr(base,"border",false);
		this.textRuns = [];
		var _g = 0;
		var _g1 = base.children;
		while(_g < _g1.length) {
			var node = _g1[_g];
			++_g;
			if(node.name == "text-run") this.textRuns.push(nanofl_TextRun.create(htmlparser_HtmlParserTools.getAttr(node,"characters"),htmlparser_HtmlParserTools.getAttr(node,"fillColor","#000000"),htmlparser_HtmlParserTools.getAttr(node,"family","Times"),htmlparser_HtmlParserTools.getAttr(node,"style",""),htmlparser_HtmlParserTools.getAttr(node,"size",12.0),htmlparser_HtmlParserTools.getAttr(node,"align","left"),htmlparser_HtmlParserTools.getAttr(node,"strokeSize",0.0),htmlparser_HtmlParserTools.getAttr(node,"strokeColor","#000000"),htmlparser_HtmlParserTools.getAttr(node,"kerning",true),htmlparser_HtmlParserTools.getAttr(node,"letterSpacing",0.0),htmlparser_HtmlParserTools.getAttr(node,"lineSpacing",2.0)));
		}
		return true;
	}
	,save: function(out) {
		out.begin("text");
		out.attr("name",this.name,"");
		nanofl_engine_elements_Element.prototype.save.call(this,out);
		out.attr("width",this.width);
		out.attr("height",this.height);
		out.attr("selectable",this.selectable,false);
		out.attr("border",this.border,false);
		var _g = 0;
		var _g1 = this.textRuns;
		while(_g < _g1.length) {
			var textRun = _g1[_g];
			++_g;
			out.begin("text-run");
			out.attr("characters",textRun.characters);
			out.attr("fillColor",textRun.fillColor);
			out.attr("align",textRun.align,"left");
			out.attr("size",textRun.size);
			out.attr("style",textRun.style,"");
			out.attr("family",textRun.family,"Times");
			out.attr("strokeSize",textRun.strokeSize,0.0);
			out.attr("strokeColor",textRun.strokeColor,"#000000");
			out.attr("kerning",textRun.kerning,true);
			out.attr("letterSpacing",textRun.letterSpacing,0.0);
			out.attr("lineSpacing",textRun.lineSpacing,2.0);
			out.end();
		}
		out.end();
	}
	,getText: function() {
		return this.textRuns.map(function(tr) {
			return tr.characters;
		}).join("");
	}
	,createDisplayObject: function(frameIndexes) {
		var dispObj = new nanofl_TextField();
		this.updateDisplayObject(dispObj,null);
		if(this.name != "") dispObj.name = this.name;
		return dispObj;
	}
	,updateDisplayObject: function(dispObj,frameIndexes) {
		stdlib_Debug.assert(js_Boot.__instanceof(dispObj,nanofl_TextField),null,{ fileName : "TextElement.hx", lineNumber : 121, className : "nanofl.engine.elements.TextElement", methodName : "updateDisplayObject"});
		this.updateDisplayObjectProperties(dispObj);
		var tf = dispObj;
		tf.width = this.width;
		tf.height = this.height;
		tf.selectable = this.selectable;
		tf.border = this.border;
		tf.textRuns = nanofl_engine_ArrayTools.clone(this.textRuns);
		tf.newTextFormat = this.newTextFormat;
		tf.setBounds(0.5,0.5,this.width,this.height);
		return tf;
	}
	,getMinSize: function(dispObj) {
		stdlib_Debug.assert(js_Boot.__instanceof(dispObj,nanofl_TextField),null,{ fileName : "TextElement.hx", lineNumber : 145, className : "nanofl.engine.elements.TextElement", methodName : "getMinSize"});
		return { width : dispObj.minWidth, height : dispObj.minHeight};
	}
	,getNearestPointsLocal: function(pos) {
		var bounds = { minX : 0.0, minY : 0.0, maxX : this.width, maxY : this.height};
		return [nanofl_engine_geom_BoundsTools.getNearestPoint(bounds,pos)];
	}
	,equ: function(element) {
		if(!nanofl_engine_elements_Element.prototype.equ.call(this,element)) return false;
		if(element.name != this.name) return false;
		if(element.width != this.width) return false;
		if(element.height != this.height) return false;
		if(element.selectable != this.selectable) return false;
		if(element.border != this.border) return false;
		if(!nanofl_engine_ArrayTools.equ(element.textRuns,this.textRuns)) return false;
		return true;
	}
	,clone: function() {
		var obj = new nanofl_engine_elements_TextElement(this.name,this.width,this.height,this.selectable,this.border,nanofl_engine_ArrayTools.clone(this.textRuns),this.newTextFormat != null?this.newTextFormat.clone():null);
		this.copyBaseProperties(obj);
		return obj;
	}
	,__class__: nanofl_engine_elements_TextElement
});
var nanofl_engine_fills_BaseFill = function() { };
$hxClasses["nanofl.engine.fills.BaseFill"] = nanofl_engine_fills_BaseFill;
nanofl_engine_fills_BaseFill.__name__ = ["nanofl","engine","fills","BaseFill"];
nanofl_engine_fills_BaseFill.prototype = {
	setLibrary: function(library) {
	}
	,__class__: nanofl_engine_fills_BaseFill
};
var nanofl_engine_fills_IFill = function() { };
$hxClasses["nanofl.engine.fills.IFill"] = nanofl_engine_fills_IFill;
nanofl_engine_fills_IFill.__name__ = ["nanofl","engine","fills","IFill"];
nanofl_engine_fills_IFill.prototype = {
	begin: null
	,clone: null
	,equ: null
	,applyAlpha: null
	,getTransformed: null
	,getTyped: null
	,save: null
	,swapInstance: null
	,setLibrary: null
	,toString: null
	,__class__: nanofl_engine_fills_IFill
};
var nanofl_engine_fills_BitmapFill = function(bitmapPath,repeat,matrix) {
	this.bitmapPath = bitmapPath;
	this.repeat = repeat;
	this.matrix = matrix;
};
$hxClasses["nanofl.engine.fills.BitmapFill"] = nanofl_engine_fills_BitmapFill;
nanofl_engine_fills_BitmapFill.__name__ = ["nanofl","engine","fills","BitmapFill"];
nanofl_engine_fills_BitmapFill.__interfaces__ = [nanofl_engine_fills_IFill];
nanofl_engine_fills_BitmapFill.load = function(node,version) {
	return new nanofl_engine_fills_BitmapFill(htmlparser_HtmlParserTools.getAttr(node,"bitmapPath"),htmlparser_HtmlParserTools.getAttr(node,"repeat","repeat"),nanofl_engine_geom_Matrix.load(node));
};
nanofl_engine_fills_BitmapFill.__super__ = nanofl_engine_fills_BaseFill;
nanofl_engine_fills_BitmapFill.prototype = $extend(nanofl_engine_fills_BaseFill.prototype,{
	library: null
	,bitmapPath: null
	,repeat: null
	,matrix: null
	,save: function(out) {
		out.begin("fill").attr("type","bitmap");
		out.attr("bitmapPath",this.bitmapPath);
		out.attr("repeat",this.repeat,"repeat");
		this.matrix.save(out);
		out.end();
	}
	,clone: function() {
		var r = new nanofl_engine_fills_BitmapFill(this.bitmapPath,this.repeat,this.matrix.clone());
		r.library = this.library;
		return r;
	}
	,applyAlpha: function(alpha) {
	}
	,getTyped: function() {
		return nanofl_engine_fills_TypedFill.BITMAP(this);
	}
	,begin: function(g) {
		if(this.library.hasItem(this.bitmapPath)) {
			var image;
			image = (js_Boot.__cast(this.library.getItem(this.bitmapPath) , nanofl_engine_libraryitems_BitmapItem)).image;
			g.beginBitmapFill(image,this.repeat,this.matrix.toMatrix2D());
		} else g.beginFill("rgba(0,0,0,0)");
	}
	,getBitmapWidth: function() {
		var item = this.library.getItem(this.bitmapPath);
		if(item == null || !js_Boot.__instanceof(item,nanofl_engine_libraryitems_BitmapItem)) return 1.0;
		return item.image.width;
	}
	,equ: function(e) {
		if(e == this) return true;
		if(js_Boot.__instanceof(e,nanofl_engine_fills_BitmapFill)) {
			var ee = e;
			return ee.bitmapPath == this.bitmapPath && ee.matrix.equ(this.matrix) && ee.repeat == this.repeat;
		}
		return false;
	}
	,swapInstance: function(oldNamePath,newNamePath) {
		if(this.bitmapPath == oldNamePath) this.bitmapPath = newNamePath;
	}
	,setLibrary: function(library) {
		this.library = library;
	}
	,getTransformed: function(m) {
		var r = this.clone();
		r.matrix.prependMatrix(m);
		return r;
	}
	,toString: function() {
		return "new BitmapFill(\"red\")";
	}
	,__class__: nanofl_engine_fills_BitmapFill
});
var nanofl_engine_fills_EraseFill = function() {
};
$hxClasses["nanofl.engine.fills.EraseFill"] = nanofl_engine_fills_EraseFill;
nanofl_engine_fills_EraseFill.__name__ = ["nanofl","engine","fills","EraseFill"];
nanofl_engine_fills_EraseFill.__interfaces__ = [nanofl_engine_fills_IFill];
nanofl_engine_fills_EraseFill.__super__ = nanofl_engine_fills_BaseFill;
nanofl_engine_fills_EraseFill.prototype = $extend(nanofl_engine_fills_BaseFill.prototype,{
	save: function(out) {
		stdlib_Debug.methodNotSupported(this,{ fileName : "EraseFill.hx", lineNumber : 12, className : "nanofl.engine.fills.EraseFill", methodName : "save"});
	}
	,clone: function() {
		return new nanofl_engine_fills_EraseFill();
	}
	,applyAlpha: function(alpha) {
		stdlib_Debug.methodNotSupported(this,{ fileName : "EraseFill.hx", lineNumber : 14, className : "nanofl.engine.fills.EraseFill", methodName : "applyAlpha"});
	}
	,getTyped: function() {
		return stdlib_Debug.methodNotSupported(this,{ fileName : "EraseFill.hx", lineNumber : 15, className : "nanofl.engine.fills.EraseFill", methodName : "getTyped"});
	}
	,begin: function(g) {
		stdlib_Debug.methodNotSupported(this,{ fileName : "EraseFill.hx", lineNumber : 16, className : "nanofl.engine.fills.EraseFill", methodName : "begin"});
	}
	,equ: function(e) {
		return js_Boot.__instanceof(e,nanofl_engine_fills_EraseFill);
	}
	,swapInstance: function(oldNamePath,newNamePath) {
		stdlib_Debug.methodNotSupported(this,{ fileName : "EraseFill.hx", lineNumber : 18, className : "nanofl.engine.fills.EraseFill", methodName : "swapInstance"});
	}
	,getTransformed: function(m) {
		return this.clone();
	}
	,toString: function() {
		return "new EraseFill";
	}
	,__class__: nanofl_engine_fills_EraseFill
});
var nanofl_engine_fills_LinearFill = function(colors,ratios,x0,y0,x1,y1) {
	this.colors = colors;
	this.ratios = ratios;
	this.x0 = x0;
	this.y0 = y0;
	this.x1 = x1;
	this.y1 = y1;
};
$hxClasses["nanofl.engine.fills.LinearFill"] = nanofl_engine_fills_LinearFill;
nanofl_engine_fills_LinearFill.__name__ = ["nanofl","engine","fills","LinearFill"];
nanofl_engine_fills_LinearFill.__interfaces__ = [nanofl_engine_fills_IFill];
nanofl_engine_fills_LinearFill.load = function(node,version) {
	return nanofl_engine_Version.handle(version,(function($this) {
		var $r;
		var _g = new haxe_ds_StringMap();
		if(__map_reserved["1.0.0"] != null) _g.setReserved("1.0.0",function() {
			var matrix = nanofl_engine_geom_Matrix.load(node);
			var pt0 = matrix.transformPoint(-1,0);
			var pt1 = matrix.transformPoint(1,0);
			return new nanofl_engine_fills_LinearFill(htmlparser_HtmlParserTools.getAttr(node,"colors",[]),htmlparser_HtmlParserTools.getAttr(node,"ratios",[0.0]),htmlparser_HtmlParserTools.getAttr(node,"x0",pt0.x),htmlparser_HtmlParserTools.getAttr(node,"y0",pt0.y),htmlparser_HtmlParserTools.getAttr(node,"x1",pt1.x),htmlparser_HtmlParserTools.getAttr(node,"y1",pt1.y));
		}); else _g.h["1.0.0"] = function() {
			var matrix = nanofl_engine_geom_Matrix.load(node);
			var pt0 = matrix.transformPoint(-1,0);
			var pt1 = matrix.transformPoint(1,0);
			return new nanofl_engine_fills_LinearFill(htmlparser_HtmlParserTools.getAttr(node,"colors",[]),htmlparser_HtmlParserTools.getAttr(node,"ratios",[0.0]),htmlparser_HtmlParserTools.getAttr(node,"x0",pt0.x),htmlparser_HtmlParserTools.getAttr(node,"y0",pt0.y),htmlparser_HtmlParserTools.getAttr(node,"x1",pt1.x),htmlparser_HtmlParserTools.getAttr(node,"y1",pt1.y));
		};
		if(__map_reserved["2.0.0"] != null) _g.setReserved("2.0.0",function() {
			return new nanofl_engine_fills_LinearFill(htmlparser_HtmlParserTools.getAttr(node,"colors",[]),htmlparser_HtmlParserTools.getAttr(node,"ratios",[0.0]),htmlparser_HtmlParserTools.getAttr(node,"x0",0.0),htmlparser_HtmlParserTools.getAttr(node,"y0",0.0),htmlparser_HtmlParserTools.getAttr(node,"x1",0.0),htmlparser_HtmlParserTools.getAttr(node,"y1",0.0));
		}); else _g.h["2.0.0"] = function() {
			return new nanofl_engine_fills_LinearFill(htmlparser_HtmlParserTools.getAttr(node,"colors",[]),htmlparser_HtmlParserTools.getAttr(node,"ratios",[0.0]),htmlparser_HtmlParserTools.getAttr(node,"x0",0.0),htmlparser_HtmlParserTools.getAttr(node,"y0",0.0),htmlparser_HtmlParserTools.getAttr(node,"x1",0.0),htmlparser_HtmlParserTools.getAttr(node,"y1",0.0));
		};
		$r = _g;
		return $r;
	}(this)));
};
nanofl_engine_fills_LinearFill.__super__ = nanofl_engine_fills_BaseFill;
nanofl_engine_fills_LinearFill.prototype = $extend(nanofl_engine_fills_BaseFill.prototype,{
	colors: null
	,ratios: null
	,x0: null
	,y0: null
	,x1: null
	,y1: null
	,save: function(out) {
		out.begin("fill").attr("type","linear");
		out.attr("colors",this.colors);
		out.attr("ratios",this.ratios);
		out.attr("x0",this.x0);
		out.attr("y0",this.y0);
		out.attr("x1",this.x1);
		out.attr("y1",this.y1);
		out.end();
	}
	,clone: function() {
		return new nanofl_engine_fills_LinearFill(this.colors.slice(),this.ratios.slice(),this.x0,this.y0,this.x1,this.y1);
	}
	,applyAlpha: function(alpha) {
		var _g1 = 0;
		var _g = this.colors.length;
		while(_g1 < _g) {
			var i = _g1++;
			var rgba = nanofl_engine_ColorTools.parse(this.colors[i]);
			rgba.a *= alpha;
			this.colors[i] = nanofl_engine_ColorTools.rgbaToString(rgba);
		}
	}
	,getTyped: function() {
		return nanofl_engine_fills_TypedFill.LINEAR(this);
	}
	,begin: function(g) {
		g.beginLinearGradientFill(this.colors,this.ratios,this.x0,this.y0,this.x1,this.y1);
	}
	,equ: function(e) {
		if(e == this) return true;
		if(js_Boot.__instanceof(e,nanofl_engine_fills_LinearFill)) {
			var ee = e;
			return this.arrEqu(ee.colors,this.colors) && this.arrEqu(ee.ratios,this.ratios) && ee.x0 == this.x0 && ee.y0 == this.y0 && ee.x1 == this.x1 && ee.y1 == this.y1;
		}
		return false;
	}
	,arrEqu: function(a,b) {
		if(a.length != b.length) return false;
		var _g1 = 0;
		var _g = a.length;
		while(_g1 < _g) {
			var i = _g1++;
			if(a[i] != b[i]) return false;
		}
		return true;
	}
	,swapInstance: function(oldNamePath,newNamePath) {
	}
	,getTransformed: function(m) {
		var r = this.clone();
		var p0 = m.transformPoint(this.x0,this.y0);
		r.x0 = p0.x;
		r.y0 = p0.y;
		var p1 = m.transformPoint(this.x1,this.y1);
		r.x1 = p1.x;
		r.y1 = p1.y;
		return r;
	}
	,toString: function() {
		return "new LinearFill(" + Std.string(this.colors.map(function(s) {
			return "\"" + s + "\"";
		})) + (", " + Std.string(this.ratios) + ", " + this.x0 + ", " + this.y0 + ", " + this.x1 + ", " + this.y1 + ")");
	}
	,__class__: nanofl_engine_fills_LinearFill
});
var nanofl_engine_fills_RadialFill = function(colors,ratios,cx,cy,r,fx,fy) {
	this.colors = colors;
	this.ratios = ratios;
	this.cx = cx;
	this.cy = cy;
	this.r = r;
	this.fx = fx;
	this.fy = fy;
};
$hxClasses["nanofl.engine.fills.RadialFill"] = nanofl_engine_fills_RadialFill;
nanofl_engine_fills_RadialFill.__name__ = ["nanofl","engine","fills","RadialFill"];
nanofl_engine_fills_RadialFill.__interfaces__ = [nanofl_engine_fills_IFill];
nanofl_engine_fills_RadialFill.load = function(node,version) {
	return nanofl_engine_Version.handle(version,(function($this) {
		var $r;
		var _g = new haxe_ds_StringMap();
		if(__map_reserved["1.0.0"] != null) _g.setReserved("1.0.0",function() {
			var matrix = nanofl_engine_geom_Matrix.load(node);
			var props = matrix.decompose();
			return new nanofl_engine_fills_RadialFill(htmlparser_HtmlParserTools.getAttr(node,"colors",[]),htmlparser_HtmlParserTools.getAttr(node,"ratios",[0.0]),props.x,props.y,(props.scaleX + props.scaleY) / 2,props.x,props.y);
		}); else _g.h["1.0.0"] = function() {
			var matrix = nanofl_engine_geom_Matrix.load(node);
			var props = matrix.decompose();
			return new nanofl_engine_fills_RadialFill(htmlparser_HtmlParserTools.getAttr(node,"colors",[]),htmlparser_HtmlParserTools.getAttr(node,"ratios",[0.0]),props.x,props.y,(props.scaleX + props.scaleY) / 2,props.x,props.y);
		};
		if(__map_reserved["2.0.0"] != null) _g.setReserved("2.0.0",function() {
			var cx = htmlparser_HtmlParserTools.getAttr(node,"cx",0.0);
			var cy = htmlparser_HtmlParserTools.getAttr(node,"cy",0.0);
			return new nanofl_engine_fills_RadialFill(htmlparser_HtmlParserTools.getAttr(node,"colors",[]),htmlparser_HtmlParserTools.getAttr(node,"ratios",[0.0]),cx,cy,htmlparser_HtmlParserTools.getAttr(node,"r",0.0),htmlparser_HtmlParserTools.getAttr(node,"fx",cx),htmlparser_HtmlParserTools.getAttr(node,"fy",cy));
		}); else _g.h["2.0.0"] = function() {
			var cx = htmlparser_HtmlParserTools.getAttr(node,"cx",0.0);
			var cy = htmlparser_HtmlParserTools.getAttr(node,"cy",0.0);
			return new nanofl_engine_fills_RadialFill(htmlparser_HtmlParserTools.getAttr(node,"colors",[]),htmlparser_HtmlParserTools.getAttr(node,"ratios",[0.0]),cx,cy,htmlparser_HtmlParserTools.getAttr(node,"r",0.0),htmlparser_HtmlParserTools.getAttr(node,"fx",cx),htmlparser_HtmlParserTools.getAttr(node,"fy",cy));
		};
		$r = _g;
		return $r;
	}(this)));
};
nanofl_engine_fills_RadialFill.__super__ = nanofl_engine_fills_BaseFill;
nanofl_engine_fills_RadialFill.prototype = $extend(nanofl_engine_fills_BaseFill.prototype,{
	colors: null
	,ratios: null
	,cx: null
	,cy: null
	,r: null
	,fx: null
	,fy: null
	,save: function(out) {
		out.begin("fill").attr("type","radial");
		out.attr("colors",this.colors);
		out.attr("ratios",this.ratios);
		out.attr("cx",this.cx);
		out.attr("cy",this.cy);
		out.attr("r",this.r);
		out.attr("fx",this.fx,this.cx);
		out.attr("fy",this.fy,this.cy);
		out.end();
	}
	,clone: function() {
		return new nanofl_engine_fills_RadialFill(this.colors.slice(),this.ratios.slice(),this.cx,this.cy,this.r,this.fx,this.fy);
	}
	,applyAlpha: function(alpha) {
		var _g1 = 0;
		var _g = this.colors.length;
		while(_g1 < _g) {
			var i = _g1++;
			var rgba = nanofl_engine_ColorTools.parse(this.colors[i]);
			rgba.a *= alpha;
			this.colors[i] = nanofl_engine_ColorTools.rgbaToString(rgba);
		}
	}
	,getTyped: function() {
		return nanofl_engine_fills_TypedFill.RADIAL(this);
	}
	,begin: function(g) {
		g.beginRadialGradientFill(this.colors,this.ratios,this.fx,this.fy,0,this.cx,this.cy,this.r);
	}
	,equ: function(e) {
		if(e == this) return true;
		if(js_Boot.__instanceof(e,nanofl_engine_fills_RadialFill)) {
			var ee = e;
			return this.arrEqu(ee.colors,this.colors) && this.arrEqu(ee.ratios,this.ratios) && ee.cx == this.cx && ee.cy == this.cy && ee.r == this.r && ee.fx == this.fx && ee.fy == this.fy;
		}
		return false;
	}
	,arrEqu: function(a,b) {
		if(a.length != b.length) return false;
		var _g1 = 0;
		var _g = a.length;
		while(_g1 < _g) {
			var i = _g1++;
			if(a[i] != b[i]) return false;
		}
		return true;
	}
	,swapInstance: function(oldNamePath,newNamePath) {
	}
	,getTransformed: function(m) {
		var fill = this.clone();
		var c = m.transformPoint(this.cx,this.cy);
		fill.cx = c.x;
		fill.cy = c.y;
		var f = m.transformPoint(this.fx,this.fy);
		fill.fx = f.x;
		fill.fy = f.y;
		fill.r *= m.getAverageScale();
		return fill;
	}
	,toString: function() {
		return "new RadialFill(" + Std.string(this.colors) + ", " + Std.string(this.ratios) + ", " + this.cx + ", " + this.cy + ", " + this.r + ", " + this.fx + ", " + this.fy + ")";
	}
	,__class__: nanofl_engine_fills_RadialFill
});
var nanofl_engine_fills_SelectionFill = function(scale) {
	if(nanofl_engine_fills_SelectionFill.pattern == null) {
		nanofl_engine_fills_SelectionFill.pattern = new createjs.Shape();
		nanofl_engine_fills_SelectionFill.pattern.graphics.beginFill("rgba(0,0,0,0.75)").rect(0,0,1,1).rect(2,2,1,1).endFill().beginFill("rgba(255,255,255,0.75)").rect(2,0,1,1).rect(0,2,1,1).endFill();
		nanofl_engine_fills_SelectionFill.pattern.cache(0,0,4,4);
	}
	this.scale = scale;
};
$hxClasses["nanofl.engine.fills.SelectionFill"] = nanofl_engine_fills_SelectionFill;
nanofl_engine_fills_SelectionFill.__name__ = ["nanofl","engine","fills","SelectionFill"];
nanofl_engine_fills_SelectionFill.__interfaces__ = [nanofl_engine_fills_IFill];
nanofl_engine_fills_SelectionFill.__super__ = nanofl_engine_fills_BaseFill;
nanofl_engine_fills_SelectionFill.prototype = $extend(nanofl_engine_fills_BaseFill.prototype,{
	scale: null
	,save: function(out) {
		throw new js__$Boot_HaxeError("Unsupported.");
	}
	,clone: function() {
		throw new js__$Boot_HaxeError("Unsupported.");
		return null;
	}
	,applyAlpha: function(alpha) {
	}
	,getTransformed: function(m) {
		return this;
	}
	,getTyped: function() {
		throw new js__$Boot_HaxeError("Unsupported.");
		return null;
	}
	,begin: function(g) {
		g.beginBitmapFill(nanofl_engine_fills_SelectionFill.pattern.cacheCanvas,"repeat",new createjs.Matrix2D(this.scale,0,0,this.scale));
	}
	,equ: function(e) {
		throw new js__$Boot_HaxeError("Unsupported.");
		return null;
	}
	,swapInstance: function(oldNamePath,newNamePath) {
	}
	,toString: function() {
		return "new SelectionFill()";
	}
	,__class__: nanofl_engine_fills_SelectionFill
});
var nanofl_engine_fills_SolidFill = function(color) {
	this.color = color;
};
$hxClasses["nanofl.engine.fills.SolidFill"] = nanofl_engine_fills_SolidFill;
nanofl_engine_fills_SolidFill.__name__ = ["nanofl","engine","fills","SolidFill"];
nanofl_engine_fills_SolidFill.__interfaces__ = [nanofl_engine_fills_IFill];
nanofl_engine_fills_SolidFill.load = function(node,version) {
	return new nanofl_engine_fills_SolidFill(htmlparser_HtmlParserTools.getAttr(node,"color","#000000"));
};
nanofl_engine_fills_SolidFill.__super__ = nanofl_engine_fills_BaseFill;
nanofl_engine_fills_SolidFill.prototype = $extend(nanofl_engine_fills_BaseFill.prototype,{
	color: null
	,save: function(out) {
		out.begin("fill").attr("type","solid");
		out.attr("color",this.color);
		out.end();
	}
	,clone: function() {
		return new nanofl_engine_fills_SolidFill(this.color);
	}
	,applyAlpha: function(alpha) {
		var rgba = nanofl_engine_ColorTools.parse(this.color);
		rgba.a *= alpha;
		this.color = nanofl_engine_ColorTools.rgbaToString(rgba);
	}
	,getTransformed: function(m) {
		return this;
	}
	,getTyped: function() {
		return nanofl_engine_fills_TypedFill.SOLID(this);
	}
	,begin: function(g) {
		g.beginFill(this.color);
	}
	,equ: function(e) {
		if(e == this) return true;
		if(js_Boot.__instanceof(e,nanofl_engine_fills_SolidFill)) {
			var ee = e;
			return ee.color == this.color;
		}
		return false;
	}
	,swapInstance: function(oldNamePath,newNamePath) {
	}
	,toString: function() {
		return "new SolidFill(\"" + this.color + "\")";
	}
	,__class__: nanofl_engine_fills_SolidFill
});
var nanofl_engine_fills_TypedFill = $hxClasses["nanofl.engine.fills.TypedFill"] = { __ename__ : ["nanofl","engine","fills","TypedFill"], __constructs__ : ["SOLID","LINEAR","RADIAL","BITMAP"] };
nanofl_engine_fills_TypedFill.SOLID = function(fill) { var $x = ["SOLID",0,fill]; $x.__enum__ = nanofl_engine_fills_TypedFill; $x.toString = $estr; return $x; };
nanofl_engine_fills_TypedFill.LINEAR = function(fill) { var $x = ["LINEAR",1,fill]; $x.__enum__ = nanofl_engine_fills_TypedFill; $x.toString = $estr; return $x; };
nanofl_engine_fills_TypedFill.RADIAL = function(fill) { var $x = ["RADIAL",2,fill]; $x.__enum__ = nanofl_engine_fills_TypedFill; $x.toString = $estr; return $x; };
nanofl_engine_fills_TypedFill.BITMAP = function(fill) { var $x = ["BITMAP",3,fill]; $x.__enum__ = nanofl_engine_fills_TypedFill; $x.toString = $estr; return $x; };
var nanofl_engine_geom_BezierCurve = function(x1,y1,x2,y2,x3,y3) {
	this.p1 = { x : x1, y : y1};
	this.p2 = { x : x2, y : y2};
	this.p3 = { x : x3, y : y3};
};
$hxClasses["nanofl.engine.geom.BezierCurve"] = nanofl_engine_geom_BezierCurve;
nanofl_engine_geom_BezierCurve.__name__ = ["nanofl","engine","geom","BezierCurve"];
nanofl_engine_geom_BezierCurve.isTrianglesIntersect = function(curveA,curveB) {
	var contourA = new nanofl_engine_geom_Contour(curveA.getTriangle());
	var contourB = new nanofl_engine_geom_Contour(curveB.getTriangle());
	var _g = 0;
	var _g1 = contourA.edges;
	while(_g < _g1.length) {
		var a = _g1[_g];
		++_g;
		var _g2 = 0;
		var _g3 = contourB.edges;
		while(_g2 < _g3.length) {
			var b = _g3[_g2];
			++_g2;
			if(a.asStraightLine().getIntersection_straightSection(b.asStraightLine()) != null) return true;
		}
	}
	if((contourA.hasPoint(curveB.p1.x,curveB.p1.y) || !contourA.isPointInside(curveB.p1.x,curveB.p1.y)) && (contourA.hasPoint(curveB.p2.x,curveB.p2.y) || !contourA.isPointInside(curveB.p2.x,curveB.p2.y)) && (contourA.hasPoint(curveB.p3.x,curveB.p3.y) || !contourA.isPointInside(curveB.p3.x,curveB.p3.y))) {
		if((contourB.hasPoint(curveA.p1.x,curveA.p1.y) || !contourB.isPointInside(curveA.p1.x,curveA.p1.y)) && (contourB.hasPoint(curveA.p2.x,curveA.p2.y) || !contourB.isPointInside(curveA.p2.x,curveA.p2.y)) && (contourB.hasPoint(curveA.p3.x,curveA.p3.y) || !contourB.isPointInside(curveA.p3.x,curveA.p3.y))) return false;
	}
	return true;
};
nanofl_engine_geom_BezierCurve.getIntersection_bezierCurve_inner = function(curveA,curveB) {
	if(curveA.equ(curveB)) return null;
	var I = nanofl_engine_geom_BezierCurve.getIntersection_bezierCurve_getT(0,1,curveA,0,1,curveB,0);
	if(I == null) return null;
	stdlib_Debug.assert(I.a.length == I.b.length,"I.a.length=" + I.a.length + " != I.b.length=" + I.b.length,{ fileName : "BezierCurve.hx", lineNumber : 434, className : "nanofl.engine.geom.BezierCurve", methodName : "getIntersection_bezierCurve_inner"});
	if(I.a.length > 4) {
		nanofl_engine_geom_BezierCurve.log("I.a.length = " + I.a.length + " ON:\ngetIntersection_bezierCurve_inner(" + Std.string(curveA) + ", " + Std.string(curveB) + ")",{ fileName : "BezierCurve.hx", lineNumber : 438, className : "nanofl.engine.geom.BezierCurve", methodName : "getIntersection_bezierCurve_inner"});
		return null;
	}
	if(I.a.length == 0) return null;
	var relatedIndexesInB;
	var _g = [];
	var _g2 = 0;
	var _g1 = I.a.length;
	while(_g2 < _g1) {
		var i = _g2++;
		_g.push(i);
	}
	relatedIndexesInB = _g;
	nanofl_engine_geom_BezierCurve.parallelSort(I.a,relatedIndexesInB);
	nanofl_engine_geom_BezierCurve.parallelSort(I.b,relatedIndexesInB,true);
	var r = { a : curveA.split(I.a), b : curveB.split(I.b)};
	var _g21 = 0;
	var _g11 = r.a.length - 1;
	while(_g21 < _g11) {
		var i1 = _g21++;
		r.a[i1].p3.x = r.a[i1 + 1].p1.x = r.b[relatedIndexesInB[i1]].p3.x;
		r.a[i1].p3.y = r.a[i1 + 1].p1.y = r.b[relatedIndexesInB[i1]].p3.y;
	}
	nanofl_engine_geom_BezierCurve.excludeDegenerated(r.a);
	nanofl_engine_geom_BezierCurve.excludeDegenerated(r.b);
	return r;
};
nanofl_engine_geom_BezierCurve.excludeDegenerated = function(arr) {
	var i = 0;
	while(i < arr.length) if(arr[i].isDegenerated()) arr.splice(i,1); else i++;
	return arr;
};
nanofl_engine_geom_BezierCurve.getIntersection_bezierCurve_getT = function(ta1,ta2,curveA,tb1,tb2,curveB,level) {
	level++;
	if(!nanofl_engine_geom_BoundsTools.isIntersect(curveA.getBounds(),curveB.getBounds())) return null;
	if(!nanofl_engine_geom_BezierCurve.isTrianglesIntersect(curveA,curveB)) return null;
	var tinyA = curveA.isTiny();
	var tinyB = curveB.isTiny();
	var I1 = null;
	var I2 = null;
	var I3 = null;
	var I4 = null;
	if(!tinyA && !tinyB) {
		var subCurvesA = curveA.split([0.5]);
		var subCurvesB = curveB.split([0.5]);
		I1 = nanofl_engine_geom_BezierCurve.getIntersection_bezierCurve_getT(ta1,(ta1 + ta2) / 2,subCurvesA[0],tb1,(tb1 + tb2) / 2,subCurvesB[0],level);
		I2 = nanofl_engine_geom_BezierCurve.getIntersection_bezierCurve_getT(ta1,(ta1 + ta2) / 2,subCurvesA[0],(tb1 + tb2) / 2,tb2,subCurvesB[1],level);
		I3 = nanofl_engine_geom_BezierCurve.getIntersection_bezierCurve_getT((ta1 + ta2) / 2,ta2,subCurvesA[1],tb1,(tb1 + tb2) / 2,subCurvesB[0],level);
		I4 = nanofl_engine_geom_BezierCurve.getIntersection_bezierCurve_getT((ta1 + ta2) / 2,ta2,subCurvesA[1],(tb1 + tb2) / 2,tb2,subCurvesB[1],level);
	} else if(!tinyA && tinyB) {
		var subCurvesA1 = curveA.split([0.5]);
		I1 = nanofl_engine_geom_BezierCurve.getIntersection_bezierCurve_getT(ta1,(ta1 + ta2) / 2,subCurvesA1[0],tb1,tb2,curveB,level);
		I2 = nanofl_engine_geom_BezierCurve.getIntersection_bezierCurve_getT((ta1 + ta2) / 2,ta2,subCurvesA1[1],tb1,tb2,curveB,level);
	} else if(tinyA && !tinyB) {
		var subCurvesB1 = curveB.split([0.5]);
		I1 = nanofl_engine_geom_BezierCurve.getIntersection_bezierCurve_getT(ta1,ta2,curveA,tb1,(tb1 + tb2) / 2,subCurvesB1[0],level);
		I2 = nanofl_engine_geom_BezierCurve.getIntersection_bezierCurve_getT(ta1,ta2,curveA,(tb1 + tb2) / 2,tb2,subCurvesB1[1],level);
	} else {
		var lineA = new nanofl_engine_geom_StraightLine(curveA.p1.x,curveA.p1.y,curveA.p3.x,curveA.p3.y);
		var lineB = new nanofl_engine_geom_StraightLine(curveB.p1.x,curveB.p1.y,curveB.p3.x,curveB.p3.y);
		if(lineA.getIntersection_straightSection(lineB) != null) return { a : [(ta1 + ta2) / 2], b : [(tb1 + tb2) / 2]};
		return null;
	}
	if(I1 == null && I2 == null && I3 == null && I4 == null) return null;
	var r = { a : [], b : []};
	if(I1 != null) {
		var _g = 0;
		var _g1 = I1.a;
		while(_g < _g1.length) {
			var e = _g1[_g];
			++_g;
			r.a.push(e);
		}
		var _g2 = 0;
		var _g11 = I1.b;
		while(_g2 < _g11.length) {
			var e1 = _g11[_g2];
			++_g2;
			r.b.push(e1);
		}
	}
	if(I2 != null) {
		var _g3 = 0;
		var _g12 = I2.a;
		while(_g3 < _g12.length) {
			var e2 = _g12[_g3];
			++_g3;
			r.a.push(e2);
		}
		var _g4 = 0;
		var _g13 = I2.b;
		while(_g4 < _g13.length) {
			var e3 = _g13[_g4];
			++_g4;
			r.b.push(e3);
		}
	}
	if(I3 != null) {
		var _g5 = 0;
		var _g14 = I3.a;
		while(_g5 < _g14.length) {
			var e4 = _g14[_g5];
			++_g5;
			r.a.push(e4);
		}
		var _g6 = 0;
		var _g15 = I3.b;
		while(_g6 < _g15.length) {
			var e5 = _g15[_g6];
			++_g6;
			r.b.push(e5);
		}
	}
	if(I4 != null) {
		var _g7 = 0;
		var _g16 = I4.a;
		while(_g7 < _g16.length) {
			var e6 = _g16[_g7];
			++_g7;
			r.a.push(e6);
		}
		var _g8 = 0;
		var _g17 = I4.b;
		while(_g8 < _g17.length) {
			var e7 = _g17[_g8];
			++_g8;
			r.b.push(e7);
		}
	}
	stdlib_Debug.assert(r.a.length == r.b.length,null,{ fileName : "BezierCurve.hx", lineNumber : 587, className : "nanofl.engine.geom.BezierCurve", methodName : "getIntersection_bezierCurve_getT"});
	return r;
};
nanofl_engine_geom_BezierCurve.parallelSort = function(a,b,byValue) {
	if(byValue == null) byValue = false;
	var _g1 = 0;
	var _g = a.length - 1;
	while(_g1 < _g) {
		var i = _g1++;
		var _g3 = 0;
		var _g2 = a.length - 1;
		while(_g3 < _g2) {
			var j = _g3++;
			if(a[j] > a[j + 1]) {
				var z = a[j];
				a[j] = a[j + 1];
				a[j + 1] = z;
				if(!byValue) {
					var t = b[j];
					b[j] = b[j + 1];
					b[j + 1] = t;
				} else {
					var n1 = HxOverrides.indexOf(b,j,0);
					var n2 = HxOverrides.indexOf(b,j + 1,0);
					b[n1] = j + 1;
					b[n2] = j;
				}
			}
		}
	}
};
nanofl_engine_geom_BezierCurve.log = function(v,infos) {
};
nanofl_engine_geom_BezierCurve.prototype = {
	p1: null
	,p2: null
	,p3: null
	,getNearestPoint: function(x,y) {
		var Ax = this.p2.x - this.p1.x;
		var Ay = this.p2.y - this.p1.y;
		var Bx = this.p1.x - 2 * this.p2.x + this.p3.x;
		var By = this.p1.y - 2 * this.p2.y + this.p3.y;
		var dx = this.p1.x - x;
		var dy = this.p1.y - y;
		var sol = nanofl_engine_geom_Equation.solveCube(Bx * Bx + By * By,3 * (Ax * Bx + Ay * By),2 * (Ax * Ax + Ay * Ay) + dx * Bx + dy * By,dx * Ax + dy * Ay);
		var d1 = nanofl_engine_geom_PointTools.getSqrDist(x,y,this.p1.x,this.p1.y);
		var d3 = nanofl_engine_geom_PointTools.getSqrDist(x,y,this.p3.x,this.p3.y);
		if(sol.length > 0) {
			var tMin = null;
			var distMin = 1.0e100;
			var pointMin = null;
			var _g = 0;
			while(_g < sol.length) {
				var t = sol[_g];
				++_g;
				if(t >= 0 && t <= 1) {
					var pt = this.getPoint(t);
					var dist = nanofl_engine_geom_PointTools.getSqrDist(x,y,pt.x,pt.y);
					if(dist < distMin) {
						tMin = t;
						distMin = dist;
						pointMin = pt;
					}
				}
			}
			if(tMin != null && distMin < d1 && distMin < d3) {
				var nor = { x : Ay + tMin * By, y : -(Ax + tMin * Bx)};
				nanofl_engine_geom_PointTools.normalize(nor);
				var dist1 = Math.sqrt(distMin);
				var orientedDist = dist1;
				if((x - pointMin.x) * nor.x + (y - pointMin.y) * nor.y < 0) {
					nor.x *= -1;
					nor.y *= -1;
					orientedDist *= -1;
				}
				return { t : tMin, point : pointMin, nor : nor, dist : dist1, orientedDist : orientedDist};
			}
		}
		if(d1 < d3) {
			var dist2 = Math.sqrt(d1);
			return { t : 0, point : nanofl_engine_geom_PointTools.clone(this.p1), nor : nanofl_engine_geom_PointTools.normalize({ x : x - this.p1.x, y : y - this.p1.y}), dist : dist2, orientedDist : dist2};
		} else {
			var dist3 = Math.sqrt(d3);
			return { t : 1, point : nanofl_engine_geom_PointTools.clone(this.p3), nor : nanofl_engine_geom_PointTools.normalize({ x : x - this.p3.x, y : y - this.p3.y}), dist : dist3, orientedDist : dist3};
		}
	}
	,getNearestPointP: function(pt) {
		return this.getNearestPoint(pt.x,pt.y);
	}
	,getPoint: function(t) {
		if(t == 0) return nanofl_engine_geom_PointTools.clone(this.p1);
		if(t == 1) return nanofl_engine_geom_PointTools.clone(this.p3);
		var z = 1 - t;
		var a = z * z;
		var b = 2 * t * z;
		var c = t * t;
		return { x : a * this.p1.x + b * this.p2.x + c * this.p3.x, y : a * this.p1.y + b * this.p2.y + c * this.p3.y};
	}
	,getPointX: function(t) {
		if(t == 0) return this.p1.x;
		if(t == 1) return this.p3.x;
		var z = 1 - t;
		var a = z * z;
		var b = 2 * t * z;
		var c = t * t;
		return a * this.p1.x + b * this.p2.x + c * this.p3.x;
	}
	,getNor: function(t) {
		var Ax = this.p2.x - this.p1.x;
		var Ay = this.p2.y - this.p1.y;
		var Bx = this.p1.x - 2 * this.p2.x + this.p3.x;
		var By = this.p1.y - 2 * this.p2.y + this.p3.y;
		var nor = { x : Ay + t * By, y : -(Ax + t * Bx)};
		nanofl_engine_geom_PointTools.normalize(nor);
		return nor;
	}
	,getBounds: function() {
		var r = { minX : Math.min(this.p1.x,Math.min(this.p2.x,this.p3.x)), maxX : Math.max(this.p1.x,Math.max(this.p2.x,this.p3.x)), minY : Math.min(this.p1.y,Math.min(this.p2.y,this.p3.y)), maxY : Math.max(this.p1.y,Math.max(this.p2.y,this.p3.y))};
		var Ax = this.p2.x - this.p1.x;
		var Ay = this.p2.y - this.p1.y;
		var Bx = this.p1.x - 2 * this.p2.x + this.p3.x;
		var By = this.p1.y - 2 * this.p2.y + this.p3.y;
		if(Math.abs(Bx) > 1e-10 && (r.minX == this.p2.x || r.maxX == this.p2.x)) {
			var u = -Ax / Bx;
			u = (1 - u) * (1 - u) * this.p1.x + 2 * u * (1 - u) * this.p2.x + u * u * this.p3.x;
			if(r.minX == this.p2.x) r.minX = u; else r.maxX = u;
		}
		if(Math.abs(By) > 1e-10 && (r.minY == this.p2.y || r.maxY == this.p2.y)) {
			var u1 = -Ay / By;
			u1 = (1 - u1) * (1 - u1) * this.p1.y + 2 * u1 * (1 - u1) * this.p2.y + u1 * u1 * this.p3.y;
			if(r.minY == this.p2.y) r.minY = u1; else r.maxY = u1;
		}
		return r;
	}
	,getIntersectionPointsX_rightRay: function(mx,my) {
		var r = [];
		if(my >= Math.min(this.p1.y,Math.min(this.p2.y,this.p3.y)) && my <= Math.max(this.p1.y,Math.max(this.p2.y,this.p3.y)) && mx <= Math.max(this.p1.x,Math.max(this.p2.x,this.p3.x))) {
			var Ay = this.p2.y - this.p1.y;
			var By = this.p1.y - 2 * this.p2.y + this.p3.y;
			var lineIntersectionCount = 0;
			var _g = 0;
			var _g1 = nanofl_engine_geom_Equation.solveQuadratic(By,2 * Ay,this.p1.y - my);
			while(_g < _g1.length) {
				var t = _g1[_g];
				++_g;
				if(t > 0 && t < 1.0) {
					var x = this.getPointX(t);
					if(x > mx) r.push(x);
					lineIntersectionCount++;
				}
			}
			if(lineIntersectionCount == 1 && (this.p1.y < my && this.p3.y < my || this.p1.y > my && this.p3.y > my)) return [];
		}
		return r;
	}
	,getIntersectionCount_rightRay: function(mx,my) {
		return this.getIntersectionPointsX_rightRay(mx,my).length;
	}
	,getIntersections_horizontalStraightSection: function(m1x,my,m2x) {
		var r = [];
		if(my >= Math.min(this.p1.y,Math.min(this.p2.y,this.p3.y)) && my <= Math.max(this.p1.y,Math.max(this.p2.y,this.p3.y))) {
			var Ay = this.p2.y - this.p1.y;
			var By = this.p1.y - 2 * this.p2.y + this.p3.y;
			var tt = nanofl_engine_geom_Equation.solveQuadratic(By,2 * Ay,this.p1.y - my);
			var _g = 0;
			while(_g < tt.length) {
				var t = tt[_g];
				++_g;
				if(t >= 0 && t <= 1) {
					var x = (1 - t) * (1 - t) * this.p1.x + 2 * (1 - t) * t * this.p2.x + t * t * this.p3.x;
					if(x > Math.min(m1x,m2x) && x < Math.max(m1x,m2x)) r.push({ t : t, x : x, y : my});
				}
			}
			if(r.length == 2 && r[0].t > r[1].t) {
				var z = r[0];
				r[0] = r[1];
				r[1] = z;
			}
		}
		return r;
	}
	,getIntersection_straightSection: function(line) {
		if(!nanofl_engine_geom_BoundsTools.isIntersect(this.getBounds(),line.getBounds())) return null;
		var tt = this.getIntersection_straightSection_getT(line);
		if(tt == null) return null;
		if(tt.length == 1) {
			var curves = this.split(tt);
			var m = curves[0].p3;
			var lines = [new nanofl_engine_geom_StraightLine(line.x1,line.y1,m.x,m.y),new nanofl_engine_geom_StraightLine(m.x,m.y,line.x2,line.y2)];
			return { curves : nanofl_engine_geom_BezierCurve.excludeDegenerated(curves), lines : nanofl_engine_geom_BezierCurve.excludeDegenerated(lines)};
		} else if(tt.length == 2) {
			var curves1 = this.split(tt);
			var m0 = curves1[1].p1;
			var m1 = curves1[1].p3;
			if(nanofl_engine_geom_PointTools.getSqrDist(line.x1,line.y1,m0.x,m0.y) < nanofl_engine_geom_PointTools.getSqrDist(line.x1,line.y1,m1.x,m1.y)) {
				var lines1 = [new nanofl_engine_geom_StraightLine(line.x1,line.y1,m0.x,m0.y),new nanofl_engine_geom_StraightLine(m0.x,m0.y,m1.x,m1.y),new nanofl_engine_geom_StraightLine(m1.x,m1.y,line.x2,line.y2)];
				return { curves : nanofl_engine_geom_BezierCurve.excludeDegenerated(curves1), lines : nanofl_engine_geom_BezierCurve.excludeDegenerated(lines1)};
			} else {
				var lines2 = [new nanofl_engine_geom_StraightLine(line.x1,line.y1,m1.x,m1.y),new nanofl_engine_geom_StraightLine(m1.x,m1.y,m0.x,m0.y),new nanofl_engine_geom_StraightLine(m0.x,m0.y,line.x2,line.y2)];
				return { curves : nanofl_engine_geom_BezierCurve.excludeDegenerated(curves1), lines : nanofl_engine_geom_BezierCurve.excludeDegenerated(lines2)};
			}
		}
		return null;
	}
	,getIntersection_straightSection_getT: function(line) {
		if(!nanofl_engine_geom_BoundsTools.isIntersect(this.getBounds(),line.getBounds())) return null;
		var dx = line.x2 - line.x1;
		var dy = line.y2 - line.y1;
		var len = Math.sqrt(dx * dx + dy * dy);
		var da = Math.atan2(dy,dx);
		var rotatedCurve = this.clone().translate(-line.x1,-line.y1).rotate(-da);
		var I = rotatedCurve.getIntersections_horizontalStraightSection(0,0,len);
		var _g = 0;
		while(_g < I.length) {
			var i = I[_g];
			++_g;
			var p = nanofl_engine_geom_PointTools.rotate(i.x,i.y,da);
			i.x = p.x + line.x1;
			i.y = p.y + line.y1;
		}
		if(I.length == 1) return [I[0].t]; else if(I.length == 2) return [I[0].t,I[1].t];
		return null;
	}
	,getIntersection_bezierCurve: function(curve) {
		var r = nanofl_engine_geom_BezierCurve.getIntersection_bezierCurve_inner(this,curve);
		return r;
	}
	,isDegenerated: function() {
		return nanofl_engine_geom_PointTools.equ(this.p1,this.p2) && nanofl_engine_geom_PointTools.equ(this.p2,this.p3);
	}
	,getFirstPart: function(t) {
		var m = this.getPoint(t);
		return new nanofl_engine_geom_BezierCurve(this.p1.x,this.p1.y,this.p1.x + t * (this.p2.x - this.p1.x),this.p1.y + t * (this.p2.y - this.p1.y),m.x,m.y);
	}
	,getSecondPart: function(t) {
		var m = this.getPoint(t);
		return new nanofl_engine_geom_BezierCurve(m.x,m.y,this.p2.x + t * (this.p3.x - this.p2.x),this.p2.y + t * (this.p3.y - this.p2.y),this.p3.x,this.p3.y);
	}
	,getPart: function(t1,t2) {
		return this.getSecondPart(t1).getFirstPart((t2 - t1) / (1 - t1));
	}
	,split: function(tt) {
		if(tt.length == 0) return [this.clone()];
		if(tt.length == 1) {
			var m = this.getPoint(tt[0]);
			return [new nanofl_engine_geom_BezierCurve(this.p1.x,this.p1.y,this.p1.x + tt[0] * (this.p2.x - this.p1.x),this.p1.y + tt[0] * (this.p2.y - this.p1.y),m.x,m.y),new nanofl_engine_geom_BezierCurve(m.x,m.y,this.p2.x + tt[0] * (this.p3.x - this.p2.x),this.p2.y + tt[0] * (this.p3.y - this.p2.y),this.p3.x,this.p3.y)];
		}
		if(tt.length == 2) {
			var curves = this.split([tt[0]]);
			var r1 = [curves[0],curves[1].getFirstPart((tt[1] - tt[0]) / (1 - tt[0])),this.getSecondPart(tt[1])];
			stdlib_Debug.assert(r1[0].p3.x == r1[1].p1.x && r1[0].p3.y == r1[1].p1.y,null,{ fileName : "BezierCurve.hx", lineNumber : 632, className : "nanofl.engine.geom.BezierCurve", methodName : "split"});
			r1[1].p3.x = r1[2].p1.x;
			r1[1].p3.y = r1[2].p1.y;
			stdlib_Debug.assert(r1[1].p3.x == r1[2].p1.x && r1[1].p3.y == r1[2].p1.y,null,{ fileName : "BezierCurve.hx", lineNumber : 635, className : "nanofl.engine.geom.BezierCurve", methodName : "split"});
			return r1;
		}
		var r = [];
		r.push(this.getFirstPart(tt[0]));
		var _g1 = 0;
		var _g = tt.length - 1;
		while(_g1 < _g) {
			var i = _g1++;
			r.push(this.getPart(tt[i],tt[i + 1]));
		}
		r.push(this.getSecondPart(tt[tt.length - 1]));
		var _g11 = 0;
		var _g2 = tt.length;
		while(_g11 < _g2) {
			var i1 = _g11++;
			r[i1].p3.x = r[i1 + 1].p1.x;
			r[i1].p3.y = r[i1 + 1].p1.y;
		}
		return r;
	}
	,translate: function(dx,dy) {
		this.p1.x += dx;
		this.p1.y += dy;
		this.p2.x += dx;
		this.p2.y += dy;
		this.p3.x += dx;
		this.p3.y += dy;
		return this;
	}
	,rotate: function(da) {
		this.p1 = nanofl_engine_geom_PointTools.getRotated(this.p1,da);
		this.p2 = nanofl_engine_geom_PointTools.getRotated(this.p2,da);
		this.p3 = nanofl_engine_geom_PointTools.getRotated(this.p3,da);
		return this;
	}
	,clone: function() {
		return new nanofl_engine_geom_BezierCurve(this.p1.x,this.p1.y,this.p2.x,this.p2.y,this.p3.x,this.p3.y);
	}
	,isTiny: function() {
		return Math.abs(this.p1.x - this.p2.x) < 0.01 && Math.abs(this.p1.y - this.p2.y) < 0.01 && Math.abs(this.p3.x - this.p2.x) < 0.01 && Math.abs(this.p3.y - this.p2.y) < 0.01;
	}
	,equ: function(curve) {
		return nanofl_engine_geom_PointTools.equ(this.p2,curve.p2) && (nanofl_engine_geom_PointTools.equ(this.p1,curve.p1) && nanofl_engine_geom_PointTools.equ(this.p3,curve.p3) || nanofl_engine_geom_PointTools.equ(this.p1,curve.p3) && nanofl_engine_geom_PointTools.equ(this.p3,curve.p1));
	}
	,getReversed: function() {
		return new nanofl_engine_geom_BezierCurve(this.p3.x,this.p3.y,this.p2.x,this.p2.y,this.p1.x,this.p1.y);
	}
	,reverse: function() {
		var z = this.p1;
		this.p1 = this.p3;
		this.p3 = this.p1;
	}
	,getLength: function() {
		var Ax = this.p2.x - this.p1.x;
		var Ay = this.p2.y - this.p1.y;
		var Bx = this.p1.x - 2 * this.p2.x + this.p3.x;
		var By = this.p1.y - 2 * this.p2.y + this.p3.y;
		var ax2 = 2 * Ax;
		var ay2 = 2 * Ay;
		var a = 4 * (Bx * Bx + By * By);
		var b = 4 * (Bx * ax2 + By * ay2);
		var c = ax2 * ax2 + ay2 * ay2;
		var z1 = 2 * Math.sqrt(a + b + c);
		var z2 = Math.sqrt(a);
		var z3 = 2 * a * z2;
		var z4 = 2 * Math.sqrt(c);
		var z5 = b / z2;
		return (z3 * z1 + z2 * b * (z1 - z4) + (4 * c * a - b * b) * Math.log((2 * z2 + z5 + z1) / (z5 + z4))) / (4 * z3);
	}
	,getTangent: function(t) {
		var Cx = (this.p2.x - this.p1.x) * t + this.p1.x;
		var Cy = (this.p2.y - this.p1.y) * t + this.p1.y;
		var Dx = (this.p3.x - this.p2.x) * t + this.p2.x;
		var Dy = (this.p3.y - this.p2.y) * t + this.p2.y;
		return Math.atan2(Dy - Cy,Dx - Cx);
	}
	,getTriangle: function() {
		return [new nanofl_engine_geom_Edge(this.p1.x,this.p1.y,this.p2.x,this.p2.y),new nanofl_engine_geom_Edge(this.p2.x,this.p2.y,this.p3.x,this.p3.y),new nanofl_engine_geom_Edge(this.p3.x,this.p3.y,this.p1.x,this.p1.y)];
	}
	,toString: function() {
		return "curve(" + this.p1.x + ", " + this.p1.y + ", " + this.p2.x + ", " + this.p2.y + ", " + this.p3.x + ", " + this.p3.y + ")";
	}
	,getMonotoneT: function(k) {
		if(k == 0) return 0;
		if(k == 1) return 1;
		var eps = 0.005;
		var need = this.getLength() * k;
		var t = 0.5;
		var d = 0.5;
		while(true) {
			var part = this.getFirstPart(t);
			var len = part.getLength();
			if(Math.abs(need - len) < eps) return t;
			d /= 2;
			if(need < len) t -= d; else t += d;
		}
	}
	,__class__: nanofl_engine_geom_BezierCurve
};
var nanofl_engine_geom_BoundsTools = function() { };
$hxClasses["nanofl.engine.geom.BoundsTools"] = nanofl_engine_geom_BoundsTools;
nanofl_engine_geom_BoundsTools.__name__ = ["nanofl","engine","geom","BoundsTools"];
nanofl_engine_geom_BoundsTools.extendR = function(bounds,rect) {
	bounds.minX = Math.min(bounds.minX,rect.x);
	bounds.minY = Math.min(bounds.minY,rect.y);
	bounds.maxX = Math.max(bounds.maxX,rect.x + rect.width);
	bounds.maxY = Math.max(bounds.maxY,rect.y + rect.height);
	return bounds;
};
nanofl_engine_geom_BoundsTools.extend = function(bounds,b) {
	bounds.minX = Math.min(bounds.minX,b.minX);
	bounds.minY = Math.min(bounds.minY,b.minY);
	bounds.maxX = Math.max(bounds.maxX,b.maxX);
	bounds.maxY = Math.max(bounds.maxY,b.maxY);
	return bounds;
};
nanofl_engine_geom_BoundsTools.isIntersect = function(a,b,gap) {
	if(gap == null) gap = 0.0;
	return a != null && b != null && a.maxX > b.minX - gap && a.maxY > b.minY - gap && b.maxX > a.minX - gap && b.maxY > a.minY - gap;
};
nanofl_engine_geom_BoundsTools.isPointInside = function(bounds,x,y,gap) {
	if(gap == null) gap = 0.0;
	return x > bounds.minX - gap && y > bounds.minY - gap && x < bounds.maxX + gap && y < bounds.maxY + gap;
};
nanofl_engine_geom_BoundsTools.isPointInsideP = function(bounds,pt,gap) {
	if(gap == null) gap = 0.0;
	return nanofl_engine_geom_BoundsTools.isPointInside(bounds,pt.x,pt.y,gap);
};
nanofl_engine_geom_BoundsTools.getNearestPoint = function(bounds,pos) {
	if(nanofl_engine_geom_BoundsTools.isPointInsideP(bounds,pos)) return nanofl_engine_geom_PointTools.clone(pos);
	var points = [new nanofl_engine_geom_StraightLine(bounds.minX,bounds.minY,bounds.maxX,bounds.minY).getNearestPoint(pos.x,pos.y).point,new nanofl_engine_geom_StraightLine(bounds.maxX,bounds.minY,bounds.maxX,bounds.maxY).getNearestPoint(pos.x,pos.y).point,new nanofl_engine_geom_StraightLine(bounds.maxX,bounds.maxY,bounds.minX,bounds.maxY).getNearestPoint(pos.x,pos.y).point,new nanofl_engine_geom_StraightLine(bounds.minX,bounds.maxY,bounds.minX,bounds.minY).getNearestPoint(pos.x,pos.y).point];
	points.sort(function(a,b) {
		return Reflect.compare(nanofl_engine_geom_PointTools.getDist(pos.x,pos.y,a.x,a.y),nanofl_engine_geom_PointTools.getDist(pos.x,pos.y,b.x,b.y));
	});
	return points[0];
};
nanofl_engine_geom_BoundsTools.clone = function(bounds) {
	if(bounds == null) return null;
	return { minX : bounds.minX, minY : bounds.minY, maxX : bounds.maxX, maxY : bounds.maxY};
};
nanofl_engine_geom_BoundsTools.toBounds = function(rect) {
	return { minX : rect.x, minY : rect.y, maxX : rect.x + rect.width, maxY : rect.y + rect.height};
};
nanofl_engine_geom_BoundsTools.toString = function(bounds) {
	if(bounds == null) return "null";
	return bounds.minX + "," + bounds.minY + ", " + bounds.maxX + ", " + bounds.maxY;
};
nanofl_engine_geom_BoundsTools.toRectangle = function(bounds) {
	if(bounds == null) return null;
	return new createjs.Rectangle(bounds.minX,bounds.minY,bounds.maxX - bounds.minX,bounds.maxY - bounds.minY);
};
nanofl_engine_geom_BoundsTools.transform = function(bounds,matrix) {
	if(bounds == null) return null;
	var x_a = bounds.width * matrix.a;
	var x_b = bounds.width * matrix.b;
	var y_c = bounds.height * matrix.c;
	var y_d = bounds.height * matrix.d;
	var tx = matrix.tx + (bounds.x * matrix.a + bounds.y * matrix.c);
	var ty = matrix.ty + (bounds.x * matrix.b + bounds.y * matrix.d);
	var minX = tx;
	var minY = ty;
	var maxX = tx;
	var maxY = ty;
	var x;
	var y;
	x = x_a + tx;
	if(x < minX) minX = x; else if(x > maxX) maxX = x;
	x = x_a + y_c + tx;
	if(x < minX) minX = x; else if(x > maxX) maxX = x;
	x = y_c + tx;
	if(x < minX) minX = x; else if(x > maxX) maxX = x;
	y = x_b + ty;
	if(y < minY) minY = y; else if(y > maxY) maxY = y;
	y = x_b + y_d + ty;
	if(y < minY) minY = y; else if(y > maxY) maxY = y;
	y = y_d + ty;
	if(y < minY) minY = y; else if(y > maxY) maxY = y;
	bounds.x = minX;
	bounds.y = minY;
	bounds.width = maxX - minX;
	bounds.height = maxY - minY;
	return bounds;
};
var nanofl_engine_geom_Contour = function(edges) {
	this.edges = edges;
};
$hxClasses["nanofl.engine.geom.Contour"] = nanofl_engine_geom_Contour;
nanofl_engine_geom_Contour.__name__ = ["nanofl","engine","geom","Contour"];
nanofl_engine_geom_Contour.fromRectangle = function(rect) {
	return new nanofl_engine_geom_Contour([new nanofl_engine_geom_Edge(rect.x,rect.y,rect.x + rect.width,rect.y),new nanofl_engine_geom_Edge(rect.x + rect.width,rect.y,rect.x + rect.width,rect.y + rect.height),new nanofl_engine_geom_Edge(rect.x + rect.width,rect.y + rect.height,rect.x,rect.y + rect.height),new nanofl_engine_geom_Edge(rect.x,rect.y + rect.height,rect.x,rect.y)]);
};
nanofl_engine_geom_Contour.prototype = {
	edges: null
	,save: function(out) {
		out.begin("contour");
		out.attr("edges",nanofl_engine_geom_Edges.save(this.edges));
		out.end();
	}
	,draw: function(g) {
		nanofl_engine_geom_Edges.draw(this.edges,g,false);
	}
	,translate: function(dx,dy) {
		var _g = 0;
		var _g1 = this.edges;
		while(_g < _g1.length) {
			var e = _g1[_g];
			++_g;
			e.translate(dx,dy);
		}
	}
	,transform: function(m) {
		var _g = 0;
		var _g1 = this.edges;
		while(_g < _g1.length) {
			var e = _g1[_g];
			++_g;
			e.transform(m);
		}
	}
	,isPointInside: function(px,py) {
		var _g = 0;
		var _g1 = this.edges;
		while(_g < _g1.length) {
			var e = _g1[_g];
			++_g;
			if(Math.abs(e.y3 - py) < nanofl_engine_geom_Contour.EPS) return this.isPointInside(px,py + nanofl_engine_geom_Contour.EPS * 2);
		}
		var counter = 0;
		var _g2 = 0;
		var _g11 = this.edges;
		while(_g2 < _g11.length) {
			var edge = _g11[_g2];
			++_g2;
			var c = edge.getIntersectionCount_rightRay(px,py);
			counter += c;
		}
		return counter % 2 != 0;
	}
	,isPointInsideP: function(p) {
		return this.isPointInside(p.x,p.y);
	}
	,hasPoint: function(px,py) {
		var _g = 0;
		var _g1 = this.edges;
		while(_g < _g1.length) {
			var edge = _g1[_g];
			++_g;
			if(edge.x1 == px && edge.y1 == py || edge.x3 == px && edge.y3 == py) return true;
		}
		return false;
	}
	,hasEdge: function(edge) {
		return edge.indexIn(this.edges) >= 0;
	}
	,isEdgeInside: function(edge) {
		if(!this.hasPoint(edge.x1,edge.y1) && !this.isPointInside(edge.x1,edge.y1)) return false;
		if(!this.hasPoint(edge.x3,edge.y3) && !this.isPointInside(edge.x3,edge.y3)) return false;
		return this.isPointInsideP(edge.getMiddlePoint());
	}
	,isNestedTo: function(outer) {
		stdlib_Debug.assert(outer != this,null,{ fileName : "Contour.hx", lineNumber : 94, className : "nanofl.engine.geom.Contour", methodName : "isNestedTo"});
		stdlib_Debug.assert(this.edges[0].x1 == this.edges[this.edges.length - 1].x3,null,{ fileName : "Contour.hx", lineNumber : 95, className : "nanofl.engine.geom.Contour", methodName : "isNestedTo"});
		stdlib_Debug.assert(this.edges[0].y1 == this.edges[this.edges.length - 1].y3,null,{ fileName : "Contour.hx", lineNumber : 96, className : "nanofl.engine.geom.Contour", methodName : "isNestedTo"});
		var _g = 0;
		var _g1 = this.edges;
		while(_g < _g1.length) {
			var edge = _g1[_g];
			++_g;
			if(!outer.hasPoint(edge.x3,edge.y3) && !outer.isPointInside(edge.x3,edge.y3)) return false;
		}
		var _g2 = 0;
		var _g11 = this.edges;
		while(_g2 < _g11.length) {
			var edge1 = _g11[_g2];
			++_g2;
			if(edge1.indexIn(outer.edges) >= 0) return false;
			var pt = edge1.getMiddlePoint();
			if(!outer.isPointInside(pt.x,pt.y)) return false;
		}
		return true;
	}
	,clone: function() {
		return new nanofl_engine_geom_Contour(nanofl_engine_ArrayTools.clone(this.edges));
	}
	,isClockwise: function() {
		return this.getClockwiseProduct() >= -nanofl_engine_geom_Contour.EPS;
	}
	,isCounterClockwise: function() {
		return this.getClockwiseProduct() <= nanofl_engine_geom_Contour.EPS;
	}
	,getClockwiseProduct: function() {
		var sum = 0.0;
		var _g = 0;
		var _g1 = this.edges;
		while(_g < _g1.length) {
			var edge = _g1[_g];
			++_g;
			sum += (edge.x2 - edge.x1) * (edge.y2 + edge.y1);
			sum += (edge.x3 - edge.x2) * (edge.y3 + edge.y2);
		}
		return sum;
	}
	,normalize: function() {
		nanofl_engine_geom_Edges.roundPoints(this.edges);
		nanofl_engine_geom_Edges.removeDegenerated(this.edges,true);
		var i = 0;
		while(i < this.edges.length) {
			var a = this.edges[i];
			var b = this.edges[(i + 1) % this.edges.length];
			if(a.x1 == b.x3 && a.y1 == b.y3 && (a.isStraight() && b.isStraight() || a.x2 == b.x2 && a.y2 == b.y2)) {
				if(i + 1 < this.edges.length) this.edges.splice(i,2); else {
					this.edges.splice(i,1);
					this.edges.splice(0,1);
					i--;
				}
			} else i++;
		}
	}
	,reverse: function() {
		this.edges.reverse();
		var _g1 = 0;
		var _g = this.edges.length;
		while(_g1 < _g) {
			var i = _g1++;
			this.edges[i] = this.edges[i].clone().reverse();
		}
		return this;
	}
	,indexIn: function(contours) {
		var _g2 = this;
		var _g1 = 0;
		var _g = contours.length;
		while(_g1 < _g) {
			var i = _g1++;
			if(contours[i].edges.length == this.edges.length) {
				if(Lambda.foreach(contours[i].edges,function(e) {
					return e.indexIn(_g2.edges) >= 0;
				})) return i;
			}
		}
		return -1;
	}
	,equ: function(c) {
		return nanofl_engine_geom_Edges.equIgnoreOrder(this.edges,c.edges);
	}
	,toString: function() {
		return "new Contour(" + Std.string(this.edges) + ")";
	}
	,assertCorrect: function() {
	}
	,__class__: nanofl_engine_geom_Contour
};
var nanofl_engine_geom_Contours = function() { };
$hxClasses["nanofl.engine.geom.Contours"] = nanofl_engine_geom_Contours;
nanofl_engine_geom_Contours.__name__ = ["nanofl","engine","geom","Contours"];
nanofl_engine_geom_Contours.fromEdges = function(edges) {
	nanofl_engine_geom_Contours.log(function() {
		return "Contours.find(1): edges = " + edges.length;
	},{ fileName : "Contours.hx", lineNumber : 14, className : "nanofl.engine.geom.Contours", methodName : "fromEdges"});
	stdlib_Debug.assert(!nanofl_engine_geom_Edges.hasDegenerated(edges),"Degenerated edges detected.",{ fileName : "Contours.hx", lineNumber : 16, className : "nanofl.engine.geom.Contours", methodName : "fromEdges"});
	stdlib_Debug.assert(!nanofl_engine_geom_Edges.hasDuplicates(edges),"Duplicated edges detected.",{ fileName : "Contours.hx", lineNumber : 17, className : "nanofl.engine.geom.Contours", methodName : "fromEdges"});
	edges = edges.slice();
	nanofl_engine_geom_Contours.removeTailEdges(edges);
	nanofl_engine_geom_Contours.log(function() {
		return "Contours.find(2): edges = " + edges.length + "; " + Std.string(edges);
	},{ fileName : "Contours.hx", lineNumber : 23, className : "nanofl.engine.geom.Contours", methodName : "fromEdges"});
	var sequences = nanofl_engine_geom_Contours.getSequencesFromEdges(edges);
	var vectors = edges.slice();
	var _g = 0;
	while(_g < edges.length) {
		var e = edges[_g];
		++_g;
		vectors.push(e.clone().reverse());
	}
	var connections = nanofl_engine_geom_Contours.getConnections(vectors);
	var excludes;
	var this1;
	this1 = new Array(vectors.length);
	excludes = this1;
	var r = [];
	var _g1 = 0;
	while(_g1 < sequences.length) {
		var sequence = sequences[_g1];
		++_g1;
		nanofl_engine_geom_Contours.find(sequence[0],vectors,connections,excludes,r);
		nanofl_engine_geom_Contours.find(sequence[0].clone().reverse(),vectors,connections,excludes,r);
		if(sequence.length > 1) {
			nanofl_engine_geom_Contours.find(sequence[sequence.length - 1],vectors,connections,excludes,r);
			nanofl_engine_geom_Contours.find(sequence[sequence.length - 1].clone().reverse(),vectors,connections,excludes,r);
		}
	}
	nanofl_engine_geom_Contours.log(function() {
		return "Contours.find(3): r =\n" + r.join("\n");
	},{ fileName : "Contours.hx", lineNumber : 48, className : "nanofl.engine.geom.Contours", methodName : "fromEdges"});
	var _g2 = 0;
	while(_g2 < r.length) {
		var contour = r[_g2];
		++_g2;
		stdlib_Debug.assert(contour.isClockwise(),null,{ fileName : "Contours.hx", lineNumber : 50, className : "nanofl.engine.geom.Contours", methodName : "fromEdges"});
	}
	return r;
};
nanofl_engine_geom_Contours.fromVectors = function(vectors) {
	vectors = vectors.slice();
	nanofl_engine_geom_Contours.removeTailEdges(vectors);
	var sequences = nanofl_engine_geom_Contours.getSequencesFromVectors(vectors);
	var connections = nanofl_engine_geom_Contours.getConnections(vectors);
	var excludes;
	var this1;
	this1 = new Array(vectors.length);
	excludes = this1;
	var r = [];
	var _g = 0;
	while(_g < sequences.length) {
		var sequence = sequences[_g];
		++_g;
		nanofl_engine_geom_Contours.find(sequence[0],vectors,connections,excludes,r);
		if(sequence.length > 1) nanofl_engine_geom_Contours.find(sequence[sequence.length - 1],vectors,connections,excludes,r);
	}
	return r;
};
nanofl_engine_geom_Contours.find = function(start,vectors,connections,excludes,r) {
	var startIndex = ((function(_e) {
		return function(f) {
			return stdlib_LambdaIterable.findIndex(_e,f);
		};
	})(vectors))(function(_) {
		return _.equDirected(start);
	});
	if(excludes[startIndex]) {
		nanofl_engine_geom_Contours.log("exclude(1) " + startIndex,{ fileName : "Contours.hx", lineNumber : 87, className : "nanofl.engine.geom.Contours", methodName : "find"});
		return;
	}
	var indexes = [startIndex];
	nanofl_engine_geom_Contours.log(function() {
		return "!!!!!!!!!!! startIndex = " + startIndex + "; start = " + Std.string(start) + "; contours = " + r.length;
	},{ fileName : "Contours.hx", lineNumber : 93, className : "nanofl.engine.geom.Contours", methodName : "find"});
	var lastBestVectorIndex = null;
	while(true) {
		var nextIndex = [nanofl_engine_geom_Contours.findNext(indexes[indexes.length - 1],vectors,connections,excludes,lastBestVectorIndex)];
		if(nextIndex[0] == null) break;
		lastBestVectorIndex = null;
		nanofl_engine_geom_Contours.log((function(nextIndex) {
			return function() {
				return "\tnextIndex = " + nextIndex[0] + "; next = " + Std.string(vectors[nextIndex[0]]);
			};
		})(nextIndex),{ fileName : "Contours.hx", lineNumber : 101, className : "nanofl.engine.geom.Contours", methodName : "find"});
		stdlib_Debug.assert(HxOverrides.indexOf(indexes,nextIndex[0],0) < 0,null,{ fileName : "Contours.hx", lineNumber : 103, className : "nanofl.engine.geom.Contours", methodName : "find"});
		var next = [vectors[nextIndex[0]]];
		if(next[0].x3 == start.x1 && next[0].y3 == start.y1) {
			indexes.push(nextIndex[0]);
			nanofl_engine_geom_Contours.contourFound(indexes,vectors,excludes,r);
			break;
		} else {
			var n = [(((function() {
				return function(_e1) {
					return (function() {
						return function(f1) {
							return stdlib_LambdaIterable.findIndex(_e1,f1);
						};
					})();
				};
			})())(indexes))((function(next) {
				return function(_1) {
					return vectors[_1].x1 == next[0].x3 && vectors[_1].y1 == next[0].y3;
				};
			})(next))];
			if(n[0] >= 0) {
				stdlib_Debug.assert(n[0] >= 1,null,{ fileName : "Contours.hx", lineNumber : 118, className : "nanofl.engine.geom.Contours", methodName : "find"});
				indexes.push(nextIndex[0]);
				lastBestVectorIndex = indexes[n[0]];
				nanofl_engine_geom_Contours.contourFound(indexes.slice(n[0]),vectors,excludes,r);
				indexes = indexes.slice(0,n[0]);
				nanofl_engine_geom_Contours.log((function(n) {
					return function() {
						return "Found inner loop n = " + n[0] + "; lastBestVectorIndex = " + lastBestVectorIndex;
					};
				})(n),{ fileName : "Contours.hx", lineNumber : 123, className : "nanofl.engine.geom.Contours", methodName : "find"});
			} else indexes.push(nextIndex[0]);
		}
	}
};
nanofl_engine_geom_Contours.contourFound = function(indexes,vectors,excludes,r) {
	var contour = new nanofl_engine_geom_Contour(indexes.map(function(_) {
		return vectors[_].clone();
	}));
	if(contour.isClockwise() && !((function(_e) {
		return function(f) {
			return Lambda.exists(_e,f);
		};
	})(r))(function(_1) {
		return _1.equ(contour);
	})) {
		r.push(contour);
		var _g = 0;
		while(_g < indexes.length) {
			var index = indexes[_g];
			++_g;
			excludes[index] = true;
		}
	}
};
nanofl_engine_geom_Contours.findNext = function(lastIndex,vectors,connections,excludes,lastBestVectorIndex) {
	var nexts = connections[lastIndex];
	stdlib_Debug.assert(nexts.length > 0,function() {
		return "nexts = " + Std.string(nexts) + "; vectors = " + Std.string(vectors);
	},{ fileName : "Contours.hx", lineNumber : 149, className : "nanofl.engine.geom.Contours", methodName : "findNext"});
	var last = vectors[lastIndex];
	var lastTangent = last.getTangent(1) + Math.PI;
	var _g = 0;
	while(_g < nexts.length) {
		var next = nexts[_g];
		++_g;
		var z = vectors[next].getTangent(0);
		while(z <= lastTangent) z += Math.PI * 2;
	}
	nexts.sort(function(a,b) {
		var tanA = vectors[a].getTangent(0);
		while(tanA <= lastTangent) tanA += Math.PI * 2;
		var tanB = vectors[b].getTangent(0);
		while(tanB <= lastTangent) tanB += Math.PI * 2;
		return Reflect.compare(tanA - lastTangent,tanB - lastTangent);
	});
	stdlib_Debug.assert(lastBestVectorIndex == null || HxOverrides.indexOf(nexts,lastBestVectorIndex,0) >= 0,null,{ fileName : "Contours.hx", lineNumber : 170, className : "nanofl.engine.geom.Contours", methodName : "findNext"});
	var n;
	if(lastBestVectorIndex == null) n = 0; else n = HxOverrides.indexOf(nexts,lastBestVectorIndex,0) + 1;
	while(n < nexts.length && excludes[nexts[n]]) {
		nanofl_engine_geom_Contours.log("exclude(2) " + nexts[n],{ fileName : "Contours.hx", lineNumber : 175, className : "nanofl.engine.geom.Contours", methodName : "findNext"});
		n++;
	}
	return nexts[n];
};
nanofl_engine_geom_Contours.mergeByCommonEdges = function(contours,counterClockwise) {
	var i = 0;
	while(i < contours.length) {
		var j = i + 1;
		while(j < contours.length) {
			stdlib_Debug.assert(contours[i].edges.length > 0,null,{ fileName : "Contours.hx", lineNumber : 191, className : "nanofl.engine.geom.Contours", methodName : "mergeByCommonEdges"});
			stdlib_Debug.assert(contours[j].edges.length > 0,null,{ fileName : "Contours.hx", lineNumber : 192, className : "nanofl.engine.geom.Contours", methodName : "mergeByCommonEdges"});
			var commonEdges = nanofl_engine_geom_Edges.getCommon(contours[i].edges,contours[j].edges);
			if(commonEdges.length > 0) {
				var outerEdges = nanofl_engine_geom_Edges.exclude(nanofl_engine_geom_Edges.concatUnique(contours[i].edges,contours[j].edges),commonEdges);
				if(outerEdges.length > 0) {
					var newContours = nanofl_engine_geom_Contours.fromEdges(outerEdges);
					newContours.sort(function(_1,_2) {
						if(_1.isNestedTo(_2)) return 1; else return -1;
					});
					contours[i] = newContours[0];
					if(counterClockwise) contours[i].reverse();
				} else stdlib_Debug.assert(false,"Two contours with same edges = " + Std.string(contours[i]),{ fileName : "Contours.hx", lineNumber : 208, className : "nanofl.engine.geom.Contours", methodName : "mergeByCommonEdges"});
				contours.splice(j,1);
				i--;
				break;
			}
			j++;
		}
		i++;
	}
};
nanofl_engine_geom_Contours.removeNested = function(contours) {
	var i = 0;
	while(i < contours.length) {
		var j = 0;
		while(j < contours.length) if(i != j && contours[j].isNestedTo(contours[i])) {
			contours.splice(j,1);
			if(i > j) i--;
		} else j++;
		i++;
	}
};
nanofl_engine_geom_Contours.removeTailEdges = function(edges) {
	nanofl_engine_geom_Edges.removeDublicates(edges);
	nanofl_engine_geom_Edges.removeDegenerated(edges,true);
	while(true) {
		var count = edges.length;
		var i = 0;
		while(i < edges.length) {
			var edge = edges[i];
			if(nanofl_engine_geom_Edges.getPointUseCount(edges,edge.x1,edge.y1) == 1 || nanofl_engine_geom_Edges.getPointUseCount(edges,edge.x3,edge.y3) == 1) edges.splice(i,1); else i++;
		}
		if(edges.length == count) break;
	}
};
nanofl_engine_geom_Contours.getEdges = function(contours) {
	var r = [];
	var _g = 0;
	while(_g < contours.length) {
		var c = contours[_g];
		++_g;
		r = r.concat(c.edges);
	}
	return r;
};
nanofl_engine_geom_Contours.getTree = function(contours) {
	var parents = contours.filter(function(a) {
		return !Lambda.exists(contours,function(b) {
			return a != b && a.isNestedTo(b);
		});
	});
	var allChildren = contours.filter(function(_) {
		return HxOverrides.indexOf(parents,_,0) < 0;
	});
	return parents.map(function(p) {
		return { parent : p, children : nanofl_engine_geom_Contours.getTree(allChildren.filter(function(_1) {
			return _1.isNestedTo(p);
		}))};
	});
};
nanofl_engine_geom_Contours.getConnections = function(vectors) {
	var r = [];
	var _g1 = 0;
	var _g = vectors.length;
	while(_g1 < _g) {
		var i = _g1++;
		var base = vectors[i];
		var dirs = [];
		var _g3 = 0;
		var _g2 = vectors.length;
		while(_g3 < _g2) {
			var j = _g3++;
			if(base.x3 == vectors[j].x1 && base.y3 == vectors[j].y1 && !base.equ(vectors[j])) dirs.push(j);
		}
		stdlib_Debug.assert(dirs.length > 0,function() {
			return "edges = " + Std.string(vectors.slice(0,vectors.length >> 1));
		},{ fileName : "Contours.hx", lineNumber : 312, className : "nanofl.engine.geom.Contours", methodName : "getConnections"});
		r.push(dirs);
	}
	return r;
};
nanofl_engine_geom_Contours.isPointUsed = function(vectors,indexes,x,y) {
	if(vectors[indexes[0]].x1 == x && vectors[indexes[0]].y1 == y) return true;
	var _g = 0;
	while(_g < indexes.length) {
		var n = indexes[_g];
		++_g;
		if(vectors[n].x3 == x && vectors[n].y3 == y) return true;
	}
	return false;
};
nanofl_engine_geom_Contours.getSequencesFromEdges = function(edges) {
	var r = [];
	edges = edges.filter(function(e) {
		return !e.isDegenerated();
	});
	var ee = edges.slice();
	while(ee.length > 0) {
		var baseEdge = ee.pop();
		var equEdge = baseEdge.clone();
		var seqEdges = [baseEdge];
		var i = 0;
		while(i < ee.length) {
			var edge = ee[i];
			if(equEdge.x3 == edge.x1 && equEdge.y3 == edge.y1 && nanofl_engine_geom_Contours.isSimplePoint(edges,edge.x1,edge.y1)) {
				seqEdges.push(edge);
				equEdge.x3 = edge.x3;
				equEdge.y3 = edge.y3;
				ee.splice(i,1);
				i = 0;
			} else if(equEdge.x3 == edge.x3 && equEdge.y3 == edge.y3 && nanofl_engine_geom_Contours.isSimplePoint(edges,edge.x3,edge.y3)) {
				seqEdges.push(edge.clone().reverse());
				equEdge.x3 = edge.x1;
				equEdge.y3 = edge.y1;
				ee.splice(i,1);
				i = 0;
			} else if(equEdge.x1 == edge.x1 && equEdge.y1 == edge.y1 && nanofl_engine_geom_Contours.isSimplePoint(edges,edge.x1,edge.y1)) {
				seqEdges.unshift(edge.clone().reverse());
				equEdge.x1 = edge.x3;
				equEdge.y1 = edge.y3;
				ee.splice(i,1);
				i = 0;
			} else if(equEdge.x1 == edge.x3 && equEdge.y1 == edge.y3 && nanofl_engine_geom_Contours.isSimplePoint(edges,edge.x3,edge.y3)) {
				seqEdges.unshift(edge);
				equEdge.x1 = edge.x1;
				equEdge.y1 = edge.y1;
				ee.splice(i,1);
				i = 0;
			} else i++;
		}
		r.push(seqEdges);
	}
	return r;
};
nanofl_engine_geom_Contours.getSequencesFromVectors = function(edges) {
	var r = [];
	edges = edges.filter(function(e) {
		return !e.isDegenerated();
	});
	var ee = edges.slice();
	while(ee.length > 0) {
		var baseEdge = ee.pop();
		var equEdge = baseEdge.clone();
		var seqEdges = [baseEdge];
		var i = 0;
		while(i < ee.length) {
			var edge = ee[i];
			if(equEdge.x3 == edge.x1 && equEdge.y3 == edge.y1 && nanofl_engine_geom_Contours.isSimplePoint(edges,edge.x1,edge.y1)) {
				seqEdges.push(edge);
				equEdge.x3 = edge.x3;
				equEdge.y3 = edge.y3;
				ee.splice(i,1);
				i = 0;
			} else if(equEdge.x1 == edge.x3 && equEdge.y1 == edge.y3 && nanofl_engine_geom_Contours.isSimplePoint(edges,edge.x3,edge.y3)) {
				seqEdges.unshift(edge);
				equEdge.x1 = edge.x1;
				equEdge.y1 = edge.y1;
				ee.splice(i,1);
				i = 0;
			} else i++;
		}
		r.push(seqEdges);
	}
	return r;
};
nanofl_engine_geom_Contours.isSimplePoint = function(edges,x,y) {
	var c = 0;
	var _g = 0;
	while(_g < edges.length) {
		var e = edges[_g];
		++_g;
		if(e.x1 == x && e.y1 == y) {
			c++;
			if(c > 2) return false;
		}
		if(e.x3 == x && e.y3 == y) {
			c++;
			if(c > 2) return false;
		}
	}
	return true;
};
nanofl_engine_geom_Contours.log = function(v,infos) {
};
var nanofl_engine_geom_Edge = function(x1,y1,x2,y2,x3,y3) {
	stdlib_Debug.assert(!isNaN(x1),null,{ fileName : "Edge.hx", lineNumber : 30, className : "nanofl.engine.geom.Edge", methodName : "new"});
	stdlib_Debug.assert(!isNaN(y1),null,{ fileName : "Edge.hx", lineNumber : 31, className : "nanofl.engine.geom.Edge", methodName : "new"});
	stdlib_Debug.assert(!isNaN(x2),null,{ fileName : "Edge.hx", lineNumber : 32, className : "nanofl.engine.geom.Edge", methodName : "new"});
	stdlib_Debug.assert(!isNaN(y2),null,{ fileName : "Edge.hx", lineNumber : 33, className : "nanofl.engine.geom.Edge", methodName : "new"});
	this.x1 = x1;
	this.y1 = y1;
	if(x3 == null) {
		this.x2 = (x1 + x2) / 2;
		this.y2 = (y1 + y2) / 2;
		this.x3 = x2;
		this.y3 = y2;
	} else {
		this.x2 = x2;
		this.y2 = y2;
		this.x3 = x3;
		this.y3 = y3;
	}
};
$hxClasses["nanofl.engine.geom.Edge"] = nanofl_engine_geom_Edge;
nanofl_engine_geom_Edge.__name__ = ["nanofl","engine","geom","Edge"];
nanofl_engine_geom_Edge.fromStraightLine = function(line) {
	return new nanofl_engine_geom_Edge(line.x1,line.y1,line.x2,line.y2);
};
nanofl_engine_geom_Edge.fromBezierCurve = function(curve) {
	return new nanofl_engine_geom_Edge(curve.p1.x,curve.p1.y,curve.p2.x,curve.p2.y,curve.p3.x,curve.p3.y);
};
nanofl_engine_geom_Edge.getIntersection = function(edgeA,edgeB) {
	if(!nanofl_engine_geom_BoundsTools.isIntersect(edgeA.getBoundsRO(),edgeB.getBoundsRO(),nanofl_engine_geom_Edge.GAP)) return null;
	if(edgeA.equ(edgeB)) return null;
	var I = nanofl_engine_geom_Edge.getIntersectionInner(edgeA,edgeB);
	if(I != null) {
		nanofl_engine_geom_Edges.normalize(I.a);
		nanofl_engine_geom_Edges.normalize(I.b);
		if(I.a.length == 1 && I.b.length == 1 && I.a[0].equ(edgeA) && I.b[0].equ(edgeB)) I = null;
	}
	return I;
};
nanofl_engine_geom_Edge.getIntersectionInner = function(edgeA,edgeB) {
	nanofl_engine_geom_Edge.log("Edge.getIntersection " + Std.string(edgeA) + " AND " + Std.string(edgeB),{ fileName : "Edge.hx", lineNumber : 305, className : "nanofl.engine.geom.Edge", methodName : "getIntersectionInner"});
	var straightA = edgeA.isStraight();
	var straightB = edgeB.isStraight();
	if(straightA && straightB) {
		nanofl_engine_geom_Edge.log("straightA && straightB",{ fileName : "Edge.hx", lineNumber : 312, className : "nanofl.engine.geom.Edge", methodName : "getIntersectionInner"});
		var p = edgeA.asStraightLine().getIntersection_straightSection(edgeB.asStraightLine());
		if(p == null) return null;
		return { a : [new nanofl_engine_geom_Edge(edgeA.x1,edgeA.y1,p.x,p.y),new nanofl_engine_geom_Edge(p.x,p.y,edgeA.x3,edgeA.y3)], b : [new nanofl_engine_geom_Edge(edgeB.x1,edgeB.y1,p.x,p.y),new nanofl_engine_geom_Edge(p.x,p.y,edgeB.x3,edgeB.y3)]};
	} else if(straightA && !straightB) {
		nanofl_engine_geom_Edge.log("straightA && !straightB",{ fileName : "Edge.hx", lineNumber : 324, className : "nanofl.engine.geom.Edge", methodName : "getIntersectionInner"});
		var p1 = edgeB.asBezierCurve().getIntersection_straightSection(edgeA.asStraightLine());
		nanofl_engine_geom_Edge.log("p = " + Std.string(p1 != null),{ fileName : "Edge.hx", lineNumber : 326, className : "nanofl.engine.geom.Edge", methodName : "getIntersectionInner"});
		if(p1 == null) return null;
		return { a : p1.lines.map(nanofl_engine_geom_Edge.fromStraightLine), b : p1.curves.map(nanofl_engine_geom_Edge.fromBezierCurve)};
	} else if(!straightA && straightB) {
		nanofl_engine_geom_Edge.log("!straightA && straightB",{ fileName : "Edge.hx", lineNumber : 337, className : "nanofl.engine.geom.Edge", methodName : "getIntersectionInner"});
		var p2 = edgeA.asBezierCurve().getIntersection_straightSection(edgeB.asStraightLine());
		nanofl_engine_geom_Edge.log("p = " + Std.string(p2 != null),{ fileName : "Edge.hx", lineNumber : 339, className : "nanofl.engine.geom.Edge", methodName : "getIntersectionInner"});
		if(p2 == null) return null;
		return { a : p2.curves.map(nanofl_engine_geom_Edge.fromBezierCurve), b : p2.lines.map(nanofl_engine_geom_Edge.fromStraightLine)};
	} else {
		nanofl_engine_geom_Edge.log("!straightA && !straightB",{ fileName : "Edge.hx", lineNumber : 349, className : "nanofl.engine.geom.Edge", methodName : "getIntersectionInner"});
		var p3 = edgeA.asBezierCurve().getIntersection_bezierCurve(edgeB.asBezierCurve());
		if(p3 == null) return null;
		return { a : p3.a.map(nanofl_engine_geom_Edge.fromBezierCurve), b : p3.b.map(nanofl_engine_geom_Edge.fromBezierCurve)};
	}
	return null;
};
nanofl_engine_geom_Edge.log = function(v,infos) {
};
nanofl_engine_geom_Edge.prototype = {
	x1: null
	,y1: null
	,x2: null
	,y2: null
	,x3: null
	,y3: null
	,cachedBounds: null
	,cachedBoundsEdge: null
	,isStraight: function() {
		var pt = this.asStraightLine().getOrthogonalRayIntersection(this.x2,this.y2).point;
		return nanofl_engine_geom_PointTools.getSqrDist(pt.x,pt.y,this.x2,this.y2) < nanofl_engine_geom_Edge.GAP * nanofl_engine_geom_Edge.GAP;
	}
	,getIntersectionCount_rightRay: function(x,y) {
		if(this.isStraight()) {
			if(this.asStraightLine().isIntersect_rightRay(x,y)) return 1; else return 0;
		} else return this.asBezierCurve().getIntersectionCount_rightRay(x,y);
	}
	,getIntersectionDirectedCount_rightRay: function(x,y) {
		if(this.isStraight()) {
			if(this.y1 == this.y3 || this.asStraightLine().getIntersectionPointX_rightRay(x,y) == null) return 0;
			if(this.y1 < this.y3) return 1; else return -1;
		} else {
			var count = this.asBezierCurve().getIntersectionCount_rightRay(x,y);
			if(count == 0 || count == 2) return 0;
			if(this.y1 < y && this.y3 > y) return 1;
			if(this.y1 > y && this.y3 < y) return -1;
			if(this.y1 < y && this.y3 < y) return -1; else return 1;
		}
	}
	,getIntersectionPointsX_rightRay: function(x,y) {
		if(this.isStraight()) {
			var rX = this.asStraightLine().getIntersectionPointX_rightRay(x,y);
			if(rX != null) return [rX]; else return [];
		} else return this.asBezierCurve().getIntersectionPointsX_rightRay(x,y);
	}
	,drawTo: function(g) {
		if(this.isStraight()) g.lineTo(this.x3,this.y3); else g.curveTo(this.x2,this.y2,this.x3,this.y3);
	}
	,equ: function(e) {
		return e.x2 == this.x2 && e.y2 == this.y2 && (e.x1 == this.x1 && e.y1 == this.y1 && e.x3 == this.x3 && e.y3 == this.y3 || e.x1 == this.x3 && e.y1 == this.y3 && e.x3 == this.x1 && e.y3 == this.y1);
	}
	,equDirected: function(e) {
		return e.x2 == this.x2 && e.y2 == this.y2 && e.x1 == this.x1 && e.y1 == this.y1 && e.x3 == this.x3 && e.y3 == this.y3;
	}
	,getNearestPoint: function(x,y) {
		var r;
		if(this.isStraight()) r = this.asStraightLine().getNearestPoint(x,y); else r = this.asBezierCurve().getNearestPoint(x,y);
		stdlib_Debug.assert(r.point != null,this.toString() + "; x = " + x + ", y = " + y,{ fileName : "Edge.hx", lineNumber : 134, className : "nanofl.engine.geom.Edge", methodName : "getNearestPoint"});
		stdlib_Debug.assert(!isNaN(r.point.x),this.toString() + "; x = " + x + ", y = " + y,{ fileName : "Edge.hx", lineNumber : 135, className : "nanofl.engine.geom.Edge", methodName : "getNearestPoint"});
		stdlib_Debug.assert(!isNaN(r.point.y),this.toString() + "; x = " + x + ", y = " + y,{ fileName : "Edge.hx", lineNumber : 136, className : "nanofl.engine.geom.Edge", methodName : "getNearestPoint"});
		stdlib_Debug.assert(!isNaN(r.t),this.toString() + "; x = " + x + ", y = " + y,{ fileName : "Edge.hx", lineNumber : 137, className : "nanofl.engine.geom.Edge", methodName : "getNearestPoint"});
		return r;
	}
	,translate: function(dx,dy) {
		this.x1 += dx;
		this.y1 += dy;
		this.x2 += dx;
		this.y2 += dy;
		this.x3 += dx;
		this.y3 += dy;
	}
	,translateVertex: function(point,dx,dy) {
		if(this.x1 == point.x && this.y1 == point.y) this.translateStart(dx,dy); else if(this.x3 == point.x && this.y3 == point.y) this.translateEnd(dx,dy);
	}
	,translateStart: function(dx,dy) {
		if(this.isStraight()) {
			this.x1 += dx;
			this.y1 += dy;
			this.x2 = (this.x1 + this.x3) / 2;
			this.y2 = (this.y1 + this.y3) / 2;
		} else {
			var a1 = Math.atan2(this.y1 - this.y3,this.x1 - this.x3);
			var l1 = this.asStraightLine().getLength();
			this.x1 += dx;
			this.y1 += dy;
			var a2 = Math.atan2(this.y1 - this.y3,this.x1 - this.x3);
			var l2 = this.asStraightLine().getLength();
			var p2 = nanofl_engine_geom_PointTools.rotate(this.x2 - this.x3,this.y2 - this.y3,a2 - a1);
			this.x2 = p2.x + this.x3;
			this.y2 = p2.y + this.y3;
		}
	}
	,translateEnd: function(dx,dy) {
		if(this.isStraight()) {
			this.x3 += dx;
			this.y3 += dy;
			this.x2 = (this.x1 + this.x3) / 2;
			this.y2 = (this.y1 + this.y3) / 2;
		} else {
			var a1 = Math.atan2(this.y3 - this.y1,this.x3 - this.x1);
			var l1 = this.asStraightLine().getLength();
			this.x3 += dx;
			this.y3 += dy;
			var a2 = Math.atan2(this.y3 - this.y1,this.x3 - this.x1);
			var l2 = this.asStraightLine().getLength();
			var p2 = nanofl_engine_geom_PointTools.rotate(this.x2 - this.x1,this.y2 - this.y1,a2 - a1);
			this.x2 = p2.x + this.x1;
			this.y2 = p2.y + this.y1;
		}
	}
	,reverse: function() {
		var z = this.x1;
		this.x1 = this.x3;
		this.x3 = z;
		z = this.y1;
		this.y1 = this.y3;
		this.y3 = z;
		return this;
	}
	,getBounds: function(bounds) {
		if(bounds == null) return nanofl_engine_geom_BoundsTools.clone(this.getBoundsRO()); else return nanofl_engine_geom_BoundsTools.extend(bounds,this.getBoundsRO());
	}
	,getBoundsRO: function() {
		if(this.cachedBounds == null || !this.cachedBoundsEdge.equ(this)) {
			if(this.isStraight()) this.cachedBounds = this.asStraightLine().getBounds(); else this.cachedBounds = this.asBezierCurve().getBounds();
			this.cachedBoundsEdge = this.clone();
		}
		return this.cachedBounds;
	}
	,toString: function() {
		if(this.isStraight()) return "new Edge(" + this.x1 + "," + this.y1 + ", " + this.x3 + "," + this.y3 + ")"; else return "new Edge(" + this.x1 + "," + this.y1 + ", " + this.x2 + "," + this.y2 + ", " + this.x3 + "," + this.y3 + ")";
	}
	,getMiddlePoint: function() {
		if(this.isStraight()) return { x : this.x2, y : this.y2}; else return this.asBezierCurve().getPoint(0.5);
	}
	,hasCommonVertices: function(edge) {
		return this.x1 == edge.x1 && this.y1 == edge.y1 || this.x1 == edge.x3 && this.y1 == edge.y3 || this.x3 == edge.x1 && this.y3 == edge.y1 || this.x3 == edge.x3 && this.y3 == edge.y3;
	}
	,transform: function(m,applyToStroke) {
		if(applyToStroke == null) applyToStroke = true;
		var straight = this.isStraight();
		var p1 = m.transformPoint(this.x1,this.y1);
		this.x1 = nanofl_engine_geom_PointTools.roundGap(p1.x);
		this.y1 = nanofl_engine_geom_PointTools.roundGap(p1.y);
		var p3 = m.transformPoint(this.x3,this.y3);
		this.x3 = nanofl_engine_geom_PointTools.roundGap(p3.x);
		this.y3 = nanofl_engine_geom_PointTools.roundGap(p3.y);
		if(straight) {
			this.x2 = (this.x1 + this.x3) / 2;
			this.y2 = (this.y1 + this.y3) / 2;
		} else {
			var p2 = m.transformPoint(this.x2,this.y2);
			this.x2 = nanofl_engine_geom_PointTools.roundGap(p2.x);
			this.y2 = nanofl_engine_geom_PointTools.roundGap(p2.y);
		}
	}
	,splitByClosePoint: function(x,y) {
		var _g = this;
		if(this.x1 == x && this.y1 == y) return null;
		if(this.x3 == x && this.y3 == y) return null;
		if(!nanofl_engine_geom_BoundsTools.isPointInside(this.getBoundsRO(),x,y,nanofl_engine_geom_Edge.GAP)) return null;
		var np = this.getNearestPoint(x,y);
		var pt = nanofl_engine_geom_PointTools.roundGapP(np.point);
		if(pt.x == x && pt.y == y && (pt.x != this.x1 || pt.y != this.y1) && (pt.x != this.x3 || pt.y != this.y3)) {
			stdlib_Debug.assert(np.t > 0 && np.t < 1,function() {
				return "edge = " + _g.toString() + "\n\t(x,y) = (" + x + "," + y + ")" + "\n\tnp = " + nanofl_engine_geom_PointTools.toString(np.point) + "\n\tpt = " + nanofl_engine_geom_PointTools.toString(pt) + "\n\tt = " + np.t;
			},{ fileName : "Edge.hx", lineNumber : 373, className : "nanofl.engine.geom.Edge", methodName : "splitByClosePoint"});
			var r = this.split([np.t]);
			r[0].x3 = r[1].x1 = x;
			r[0].y3 = r[1].y1 = y;
			nanofl_engine_geom_Edges.normalize(r);
			stdlib_Debug.assert(r.length > 1,function() {
				return "edge = " + _g.toString() + "\n\t(x,y) = (" + x + "," + y + ")" + "\n\tnp = " + nanofl_engine_geom_PointTools.toString(np.point) + "\n\tpt = " + nanofl_engine_geom_PointTools.toString(pt) + "\n\tt = " + np.t + "\n\tr = " + Std.string(r);
			},{ fileName : "Edge.hx", lineNumber : 386, className : "nanofl.engine.geom.Edge", methodName : "splitByClosePoint"});
			return r;
		}
		return null;
	}
	,asStraightLine: function() {
		return new nanofl_engine_geom_StraightLine(this.x1,this.y1,this.x3,this.y3);
	}
	,asBezierCurve: function() {
		return new nanofl_engine_geom_BezierCurve(this.x1,this.y1,this.x2,this.y2,this.x3,this.y3);
	}
	,clone: function() {
		return new nanofl_engine_geom_Edge(this.x1,this.y1,this.x2,this.y2,this.x3,this.y3);
	}
	,duplicate: function(e) {
		return new nanofl_engine_geom_Edge(e.x1,e.y1,e.x2,e.y2,e.x3,e.y3);
	}
	,indexIn: function(edges) {
		var _g1 = 0;
		var _g = edges.length;
		while(_g1 < _g) {
			var i = _g1++;
			if(this.equ(edges[i])) return i;
		}
		return -1;
	}
	,isDegenerated: function() {
		return this.x1 == this.x2 && this.x2 == this.x3 && this.y1 == this.y2 && this.y2 == this.y3;
	}
	,roundPoints: function() {
		var straight = this.isStraight();
		this.x1 = nanofl_engine_geom_PointTools.roundGap(this.x1);
		this.y1 = nanofl_engine_geom_PointTools.roundGap(this.y1);
		this.x3 = nanofl_engine_geom_PointTools.roundGap(this.x3);
		this.y3 = nanofl_engine_geom_PointTools.roundGap(this.y3);
		if(straight) {
			this.x2 = (this.x1 + this.x3) / 2;
			this.y2 = (this.y1 + this.y3) / 2;
		} else {
			this.x2 = nanofl_engine_geom_PointTools.roundGap(this.x2);
			this.y2 = nanofl_engine_geom_PointTools.roundGap(this.y2);
			if(this.isStraight()) {
				this.x2 = (this.x1 + this.x3) / 2;
				this.y2 = (this.y1 + this.y3) / 2;
			}
		}
	}
	,getLength: function() {
		if(this.isStraight()) return this.asStraightLine().getLength(); else return this.asBezierCurve().getLength();
	}
	,getPart: function(t) {
		if(this.isStraight()) return nanofl_engine_geom_Edge.fromStraightLine(this.asStraightLine().getFirstPart(t)); else return nanofl_engine_geom_Edge.fromBezierCurve(this.asBezierCurve().getFirstPart(t));
	}
	,getPoint: function(t) {
		if(this.isStraight()) return this.asStraightLine().getPoint(t); else return this.asBezierCurve().getPoint(t);
	}
	,getTangent: function(t) {
		if(this.isStraight()) return this.asStraightLine().getTangent(t); else return this.asBezierCurve().getTangent(t);
	}
	,split: function(tt) {
		if(this.isStraight()) return this.asStraightLine().split(tt).map(nanofl_engine_geom_Edge.fromStraightLine); else return this.asBezierCurve().split(tt).map(nanofl_engine_geom_Edge.fromBezierCurve);
	}
	,isInRectangle: function(x,y,width,height) {
		if(this.x1 >= x && this.y1 >= y && this.x1 <= x + width && this.y1 <= y + height && this.x3 >= x && this.y3 >= y && this.x3 <= x + width && this.y3 <= y + height) {
			if(this.isStraight()) return true;
			if(this.x2 >= x && this.y2 >= y && this.x2 <= x + width && this.y2 <= y + height) return true;
			var curve = this.asBezierCurve();
			if(curve.getIntersection_straightSection(new nanofl_engine_geom_StraightLine(x,y,x + width,y)) != null) return false;
			if(curve.getIntersection_straightSection(new nanofl_engine_geom_StraightLine(x,y,x,y + height)) != null) return false;
			if(curve.getIntersection_straightSection(new nanofl_engine_geom_StraightLine(x,y + height,x + width,y + height)) != null) return false;
			if(curve.getIntersection_straightSection(new nanofl_engine_geom_StraightLine(x + width,y,x + width,y + height)) != null) return false;
			return true;
		}
		return false;
	}
	,getMonotoneT: function(k) {
		if(this.isStraight()) return k; else return this.asBezierCurve().getMonotoneT(k);
	}
	,__class__: nanofl_engine_geom_Edge
};
var nanofl_engine_geom_Edges = function() { };
$hxClasses["nanofl.engine.geom.Edges"] = nanofl_engine_geom_Edges;
nanofl_engine_geom_Edges.__name__ = ["nanofl","engine","geom","Edges"];
nanofl_engine_geom_Edges.hasDuplicates = function(edges) {
	var _g1 = 0;
	var _g = edges.length;
	while(_g1 < _g) {
		var i = _g1++;
		var _g3 = i + 1;
		var _g2 = edges.length;
		while(_g3 < _g2) {
			var j = _g3++;
			if(edges[i].equ(edges[j])) return true;
		}
	}
	return false;
};
nanofl_engine_geom_Edges.removeDublicates = function(edges) {
	var i = 0;
	while(i < edges.length) {
		var j = i + 1;
		while(j < edges.length) if(edges[i].equ(edges[j])) edges.splice(j,1); else j++;
		i++;
	}
};
nanofl_engine_geom_Edges.concatUnique = function(edgesA,edgesB) {
	var r = edgesA.slice();
	var _g = 0;
	while(_g < edgesB.length) {
		var e = edgesB[_g];
		++_g;
		if(e.indexIn(edgesA) < 0) r.push(e);
	}
	return r;
};
nanofl_engine_geom_Edges.appendUnique = function(edgesA,edgesB) {
	var _g = 0;
	while(_g < edgesB.length) {
		var e = edgesB[_g];
		++_g;
		if(e.indexIn(edgesA) < 0) edgesA.push(e);
	}
	return edgesA;
};
nanofl_engine_geom_Edges.exclude = function(edges,exclude) {
	var _g = 0;
	while(_g < exclude.length) {
		var e = exclude[_g];
		++_g;
		var n = e.indexIn(edges);
		if(n >= 0) {
			edges.splice(n,1);
			stdlib_Debug.assert(e.indexIn(edges) < 0,null,{ fileName : "Edges.hx", lineNumber : 66, className : "nanofl.engine.geom.Edges", methodName : "exclude"});
		}
	}
	return edges;
};
nanofl_engine_geom_Edges.draw = function(edges,g,fixLineJoinsInClosedContours) {
	var x = 1e100;
	var y = 1e100;
	var startEdge = null;
	var _g = 0;
	while(_g < edges.length) {
		var e = edges[_g];
		++_g;
		if(e.x1 != x || e.y1 != y) {
			if(fixLineJoinsInClosedContours && startEdge != null) {
				if(startEdge.x1 == x && startEdge.y1 == y) startEdge.drawTo(g);
			}
			startEdge = e;
			g.moveTo(e.x1,e.y1);
		}
		e.drawTo(g);
		x = e.x3;
		y = e.y3;
	}
	if(fixLineJoinsInClosedContours && startEdge != null) {
		if(startEdge.x1 == x && startEdge.y1 == y) startEdge.drawTo(g);
	}
};
nanofl_engine_geom_Edges.getBounds = function(edges,bounds) {
	if(edges.length > 0) {
		if(bounds == null) bounds = { minX : 1e100, minY : 1e100, maxX : -1e100, maxY : -1e100};
		var _g = 0;
		while(_g < edges.length) {
			var e = edges[_g];
			++_g;
			e.getBounds(bounds);
		}
		return bounds;
	}
	return bounds;
};
nanofl_engine_geom_Edges["export"] = function(edges,out) {
	if(edges.length == 0) return;
	var x = null;
	var y = null;
	var _g = 0;
	while(_g < edges.length) {
		var e = edges[_g];
		++_g;
		if(e.x1 != x || e.y1 != y) out.begin("move").attr("x",e.x1).attr("y",e.y1).end();
		if(e.isStraight()) out.begin("line").attr("x",e.x3).attr("y",e.y3).end(); else out.begin("curve").attr("x1",e.x2).attr("y1",e.y2).attr("x2",e.x3).attr("y2",e.y3).end();
		x = e.x3;
		y = e.y3;
	}
};
nanofl_engine_geom_Edges.exportStroked = function(edges,out) {
	if(edges.length == 0) return;
	var strokes = [];
	var edgesByFill = [];
	var _g = 0;
	while(_g < edges.length) {
		var e = edges[_g];
		++_g;
		var strokeIndex = -1;
		var _g2 = 0;
		var _g1 = strokes.length;
		while(_g2 < _g1) {
			var i = _g2++;
			if(strokes[i].equ(e.stroke)) {
				strokeIndex = i;
				break;
			}
		}
		if(strokeIndex == -1) {
			strokeIndex = strokes.length;
			strokes.push(e.stroke);
			edgesByFill.push([]);
		}
		edgesByFill[strokeIndex].push(e);
	}
	var _g11 = 0;
	var _g3 = edgesByFill.length;
	while(_g11 < _g3) {
		var i1 = _g11++;
		out.begin("edges").attr("strokeIndex",i1);
		nanofl_engine_geom_Edges["export"](edgesByFill[i1],out);
		out.end();
	}
};
nanofl_engine_geom_Edges.load = function(s) {
	var r = [];
	var x = 0.0;
	var y = 0.0;
	var i = 0;
	while(i < s.length) {
		var c = s.charAt(i);
		i++;
		if(c == "M") {
			if(!nanofl_engine_geom_Edges.reFloat2.matchSub(s,i)) throw new js__$Boot_HaxeError("Cannot parse " + HxOverrides.substr(s,i,20) + "'.");
			x = Std.parseFloat(nanofl_engine_geom_Edges.reFloat2.matched(1));
			y = Std.parseFloat(nanofl_engine_geom_Edges.reFloat2.matched(2));
			i += nanofl_engine_geom_Edges.reFloat2.matchedPos().len;
		} else if(c == "L") {
			if(!nanofl_engine_geom_Edges.reFloat2.matchSub(s,i)) throw new js__$Boot_HaxeError("Cannot parse " + HxOverrides.substr(s,i,20) + "'.");
			var newX = Std.parseFloat(nanofl_engine_geom_Edges.reFloat2.matched(1));
			var newY = Std.parseFloat(nanofl_engine_geom_Edges.reFloat2.matched(2));
			r.push(new nanofl_engine_geom_Edge(x,y,newX,newY));
			x = newX;
			y = newY;
			i += nanofl_engine_geom_Edges.reFloat2.matchedPos().len;
		} else if(c == "C") {
			if(!nanofl_engine_geom_Edges.reFloat4.matchSub(s,i)) throw new js__$Boot_HaxeError("Cannot parse " + HxOverrides.substr(s,i,20) + "'.");
			var newX1 = Std.parseFloat(nanofl_engine_geom_Edges.reFloat4.matched(3));
			var newY1 = Std.parseFloat(nanofl_engine_geom_Edges.reFloat4.matched(4));
			r.push(new nanofl_engine_geom_Edge(x,y,Std.parseFloat(nanofl_engine_geom_Edges.reFloat4.matched(1)),Std.parseFloat(nanofl_engine_geom_Edges.reFloat4.matched(2)),newX1,newY1));
			x = newX1;
			y = newY1;
			i += nanofl_engine_geom_Edges.reFloat4.matchedPos().len;
		} else throw new js__$Boot_HaxeError("Unexpected command '" + c + "'.");
	}
	return r;
};
nanofl_engine_geom_Edges.save = function(edges) {
	var r_b = "";
	var x = null;
	var y = null;
	var _g = 0;
	while(_g < edges.length) {
		var e = edges[_g];
		++_g;
		if(e.x1 != x || e.y1 != y) r_b += Std.string("M" + e.x1 + "," + e.y1);
		if(e.isStraight()) r_b += Std.string("L" + e.x3 + "," + e.y3); else r_b += Std.string("C" + e.x2 + "," + e.y2 + "," + e.x3 + "," + e.y3);
		x = e.x3;
		y = e.y3;
	}
	return r_b;
};
nanofl_engine_geom_Edges.replace = function(edges,search,replacement) {
	stdlib_Debug.assert(!nanofl_engine_geom_Edges.hasDuplicates(edges),"Edges must be unique.",{ fileName : "Edges.hx", lineNumber : 248, className : "nanofl.engine.geom.Edges", methodName : "replace"});
	stdlib_Debug.assert(HxOverrides.indexOf(edges,null,0) < 0,null,{ fileName : "Edges.hx", lineNumber : 249, className : "nanofl.engine.geom.Edges", methodName : "replace"});
	stdlib_Debug.assert(HxOverrides.indexOf(replacement,null,0) < 0,null,{ fileName : "Edges.hx", lineNumber : 250, className : "nanofl.engine.geom.Edges", methodName : "replace"});
	if(replacement.length == 1 && replacement[0].equ(search)) return -1;
	stdlib_Debug.assert(search.indexIn(replacement) < 0,null,{ fileName : "Edges.hx", lineNumber : 254, className : "nanofl.engine.geom.Edges", methodName : "replace"});
	var i = search.indexIn(edges);
	if(i >= 0) {
		var _g = 0;
		while(_g < replacement.length) {
			var e = replacement[_g];
			++_g;
			stdlib_Debug.assert(e.indexIn(edges) < 0,e.toString(),{ fileName : "Edges.hx", lineNumber : 259, className : "nanofl.engine.geom.Edges", methodName : "replace"});
		}
		var edge = edges[i];
		nanofl_engine_geom_Edges.replaceAt(edges,i,replacement,edge.x1 == search.x3 && edge.y1 == search.y3);
	}
	stdlib_Debug.assert(!nanofl_engine_geom_Edges.hasDuplicates(edges),"Edges must be unique.",{ fileName : "Edges.hx", lineNumber : 265, className : "nanofl.engine.geom.Edges", methodName : "replace"});
	return i;
};
nanofl_engine_geom_Edges.replaceAll = function(edges,search,replacement) {
	stdlib_Debug.assert(HxOverrides.indexOf(edges,null,0) < 0,null,{ fileName : "Edges.hx", lineNumber : 272, className : "nanofl.engine.geom.Edges", methodName : "replaceAll"});
	stdlib_Debug.assert(HxOverrides.indexOf(replacement,null,0) < 0,null,{ fileName : "Edges.hx", lineNumber : 273, className : "nanofl.engine.geom.Edges", methodName : "replaceAll"});
	stdlib_Debug.assert(search.indexIn(replacement) < 0,null,{ fileName : "Edges.hx", lineNumber : 274, className : "nanofl.engine.geom.Edges", methodName : "replaceAll"});
	var i = 0;
	while(i < edges.length) {
		var edge = edges[i];
		if(edge.equ(search)) {
			nanofl_engine_geom_Edges.replaceAt(edges,i,replacement,search.x1 == edge.x3 && search.y1 == edge.y3);
			i += replacement.length;
		} else i++;
	}
	stdlib_Debug.assert(HxOverrides.indexOf(edges,null,0) < 0,null,{ fileName : "Edges.hx", lineNumber : 290, className : "nanofl.engine.geom.Edges", methodName : "replaceAll"});
};
nanofl_engine_geom_Edges.replaceAt = function(edges,n,replacement,reverse) {
	stdlib_Debug.assert(n >= 0 && n < edges.length,"n = " + n + "; edges.length = " + edges.length,{ fileName : "Edges.hx", lineNumber : 295, className : "nanofl.engine.geom.Edges", methodName : "replaceAt"});
	stdlib_Debug.assert(HxOverrides.indexOf(edges,null,0) < 0,null,{ fileName : "Edges.hx", lineNumber : 296, className : "nanofl.engine.geom.Edges", methodName : "replaceAt"});
	stdlib_Debug.assert(HxOverrides.indexOf(replacement,null,0) < 0,null,{ fileName : "Edges.hx", lineNumber : 297, className : "nanofl.engine.geom.Edges", methodName : "replaceAt"});
	var edge = edges[n];
	edges.splice(n,1);
	replacement = replacement.map(function(e) {
		var r = edge.clone();
		r.x1 = e.x1;
		r.y1 = e.y1;
		r.x2 = e.x2;
		r.y2 = e.y2;
		r.x3 = e.x3;
		r.y3 = e.y3;
		return r;
	});
	if(reverse) {
		replacement.reverse();
		var _g = 0;
		while(_g < replacement.length) {
			var edge1 = replacement[_g];
			++_g;
			edge1.reverse();
		}
	}
	stdlib_LambdaArray.insertRange(edges,n,replacement);
};
nanofl_engine_geom_Edges.intersect = function(edgesA,edgesB,onReplace) {
	nanofl_engine_geom_Edges.normalize(edgesA);
	nanofl_engine_geom_Edges.normalize(edgesB);
	stdlib_Debug.assert(edgesA != edgesB,"Must not be the same edges array.",{ fileName : "Edges.hx", lineNumber : 329, className : "nanofl.engine.geom.Edges", methodName : "intersect"});
	stdlib_Debug.assert(HxOverrides.indexOf(edgesA,null,0) < 0,null,{ fileName : "Edges.hx", lineNumber : 330, className : "nanofl.engine.geom.Edges", methodName : "intersect"});
	stdlib_Debug.assert(HxOverrides.indexOf(edgesB,null,0) < 0,null,{ fileName : "Edges.hx", lineNumber : 331, className : "nanofl.engine.geom.Edges", methodName : "intersect"});
	stdlib_Debug.assert(!nanofl_engine_geom_Edges.hasDuplicates(edgesA),"Must not have duplicated in edgesA.",{ fileName : "Edges.hx", lineNumber : 332, className : "nanofl.engine.geom.Edges", methodName : "intersect"});
	stdlib_Debug.assert(!nanofl_engine_geom_Edges.hasDuplicates(edgesB),"Must not have duplicated in edgesB.",{ fileName : "Edges.hx", lineNumber : 333, className : "nanofl.engine.geom.Edges", methodName : "intersect"});
	stdlib_Debug.assert(!nanofl_engine_geom_Edges.hasDegenerated(edgesA),"Must not have degenerated in edgesA.",{ fileName : "Edges.hx", lineNumber : 334, className : "nanofl.engine.geom.Edges", methodName : "intersect"});
	stdlib_Debug.assert(!nanofl_engine_geom_Edges.hasDegenerated(edgesB),"Must not have degenerated in edgesB.",{ fileName : "Edges.hx", lineNumber : 335, className : "nanofl.engine.geom.Edges", methodName : "intersect"});
	nanofl_engine_geom_Edges.intersectByClosePoints(edgesA,edgesB,onReplace);
	stdlib_Debug.assert(!nanofl_engine_geom_Edges.hasDuplicates(edgesA),"Must not have duplicated in edgesA.",{ fileName : "Edges.hx", lineNumber : 345, className : "nanofl.engine.geom.Edges", methodName : "intersect"});
	stdlib_Debug.assert(!nanofl_engine_geom_Edges.hasDuplicates(edgesB),"Must not have duplicated in edgesB.",{ fileName : "Edges.hx", lineNumber : 346, className : "nanofl.engine.geom.Edges", methodName : "intersect"});
	var i = 0;
	while(i < edgesA.length) {
		var j = [0];
		while(j[0] < edgesB.length) {
			stdlib_Debug.assert(i < edgesA.length,(function() {
				return function() {
					return "i = " + i + "; edgesA.length = " + edgesA.length;
				};
			})(),{ fileName : "Edges.hx", lineNumber : 354, className : "nanofl.engine.geom.Edges", methodName : "intersect"});
			stdlib_Debug.assert(j[0] < edgesB.length,(function(j) {
				return function() {
					return "j = " + j[0] + "; edgesB.length = " + edgesB.length;
				};
			})(j),{ fileName : "Edges.hx", lineNumber : 355, className : "nanofl.engine.geom.Edges", methodName : "intersect"});
			var edgeA = edgesA[i];
			var edgeB = edgesB[j[0]];
			var I = nanofl_engine_geom_Edge.getIntersection(edgeA,edgeB);
			if(I != null) {
				var decI = false;
				if(I.a.length != 1 || !I.a[0].equ(edgeA)) {
					if(onReplace != null) onReplace(edgeA,I.a);
					edgesA.splice(i,1);
					var _g = 0;
					var _g1 = I.a;
					while(_g < _g1.length) {
						var e = _g1[_g];
						++_g;
						if(e.indexIn(edgesA) < 0) edgesA.push(edgeA.duplicate(e));
					}
					i--;
					decI = true;
					var n = edgeA.indexIn(edgesB);
					if(n >= 0) {
						edgesB.splice(n,1);
						var _g2 = 0;
						var _g11 = I.a;
						while(_g2 < _g11.length) {
							var e1 = _g11[_g2];
							++_g2;
							if(e1.indexIn(edgesB) < 0) edgesB.push(edgeB.duplicate(e1));
						}
						if(j[0] > n) j[0]--;
					}
				}
				if(I.b.length != 1 || !I.b[0].equ(edgeB)) {
					if(onReplace != null) onReplace(edgeB,I.b);
					edgesB.splice(j[0],1);
					var _g3 = 0;
					var _g12 = I.b;
					while(_g3 < _g12.length) {
						var e2 = _g12[_g3];
						++_g3;
						if(e2.indexIn(edgesB) < 0) edgesB.push(edgeB.duplicate(e2));
					}
					j[0]--;
					var n1 = edgeB.indexIn(edgesA);
					if(n1 >= 0) {
						edgesA.splice(n1,1);
						var _g4 = 0;
						var _g13 = I.b;
						while(_g4 < _g13.length) {
							var e3 = _g13[_g4];
							++_g4;
							if(e3.indexIn(edgesA) < 0) edgesA.push(edgeA.duplicate(e3));
						}
						if(i > n1) {
							i--;
							decI = true;
						}
					}
				}
				if(decI) break;
			} else j[0]++;
		}
		i++;
	}
	stdlib_Debug.assert(edgesA != edgesB,"Must not be the same edges array.",{ fileName : "Edges.hx", lineNumber : 416, className : "nanofl.engine.geom.Edges", methodName : "intersect"});
	stdlib_Debug.assert(HxOverrides.indexOf(edgesA,null,0) < 0,null,{ fileName : "Edges.hx", lineNumber : 417, className : "nanofl.engine.geom.Edges", methodName : "intersect"});
	stdlib_Debug.assert(HxOverrides.indexOf(edgesB,null,0) < 0,null,{ fileName : "Edges.hx", lineNumber : 418, className : "nanofl.engine.geom.Edges", methodName : "intersect"});
	stdlib_Debug.assert(!nanofl_engine_geom_Edges.hasDuplicates(edgesA),"Must not have duplicated in edgesA.",{ fileName : "Edges.hx", lineNumber : 419, className : "nanofl.engine.geom.Edges", methodName : "intersect"});
	stdlib_Debug.assert(!nanofl_engine_geom_Edges.hasDuplicates(edgesB),"Must not have duplicated in edgesB.",{ fileName : "Edges.hx", lineNumber : 420, className : "nanofl.engine.geom.Edges", methodName : "intersect"});
	stdlib_Debug.assert(!nanofl_engine_geom_Edges.hasIntersections(edgesA,edgesB),"After intersection must not be intersections (" + nanofl_engine_geom_Edges.getFirstIntersectionString(edgesA,edgesB) + ").",{ fileName : "Edges.hx", lineNumber : 421, className : "nanofl.engine.geom.Edges", methodName : "intersect"});
	stdlib_Debug.assert(!nanofl_engine_geom_Edges.hasDegenerated(edgesA),"Must not have degenerated in edgesA.",{ fileName : "Edges.hx", lineNumber : 422, className : "nanofl.engine.geom.Edges", methodName : "intersect"});
	stdlib_Debug.assert(!nanofl_engine_geom_Edges.hasDegenerated(edgesB),"Must not have degenerated in edgesB.",{ fileName : "Edges.hx", lineNumber : 423, className : "nanofl.engine.geom.Edges", methodName : "intersect"});
};
nanofl_engine_geom_Edges.intersectByClosePoints = function(edgesA,edgesB,onReplace) {
	nanofl_engine_geom_Edges.intersectByClosePointsInner(edgesA,edgesB,onReplace);
	nanofl_engine_geom_Edges.intersectByClosePointsInner(edgesB,edgesA,onReplace);
};
nanofl_engine_geom_Edges.intersectByClosePointsInner = function(edgesA,edgesB,onReplace) {
	stdlib_Debug.assert(edgesA != edgesB,"Must not be the same edges array.",{ fileName : "Edges.hx", lineNumber : 435, className : "nanofl.engine.geom.Edges", methodName : "intersectByClosePointsInner"});
	stdlib_Debug.assert(HxOverrides.indexOf(edgesA,null,0) < 0,null,{ fileName : "Edges.hx", lineNumber : 436, className : "nanofl.engine.geom.Edges", methodName : "intersectByClosePointsInner"});
	stdlib_Debug.assert(HxOverrides.indexOf(edgesB,null,0) < 0,null,{ fileName : "Edges.hx", lineNumber : 437, className : "nanofl.engine.geom.Edges", methodName : "intersectByClosePointsInner"});
	stdlib_Debug.assert(!nanofl_engine_geom_Edges.hasDuplicates(edgesA),"Must not have duplicated in edgesA.",{ fileName : "Edges.hx", lineNumber : 438, className : "nanofl.engine.geom.Edges", methodName : "intersectByClosePointsInner"});
	stdlib_Debug.assert(!nanofl_engine_geom_Edges.hasDuplicates(edgesB),"Must not have duplicated in edgesB.",{ fileName : "Edges.hx", lineNumber : 439, className : "nanofl.engine.geom.Edges", methodName : "intersectByClosePointsInner"});
	stdlib_Debug.assert(!nanofl_engine_geom_Edges.hasDegenerated(edgesA),"Must not have degenerated in edgesA.",{ fileName : "Edges.hx", lineNumber : 440, className : "nanofl.engine.geom.Edges", methodName : "intersectByClosePointsInner"});
	stdlib_Debug.assert(!nanofl_engine_geom_Edges.hasDegenerated(edgesB),"Must not have degenerated in edgesB.",{ fileName : "Edges.hx", lineNumber : 441, className : "nanofl.engine.geom.Edges", methodName : "intersectByClosePointsInner"});
	var _g = 0;
	while(_g < edgesA.length) {
		var edgeA = edgesA[_g];
		++_g;
		var i = 0;
		while(i < edgesB.length) {
			var edgeB = edgesB[i];
			if(nanofl_engine_geom_BoundsTools.isIntersect(edgeA.getBoundsRO(),edgeB.getBoundsRO(),nanofl_engine_geom_Edges.GAP) && !edgeA.equ(edgeB)) {
				var r = edgeB.splitByClosePoint(edgeA.x1,edgeA.y1);
				if(r == null) r = edgeB.splitByClosePoint(edgeA.x3,edgeA.y3);
				if(r != null) {
					if(onReplace != null) onReplace(edgeB,r);
					edgesB.splice(i,1);
					var _g1 = 0;
					while(_g1 < r.length) {
						var e = r[_g1];
						++_g1;
						if(e.indexIn(edgesB) < 0) edgesB.push(edgeB.duplicate(e));
					}
					i--;
				}
			}
			i++;
		}
	}
	stdlib_Debug.assert(edgesA != edgesB,"Must not be the same edges array.",{ fileName : "Edges.hx", lineNumber : 468, className : "nanofl.engine.geom.Edges", methodName : "intersectByClosePointsInner"});
	stdlib_Debug.assert(HxOverrides.indexOf(edgesA,null,0) < 0,null,{ fileName : "Edges.hx", lineNumber : 469, className : "nanofl.engine.geom.Edges", methodName : "intersectByClosePointsInner"});
	stdlib_Debug.assert(HxOverrides.indexOf(edgesB,null,0) < 0,null,{ fileName : "Edges.hx", lineNumber : 470, className : "nanofl.engine.geom.Edges", methodName : "intersectByClosePointsInner"});
	stdlib_Debug.assert(!nanofl_engine_geom_Edges.hasDuplicates(edgesA),"Must not have duplicated in edgesA.",{ fileName : "Edges.hx", lineNumber : 471, className : "nanofl.engine.geom.Edges", methodName : "intersectByClosePointsInner"});
	stdlib_Debug.assert(!nanofl_engine_geom_Edges.hasDuplicates(edgesB),"Must not have duplicated in edgesB.",{ fileName : "Edges.hx", lineNumber : 472, className : "nanofl.engine.geom.Edges", methodName : "intersectByClosePointsInner"});
	stdlib_Debug.assert(!nanofl_engine_geom_Edges.hasDegenerated(edgesA),"Must not have degenerated in edgesA.",{ fileName : "Edges.hx", lineNumber : 473, className : "nanofl.engine.geom.Edges", methodName : "intersectByClosePointsInner"});
	stdlib_Debug.assert(!nanofl_engine_geom_Edges.hasDegenerated(edgesB),"Must not have degenerated in edgesB.",{ fileName : "Edges.hx", lineNumber : 474, className : "nanofl.engine.geom.Edges", methodName : "intersectByClosePointsInner"});
};
nanofl_engine_geom_Edges.intersectSelf = function(edges,onReplace) {
	nanofl_engine_geom_Edges.intersect(edges,edges.slice(),onReplace);
};
nanofl_engine_geom_Edges.normalize = function(edges) {
	nanofl_engine_geom_Edges.roundPoints(edges);
	nanofl_engine_geom_Edges.removeDegenerated(edges);
	nanofl_engine_geom_Edges.removeDublicates(edges);
	return edges;
};
nanofl_engine_geom_Edges.roundPoints = function(edges) {
	var _g = 0;
	while(_g < edges.length) {
		var edge = edges[_g];
		++_g;
		edge.roundPoints();
	}
	return edges;
};
nanofl_engine_geom_Edges.removeDegenerated = function(edges,removeAlsoCurvesWithStartAndEndEquals) {
	if(removeAlsoCurvesWithStartAndEndEquals == null) removeAlsoCurvesWithStartAndEndEquals = false;
	if(removeAlsoCurvesWithStartAndEndEquals) {
		var i = 0;
		while(i < edges.length) {
			var edge = edges[i];
			if(edge.x1 == edge.x3 && edge.y1 == edge.y3) edges.splice(i,1); else i++;
		}
	} else {
		var i1 = 0;
		while(i1 < edges.length) if(edges[i1].isDegenerated()) edges.splice(i1,1); else i1++;
	}
	return edges;
};
nanofl_engine_geom_Edges.isPointInside = function(edges,x,y,fillEvenOdd) {
	if(fillEvenOdd) {
		var count1 = 0;
		var _g = 0;
		while(_g < edges.length) {
			var edge = edges[_g];
			++_g;
			count1 += edge.getIntersectionCount_rightRay(x,y);
		}
		return count1 % 2 == 1;
	}
	var count = 0;
	var _g1 = 0;
	while(_g1 < edges.length) {
		var edge1 = edges[_g1];
		++_g1;
		count += edge1.getIntersectionDirectedCount_rightRay(x,y);
	}
	return count != 0;
};
nanofl_engine_geom_Edges.hasIntersections = function(edgesA,edgesB) {
	var _g = 0;
	while(_g < edgesA.length) {
		var a = edgesA[_g];
		++_g;
		var _g1 = 0;
		while(_g1 < edgesB.length) {
			var b = edgesB[_g1];
			++_g1;
			var I = nanofl_engine_geom_Edge.getIntersection(a,b);
			if(I != null) return true;
		}
	}
	return false;
};
nanofl_engine_geom_Edges.getFirstIntersectionString = function(edgesA,edgesB) {
	var _g = 0;
	while(_g < edgesA.length) {
		var a = edgesA[_g];
		++_g;
		var _g1 = 0;
		while(_g1 < edgesB.length) {
			var b = edgesB[_g1];
			++_g1;
			var I = nanofl_engine_geom_Edge.getIntersection(a,b);
			if(I != null) return a.toString() + ", " + b.toString();
		}
	}
	return "";
};
nanofl_engine_geom_Edges.isSequence = function(edges) {
	var _g1 = 1;
	var _g = edges.length;
	while(_g1 < _g) {
		var i = _g1++;
		if(edges[i - 1].x3 != edges[i].x1) return false;
		if(edges[i - 1].y3 != edges[i].y1) return false;
	}
	return true;
};
nanofl_engine_geom_Edges.hasDegenerated = function(edges) {
	var _g = 0;
	while(_g < edges.length) {
		var e = edges[_g];
		++_g;
		if(e.isDegenerated()) return true;
	}
	return false;
};
nanofl_engine_geom_Edges.getPointUseCount = function(edges,x,y) {
	var r = 0;
	var _g = 0;
	while(_g < edges.length) {
		var e = edges[_g];
		++_g;
		if(e.x1 == x && e.y1 == y) r++;
		if(e.x3 == x && e.y3 == y) r++;
	}
	return r;
};
nanofl_engine_geom_Edges.equIgnoreOrder = function(edgesA,edgesB) {
	if(edgesA.length != edgesB.length) return false;
	var _g = 0;
	while(_g < edgesA.length) {
		var edgeA = edgesA[_g];
		++_g;
		if(edgeA.indexIn(edgesB) < 0) return false;
	}
	return true;
};
nanofl_engine_geom_Edges.getCommon = function(edgesA,edgesB) {
	var r = [];
	var _g = 0;
	while(_g < edgesA.length) {
		var edge = edgesA[_g];
		++_g;
		if(edge.indexIn(edgesB) >= 0) r.push(edge);
	}
	return r;
};
nanofl_engine_geom_Edges.getDifferent = function(edgesA,edgesB) {
	var r = [];
	var _g = 0;
	while(_g < edgesA.length) {
		var edge = edgesA[_g];
		++_g;
		if(edge.indexIn(edgesB) < 0) r.push(edge);
	}
	var _g1 = 0;
	while(_g1 < edgesB.length) {
		var edge1 = edgesB[_g1];
		++_g1;
		if(edge1.indexIn(edgesA) < 0) r.push(edge1);
	}
	return r;
};
nanofl_engine_geom_Edges.getNearestVertex = function(edges,x,y) {
	var r = { x : -1e10, y : -1e10};
	var _g = 0;
	while(_g < edges.length) {
		var e = edges[_g];
		++_g;
		if(nanofl_engine_geom_PointTools.getSqrDist(r.x,r.y,x,y) > nanofl_engine_geom_PointTools.getSqrDist(e.x1,e.y1,x,y)) {
			r.x = e.x1;
			r.y = e.y1;
		}
		if(nanofl_engine_geom_PointTools.getSqrDist(r.x,r.y,x,y) > nanofl_engine_geom_PointTools.getSqrDist(e.x3,e.y3,x,y)) {
			r.x = e.x3;
			r.y = e.y3;
		}
	}
	return r;
};
nanofl_engine_geom_Edges.getTailPoints = function(edges) {
	var r = [];
	var _g = 0;
	while(_g < edges.length) {
		var e = [edges[_g]];
		++_g;
		if(nanofl_engine_geom_Edges.getPointUseCount(edges,e[0].x1,e[0].y1) == 1 && !Lambda.exists(r,(function(e) {
			return function(p) {
				return p.x == e[0].x1 && p.y == e[0].y1;
			};
		})(e))) r.push({ x : e[0].x1, y : e[0].y1});
		if(nanofl_engine_geom_Edges.getPointUseCount(edges,e[0].x3,e[0].y3) == 1 && !Lambda.exists(r,(function(e) {
			return function(p1) {
				return p1.x == e[0].x3 && p1.y == e[0].y3;
			};
		})(e))) r.push({ x : e[0].x3, y : e[0].y3});
	}
	return r;
};
nanofl_engine_geom_Edges.smoothStraightLineSequence = function(edges,power) {
	var i = 0;
	while(i < edges.length) {
		var a = edges[i];
		var b = edges[(i + 1) % edges.length];
		if(a.x3 == b.x1 && a.y3 == b.y1) {
			var cc = a.split([1 - power / 2]);
			var dd = b.split([power / 2]);
			edges[i] = cc[0];
			edges[i + 1] = dd[1];
			cc[1].x2 = a.x3;
			cc[1].y2 = a.y3;
			cc[1].x3 = dd[0].x3;
			cc[1].y3 = dd[0].y3;
			edges.splice(i + 1,0,cc[1]);
			i++;
		}
		i++;
	}
};
nanofl_engine_geom_Edges.assertHasNoIntersections = function(edges) {
	var _g1 = 0;
	var _g = edges.length;
	while(_g1 < _g) {
		var i = _g1++;
		var _g3 = i + 1;
		var _g2 = edges.length;
		while(_g3 < _g2) {
			var j = _g3++;
			var hasCV = edges[i].hasCommonVertices(edges[j]);
			var I = nanofl_engine_geom_Edge.getIntersection(edges[i],edges[j]);
			stdlib_Debug.assert(hasCV || I == null || I.a.length == 1 || I.b.length == 1,"hasCV = " + (hasCV == null?"null":"" + hasCV) + "\n" + "I = " + Std.string(I != null) + "\n" + "edges[" + i + "] = " + Std.string(edges[i]) + "\n" + "edges[" + j + "] = " + Std.string(edges[j]),{ fileName : "Edges.hx", lineNumber : 745, className : "nanofl.engine.geom.Edges", methodName : "assertHasNoIntersections"});
		}
	}
};
nanofl_engine_geom_Edges.simplificate = function(sequence,eps) {
	if(sequence.length < 2) return sequence.slice();
	var eps2 = eps * eps;
	var r = [];
	r.push(sequence[0]);
	var _g1 = 1;
	var _g = sequence.length;
	while(_g1 < _g) {
		var i = _g1++;
		var edgeA = r[r.length - 1];
		var edgeB = sequence[i];
		var equal = true;
		var edgeC = nanofl_engine_geom_Edges.getAppoximated(edgeA,edgeB);
		var _g2 = 0;
		while(_g2 < 7) {
			var i1 = _g2++;
			var pt0 = edgeC.getPoint(i1 / 6);
			var d1 = nanofl_engine_geom_PointTools.getSqrDistP(pt0,edgeA.getNearestPoint(pt0.x,pt0.y).point);
			var d2 = nanofl_engine_geom_PointTools.getSqrDistP(pt0,edgeB.getNearestPoint(pt0.x,pt0.y).point);
			if(d1 > eps2 && d2 > eps2) {
				equal = false;
				break;
			}
		}
		if(equal) r[r.length - 1] = edgeC; else r.push(edgeB);
	}
	return r;
};
nanofl_engine_geom_Edges.getAppoximated = function(edgeA,edgeB) {
	stdlib_Debug.assert(edgeA.x3 == edgeB.x1 && edgeA.y3 == edgeB.y1,null,{ fileName : "Edges.hx", lineNumber : 798, className : "nanofl.engine.geom.Edges", methodName : "getAppoximated"});
	var lineA = new nanofl_engine_geom_StraightLine(edgeA.x1,edgeA.y1,edgeA.x2,edgeA.y2);
	var lineB = new nanofl_engine_geom_StraightLine(edgeB.x3,edgeB.y3,edgeB.x2,edgeB.y2);
	var I = lineA.getIntersection_infinityLine(lineB);
	var r = edgeA.clone();
	r.x3 = edgeB.x3;
	r.y3 = edgeB.y3;
	if(I == null) r.x2 = (r.x1 + r.x3) / 2; else r.x2 = I.x;
	if(I == null) r.y2 = (r.y1 + r.y3) / 2; else r.y2 = I.y;
	return r;
};
nanofl_engine_geom_Edges.log = function(v,infos) {
};
var nanofl_engine_geom_Equation = function() { };
$hxClasses["nanofl.engine.geom.Equation"] = nanofl_engine_geom_Equation;
nanofl_engine_geom_Equation.__name__ = ["nanofl","engine","geom","Equation"];
nanofl_engine_geom_Equation.solveCube = function(a,b,c,d) {
	if(Math.abs(a) < 1e-10) return nanofl_engine_geom_Equation.solveQuadratic(b,c,d);
	var z = a;
	a = b / z;
	b = c / z;
	c = d / z;
	var p = b - a * a / 3;
	var q = a * (2 * a * a - 9 * b) / 27 + c;
	var p3 = p * p * p;
	var D = q * q + 4 * p3 / 27;
	var offset = -a / 3;
	if(D > 1e-10) {
		z = Math.sqrt(D);
		var u = (-q + z) / 2;
		var v = (-q - z) / 2;
		if(u >= 0) u = Math.pow(u,0.33333333333333331); else u = -Math.pow(-u,0.33333333333333331);
		if(v >= 0) v = Math.pow(v,0.33333333333333331); else v = -Math.pow(-v,0.33333333333333331);
		return [u + v + offset];
	} else if(D < -1e-010) {
		var u1 = 2 * Math.sqrt(-p / 3);
		var v1 = Math.acos(-Math.sqrt(-27 / p3) * q / 2) / 3;
		return [u1 * Math.cos(v1) + offset,u1 * Math.cos(v1 + 2 * Math.PI / 3) + offset,u1 * Math.cos(v1 + 4 * Math.PI / 3) + offset];
	} else {
		var u2;
		if(q < 0) u2 = Math.pow(-q / 2,0.33333333333333331); else u2 = -Math.pow(q / 2,0.33333333333333331);
		return [2 * u2 + offset,-u2 + offset];
	}
};
nanofl_engine_geom_Equation.solveQuadratic = function(a,b,c) {
	if(Math.abs(a) <= 1e-10) if(Math.abs(b) > 1e-10) return [-c / b]; else return [];
	var D = b * b - 4 * a * c;
	if(D > 1e-10) {
		D = Math.sqrt(D);
		return [(-b - D) / (2 * a),(-b + D) / (2 * a)];
	}
	if(D > -1e-010) return [-b / (2 * a)];
	return [];
};
var nanofl_engine_geom_Matrix = function(a,b,c,d,tx,ty) {
	if(ty == null) ty = 0.0;
	if(tx == null) tx = 0.0;
	if(d == null) d = 1.0;
	if(c == null) c = 0.0;
	if(b == null) b = 0.0;
	if(a == null) a = 1.0;
	this.a = a;
	this.b = b;
	this.c = c;
	this.d = d;
	this.tx = tx;
	this.ty = ty;
};
$hxClasses["nanofl.engine.geom.Matrix"] = nanofl_engine_geom_Matrix;
nanofl_engine_geom_Matrix.__name__ = ["nanofl","engine","geom","Matrix"];
nanofl_engine_geom_Matrix.load = function(node) {
	var coefs = htmlparser_HtmlParserTools.getAttr(node,"matrix",[0.0]);
	if(coefs != null) return new nanofl_engine_geom_Matrix(coefs[0],coefs[1],coefs[2],coefs[3],htmlparser_HtmlParserTools.getAttr(node,"x",0.0),htmlparser_HtmlParserTools.getAttr(node,"y",0.0)); else return new nanofl_engine_geom_Matrix(1.0,0.0,0.0,1.0,htmlparser_HtmlParserTools.getAttr(node,"x",0.0),htmlparser_HtmlParserTools.getAttr(node,"y",0.0));
};
nanofl_engine_geom_Matrix.fromMatrix2D = function(m) {
	return new nanofl_engine_geom_Matrix(m.a,m.b,m.c,m.d,m.tx,m.ty);
};
nanofl_engine_geom_Matrix.prototype = {
	a: null
	,b: null
	,c: null
	,d: null
	,tx: null
	,ty: null
	,save: function(out) {
		if(this.tx != 0.0 || this.ty != 0.0) {
			out.attr("x",this.tx);
			out.attr("y",this.ty);
		}
		if(this.a != 1.0 || this.b != 0.0 || this.c != 0.0 || this.d != 1.0) out.attr("matrix",[this.a,this.b,this.c,this.d].join(","));
	}
	,decompose: function() {
		var r = { };
		r.x = this.tx;
		r.y = this.ty;
		r.scaleX = Math.sqrt(this.a * this.a + this.b * this.b);
		r.scaleY = Math.sqrt(this.c * this.c + this.d * this.d);
		var skewX = Math.atan2(-this.c,this.d);
		var skewY = Math.atan2(this.b,this.a);
		if(skewX == skewY) {
			r.rotation = skewY * 180 / Math.PI;
			if(this.a < 0 && this.d >= 0) if(r.rotation <= 0) r.rotation += 180; else r.rotation += -180;
			r.skewX = r.skewY = 0;
		} else {
			r.rotation = 0;
			r.skewX = skewX * 180 / Math.PI;
			r.skewY = skewY * 180 / Math.PI;
		}
		return r;
	}
	,setMatrix: function(m) {
		this.a = m.a;
		this.b = m.b;
		this.c = m.c;
		this.d = m.d;
		this.tx = m.tx;
		this.ty = m.ty;
		return this;
	}
	,isIdentity: function() {
		return this.a == 1.0 && this.b == 0.0 && this.c == 0.0 && this.d == 1.0 && this.tx == 0.0 && this.ty == 0.0;
	}
	,invert: function() {
		var a1 = this.a;
		var b1 = this.b;
		var c1 = this.c;
		var d1 = this.d;
		var tx1 = this.tx;
		var n = a1 * d1 - b1 * c1;
		this.a = d1 / n;
		this.b = -b1 / n;
		this.c = -c1 / n;
		this.d = a1 / n;
		this.tx = (c1 * this.ty - d1 * tx1) / n;
		this.ty = -(a1 * this.ty - b1 * tx1) / n;
		return this;
	}
	,transformPoint: function(x,y) {
		return { x : x * this.a + y * this.c + this.tx, y : x * this.b + y * this.d + this.ty};
	}
	,transformPointP: function(pos) {
		return { x : pos.x * this.a + pos.y * this.c + this.tx, y : pos.x * this.b + pos.y * this.d + this.ty};
	}
	,clone: function() {
		return new nanofl_engine_geom_Matrix(this.a,this.b,this.c,this.d,this.tx,this.ty);
	}
	,translate: function(tx,ty) {
		this.tx += tx;
		this.ty += ty;
		return this;
	}
	,equ: function(m) {
		return m.a == this.a && m.b == this.b && m.c == this.c && m.d == this.d && m.tx == this.tx && m.ty == this.ty;
	}
	,setTransform: function(x,y,scaleX,scaleY,rotation,skewX,skewY,regX,regY) {
		return this.setMatrix(new nanofl_engine_geom_Matrix().appendTransform(x,y,scaleX,scaleY,rotation,skewX,skewY,regX,regY));
	}
	,appendMatrix: function(m) {
		return this.append(m.a,m.b,m.c,m.d,m.tx,m.ty);
	}
	,prependMatrix: function(m) {
		return this.prepend(m.a,m.b,m.c,m.d,m.tx,m.ty);
	}
	,append: function(a,b,c,d,tx,ty) {
		var a1 = this.a;
		var b1 = this.b;
		var c1 = this.c;
		var d1 = this.d;
		this.a = a * a1 + b * c1;
		this.b = a * b1 + b * d1;
		this.c = c * a1 + d * c1;
		this.d = c * b1 + d * d1;
		this.tx = tx * a1 + ty * c1 + this.tx;
		this.ty = tx * b1 + ty * d1 + this.ty;
		return this;
	}
	,prepend: function(a,b,c,d,tx,ty) {
		var tx1 = this.tx;
		if(a != 1 || b != 0 || c != 0 || d != 1) {
			var a1 = this.a;
			var c1 = this.c;
			this.a = a1 * a + this.b * c;
			this.b = a1 * b + this.b * d;
			this.c = c1 * a + this.d * c;
			this.d = c1 * b + this.d * d;
		}
		this.tx = tx1 * a + this.ty * c + tx;
		this.ty = tx1 * b + this.ty * d + ty;
		return this;
	}
	,appendTransform: function(x,y,scaleX,scaleY,rotation,skewX,skewY,regX,regY) {
		if(regY == null) regY = 0.0;
		if(regX == null) regX = 0.0;
		if(skewY == null) skewY = 0.0;
		if(skewX == null) skewX = 0.0;
		if(rotation == null) rotation = 0.0;
		if(scaleY == null) scaleY = 1.0;
		if(scaleX == null) scaleX = 1.0;
		var sin;
		var cos;
		if(rotation % 360 != 0) {
			var r = rotation * nanofl_engine_geom_Matrix.DEG_TO_RAD;
			cos = Math.cos(r);
			sin = Math.sin(r);
		} else {
			cos = 1;
			sin = 0;
		}
		if(skewX != 0 || skewY != 0) {
			skewX *= nanofl_engine_geom_Matrix.DEG_TO_RAD;
			skewY *= nanofl_engine_geom_Matrix.DEG_TO_RAD;
			this.append(Math.cos(skewY),Math.sin(skewY),-Math.sin(skewX),Math.cos(skewX),x,y);
			this.append(cos * scaleX,sin * scaleX,-sin * scaleY,cos * scaleY,0,0);
		} else this.append(cos * scaleX,sin * scaleX,-sin * scaleY,cos * scaleY,x,y);
		if(regX != 0 || regY != 0) {
			this.tx -= regX * this.a + regY * this.c;
			this.ty -= regX * this.b + regY * this.d;
		}
		return this;
	}
	,prependTransform: function(x,y,scaleX,scaleY,rotation,skewX,skewY,regX,regY) {
		if(regY == null) regY = 0.0;
		if(regX == null) regX = 0.0;
		if(skewY == null) skewY = 0.0;
		if(skewX == null) skewX = 0.0;
		if(rotation == null) rotation = 0.0;
		if(scaleY == null) scaleY = 1.0;
		if(scaleX == null) scaleX = 1.0;
		var sin;
		var cos;
		if(rotation % 360 != 0) {
			var r = rotation * nanofl_engine_geom_Matrix.DEG_TO_RAD;
			cos = Math.cos(r);
			sin = Math.sin(r);
		} else {
			cos = 1;
			sin = 0;
		}
		this.tx -= regX;
		this.ty -= regY;
		if(skewX != 0 || skewY != 0) {
			skewX *= nanofl_engine_geom_Matrix.DEG_TO_RAD;
			skewY *= nanofl_engine_geom_Matrix.DEG_TO_RAD;
			this.prepend(cos * scaleX,sin * scaleX,-sin * scaleY,cos * scaleY,0,0);
			this.prepend(Math.cos(skewY),Math.sin(skewY),-Math.sin(skewX),Math.cos(skewX),x,y);
		} else this.prepend(cos * scaleX,sin * scaleX,-sin * scaleY,cos * scaleY,x,y);
		return this;
	}
	,rotate: function(angle) {
		var cos = Math.cos(angle);
		var sin = Math.sin(angle);
		var a1 = this.a;
		var c1 = this.c;
		var tx1 = this.tx;
		this.a = a1 * cos - this.b * sin;
		this.b = a1 * sin + this.b * cos;
		this.c = c1 * cos - this.d * sin;
		this.d = c1 * sin + this.d * cos;
		this.tx = tx1 * cos - this.ty * sin;
		this.ty = tx1 * sin + this.ty * cos;
		return this;
	}
	,skew: function(skewX,skewY) {
		skewX = skewX * nanofl_engine_geom_Matrix.DEG_TO_RAD;
		skewY = skewY * nanofl_engine_geom_Matrix.DEG_TO_RAD;
		this.append(Math.cos(skewY),Math.sin(skewY),-Math.sin(skewX),Math.cos(skewX),0,0);
		return this;
	}
	,scale: function(kx,ky) {
		this.a *= kx;
		this.d *= ky;
		this.c *= kx;
		this.b *= ky;
		this.tx *= kx;
		this.ty *= ky;
		return this;
	}
	,createGradientBox: function(width,height,rotation,tx,ty) {
		if(ty == null) ty = 0.0;
		if(tx == null) tx = 0.0;
		if(rotation == null) rotation = 0.0;
		this.a = width / 1638.4;
		this.d = height / 1638.4;
		if(rotation != 0) {
			var cos = Math.cos(rotation);
			var sin = Math.sin(rotation);
			this.b = sin * this.d;
			this.c = -sin * this.a;
			this.a *= cos;
			this.d *= cos;
		} else {
			this.b = 0;
			this.c = 0;
		}
		this.tx = tx + width / 2;
		this.ty = ty + height / 2;
		return this;
	}
	,getAverageScale: function() {
		return (Math.sqrt(this.a * this.a + this.c * this.c) + Math.sqrt(this.b * this.b + this.d * this.d)) / 2;
	}
	,toMatrix2D: function() {
		return new createjs.Matrix2D(this.a,this.b,this.c,this.d,this.tx,this.ty);
	}
	,toArray: function() {
		return [this.a,this.b,this.c,this.d,this.tx,this.ty];
	}
	,toString: function() {
		return "Matrix(" + this.a + ", " + this.b + ", " + this.c + ", " + this.d + ", " + this.tx + ", " + this.ty + ")";
	}
	,__class__: nanofl_engine_geom_Matrix
};
var nanofl_engine_geom_PointTools = function() { };
$hxClasses["nanofl.engine.geom.PointTools"] = nanofl_engine_geom_PointTools;
nanofl_engine_geom_PointTools.__name__ = ["nanofl","engine","geom","PointTools"];
nanofl_engine_geom_PointTools.half = function(pt) {
	var ix = pt.x | 0;
	pt.x = ix + (ix > pt.x?-0.5:0.5);
	var iy = pt.y | 0;
	pt.y = iy + (iy > pt.y?-0.5:0.5);
	return pt;
};
nanofl_engine_geom_PointTools.round = function(pt) {
	pt.x = Math.round(pt.x);
	pt.y = Math.round(pt.y);
	return pt;
};
nanofl_engine_geom_PointTools.normalize = function(pt) {
	var len = nanofl_engine_geom_PointTools.getLength(pt);
	if(len != 0) {
		pt.x /= len;
		pt.y /= len;
	}
	return pt;
};
nanofl_engine_geom_PointTools.getLength = function(pt) {
	return Math.sqrt(pt.x * pt.x + pt.y * pt.y);
};
nanofl_engine_geom_PointTools.getDist = function(x1,y1,x2,y2) {
	var dx = x2 - x1;
	var dy = y2 - y1;
	return Math.sqrt(dx * dx + dy * dy);
};
nanofl_engine_geom_PointTools.getSqrDist = function(x1,y1,x2,y2) {
	var dx = x2 - x1;
	var dy = y2 - y1;
	return dx * dx + dy * dy;
};
nanofl_engine_geom_PointTools.getDistP = function(a,b) {
	return nanofl_engine_geom_PointTools.getDist(a.x,a.y,b.x,b.y);
};
nanofl_engine_geom_PointTools.getSqrDistP = function(a,b) {
	return nanofl_engine_geom_PointTools.getSqrDist(a.x,a.y,b.x,b.y);
};
nanofl_engine_geom_PointTools.rotate = function(x,y,da) {
	return { x : x * Math.cos(da) - y * Math.sin(da), y : y * Math.cos(da) + x * Math.sin(da)};
};
nanofl_engine_geom_PointTools.getRotated = function(pt,da) {
	return nanofl_engine_geom_PointTools.rotate(pt.x,pt.y,da);
};
nanofl_engine_geom_PointTools.moveInDirection = function(start,endX,endY,len) {
	var v = { x : endX - start.x, y : endY - start.y};
	var l = nanofl_engine_geom_PointTools.getLength(v);
	nanofl_engine_geom_PointTools.normalize(v);
	var k = Math.min(len,l);
	start.x = v.x * k + start.x;
	start.y = v.y * k + start.y;
	return start;
};
nanofl_engine_geom_PointTools.equ = function(pt1,pt2) {
	return pt1.x == pt2.x && pt1.y == pt2.y;
};
nanofl_engine_geom_PointTools.clone = function(pt) {
	return { x : pt.x, y : pt.y};
};
nanofl_engine_geom_PointTools.roundGap = function(n) {
	return Math.round(n * 100) / 100;
};
nanofl_engine_geom_PointTools.roundGapP = function(pt) {
	pt.x = nanofl_engine_geom_PointTools.roundGap(pt.x);
	pt.y = nanofl_engine_geom_PointTools.roundGap(pt.y);
	return pt;
};
nanofl_engine_geom_PointTools.getNearest = function(pt,points) {
	if(points == null || points.length == 0) return null;
	var bestP = points[0];
	var bestD = nanofl_engine_geom_PointTools.getSqrDist(pt.x,pt.y,bestP.x,bestP.y);
	var _g = 0;
	while(_g < points.length) {
		var point = points[_g];
		++_g;
		var dist = nanofl_engine_geom_PointTools.getSqrDist(pt.x,pt.y,point.x,point.y);
		if(dist < bestD) {
			bestP = point;
			bestD = dist;
		}
	}
	return bestP;
};
nanofl_engine_geom_PointTools.toString = function(pt) {
	if(pt != null) return pt.x + "," + pt.y; else return "null";
};
var nanofl_engine_geom_Polygon = function(fill,contours,selected) {
	if(selected == null) selected = false;
	this.fill = fill;
	if(contours != null) this.contours = contours; else this.contours = [];
	this.selected = selected;
};
$hxClasses["nanofl.engine.geom.Polygon"] = nanofl_engine_geom_Polygon;
nanofl_engine_geom_Polygon.__name__ = ["nanofl","engine","geom","Polygon"];
nanofl_engine_geom_Polygon.__interfaces__ = [nanofl_engine_ISelectable];
nanofl_engine_geom_Polygon.load = function(node,fills,version) {
	stdlib_Debug.assert(node.name == "polygon",null,{ fileName : "Polygon.hx", lineNumber : 34, className : "nanofl.engine.geom.Polygon", methodName : "load"});
	var fillIndex = Std["int"](htmlparser_HtmlParserTools.getAttr(node,"fillIndex",-1));
	stdlib_Debug.assert(fillIndex != null,null,{ fileName : "Polygon.hx", lineNumber : 37, className : "nanofl.engine.geom.Polygon", methodName : "load"});
	stdlib_Debug.assert(fillIndex >= 0,null,{ fileName : "Polygon.hx", lineNumber : 38, className : "nanofl.engine.geom.Polygon", methodName : "load"});
	stdlib_Debug.assert(fillIndex < fills.length,null,{ fileName : "Polygon.hx", lineNumber : 39, className : "nanofl.engine.geom.Polygon", methodName : "load"});
	var contours = [];
	var _g = 0;
	var _g1 = node.children;
	while(_g < _g1.length) {
		var node1 = _g1[_g];
		++_g;
		if(node1.name == "contour") contours.push(new nanofl_engine_geom_Contour(nanofl_engine_geom_Edges.load(htmlparser_HtmlParserTools.getAttr(node1,"edges"))));
	}
	return new nanofl_engine_geom_Polygon(fills[fillIndex],contours);
};
nanofl_engine_geom_Polygon.prototype = {
	contours: null
	,fill: null
	,selected: null
	,save: function(fills,out) {
		out.begin("polygon").attr("fillIndex",this.getFillIndex(fills));
		var _g = 0;
		var _g1 = this.contours;
		while(_g < _g1.length) {
			var c = _g1[_g];
			++_g;
			c.save(out);
		}
		out.end();
	}
	,draw: function(g,scaleSelection) {
		this.fill.begin(g);
		var _g = 0;
		var _g1 = this.contours;
		while(_g < _g1.length) {
			var contour = _g1[_g];
			++_g;
			contour.draw(g);
		}
		g.endFill();
		if(nanofl_engine_geom_Polygon.showSelection && this.selected) {
			new nanofl_engine_fills_SelectionFill(scaleSelection).begin(g);
			var _g2 = 0;
			var _g11 = this.contours;
			while(_g2 < _g11.length) {
				var contour1 = _g11[_g2];
				++_g2;
				contour1.draw(g);
			}
			g.endFill();
		}
	}
	,translate: function(dx,dy) {
		if(this.fill != null) this.fill = this.fill.getTransformed(new nanofl_engine_geom_Matrix(1,0,0,1,dx,dy));
		var _g = 0;
		var _g1 = this.contours;
		while(_g < _g1.length) {
			var c = _g1[_g];
			++_g;
			c.translate(dx,dy);
		}
	}
	,isPointInside: function(px,py) {
		return this.contours[0].isPointInside(px,py) && ((function(_e) {
			return function(f) {
				return Lambda.foreach(_e,f);
			};
		})(this.contours.slice(1)))(function(_) {
			return !_.isPointInside(px,py);
		});
	}
	,getFillIndex: function(fills) {
		var _g = this;
		var r = stdlib_LambdaIterable.findIndex(fills,function(f) {
			return f.equ(_g.fill);
		});
		if(r < 0) {
			r = fills.length;
			fills.push(this.fill);
		}
		return r;
	}
	,hasPoint: function(px,py) {
		var _g = 0;
		var _g1 = this.contours;
		while(_g < _g1.length) {
			var contour = _g1[_g];
			++_g;
			if(contour.hasPoint(px,py)) return true;
		}
		return false;
	}
	,hasEdge: function(edge) {
		var _g = 0;
		var _g1 = this.contours;
		while(_g < _g1.length) {
			var c = _g1[_g];
			++_g;
			if(c.hasEdge(edge)) return true;
		}
		return false;
	}
	,isEdgeInside: function(edge) {
		stdlib_Debug.assert(this.contours.length > 0,null,{ fileName : "Polygon.hx", lineNumber : 112, className : "nanofl.engine.geom.Polygon", methodName : "isEdgeInside"});
		return this.contours[0].isEdgeInside(edge) && Lambda.foreach(this.contours.slice(1),function(c) {
			return !c.isEdgeInside(edge);
		});
	}
	,isEdgeAtLeastPartiallyInside: function(edge) {
		var m = edge.getMiddlePoint();
		return !this.hasPoint(m.x,m.y) && this.isPointInside(m.x,m.y) || !this.hasPoint(edge.x1,edge.y1) && this.isPointInside(edge.x1,edge.y1) || !this.hasPoint(edge.x3,edge.y3) && this.isPointInside(edge.x3,edge.y3);
	}
	,isPolygonInside: function(p) {
		stdlib_Debug.assert(this.contours.length > 0,null,{ fileName : "Polygon.hx", lineNumber : 126, className : "nanofl.engine.geom.Polygon", methodName : "isPolygonInside"});
		stdlib_Debug.assert(p.contours.length > 0,null,{ fileName : "Polygon.hx", lineNumber : 127, className : "nanofl.engine.geom.Polygon", methodName : "isPolygonInside"});
		var _g = 0;
		var _g1 = p.contours[0].edges;
		while(_g < _g1.length) {
			var edge = _g1[_g];
			++_g;
			if(!this.isEdgeInside(edge)) return false;
		}
		var _g11 = 1;
		var _g2 = this.contours.length;
		while(_g11 < _g2) {
			var i = _g11++;
			var _g21 = 0;
			var _g3 = this.contours[i].edges;
			while(_g21 < _g3.length) {
				var edge1 = _g3[_g21];
				++_g21;
				if(p.isEdgeInside(edge1)) return false;
			}
		}
		return true;
	}
	,translateVertex: function(point,dx,dy) {
		var _g = 0;
		var _g1 = this.contours;
		while(_g < _g1.length) {
			var contour = _g1[_g];
			++_g;
			var _g2 = 0;
			var _g3 = contour.edges;
			while(_g2 < _g3.length) {
				var edge = _g3[_g2];
				++_g2;
				edge.translateVertex(point,dx,dy);
			}
		}
	}
	,getBounds: function(bounds) {
		if(this.contours.length > 0) {
			if(bounds == null) bounds = { minX : 1e10, minY : 1e10, maxX : -1e10, maxY : -1e10};
			var _g = 0;
			var _g1 = this.contours;
			while(_g < _g1.length) {
				var contour = _g1[_g];
				++_g;
				nanofl_engine_geom_Edges.getBounds(contour.edges,bounds);
			}
			return bounds;
		}
		if(bounds != null) return bounds; else return { minX : 0.0, minY : 0.0, maxX : 0.0, maxY : 0.0};
	}
	,applyFill: function(fill,x1,y1,x2,y2) {
		{
			var _g = fill.getTyped();
			switch(_g[1]) {
			case 0:
				var fill1 = _g[2];
				this.fill = fill1.clone();
				break;
			case 1:
				var fill2 = _g[2];
				fill2 = fill2.clone();
				if(this.fill == null || Type.enumIndex(this.fill.getTyped()) != Type.enumIndex(fill2.getTyped()) || x1 != null) {
					var len;
					if(x1 == null || x1 == x2 && y1 == y2) {
						var bounds = this.getBounds();
						len = bounds.maxX - bounds.minX;
						x1 = bounds.minX;
						x2 = bounds.maxX;
						y1 = y2 = bounds.minY;
					} else len = nanofl_engine_geom_PointTools.getDist(x1,y1,x2,y2);
					fill2.x0 = x1;
					fill2.y0 = y1;
					fill2.x1 = x2;
					fill2.y1 = y2;
				} else {
					var t;
					t = js_Boot.__cast(this.fill , nanofl_engine_fills_LinearFill);
					fill2.x0 = t.x0;
					fill2.y0 = t.y0;
					fill2.x1 = t.x1;
					fill2.y1 = t.y1;
				}
				this.fill = fill2;
				break;
			case 2:
				var fill3 = _g[2];
				fill3 = fill3.clone();
				if(this.fill == null || Type.enumIndex(this.fill.getTyped()) != Type.enumIndex(fill3.getTyped()) || x1 != null) {
					var len1;
					if(x1 == null || x1 == x2 && y1 == y2) {
						var bounds1 = this.getBounds();
						len1 = Math.max(bounds1.maxX - bounds1.minX,bounds1.maxY - bounds1.minY) / 2;
						x1 = (bounds1.minX + bounds1.maxX) / 2;
						y1 = (bounds1.minY + bounds1.maxY) / 2;
					} else len1 = nanofl_engine_geom_PointTools.getDist(x1,y1,x2,y2);
					fill3.cx = x1;
					fill3.cy = y1;
					fill3.r = len1;
					fill3.fx = x1;
					fill3.fy = y1;
				} else {
					var t1;
					t1 = js_Boot.__cast(this.fill , nanofl_engine_fills_RadialFill);
					fill3.cx = t1.cx;
					fill3.cy = t1.cy;
					fill3.r = t1.r;
					fill3.fx = t1.fx;
					fill3.fy = t1.fy;
				}
				this.fill = fill3;
				break;
			case 3:
				var fill4 = _g[2];
				fill4 = fill4.clone();
				var len2;
				if(x1 != null) fill4.repeat = "repeat"; else fill4.repeat = "no-repeat";
				var bitmapWidth = fill4.getBitmapWidth();
				if(x1 == null || x1 == x2 && y1 == y2) {
					var bounds2 = this.getBounds();
					len2 = bounds2.maxX - bounds2.minX;
					x1 = bounds2.minX;
					x2 = bounds2.minX + bitmapWidth;
					y1 = y2 = bounds2.minY;
				} else len2 = nanofl_engine_geom_PointTools.getDist(x1,y1,x2,y2);
				fill4.matrix = new nanofl_engine_geom_Matrix();
				fill4.matrix.scale(len2 / bitmapWidth,len2 / bitmapWidth);
				if(x1 != x2 || y1 != y2) fill4.matrix.rotate(Math.atan2(y2 - y1,x2 - x1));
				fill4.matrix.translate(x1,y1);
				this.fill = fill4;
				break;
			}
		}
	}
	,transform: function(m,applyToFill) {
		if(applyToFill == null) applyToFill = true;
		var _g = 0;
		var _g1 = this.contours;
		while(_g < _g1.length) {
			var contour = _g1[_g];
			++_g;
			var _g2 = 0;
			var _g3 = contour.edges;
			while(_g2 < _g3.length) {
				var edge = _g3[_g2];
				++_g2;
				edge.transform(m);
			}
		}
		if(applyToFill && this.fill != null) this.fill = this.fill.getTransformed(m);
	}
	,getEdges: function(edges) {
		if(edges == null) edges = [];
		var _g = 0;
		var _g1 = this.contours;
		while(_g < _g1.length) {
			var contour = _g1[_g];
			++_g;
			nanofl_engine_geom_Edges.appendUnique(edges,contour.edges);
		}
		return edges;
	}
	,getPointInside: function() {
		var bounds = this.getBounds();
		var yy = [bounds.minY,bounds.maxY];
		var _g = 0;
		var _g1 = this.getEdges();
		while(_g < _g1.length) {
			var edge = _g1[_g];
			++_g;
			yy.push(edge.y1);
		}
		yy.sort(Reflect.compare);
		var maxDY = 0.0;
		var rY = yy[0];
		var _g11 = 1;
		var _g2 = yy.length;
		while(_g11 < _g2) {
			var i1 = _g11++;
			if(yy[i1] - yy[i1 - 1] > maxDY) {
				maxDY = yy[i1] - yy[i1 - 1];
				rY = (yy[i1] + yy[i1 - 1]) / 2;
			}
		}
		var xx = [];
		var _g3 = 0;
		var _g12 = this.contours;
		while(_g3 < _g12.length) {
			var contour = _g12[_g3];
			++_g3;
			var _g21 = 0;
			var _g31 = contour.edges;
			while(_g21 < _g31.length) {
				var edge1 = _g31[_g21];
				++_g21;
				var _g4 = 0;
				var _g5 = edge1.getIntersectionPointsX_rightRay(-1.0e100,rY);
				while(_g4 < _g5.length) {
					var x = _g5[_g4];
					++_g4;
					xx.push(x);
				}
			}
			stdlib_Debug.assert(xx.length % 2 == 0,"Polygon.getPointInside() error\nxx = " + Std.string(xx) + "\nrY = " + rY + "\nedges = " + Std.string(contour.edges),{ fileName : "Polygon.hx", lineNumber : 335, className : "nanofl.engine.geom.Polygon", methodName : "getPointInside"});
		}
		xx.sort(Reflect.compare);
		var maxDX = 0.0;
		var rX = xx[0];
		var i = 1;
		while(i < xx.length) {
			if(xx[i] - xx[i - 1] > maxDX) {
				maxDX = xx[i] - xx[i - 1];
				rX = (xx[i] + xx[i - 1]) / 2;
			}
			i += 2;
		}
		return { x : rX, y : rY};
	}
	,clone: function() {
		return new nanofl_engine_geom_Polygon(this.fill.clone(),nanofl_engine_ArrayTools.clone(this.contours),this.selected);
	}
	,replaceEdge: function(search,replacement) {
		var _g = 0;
		var _g1 = this.contours;
		while(_g < _g1.length) {
			var contour = _g1[_g];
			++_g;
			nanofl_engine_geom_Edges.replaceAll(contour.edges,search,replacement);
		}
	}
	,'export': function(out,fills) {
		var fillIndex = -1;
		var _g1 = 0;
		var _g = fills.length;
		while(_g1 < _g) {
			var i = _g1++;
			if(fills[i].equ(this.fill)) {
				fillIndex = i;
				break;
			}
		}
		if(fillIndex == -1) {
			fillIndex = fills.length;
			fills.push(this.fill);
		}
		out.begin("polygon").attr("fillIndex",fillIndex);
		var _g2 = 0;
		var _g11 = this.contours;
		while(_g2 < _g11.length) {
			var c = _g11[_g2];
			++_g2;
			out.begin("contour");
			nanofl_engine_geom_Edges["export"](c.edges,out);
			out.end();
		}
		out.end();
	}
	,split: function() {
		var outers = [];
		var _g = 0;
		var _g1 = this.contours;
		while(_g < _g1.length) {
			var contour = [_g1[_g]];
			++_g;
			if(Lambda.foreach(this.contours,(function(contour) {
				return function(c) {
					return c == contour[0] || !contour[0].isNestedTo(c);
				};
			})(contour))) outers.push(contour[0]);
		}
		if(outers.length == 1) return [this];
		var r = [];
		var _g2 = 0;
		while(_g2 < outers.length) {
			var outer = [outers[_g2]];
			++_g2;
			var inners = this.contours.filter((function(outer) {
				return function(c1) {
					return c1 != outer[0] && c1.isNestedTo(outer[0]);
				};
			})(outer));
			inners.unshift(outer[0]);
			r.push(new nanofl_engine_geom_Polygon(this.fill,inners));
		}
		return r;
	}
	,equ: function(p) {
		if(p.contours.length != this.contours.length) return false;
		return Lambda.foreach(this.contours,function(a) {
			return Lambda.exists(p.contours,function(b) {
				return a.equ(b);
			});
		});
	}
	,normalize: function() {
		var i = 0;
		while(i < this.contours.length) {
			this.contours[i].normalize();
			if(this.contours[i].edges.length <= 1) this.contours.splice(i,1); else i++;
		}
	}
	,isInRectangle: function(x,y,width,height) {
		var _g = 0;
		var _g1 = this.contours[0].edges;
		while(_g < _g1.length) {
			var edge = _g1[_g];
			++_g;
			if(!edge.isInRectangle(x,y,width,height)) return false;
		}
		return true;
	}
	,assertCorrect: function() {
	}
	,isContourOutside: function(c) {
		var allEdges = this.getEdges();
		var _g = 0;
		var _g1 = c.edges;
		while(_g < _g1.length) {
			var e = [_g1[_g]];
			++_g;
			if(!this.hasPoint(e[0].x3,e[0].y3) && !Lambda.exists(allEdges,(function(e) {
				return function(ee) {
					return ee.y3 == e[0].y3;
				};
			})(e)) && this.isPointInside(e[0].x3,e[0].y3)) return false;
		}
		return true;
	}
	,fixErrors: function() {
		var r = [];
		var tree = nanofl_engine_geom_Contours.getTree(this.contours);
		this.collectPolygonsByContourTree(tree,r);
		var _g = 0;
		while(_g < r.length) {
			var p = r[_g];
			++_g;
			p.fixContoursDirection();
		}
		return r;
	}
	,collectPolygonsByContourTree: function(tree,dest) {
		var _g = 0;
		while(_g < tree.length) {
			var p = tree[_g];
			++_g;
			dest.push(new nanofl_engine_geom_Polygon(this.fill,[p.parent].concat(p.children.map(function(_) {
				return _.parent;
			}))));
			var _g1 = 0;
			var _g2 = p.children;
			while(_g1 < _g2.length) {
				var c = _g2[_g1];
				++_g1;
				this.collectPolygonsByContourTree(c.children,dest);
			}
		}
	}
	,fixContoursDirection: function() {
		if(this.contours[0].getClockwiseProduct() < 0) this.contours[0].reverse();
		var _g = 0;
		var _g1 = this.contours.slice(1);
		while(_g < _g1.length) {
			var contour = _g1[_g];
			++_g;
			if(contour.getClockwiseProduct() > 0) contour.reverse();
		}
	}
	,toString: function() {
		return "new Polygon(" + Std.string(this.fill) + ", " + Std.string(this.contours) + ")";
	}
	,__class__: nanofl_engine_geom_Polygon
};
var nanofl_engine_geom_Polygons = function() { };
$hxClasses["nanofl.engine.geom.Polygons"] = nanofl_engine_geom_Polygons;
nanofl_engine_geom_Polygons.__name__ = ["nanofl","engine","geom","Polygons"];
nanofl_engine_geom_Polygons.findByPoint = function(polygons,x,y) {
	var _g = 0;
	while(_g < polygons.length) {
		var p = polygons[_g];
		++_g;
		if(p.isPointInside(x,y)) return p;
	}
	return null;
};
nanofl_engine_geom_Polygons.isEdgeInside = function(polygons,edge) {
	var _g = 0;
	while(_g < polygons.length) {
		var p = polygons[_g];
		++_g;
		if(p.isEdgeInside(edge)) return true;
	}
	return false;
};
nanofl_engine_geom_Polygons.mergeByCommonEdges = function(polygons,edges) {
	stdlib_Debug.assert(!nanofl_engine_geom_Polygons.hasDublicates(polygons),null,{ fileName : "Polygons.hx", lineNumber : 32, className : "nanofl.engine.geom.Polygons", methodName : "mergeByCommonEdges"});
	nanofl_engine_geom_Polygons.assertCorrect(polygons,false);
	nanofl_engine_geom_Polygons.log(function() {
		return "mergeByCommonEdges\npolygons =\n" + polygons.map(function(p) {
			return "\t" + Std.string(p);
		}).join("\n") + "\nedges = " + edges.join("; ");
	},{ fileName : "Polygons.hx", lineNumber : 35, className : "nanofl.engine.geom.Polygons", methodName : "mergeByCommonEdges"});
	var i = 0;
	while(i < polygons.length) {
		var j = [i + 1];
		while(j[0] < polygons.length) {
			nanofl_engine_geom_Polygons.log((function(j) {
				return function() {
					return "test i=" + i + " and j=" + j[0] + "\n\t\t" + polygons[i].toString() + "\n\t\t" + Std.string(polygons[j[0]]);
				};
			})(j),{ fileName : "Polygons.hx", lineNumber : 42, className : "nanofl.engine.geom.Polygons", methodName : "mergeByCommonEdges"});
			if(polygons[i].fill.equ(polygons[j[0]].fill)) {
				nanofl_engine_geom_Polygons.log((function() {
					return function() {
						return "\tfill match!";
					};
				})(),{ fileName : "Polygons.hx", lineNumber : 45, className : "nanofl.engine.geom.Polygons", methodName : "mergeByCommonEdges"});
				stdlib_Debug.assert(polygons[i].contours.length > 0,null,{ fileName : "Polygons.hx", lineNumber : 46, className : "nanofl.engine.geom.Polygons", methodName : "mergeByCommonEdges"});
				stdlib_Debug.assert(polygons[j[0]].contours.length > 0,null,{ fileName : "Polygons.hx", lineNumber : 47, className : "nanofl.engine.geom.Polygons", methodName : "mergeByCommonEdges"});
				var commonEdges = [nanofl_engine_geom_Edges.getCommon(polygons[i].contours[0].edges,polygons[j[0]].contours[0].edges)];
				nanofl_engine_geom_Polygons.log((function(commonEdges) {
					return function() {
						return "\tcommonEdges = " + Std.string(commonEdges[0]);
					};
				})(commonEdges),{ fileName : "Polygons.hx", lineNumber : 50, className : "nanofl.engine.geom.Polygons", methodName : "mergeByCommonEdges"});
				if(commonEdges[0].length > 0 && Lambda.foreach(commonEdges[0],(function() {
					return function(e) {
						return e.indexIn(edges) < 0;
					};
				})())) {
					var outerEdges = nanofl_engine_geom_Edges.exclude(nanofl_engine_geom_Edges.concatUnique(polygons[i].contours[0].edges,polygons[j[0]].contours[0].edges),commonEdges[0]);
					nanofl_engine_geom_Polygons.log("\tMERGE!",{ fileName : "Polygons.hx", lineNumber : 55, className : "nanofl.engine.geom.Polygons", methodName : "mergeByCommonEdges"});
					if(outerEdges.length > 0) {
						var outerContours = nanofl_engine_geom_Contours.fromEdges(outerEdges);
						outerContours.sort((function() {
							return function(a,b) {
								if(a.isNestedTo(b)) return 1; else return -1;
							};
						})());
						var _g1 = 1;
						var _g = outerContours.length;
						while(_g1 < _g) {
							var k = _g1++;
							outerContours[k].reverse();
						}
						var inners = outerContours.slice(1).concat(polygons[i].contours.slice(1)).concat(polygons[j[0]].contours.slice(1));
						nanofl_engine_geom_Contours.removeNested(inners);
						nanofl_engine_geom_Contours.mergeByCommonEdges(inners,true);
						polygons[i] = new nanofl_engine_geom_Polygon(polygons[i].fill,[outerContours[0]].concat(inners));
						polygons[i].assertCorrect();
					} else stdlib_Debug.assert(false,(function() {
						return function() {
							return "Two polygons with same outer contour = " + Std.string(polygons[i].contours[0]);
						};
					})(),{ fileName : "Polygons.hx", lineNumber : 78, className : "nanofl.engine.geom.Polygons", methodName : "mergeByCommonEdges"});
					nanofl_engine_geom_Polygons.log("\tRemove polygon " + j[0],{ fileName : "Polygons.hx", lineNumber : 82, className : "nanofl.engine.geom.Polygons", methodName : "mergeByCommonEdges"});
					polygons.splice(j[0],1);
					if(outerEdges.length > 0) j[0] = i; else j[0]--;
					nanofl_engine_geom_Polygons.log("\tj = " + j[0],{ fileName : "Polygons.hx", lineNumber : 88, className : "nanofl.engine.geom.Polygons", methodName : "mergeByCommonEdges"});
				}
			}
			j[0]++;
		}
		i++;
	}
	nanofl_engine_geom_Polygons.log("==================================== in the middle ==========================",{ fileName : "Polygons.hx", lineNumber : 96, className : "nanofl.engine.geom.Polygons", methodName : "mergeByCommonEdges"});
	nanofl_engine_geom_Polygons.log(function() {
		return "// SOURCE:\n\t" + polygons.join("\n\t");
	},{ fileName : "Polygons.hx", lineNumber : 97, className : "nanofl.engine.geom.Polygons", methodName : "mergeByCommonEdges"});
	nanofl_engine_geom_Polygons.assertCorrect(polygons,false);
	var i1 = 0;
	while(i1 < polygons.length) {
		var j1 = [0];
		while(j1[0] < polygons.length) {
			if(i1 != j1[0] && polygons[i1].fill.equ(polygons[j1[0]].fill)) {
				stdlib_Debug.assert(polygons[i1].contours.length > 0,null,{ fileName : "Polygons.hx", lineNumber : 108, className : "nanofl.engine.geom.Polygons", methodName : "mergeByCommonEdges"});
				stdlib_Debug.assert(polygons[j1[0]].contours.length > 0,null,{ fileName : "Polygons.hx", lineNumber : 109, className : "nanofl.engine.geom.Polygons", methodName : "mergeByCommonEdges"});
				var outerJ = polygons[j1[0]].contours[0];
				var _g11 = 1;
				var _g2 = polygons[i1].contours.length;
				while(_g11 < _g2) {
					var k1 = _g11++;
					var innerI = polygons[i1].contours[k1];
					var commonEdges1 = [nanofl_engine_geom_Edges.getCommon(innerI.edges,outerJ.edges)];
					nanofl_engine_geom_Polygons.log((function(commonEdges1) {
						return function() {
							return "\tcommonEdges = " + Std.string(commonEdges1[0]);
						};
					})(commonEdges1),{ fileName : "Polygons.hx", lineNumber : 118, className : "nanofl.engine.geom.Polygons", methodName : "mergeByCommonEdges"});
					if(commonEdges1[0].length > 0 && Lambda.foreach(commonEdges1[0],(function() {
						return function(e1) {
							return e1.indexIn(edges) < 0;
						};
					})())) {
						var innerEdges = [nanofl_engine_geom_Edges.exclude(nanofl_engine_geom_Edges.concatUnique(innerI.edges,outerJ.edges),commonEdges1[0])];
						nanofl_engine_geom_Polygons.log((function(innerEdges) {
							return function() {
								return "\tinnerEdges = " + Std.string(innerEdges[0]);
							};
						})(innerEdges),{ fileName : "Polygons.hx", lineNumber : 122, className : "nanofl.engine.geom.Polygons", methodName : "mergeByCommonEdges"});
						nanofl_engine_geom_Polygons.log((function(j1) {
							return function() {
								return "// MERGE " + i1 + " and " + j1[0] + "\n\t" + Std.string(polygons[i1]) + "\n\t" + Std.string(polygons[j1[0]]);
							};
						})(j1),{ fileName : "Polygons.hx", lineNumber : 124, className : "nanofl.engine.geom.Polygons", methodName : "mergeByCommonEdges"});
						polygons[i1].contours.splice(k1,1);
						if(innerEdges[0].length > 0) {
							var inners1 = nanofl_engine_geom_Contours.fromEdges(innerEdges[0]);
							var _g21 = 0;
							while(_g21 < inners1.length) {
								var c = inners1[_g21];
								++_g21;
								c.reverse();
							}
							inners1 = inners1.concat(polygons[j1[0]].contours.slice(1));
							polygons[i1].contours = polygons[i1].contours.concat(inners1);
							polygons[i1].assertCorrect();
						} else {
							polygons[i1].contours = polygons[i1].contours.concat(polygons[j1[0]].contours.slice(1));
							polygons[i1].assertCorrect();
						}
						nanofl_engine_geom_Polygons.log((function() {
							return function() {
								return "// RESULT\n\t" + Std.string(polygons[i1]);
							};
						})(),{ fileName : "Polygons.hx", lineNumber : 142, className : "nanofl.engine.geom.Polygons", methodName : "mergeByCommonEdges"});
						polygons.splice(j1[0],1);
						if(i1 > j1[0]) i1--;
						j1[0] = -1;
						break;
					}
				}
			}
			j1[0]++;
		}
		i1++;
	}
	nanofl_engine_geom_Polygons.assertCorrect(polygons,true);
};
nanofl_engine_geom_Polygons.removeDublicates = function(polygons) {
	var i = 0;
	while(i < polygons.length) {
		var j = i + 1;
		while(j < polygons.length) if(polygons[i].equ(polygons[j])) {
			polygons[i].fill = polygons[j].fill;
			polygons.splice(j,1);
		} else j++;
		i++;
	}
};
nanofl_engine_geom_Polygons.hasDublicates = function(polygons) {
	var _g1 = 0;
	var _g = polygons.length;
	while(_g1 < _g) {
		var i = _g1++;
		var _g3 = i + 1;
		var _g2 = polygons.length;
		while(_g3 < _g2) {
			var j = _g3++;
			if(polygons[i].equ(polygons[j])) return true;
		}
	}
	return false;
};
nanofl_engine_geom_Polygons.normalize = function(polygons) {
	var i = 0;
	while(i < polygons.length) {
		polygons[i].normalize();
		if(polygons[i].contours.length == 0) polygons.splice(i,1); else i++;
	}
	nanofl_engine_geom_Polygons.log("normalize > removeDublicates vvvvvvvvvvv",{ fileName : "Polygons.hx", lineNumber : 200, className : "nanofl.engine.geom.Polygons", methodName : "normalize"});
	nanofl_engine_geom_Polygons.removeDublicates(polygons);
	nanofl_engine_geom_Polygons.log("normalize > removeDublicates ^^^^^^^^^^^",{ fileName : "Polygons.hx", lineNumber : 202, className : "nanofl.engine.geom.Polygons", methodName : "normalize"});
	if(nanofl_engine_geom_Polygons.hasDublicates(polygons)) haxe_Log.trace("normalize > DUPS DETECTED!!!!!!!",{ fileName : "Polygons.hx", lineNumber : 204, className : "nanofl.engine.geom.Polygons", methodName : "normalize"});
};
nanofl_engine_geom_Polygons.getEdges = function(polygons) {
	var r = [];
	var _g = 0;
	while(_g < polygons.length) {
		var polygon = polygons[_g];
		++_g;
		var _g1 = 0;
		var _g2 = polygon.contours;
		while(_g1 < _g2.length) {
			var contour = _g2[_g1];
			++_g1;
			nanofl_engine_geom_Edges.appendUnique(r,contour.edges);
		}
	}
	return r;
};
nanofl_engine_geom_Polygons.getByPoint = function(polygons,pos) {
	var i = polygons.length - 1;
	while(i >= 0) {
		if(polygons[i].isPointInside(pos.x,pos.y)) return polygons[i];
		i--;
	}
	return null;
};
nanofl_engine_geom_Polygons.fromEdges = function(edges,strokeEdges,polygonsToDetectFill) {
	stdlib_Debug.assert(!nanofl_engine_geom_Edges.hasDegenerated(edges),"Degenerated edges detected.",{ fileName : "Polygons.hx", lineNumber : 234, className : "nanofl.engine.geom.Polygons", methodName : "fromEdges"});
	stdlib_Debug.assert(!nanofl_engine_geom_Edges.hasDuplicates(edges),"Duplicated edges detected.",{ fileName : "Polygons.hx", lineNumber : 235, className : "nanofl.engine.geom.Polygons", methodName : "fromEdges"});
	stdlib_Debug.assert(!nanofl_engine_geom_Edges.hasDuplicates(strokeEdges),"Duplicated strokeEdges detected.",{ fileName : "Polygons.hx", lineNumber : 236, className : "nanofl.engine.geom.Polygons", methodName : "fromEdges"});
	nanofl_engine_geom_Polygons.log(function() {
		return "Polygons.getReconstructed vvvvvvvvvvvvvvvvvvvvvvvv";
	},{ fileName : "Polygons.hx", lineNumber : 238, className : "nanofl.engine.geom.Polygons", methodName : "fromEdges"});
	var contours = nanofl_engine_geom_Contours.fromEdges(edges);
	var r = nanofl_engine_geom_Polygons.fromContours(contours,strokeEdges,function(polygon) {
		var pt = polygon.getPointInside();
		var original = nanofl_engine_geom_Polygons.getByPoint(polygonsToDetectFill,pt);
		if(original != null) return original.fill; else return null;
	});
	nanofl_engine_geom_Polygons.log(function() {
		return "Polygons.getReconstructed ^^^^^^^^^^^^^^^^^^^^^^^^ result =\n\t" + r.join(";\n\t");
	},{ fileName : "Polygons.hx", lineNumber : 249, className : "nanofl.engine.geom.Polygons", methodName : "fromEdges"});
	return r;
};
nanofl_engine_geom_Polygons.fromContours = function(contours,strokeEdges,getFill) {
	var r = [];
	var _g = 0;
	while(_g < contours.length) {
		var outer = contours[_g];
		++_g;
		var inners = [];
		var _g1 = 0;
		while(_g1 < contours.length) {
			var inner = contours[_g1];
			++_g1;
			if(inner != outer && inner.isNestedTo(outer)) inners.push(inner.clone().reverse());
		}
		nanofl_engine_geom_Contours.removeNested(inners);
		nanofl_engine_geom_Contours.mergeByCommonEdges(inners,true);
		var polygon = new nanofl_engine_geom_Polygon(null,[outer].concat(inners));
		polygon.assertCorrect();
		var fill = getFill(polygon);
		if(fill != null) {
			polygon.fill = fill;
			r.push(polygon);
		}
	}
	nanofl_engine_geom_Polygons.mergeByCommonEdges(r,strokeEdges);
	return r;
};
nanofl_engine_geom_Polygons.fromRawContours = function(originalContours,fill,fillEvenOdd) {
	return nanofl_engine_geom_Polygons.fromRawContoursInner(originalContours,fill,fillEvenOdd);
};
nanofl_engine_geom_Polygons.fromRawContoursInner = function(originalContours,fill,fillEvenOdd) {
	var edges = nanofl_engine_geom_Contours.getEdges(originalContours);
	nanofl_engine_geom_Polygons.log(function() {
		return "\n\nPolygons.fromContours vvvvvvvvvvvvvvvvvvvvvvvvv edges = " + edges.length;
	},{ fileName : "Polygons.hx", lineNumber : 312, className : "nanofl.engine.geom.Polygons", methodName : "fromRawContoursInner"});
	var originalContoursNormalized = new haxe_ds_ObjectMap();
	var _g1 = 0;
	while(_g1 < originalContours.length) {
		var c1 = originalContours[_g1];
		++_g1;
		var ee = c1.edges.slice();
		nanofl_engine_geom_Edges.normalize(ee);
		nanofl_engine_geom_Edges.intersectSelf(ee);
		var value = nanofl_engine_geom_Contours.fromEdges(ee);
		originalContoursNormalized.set(c1,value);
	}
	stdlib_Debug.assert(HxOverrides.indexOf(edges,null,0) < 0,null,{ fileName : "Polygons.hx", lineNumber : 323, className : "nanofl.engine.geom.Polygons", methodName : "fromRawContoursInner"});
	nanofl_engine_geom_Edges.normalize(edges);
	nanofl_engine_geom_Edges.intersectSelf(edges);
	var contours = nanofl_engine_geom_Contours.fromEdges(edges);
	var r = nanofl_engine_geom_Polygons.fromContours(contours,[],function(polygon) {
		var pt = polygon.getPointInside();
		var edgesToTestFilling = [];
		var _g = 0;
		while(_g < originalContours.length) {
			var contour = originalContours[_g];
			++_g;
			if(Lambda.exists(originalContoursNormalized.h[contour.__id__],function(c) {
				return c.isPointInsideP(pt);
			})) edgesToTestFilling = edgesToTestFilling.concat(contour.edges);
		}
		if(nanofl_engine_geom_Edges.isPointInside(edgesToTestFilling,pt.x,pt.y,fillEvenOdd)) return fill; else return null;
	});
	nanofl_engine_geom_Polygons.log(function() {
		return "Polygons.fromContours ^^^^^^^^^^^^^^^^^^^^^^^^^";
	},{ fileName : "Polygons.hx", lineNumber : 348, className : "nanofl.engine.geom.Polygons", methodName : "fromRawContoursInner"});
	return r;
};
nanofl_engine_geom_Polygons.getEdgesToTestFilling = function(originals,edges) {
	var r = [];
	var _g = 0;
	while(_g < originals.length) {
		var edge = originals[_g];
		++_g;
		if(HxOverrides.indexOf(r,edge,0) < 0 && edge.indexIn(edges) >= 0) r.push(edge);
	}
	return r;
};
nanofl_engine_geom_Polygons.assertCorrect = function(polygons,intergrityChecks,message) {
};
nanofl_engine_geom_Polygons.removeErased = function(polygons) {
	var i = 0;
	while(i < polygons.length) if(js_Boot.__instanceof(polygons[i].fill,nanofl_engine_fills_EraseFill)) polygons.splice(i,1); else i++;
};
nanofl_engine_geom_Polygons.equ = function(a,b) {
	return nanofl_engine_ArrayTools.equ(a,b) && nanofl_engine_ArrayTools.equ(a.map(function(_) {
		return _.fill;
	}),b.map(function(_1) {
		return _1.fill;
	}));
};
nanofl_engine_geom_Polygons.log = function(v,infos) {
};
var nanofl_engine_geom_StraightLine = function(x1,y1,x2,y2) {
	this.x1 = x1;
	this.y1 = y1;
	this.x2 = x2;
	this.y2 = y2;
};
$hxClasses["nanofl.engine.geom.StraightLine"] = nanofl_engine_geom_StraightLine;
nanofl_engine_geom_StraightLine.__name__ = ["nanofl","engine","geom","StraightLine"];
nanofl_engine_geom_StraightLine.prototype = {
	x1: null
	,y1: null
	,x2: null
	,y2: null
	,clone: function() {
		return new nanofl_engine_geom_StraightLine(this.x1,this.y1,this.x2,this.y2);
	}
	,getBounds: function() {
		return { minX : Math.min(this.x1,this.x2), maxX : Math.max(this.x1,this.x2), minY : Math.min(this.y1,this.y2), maxY : Math.max(this.y1,this.y2)};
	}
	,getNearestPoint: function(x,y) {
		var dx = this.x2 - this.x1;
		var dy = this.y2 - this.y1;
		if(dx == 0 && dy == 0) return { t : 0, point : { x : this.x1, y : this.y1}};
		var t = Math.min(1,Math.max(0,((x - this.x1) * dx + (y - this.y1) * dy) / (dx * dx + dy * dy)));
		if(t == 1) return { t : 1, point : { x : this.x2, y : this.y2}};
		return { t : t, point : { x : this.x1 + t * dx, y : this.y1 + t * dy}};
	}
	,getOrthogonalRayIntersection: function(x,y) {
		var dx = this.x2 - this.x1;
		var dy = this.y2 - this.y1;
		if(dx == 0 && dy == 0) return { t : 0, point : { x : this.x1, y : this.y1}};
		var t = ((x - this.x1) * dx + (y - this.y1) * dy) / (dx * dx + dy * dy);
		if(t == 1) return { t : 1, point : { x : this.x2, y : this.y2}};
		return { t : t, point : { x : this.x1 + t * dx, y : this.y1 + t * dy}};
	}
	,getOrthogonalVector: function() {
		return { x : this.y1 - this.y2, y : this.x2 - this.x1};
	}
	,getLength: function() {
		return nanofl_engine_geom_PointTools.getDist(this.x1,this.y1,this.x2,this.y2);
	}
	,getIntersectionPointX_rightRay: function(mx,my) {
		if(Math.max(this.y1,this.y2) >= my && Math.min(this.y1,this.y2) <= my) {
			var t = (my - this.y1) / (this.y2 - this.y1);
			if(this.y1 <= this.y2 && t >= 0 && t < 1 || this.y1 > this.y2 && t > 0 && t <= 1) {
				var x = this.x1 + (this.x2 - this.x1) * t;
				if(x > mx) return x;
			}
		}
		return null;
	}
	,isIntersect_rightRay: function(mx,my) {
		return this.getIntersectionPointX_rightRay(mx,my) != null;
	}
	,getIntersection_straightSection: function(line) {
		if(this.x1 == line.x1 && this.y1 == line.y1 || this.x1 == line.x2 && this.y1 == line.y2) return null;
		if(this.x2 == line.x1 && this.y2 == line.y1 || this.x2 == line.x2 && this.y2 == line.y2) return null;
		var dax = this.x1 - this.x2;
		var dbx = line.x1 - line.x2;
		var day = this.y1 - this.y2;
		var dby = line.y1 - line.y2;
		var den = dax * dby - day * dbx;
		if(Math.abs(den) < 1e-10) return null;
		var A = this.x1 * this.y2 - this.y1 * this.x2;
		var B = line.x1 * line.y2 - line.y1 * line.x2;
		var I = { x : (A * dbx - dax * B) / den, y : (A * dby - day * B) / den};
		if(this.inRect(I) && line.inRect(I)) return I;
		return null;
	}
	,getIntersection_infinityLine: function(line) {
		var dax = this.x1 - this.x2;
		var dbx = line.x1 - line.x2;
		var day = this.y1 - this.y2;
		var dby = line.y1 - line.y2;
		var den = dax * dby - day * dbx;
		if(Math.abs(den) < 1e-10) return null;
		var A = this.x1 * this.y2 - this.y1 * this.x2;
		var B = line.x1 * line.y2 - line.y1 * line.x2;
		return { x : (A * dbx - dax * B) / den, y : (A * dby - day * B) / den};
	}
	,inRect: function(p) {
		if(this.x1 == this.x2) return p.y >= Math.min(this.y1,this.y2) && p.y <= Math.max(this.y1,this.y2);
		if(this.y1 == this.y2) return p.x >= Math.min(this.x1,this.x2) && p.x <= Math.max(this.x1,this.x2);
		return p.x >= Math.min(this.x1,this.x2) && p.x <= Math.max(this.x1,this.x2) && p.y >= Math.min(this.y1,this.y2) && p.y <= Math.max(this.y1,this.y2);
	}
	,isDegenerated: function() {
		return this.x1 == this.x2 && this.y1 == this.y2;
	}
	,getFirstPart: function(t) {
		return new nanofl_engine_geom_StraightLine(this.x1,this.y1,this.x1 + (this.x2 - this.x1) * t,this.y1 + (this.y2 - this.y1) * t);
	}
	,getSecondPart: function(t) {
		return new nanofl_engine_geom_StraightLine(this.x1 + (this.x2 - this.x1) * t,this.y1 + (this.y2 - this.y1) * t,this.x2,this.y2);
	}
	,split: function(tt) {
		var _g = 0;
		while(_g < tt.length) {
			var t = tt[_g];
			++_g;
			stdlib_Debug.assert(!isNaN(t),"t = " + t,{ fileName : "StraightLine.hx", lineNumber : 157, className : "nanofl.engine.geom.StraightLine", methodName : "split"});
		}
		if(tt.length == 0) return [this.clone()];
		if(tt.length == 1) {
			var m = this.getPoint(tt[0]);
			return [new nanofl_engine_geom_StraightLine(this.x1,this.y1,m.x,m.y),new nanofl_engine_geom_StraightLine(m.x,m.y,this.x2,this.y2)];
		}
		var r = [];
		var p = { x : this.x1, y : this.y1};
		var _g1 = 0;
		while(_g1 < tt.length) {
			var t1 = tt[_g1];
			++_g1;
			var m1 = this.getPoint(t1);
			r.push(new nanofl_engine_geom_StraightLine(p.x,p.y,m1.x,m1.y));
			p = m1;
		}
		r.push(new nanofl_engine_geom_StraightLine(p.x,p.y,this.x2,this.y2));
		return r;
	}
	,getPoint: function(t) {
		return { x : this.x1 + (this.x2 - this.x1) * t, y : this.y1 + (this.y2 - this.y1) * t};
	}
	,getTangent: function(t) {
		return Math.atan2(this.y2 - this.y1,this.x2 - this.x1);
	}
	,toString: function() {
		return "line(" + this.x1 + ", " + this.y1 + ", " + this.x2 + ", " + this.y2 + ")";
	}
	,__class__: nanofl_engine_geom_StraightLine
};
var nanofl_engine_geom_StrokeEdge = function(x1,y1,x2,y2,x3,y3,stroke,selected) {
	if(selected == null) selected = false;
	nanofl_engine_geom_Edge.call(this,x1,y1,x2,y2,x3,y3);
	this.stroke = stroke;
	this.selected = selected;
};
$hxClasses["nanofl.engine.geom.StrokeEdge"] = nanofl_engine_geom_StrokeEdge;
nanofl_engine_geom_StrokeEdge.__name__ = ["nanofl","engine","geom","StrokeEdge"];
nanofl_engine_geom_StrokeEdge.__interfaces__ = [nanofl_engine_ISelectable];
nanofl_engine_geom_StrokeEdge.fromEdge = function(edge,stroke,selected) {
	if(selected == null) selected = false;
	return new nanofl_engine_geom_StrokeEdge(edge.x1,edge.y1,edge.x2,edge.y2,edge.x3,edge.y3,stroke,selected);
};
nanofl_engine_geom_StrokeEdge.__super__ = nanofl_engine_geom_Edge;
nanofl_engine_geom_StrokeEdge.prototype = $extend(nanofl_engine_geom_Edge.prototype,{
	stroke: null
	,selected: null
	,getNearestPointUseStrokeSize: function(x,y) {
		var pointAndT = this.getNearestPoint(x,y);
		nanofl_engine_geom_PointTools.moveInDirection(pointAndT.point,x,y,this.stroke != null?this.stroke.thickness / 2:0);
		return pointAndT;
	}
	,addTo: function(edges) {
		var n = this.indexIn(edges);
		if(n >= 0) edges[n].stroke = this.stroke; else edges.push(this);
	}
	,transform: function(m,applyToStrokeThickness) {
		if(applyToStrokeThickness == null) applyToStrokeThickness = true;
		nanofl_engine_geom_Edge.prototype.transform.call(this,m);
		if(this.stroke != null) this.stroke = this.stroke.getTransformed(m,applyToStrokeThickness);
	}
	,translate: function(dx,dy) {
		nanofl_engine_geom_Edge.prototype.translate.call(this,dx,dy);
		if(this.stroke != null) this.stroke = this.stroke.getTransformed(new nanofl_engine_geom_Matrix(1,0,0,1,dx,dy),false);
	}
	,clone: function() {
		return new nanofl_engine_geom_StrokeEdge(this.x1,this.y1,this.x2,this.y2,this.x3,this.y3,this.stroke.clone(),this.selected);
	}
	,duplicate: function(e) {
		return new nanofl_engine_geom_StrokeEdge(e.x1,e.y1,e.x2,e.y2,e.x3,e.y3,this.stroke,this.selected);
	}
	,split: function(tt) {
		return nanofl_engine_geom_Edge.prototype.split.call(this,tt).map((function(f,a2,a3) {
			return function(a1) {
				return f(a1,a2,a3);
			};
		})(nanofl_engine_geom_StrokeEdge.fromEdge,this.stroke,this.selected));
	}
	,toString: function() {
		if(this.isStraight()) return "new StrokeEdge(" + this.x1 + "," + this.y1 + ", " + this.x3 + "," + this.y3 + ", " + Std.string(this.stroke) + ", " + Std.string(this.selected) + ")"; else return "new StrokeEdge(" + this.x1 + "," + this.y1 + ", " + this.x2 + "," + this.y2 + ", " + this.x3 + "," + this.y3 + ", " + Std.string(this.stroke) + ", " + Std.string(this.selected) + ")";
	}
	,__class__: nanofl_engine_geom_StrokeEdge
});
var nanofl_engine_geom_StrokeEdges = function() { };
$hxClasses["nanofl.engine.geom.StrokeEdges"] = nanofl_engine_geom_StrokeEdges;
nanofl_engine_geom_StrokeEdges.__name__ = ["nanofl","engine","geom","StrokeEdges"];
nanofl_engine_geom_StrokeEdges.load = function(node,strokes,version) {
	stdlib_Debug.assert(node.name == "edge",null,{ fileName : "StrokeEdges.hx", lineNumber : 15, className : "nanofl.engine.geom.StrokeEdges", methodName : "load"});
	var strokeIndex = Std["int"](htmlparser_HtmlParserTools.getAttr(node,"strokeIndex",-1));
	stdlib_Debug.assert(strokeIndex >= 0,null,{ fileName : "StrokeEdges.hx", lineNumber : 18, className : "nanofl.engine.geom.StrokeEdges", methodName : "load"});
	stdlib_Debug.assert(strokeIndex < strokes.length,null,{ fileName : "StrokeEdges.hx", lineNumber : 19, className : "nanofl.engine.geom.StrokeEdges", methodName : "load"});
	return nanofl_engine_geom_Edges.load(node.getAttribute("edges")).map(function(e) {
		return nanofl_engine_geom_StrokeEdge.fromEdge(e,strokes[strokeIndex]);
	});
};
nanofl_engine_geom_StrokeEdges.save = function(edges,strokes,out) {
	var groups = nanofl_engine_geom_StrokeEdges.getStrokeGroups(edges,strokes);
	var _g1 = 0;
	var _g = groups.length;
	while(_g1 < _g) {
		var i = _g1++;
		out.begin("edge").attr("strokeIndex",i);
		out.attr("edges",nanofl_engine_geom_Edges.save(groups[i]));
		out.end();
	}
};
nanofl_engine_geom_StrokeEdges.getStrokeGroups = function(edges,strokes) {
	var groups = [];
	var _g1 = 0;
	var _g = strokes.length;
	while(_g1 < _g) {
		var i = _g1++;
		groups.push([]);
	}
	var _g2 = 0;
	while(_g2 < edges.length) {
		var e = [edges[_g2]];
		++_g2;
		var index = stdlib_LambdaIterable.findIndex(strokes,(function(e) {
			return function(stroke) {
				return stroke.equ(e[0].stroke);
			};
		})(e));
		groups[index].push(e[0]);
	}
	return groups;
};
nanofl_engine_geom_StrokeEdges.getBounds = function(edges,bounds) {
	if(edges.length > 0) {
		if(bounds == null) bounds = { minX : 1e100, minY : 1e100, maxX : -1e100, maxY : -1e100};
		var _g = 0;
		while(_g < edges.length) {
			var e = edges[_g];
			++_g;
			var b = e.getBounds();
			var r = e.stroke.thickness / 2;
			bounds.minX = Math.min(bounds.minX,b.minX - r);
			bounds.minY = Math.min(bounds.minY,b.minY - r);
			bounds.maxX = Math.max(bounds.maxX,b.maxX + r);
			bounds.maxY = Math.max(bounds.maxY,b.maxY + r);
		}
	}
	return bounds;
};
nanofl_engine_geom_StrokeEdges.processStrokes = function(edges,callb) {
	var processed = new haxe_ds_ObjectMap();
	var _g = 0;
	while(_g < edges.length) {
		var e = edges[_g];
		++_g;
		var stroke = processed.h[e.stroke.__id__];
		if(stroke == null) {
			stroke = e.stroke.clone();
			callb(stroke);
			processed.set(e.stroke,stroke);
		}
		e.stroke = stroke;
	}
};
nanofl_engine_geom_StrokeEdges.drawSorted = function(edges,g,scaleSelection) {
	nanofl_engine_geom_StrokeEdges.sort(edges);
	var i = 0;
	while(i < edges.length) {
		var j = i + 1;
		while(j < edges.length && edges[i].stroke.equ(edges[j].stroke)) j++;
		edges[i].stroke.begin(g);
		nanofl_engine_geom_Edges.draw(edges.slice(i,j),g,true);
		g.endStroke();
		i = j;
	}
	if(nanofl_engine_geom_Edges.showSelection) {
		edges = edges.filter(function(e) {
			return e.selected;
		});
		if(edges.length > 0) {
			var i1 = 0;
			while(i1 < edges.length) {
				var j1 = i1 + 1;
				while(j1 < edges.length && edges[i1].stroke.equ(edges[j1].stroke)) j1++;
				new nanofl_engine_strokes_SelectionStroke(edges[i1].stroke,scaleSelection).begin(g);
				nanofl_engine_geom_Edges.draw(edges.slice(i1,j1),g,true);
				g.endStroke();
				i1 = j1;
			}
		}
	}
};
nanofl_engine_geom_StrokeEdges.sort = function(edges) {
	var i = 1;
	while(i < edges.length) {
		while(i < edges.length && edges[i - 1].stroke.equ(edges[i].stroke)) i++;
		var _g1 = i;
		var _g = edges.length;
		while(_g1 < _g) {
			var j = _g1++;
			if(edges[i].stroke.equ(edges[j].stroke)) {
				var z = edges[i];
				edges[i] = edges[j];
				edges[j] = z;
				i++;
			}
		}
		i++;
	}
	var i1 = 0;
	while(i1 < edges.length) {
		var j1 = i1 + 1;
		while(j1 < edges.length && edges[i1].stroke.equ(edges[j1].stroke)) j1++;
		nanofl_engine_geom_StrokeEdges.sortToProduceSequences(edges,i1,j1);
		i1 = j1;
	}
};
nanofl_engine_geom_StrokeEdges.sortToProduceSequences = function(edges,from,to) {
	var lastSorted = from;
	var i = lastSorted + 1;
	while(i < to) if(lastSorted + 1 < to && edges[lastSorted].x3 == edges[i].x1 && edges[lastSorted].y3 == edges[i].y1) {
		nanofl_engine_ArrayTools.swap(edges,lastSorted + 1,i);
		lastSorted++;
		i = lastSorted + 1;
	} else if(lastSorted + 1 < to && edges[lastSorted].x3 == edges[i].x3 && edges[lastSorted].y3 == edges[i].y3) {
		edges[i].reverse();
		nanofl_engine_ArrayTools.swap(edges,lastSorted + 1,i);
		lastSorted++;
		i = lastSorted + 1;
	} else if(edges[from].x1 == edges[i].x3 && edges[from].y1 == edges[i].y3) {
		var z = edges[i];
		var k = i;
		while(k > from) {
			edges[k] = edges[k - 1];
			k--;
		}
		edges[from] = z;
		lastSorted++;
		i = lastSorted + 1;
	} else if(edges[i].x1 == edges[from].x1 && edges[i].y1 == edges[from].y1) {
		edges[i].reverse();
		var z1 = edges[i];
		var k1 = i;
		while(k1 > from) {
			edges[k1] = edges[k1 - 1];
			k1--;
		}
		edges[from] = z1;
		lastSorted++;
		i = lastSorted + 1;
	} else i++;
	if(lastSorted + 2 < to) nanofl_engine_geom_StrokeEdges.sortToProduceSequences(edges,lastSorted + 1,to);
};
nanofl_engine_geom_StrokeEdges.fromEdges = function(edges,stroke,selected) {
	if(selected == null) selected = false;
	return edges.map(function(e) {
		return nanofl_engine_geom_StrokeEdge.fromEdge(e,stroke,selected);
	});
};
nanofl_engine_geom_StrokeEdges.replace = function(edges,search,replacement) {
	nanofl_engine_geom_Edges.replace(edges,search,replacement.filter(function(e) {
		return e.indexIn(edges) < 0;
	}));
};
nanofl_engine_geom_StrokeEdges.equ = function(a,b) {
	return nanofl_engine_ArrayTools.equ(a,b) && nanofl_engine_ArrayTools.equ(a.map(function(_) {
		return _.stroke;
	}),b.map(function(_1) {
		return _1.stroke;
	}));
};
var stdlib_AbstractClass = function() { };
$hxClasses["stdlib.AbstractClass"] = stdlib_AbstractClass;
stdlib_AbstractClass.__name__ = ["stdlib","AbstractClass"];
var nanofl_engine_libraryitems_LibraryItem = function(namePath) {
	this.namePath = namePath;
};
$hxClasses["nanofl.engine.libraryitems.LibraryItem"] = nanofl_engine_libraryitems_LibraryItem;
nanofl_engine_libraryitems_LibraryItem.__name__ = ["nanofl","engine","libraryitems","LibraryItem"];
nanofl_engine_libraryitems_LibraryItem.__interfaces__ = [stdlib_AbstractClass];
nanofl_engine_libraryitems_LibraryItem.parse = function(namePath,itemNode) {
	var movieClipItem = nanofl_engine_libraryitems_MovieClipItem.parse(namePath,itemNode);
	if(movieClipItem != null) return movieClipItem;
	var bitmapItem = nanofl_engine_libraryitems_BitmapItem.parse(namePath,itemNode);
	if(bitmapItem != null) return bitmapItem;
	var meshItem = nanofl_engine_libraryitems_MeshItem.parse(namePath,itemNode);
	if(meshItem != null) return meshItem;
	var fontItem = nanofl_engine_libraryitems_FontItem.parse(namePath,itemNode);
	if(fontItem != null) return fontItem;
	var soundItem = nanofl_engine_libraryitems_SoundItem.parse(namePath,itemNode);
	if(soundItem != null) return soundItem;
	var spriteItem = nanofl_engine_libraryitems_SpriteItem.parse(namePath,itemNode);
	if(spriteItem != null) return spriteItem;
	var foldertem = nanofl_engine_libraryitems_FolderItem.parse(namePath,itemNode);
	if(foldertem != null) return foldertem;
	return null;
};
nanofl_engine_libraryitems_LibraryItem.prototype = {
	library: null
	,namePath: null
	,getType: function() {
		return stdlib_Debug.methodMustBeOverriden(this,{ fileName : "LibraryItem.hx", lineNumber : 23, className : "nanofl.engine.libraryitems.LibraryItem", methodName : "getType"});
	}
	,getIcon: function() {
		return "";
	}
	,copyBaseProperties: function(obj) {
		obj.library = this.library;
		obj.namePath = this.namePath;
	}
	,clone: function() {
		return stdlib_Debug.methodNotSupported(this,{ fileName : "LibraryItem.hx", lineNumber : 33, className : "nanofl.engine.libraryitems.LibraryItem", methodName : "clone"});
	}
	,loadProperties: function(xml) {
	}
	,saveProperties: function(xml) {
	}
	,save: function(fileSystem) {
	}
	,hasXmlToSave: function() {
		return false;
	}
	,saveToXml: function(out) {
	}
	,preload: function(ready) {
		ready();
	}
	,setLibrary: function(library) {
		this.library = library;
	}
	,duplicate: function(newNamePath) {
		var item = this.clone();
		item.namePath = newNamePath;
		if(this.library != null) this.library.addItem(item);
		return item;
	}
	,remove: function() {
		if(this.library != null) this.library.removeItem(this.namePath);
	}
	,getNotSerializableFields: function() {
		return [];
	}
	,hxSerialize: function(s) {
		var fields = Reflect.fields(this);
		var exclude = this.getNotSerializableFields();
		var arr = [];
		var _g = 0;
		while(_g < fields.length) {
			var field = fields[_g];
			++_g;
			var v = Reflect.field(this,field);
			if(v != null && !Reflect.isFunction(v) && HxOverrides.indexOf(exclude,field,0) < 0) {
				arr.push(field);
				arr.push(v);
			}
		}
		s.serialize(arr);
	}
	,hxUnserialize: function(s) {
		var arr = s.unserialize();
		var _g1 = 0;
		var _g = arr.length >> 1;
		while(_g1 < _g) {
			var i = _g1++;
			Reflect.setField(this,arr[i * 2],arr[i * 2 + 1]);
		}
	}
	,equ: function(item) {
		return stdlib_Debug.methodMustBeOverriden(this,{ fileName : "LibraryItem.hx", lineNumber : 134, className : "nanofl.engine.libraryitems.LibraryItem", methodName : "equ"});
	}
	,toString: function() {
		return "Item(" + this.namePath + ")";
	}
	,__class__: nanofl_engine_libraryitems_LibraryItem
};
var nanofl_engine_libraryitems_InstancableItem = function(namePath) {
	this.linkedClass = "";
	nanofl_engine_libraryitems_LibraryItem.call(this,namePath);
};
$hxClasses["nanofl.engine.libraryitems.InstancableItem"] = nanofl_engine_libraryitems_InstancableItem;
nanofl_engine_libraryitems_InstancableItem.__name__ = ["nanofl","engine","libraryitems","InstancableItem"];
nanofl_engine_libraryitems_InstancableItem.__super__ = nanofl_engine_libraryitems_LibraryItem;
nanofl_engine_libraryitems_InstancableItem.prototype = $extend(nanofl_engine_libraryitems_LibraryItem.prototype,{
	linkedClass: null
	,hasXmlToSave: function() {
		return nanofl_engine_libraryitems_LibraryItem.prototype.hasXmlToSave.call(this) || this.linkedClass != "";
	}
	,loadProperties: function(xml) {
		nanofl_engine_libraryitems_LibraryItem.prototype.loadProperties.call(this,xml);
		this.linkedClass = htmlparser_HtmlParserTools.getAttr(xml,"linkedClass","");
	}
	,saveProperties: function(xml) {
		nanofl_engine_libraryitems_LibraryItem.prototype.saveProperties.call(this,xml);
		xml.attr("linkedClass",this.linkedClass,"");
	}
	,copyBaseProperties: function(obj) {
		nanofl_engine_libraryitems_LibraryItem.prototype.copyBaseProperties.call(this,obj);
		obj.linkedClass = this.linkedClass;
	}
	,newInstance: function() {
		stdlib_Debug.assert(this.library != null,"You must add symbol '" + this.namePath + "' to library before newInstance() call.",{ fileName : "InstancableItem.hx", lineNumber : 37, className : "nanofl.engine.libraryitems.InstancableItem", methodName : "newInstance"});
		var r = new nanofl_engine_elements_Instance(this.namePath);
		r.setLibrary(this.library);
		return r;
	}
	,getDisplayObjectClassName: function() {
		return stdlib_Debug.methodMustBeOverriden(this,{ fileName : "InstancableItem.hx", lineNumber : 43, className : "nanofl.engine.libraryitems.InstancableItem", methodName : "getDisplayObjectClassName"});
	}
	,createDisplayObject: function(initFrameIndex,childFrameIndexes) {
		if(this.linkedClass != "") {
			var klass = window[this.linkedClass];
			if(klass != null) return new klass(this);
			haxe_Log.trace("Linkage class '" + this.linkedClass + "' is not found.",{ fileName : "InstancableItem.hx", lineNumber : 54, className : "nanofl.engine.libraryitems.InstancableItem", methodName : "createDisplayObject"});
		}
		return null;
	}
	,updateDisplayObject: function(dispObj,childFrameIndexes) {
		stdlib_Debug.methodMustBeOverriden(this,{ fileName : "InstancableItem.hx", lineNumber : 60, className : "nanofl.engine.libraryitems.InstancableItem", methodName : "updateDisplayObject"});
	}
	,getNearestPoint: function(pos) {
		return { x : 1e100, y : 1e100};
	}
	,__class__: nanofl_engine_libraryitems_InstancableItem
});
var nanofl_engine_libraryitems_BitmapItem = function(namePath,ext) {
	nanofl_engine_libraryitems_InstancableItem.call(this,namePath);
	this.ext = ext;
};
$hxClasses["nanofl.engine.libraryitems.BitmapItem"] = nanofl_engine_libraryitems_BitmapItem;
nanofl_engine_libraryitems_BitmapItem.__name__ = ["nanofl","engine","libraryitems","BitmapItem"];
nanofl_engine_libraryitems_BitmapItem.__interfaces__ = [nanofl_engine_ITextureItem];
nanofl_engine_libraryitems_BitmapItem.parse = function(namePath,itemNode) {
	if(itemNode.name != "bitmap") return null;
	var item = new nanofl_engine_libraryitems_BitmapItem(namePath,itemNode.getAttribute("ext"));
	item.loadProperties(itemNode);
	return item;
};
nanofl_engine_libraryitems_BitmapItem.log = function(v,infos) {
};
nanofl_engine_libraryitems_BitmapItem.__super__ = nanofl_engine_libraryitems_InstancableItem;
nanofl_engine_libraryitems_BitmapItem.prototype = $extend(nanofl_engine_libraryitems_InstancableItem.prototype,{
	ext: null
	,textureAtlas: null
	,image: null
	,getNotSerializableFields: function() {
		return nanofl_engine_libraryitems_InstancableItem.prototype.getNotSerializableFields.call(this).concat(["image"]);
	}
	,getType: function() {
		return "bitmap";
	}
	,clone: function() {
		var obj = new nanofl_engine_libraryitems_BitmapItem(this.namePath,this.ext);
		obj.ext = this.ext;
		obj.textureAtlas = this.textureAtlas;
		obj.image = this.image;
		this.copyBaseProperties(obj);
		return obj;
	}
	,getIcon: function() {
		return "custom-icon-picture";
	}
	,save: function(fileSystem) {
		var xmlPath = this.library.libraryDir + "/" + this.namePath + ".xml";
		if(this.hasXmlToSave()) {
			var out = new htmlparser_XmlBuilder();
			this.saveToXml(out);
			fileSystem.saveContent(xmlPath,out.toString());
		} else fileSystem.remove(xmlPath);
	}
	,hasXmlToSave: function() {
		return nanofl_engine_libraryitems_InstancableItem.prototype.hasXmlToSave.call(this) || this.textureAtlas != null && this.textureAtlas != "";
	}
	,saveToXml: function(out) {
		out.begin("bitmap").attr("version",nanofl_engine_Version.document);
		this.saveProperties(out);
		out.end();
	}
	,loadProperties: function(xml) {
		nanofl_engine_libraryitems_InstancableItem.prototype.loadProperties.call(this,xml);
		this.textureAtlas = htmlparser_HtmlParserTools.getAttr(xml,"textureAtlas",null);
	}
	,saveProperties: function(xml) {
		nanofl_engine_libraryitems_InstancableItem.prototype.saveProperties.call(this,xml);
		xml.attr("ext",this.ext,null);
		xml.attr("textureAtlas",this.textureAtlas,null);
	}
	,getUrl: function() {
		return this.library.realUrl(this.namePath + "." + this.ext);
	}
	,preload: function(ready) {
		var _g = this;
		stdlib_Debug.assert(this.library != null,"You need to add item '" + this.namePath + "' to the library before preload call.",{ fileName : "BitmapItem.hx", lineNumber : 107, className : "nanofl.engine.libraryitems.BitmapItem", methodName : "preload"});
		if(nanofl_engine_TextureItemTools.getSpriteSheet(this) == null) nanofl_engine_Loader.image(this.getUrl(),function(i) {
			_g.image = i;
			ready();
		}); else nanofl_engine_TextureItemTools.preload(this,ready);
	}
	,createDisplayObject: function(initFrameIndex,childFrameIndexes) {
		var r = nanofl_engine_libraryitems_InstancableItem.prototype.createDisplayObject.call(this,initFrameIndex,childFrameIndexes);
		if(r == null) {
			var spriteSheet = nanofl_engine_TextureItemTools.getSpriteSheet(this);
			if(spriteSheet == null) r = new nanofl_Bitmap(this); else r = new createjs.Sprite(spriteSheet);
		}
		r.setBounds(0,0,this.image.width,this.image.height);
		return r;
	}
	,updateDisplayObject: function(dispObj,childFrameIndexes) {
		stdlib_Debug.assert(js_Boot.__instanceof(dispObj,createjs.Bitmap),null,{ fileName : "BitmapItem.hx", lineNumber : 143, className : "nanofl.engine.libraryitems.BitmapItem", methodName : "updateDisplayObject"});
		dispObj.image = this.image;
		dispObj.setBounds(0,0,this.image.width,this.image.height);
	}
	,getDisplayObjectClassName: function() {
		return "nanofl.Bitmap";
	}
	,equ: function(item) {
		if(item.namePath != this.namePath) return false;
		if(!js_Boot.__instanceof(item,nanofl_engine_libraryitems_BitmapItem)) return false;
		if(item.ext != this.ext) return false;
		return true;
	}
	,getNearestPoint: function(pos) {
		var bounds = { minX : 0.0, minY : 0.0, maxX : this.image.width + 0.0, maxY : this.image.height + 0.0};
		return nanofl_engine_geom_BoundsTools.getNearestPoint(bounds,pos);
	}
	,toString: function() {
		return "BitmapItem(" + this.namePath + ")";
	}
	,__class__: nanofl_engine_libraryitems_BitmapItem
});
var nanofl_engine_libraryitems_FolderItem = function(namePath) {
	this.opened = false;
	nanofl_engine_libraryitems_LibraryItem.call(this,namePath);
};
$hxClasses["nanofl.engine.libraryitems.FolderItem"] = nanofl_engine_libraryitems_FolderItem;
nanofl_engine_libraryitems_FolderItem.__name__ = ["nanofl","engine","libraryitems","FolderItem"];
nanofl_engine_libraryitems_FolderItem.parse = function(namePath,itemNode) {
	if(itemNode.name != "folder") return null;
	return new nanofl_engine_libraryitems_FolderItem(namePath);
};
nanofl_engine_libraryitems_FolderItem.__super__ = nanofl_engine_libraryitems_LibraryItem;
nanofl_engine_libraryitems_FolderItem.prototype = $extend(nanofl_engine_libraryitems_LibraryItem.prototype,{
	opened: null
	,clone: function() {
		var obj = new nanofl_engine_libraryitems_FolderItem(this.namePath);
		obj.opened = this.opened;
		this.copyBaseProperties(obj);
		return obj;
	}
	,save: function(fileSystem) {
		fileSystem.createDirectory(this.library.libraryDir + "/" + this.namePath);
	}
	,hasXmlToSave: function() {
		return true;
	}
	,saveToXml: function(out) {
		out.begin("folder").attr("version",nanofl_engine_Version.document);
		this.saveProperties(out);
		out.end();
	}
	,getIcon: function() {
		if(this.opened) return "custom-icon-folder-open"; else return "custom-icon-folder-close";
	}
	,toString: function() {
		return "FolderItem(" + this.namePath + ")";
	}
	,equ: function(item) {
		if(item.namePath != this.namePath) return false;
		if(!js_Boot.__instanceof(item,nanofl_engine_libraryitems_FolderItem)) return false;
		return true;
	}
	,__class__: nanofl_engine_libraryitems_FolderItem
});
var nanofl_engine_libraryitems_FontItem = function(namePath,variants) {
	nanofl_engine_libraryitems_LibraryItem.call(this,namePath);
	this.variants = variants;
};
$hxClasses["nanofl.engine.libraryitems.FontItem"] = nanofl_engine_libraryitems_FontItem;
nanofl_engine_libraryitems_FontItem.__name__ = ["nanofl","engine","libraryitems","FontItem"];
nanofl_engine_libraryitems_FontItem.parse = function(namePath,itemNode) {
	if(itemNode.name != "font") return null;
	var version = itemNode.getAttribute("version");
	if(version == null || version == "") version = "1.0.0";
	var variants = [];
	var _g = 0;
	var _g1 = itemNode.children;
	while(_g < _g1.length) {
		var node = [_g1[_g]];
		++_g;
		if(node[0].name == "variant") {
			var variant = [new nanofl_engine_FontVariant(htmlparser_HtmlParserTools.getAttr(node[0],"style","normal"),htmlparser_HtmlParserTools.getAttr(node[0],"weight",400),htmlparser_HtmlParserTools.getAttrString(node[0],"locals","").split(",").map((function() {
				return function(_) {
					return stdlib_StringTools.trim(_);
				};
			})()).filter((function() {
				return function(_1) {
					return _1 != "";
				};
			})()))];
			nanofl_engine_Version.handle(version,(function($this) {
				var $r;
				var _g2 = new haxe_ds_StringMap();
				if(__map_reserved["1.0.0"] != null) _g2.setReserved("1.0.0",(function(variant,node) {
					return function() {
						var key = htmlparser_HtmlParserTools.getAttr(node[0],"format","");
						var value = htmlparser_HtmlParserTools.getAttrString(node[0],"url","");
						variant[0].urls.set(key,value);
					};
				})(variant,node)); else _g2.h["1.0.0"] = (function(variant,node) {
					return function() {
						var key = htmlparser_HtmlParserTools.getAttr(node[0],"format","");
						var value = htmlparser_HtmlParserTools.getAttrString(node[0],"url","");
						variant[0].urls.set(key,value);
					};
				})(variant,node);
				if(__map_reserved["2.0.0"] != null) _g2.setReserved("2.0.0",(function(variant,node) {
					return function() {
						var _g3 = 0;
						var _g4 = node[0].children;
						while(_g3 < _g4.length) {
							var urlNode = _g4[_g3];
							++_g3;
							var key1 = htmlparser_HtmlParserTools.getAttr(urlNode,"format","");
							var value1 = htmlparser_HtmlParserTools.getAttrString(urlNode,"url","");
							variant[0].urls.set(key1,value1);
						}
					};
				})(variant,node)); else _g2.h["2.0.0"] = (function(variant,node) {
					return function() {
						var _g3 = 0;
						var _g4 = node[0].children;
						while(_g3 < _g4.length) {
							var urlNode = _g4[_g3];
							++_g3;
							var key1 = htmlparser_HtmlParserTools.getAttr(urlNode,"format","");
							var value1 = htmlparser_HtmlParserTools.getAttrString(urlNode,"url","");
							variant[0].urls.set(key1,value1);
						}
					};
				})(variant,node);
				$r = _g2;
				return $r;
			}(this)));
			variants.push(variant[0]);
		}
	}
	return new nanofl_engine_libraryitems_FontItem(namePath,variants);
};
nanofl_engine_libraryitems_FontItem.__super__ = nanofl_engine_libraryitems_LibraryItem;
nanofl_engine_libraryitems_FontItem.prototype = $extend(nanofl_engine_libraryitems_LibraryItem.prototype,{
	variants: null
	,getType: function() {
		return "font";
	}
	,clone: function() {
		var obj = new nanofl_engine_libraryitems_FontItem(this.namePath,this.variants.slice());
		this.copyBaseProperties(obj);
		return obj;
	}
	,getIcon: function() {
		return "icon-font";
	}
	,save: function(fileSystem) {
		var out = new htmlparser_XmlBuilder();
		this.saveToXml(out);
		fileSystem.saveContent(this.library.libraryDir + "/" + this.namePath + ".xml",out.toString());
	}
	,hasXmlToSave: function() {
		return true;
	}
	,saveToXml: function(out) {
		out.begin("font").attr("version",nanofl_engine_Version.document);
		var _g = 0;
		var _g1 = this.variants;
		while(_g < _g1.length) {
			var variant = _g1[_g];
			++_g;
			out.begin("variant").attr("style",variant.style).attr("weight",variant.weight).attr("locals",variant.locals.join(", "));
			var $it0 = variant.urls.keys();
			while( $it0.hasNext() ) {
				var format = $it0.next();
				out.begin("file").attr("format",format).attr("url",variant.urls.get(format));
				out.end();
			}
			out.end();
		}
		out.end();
	}
	,toFont: function() {
		return { family : haxe_io_Path.withoutDirectory(this.namePath), fallbacks : [], variants : this.variants};
	}
	,preload: function(ready) {
		stdlib_Debug.assert(this.library != null,"You need to add item '" + this.namePath + "' to the library before preload call.",{ fileName : "FontItem.hx", lineNumber : 116, className : "nanofl.engine.libraryitems.FontItem", methodName : "preload"});
		var family = haxe_io_Path.withoutDirectory(this.namePath);
		var loadCount = this.variants.length;
		var _g = 0;
		var _g1 = this.variants;
		while(_g < _g1.length) {
			var variant = [_g1[_g]];
			++_g;
			this.getExistsSupportedFormat(variant[0],(function(variant) {
				return function(format) {
					if(format != null) {
						var font = new FontFace(family,"url(" + variant[0].urls.get(format) + ") format(\"" + format + "\")",{ style : variant[0].style, weight : variant[0].weight == null?"null":"" + variant[0].weight});
						font.load().then((function() {
							return function(font1) {
								loadCount--;
								window.document.fonts.add(font1);
								if(loadCount == 0) ready();
							};
						})(),(function(variant) {
							return function(e) {
								haxe_Log.trace("Font '" + family + "' loading error ('" + variant[0].urls.get(format) + "'):",{ fileName : "FontItem.hx", lineNumber : 143, className : "nanofl.engine.libraryitems.FontItem", methodName : "preload"});
								haxe_Log.trace(e,{ fileName : "FontItem.hx", lineNumber : 144, className : "nanofl.engine.libraryitems.FontItem", methodName : "preload"});
								loadCount--;
								if(loadCount == 0) ready();
							};
						})(variant));
					} else {
						haxe_Log.trace("Can't found suitable font file format ('" + family + " " + variant[0].style + " " + variant[0].weight + "').",{ fileName : "FontItem.hx", lineNumber : 152, className : "nanofl.engine.libraryitems.FontItem", methodName : "preload"});
						loadCount--;
						if(loadCount == 0) ready();
					}
				};
			})(variant));
		}
	}
	,getExistsSupportedFormat: function(variant,callb) {
		window.fontSupport(function(supports) {
			if(supports.woff2 && variant.urls.exists("woff2")) callb("woff2"); else if(supports.woff && variant.urls.exists("woff")) callb("woff"); else if(supports.ttf && variant.urls.exists("truetype")) callb("truetype"); else if(supports.svg && variant.urls.exists("svg")) callb("svg"); else if(variant.urls.exists("eot")) callb("eot"); else callb(null);
		});
	}
	,addVariant: function(v) {
		var origV = ((function(_e) {
			return function(f) {
				return Lambda.find(_e,f);
			};
		})(this.variants))(function(_) {
			return v.style == _.style && v.weight == _.weight;
		});
		if(origV != null) {
			var $it0 = v.urls.keys();
			while( $it0.hasNext() ) {
				var format = $it0.next();
				var value = v.urls.get(format);
				origV.urls.set(format,value);
			}
		} else this.variants.push(v);
	}
	,equ: function(item) {
		if(item.namePath != this.namePath) return false;
		if(!js_Boot.__instanceof(item,nanofl_engine_libraryitems_FontItem)) return false;
		if(!nanofl_engine_ArrayTools.equ(item.variants,this.variants)) return false;
		return true;
	}
	,toString: function() {
		return "FontItem(" + this.namePath + ")";
	}
	,__class__: nanofl_engine_libraryitems_FontItem
});
var nanofl_engine_libraryitems_MeshItem = function(namePath,ext,originalExt) {
	this.textureFiles = [];
	this.loadLights = false;
	this.renderAreaSize = 256;
	var _g = this;
	Object.defineProperty(this,"renderer",{ get : function() {
		return _g.get_renderer();
	}});
	nanofl_engine_libraryitems_InstancableItem.call(this,namePath);
	this.ext = ext;
	this.originalExt = originalExt;
};
$hxClasses["nanofl.engine.libraryitems.MeshItem"] = nanofl_engine_libraryitems_MeshItem;
nanofl_engine_libraryitems_MeshItem.__name__ = ["nanofl","engine","libraryitems","MeshItem"];
nanofl_engine_libraryitems_MeshItem.__interfaces__ = [nanofl_engine_ITextureItem];
nanofl_engine_libraryitems_MeshItem.getTextureFiles = function(namePath,json) {
	return nanofl_engine_libraryitems_MeshItem.parseTextureFiles(namePath,nanofl_engine_libraryitems_MeshItem.parseMaterials(json));
};
nanofl_engine_libraryitems_MeshItem.parseMaterials = function(json) {
	var r = [];
	if(json.materials != null) r = r.concat(json.materials);
	if(json.geometries != null && json.geometries.materials != null) r = r.concat(json.geometries.materials);
	return r;
};
nanofl_engine_libraryitems_MeshItem.parseTextureFiles = function(namePath,materials) {
	var r = [];
	var _g = 0;
	while(_g < materials.length) {
		var material = materials[_g];
		++_g;
		if(material.mapDiffuse != null && material.mapDiffuse != "") r.push(haxe_io_Path.join([haxe_io_Path.directory(namePath),stdlib_StringTools.replace(material.mapDiffuse,"\\","/")]));
	}
	return r;
};
nanofl_engine_libraryitems_MeshItem.parse = function(namePath,itemNode) {
	if(itemNode.name != "mesh") return null;
	var item = new nanofl_engine_libraryitems_MeshItem(namePath,itemNode.getAttribute("ext"),itemNode.getAttribute("originalExt"));
	item.loadProperties(itemNode);
	return item;
};
nanofl_engine_libraryitems_MeshItem.isWebGLSupported = function() {
	if(nanofl_engine_libraryitems_MeshItem._isWebGLSupported == null) {
		var canvas = window.document.createElement("canvas");
		nanofl_engine_libraryitems_MeshItem._isWebGLSupported = !(!(window.WebGLRenderingContext && (canvas.getContext("webgl") || canvas.getContext("experimental-webgl"))));
	}
	return nanofl_engine_libraryitems_MeshItem._isWebGLSupported;
};
nanofl_engine_libraryitems_MeshItem.log = function(v,infos) {
};
nanofl_engine_libraryitems_MeshItem.__super__ = nanofl_engine_libraryitems_InstancableItem;
nanofl_engine_libraryitems_MeshItem.prototype = $extend(nanofl_engine_libraryitems_InstancableItem.prototype,{
	ext: null
	,originalExt: null
	,textureAtlas: null
	,renderAreaSize: null
	,loadLights: null
	,scene: null
	,boundingRadius: null
	,_renderer: null
	,renderer: null
	,_rendererLoadLights: null
	,textureFiles: null
	,getNotSerializableFields: function() {
		return nanofl_engine_libraryitems_InstancableItem.prototype.getNotSerializableFields.call(this).concat(["scene","boundingRadius","_renderer","_rendererLoadLights","textureFiles"]);
	}
	,getType: function() {
		return "mesh";
	}
	,clone: function() {
		var obj = new nanofl_engine_libraryitems_MeshItem(this.namePath,this.ext,this.originalExt);
		obj.textureAtlas = this.textureAtlas;
		obj.renderAreaSize = this.renderAreaSize;
		obj.loadLights = this.loadLights;
		if(this.scene != null) obj.scene = this.scene.clone(true); else obj.scene = null;
		obj.boundingRadius = this.boundingRadius;
		obj.textureFiles = this.textureFiles;
		this.copyBaseProperties(obj);
		return obj;
	}
	,getIcon: function() {
		return "custom-icon-cube";
	}
	,save: function(fileSystem) {
		var xmlPath = this.library.libraryDir + "/" + this.namePath + ".xml";
		if(this.hasXmlToSave()) {
			var out = new htmlparser_XmlBuilder();
			this.saveToXml(out);
			fileSystem.saveContent(xmlPath,out.toString());
		} else fileSystem.remove(xmlPath);
	}
	,hasXmlToSave: function() {
		return nanofl_engine_libraryitems_InstancableItem.prototype.hasXmlToSave.call(this) || this.originalExt != null && this.originalExt != "" || this.textureAtlas != null && this.textureAtlas != "";
	}
	,saveToXml: function(out) {
		out.begin("mesh").attr("version",nanofl_engine_Version.document);
		this.saveProperties(out);
		out.end();
	}
	,loadProperties: function(xml) {
		nanofl_engine_libraryitems_InstancableItem.prototype.loadProperties.call(this,xml);
		this.originalExt = htmlparser_HtmlParserTools.getAttr(xml,"originalExt",null);
		this.textureAtlas = htmlparser_HtmlParserTools.getAttr(xml,"textureAtlas",null);
		this.renderAreaSize = htmlparser_HtmlParserTools.getAttr(xml,"renderAreaSize",256);
		this.loadLights = htmlparser_HtmlParserTools.getAttr(xml,"loadLights",false);
	}
	,saveProperties: function(xml) {
		nanofl_engine_libraryitems_InstancableItem.prototype.saveProperties.call(this,xml);
		xml.attr("ext",this.ext,null);
		xml.attr("originalExt",this.originalExt,null);
		xml.attr("textureAtlas",this.textureAtlas,null);
		xml.attr("renderAreaSize",this.renderAreaSize,256);
		xml.attr("loadLights",this.loadLights,false);
	}
	,getUrl: function() {
		return this.library.realUrl(this.namePath + "." + this.ext);
	}
	,preload: function(ready) {
		stdlib_Debug.assert(this.library != null,"You need to add item '" + this.namePath + "' to the library before preload call.",{ fileName : "MeshItem.hx", lineNumber : 230, className : "nanofl.engine.libraryitems.MeshItem", methodName : "preload"});
		if(nanofl_engine_TextureItemTools.getSpriteSheet(this) == null) this.preloadInner(ready); else nanofl_engine_TextureItemTools.preload(this,ready);
	}
	,preloadInner: function(ready) {
		var _g = this;
		nanofl_engine_Loader.file(this.getUrl(),function(s) {
			var _g1 = _g.ext.toLowerCase();
			switch(_g1) {
			case "json":
				var json = tjson_TJSON.parse(s);
				var materials = nanofl_engine_libraryitems_MeshItem.parseMaterials(json);
				var _g2 = 0;
				while(_g2 < materials.length) {
					var material = materials[_g2];
					++_g2;
					if(Object.prototype.hasOwnProperty.call(material,"colorDiffuse")) Reflect.deleteField(material,"DbgColor");
					if(Object.prototype.hasOwnProperty.call(material,"colorAmbient")) Reflect.deleteField(material,"colorAmbient");
				}
				_g.textureFiles = nanofl_engine_libraryitems_MeshItem.parseTextureFiles(_g.namePath,materials);
				if(json.object != null) {
					var loader = new THREE.ObjectLoader();
					loader.setTexturePath(_g.library.realUrl(""));
					var obj = loader.parse(json);
					if(obj.type == "Scene") _g.scene = obj; else {
						_g.scene = new THREE.Scene();
						_g.scene.add(obj);
					}
				} else {
					var loader1 = new THREE.JSONLoader();
					var data = loader1.parse(json,_g.library.realUrl(""));
					_g.scene = new THREE.Scene();
					var material1;
					if(data.materials != null) material1 = new THREE.MeshFaceMaterial(data.materials); else material1 = new THREE.MeshLambertMaterial({ color : 11184810, overdraw : 1});
					_g.scene.add(new THREE.Mesh(data.geometry,material1));
				}
				_g.scene.traverse(function(object) {
					if(object.type == "Mesh") object.material.overdraw = 1;
				});
				_g.updateBoundingRadius();
				if(_g.textureFiles.length > 0) haxe_Timer.delay(function() {
					nanofl_engine_Loader.queued(_g.textureFiles.map(function(_) {
						return _g.library.realUrl(_);
					}),nanofl_engine_Loader.image,function(_1) {
						ready();
					});
				},1); else ready();
				break;
			default:
				stdlib_Debug.assert(false,"Unknow Mesh file extension ('" + _g.ext + "').",{ fileName : "MeshItem.hx", lineNumber : 330, className : "nanofl.engine.libraryitems.MeshItem", methodName : "preloadInner"});
			}
		});
	}
	,updateBoundingRadius: function() {
		var _g = this;
		this.boundingRadius = 0.0;
		this.scene.traverse(function(object) {
			nanofl_engine_libraryitems_MeshItem.log("MeshItem.updateBoundingRadius object " + object.type + " / " + object.name,{ fileName : "MeshItem.hx", lineNumber : 341, className : "nanofl.engine.libraryitems.MeshItem", methodName : "updateBoundingRadius"});
			if(object.type == "Mesh") {
				var mesh = object;
				mesh.updateMatrixWorld();
				var geometry = mesh.geometry;
				if(geometry.vertices != null) {
					var radiusSq = 0.0;
					var _g1 = 0;
					var _g11 = geometry.vertices;
					while(_g1 < _g11.length) {
						var v = _g11[_g1];
						++_g1;
						radiusSq = Math.max(radiusSq,mesh.localToWorld(v.clone()).lengthSq());
					}
					_g.boundingRadius = Math.max(_g.boundingRadius,radiusSq);
				}
			}
		});
		this.boundingRadius = Math.sqrt(this.boundingRadius);
		nanofl_engine_libraryitems_MeshItem.log("MeshItem.updateBoundingRadius boundingRadius = " + this.boundingRadius,{ fileName : "MeshItem.hx", lineNumber : 362, className : "nanofl.engine.libraryitems.MeshItem", methodName : "updateBoundingRadius"});
	}
	,createDisplayObject: function(initFrameIndex,childFrameIndexes) {
		var r = nanofl_engine_libraryitems_InstancableItem.prototype.createDisplayObject.call(this,initFrameIndex,childFrameIndexes);
		if(r == null) {
			var spriteSheet = nanofl_engine_TextureItemTools.getSpriteSheet(this);
			if(spriteSheet == null) r = new nanofl_Mesh(this); else r = new createjs.Sprite(spriteSheet);
		}
		return r;
	}
	,updateDisplayObject: function(dispObj,childFrameIndexes) {
		stdlib_Debug.assert(js_Boot.__instanceof(dispObj,nanofl_Mesh),null,{ fileName : "MeshItem.hx", lineNumber : 391, className : "nanofl.engine.libraryitems.MeshItem", methodName : "updateDisplayObject"});
		var mesh = dispObj;
		mesh.scene = new THREE.Scene();
		mesh.scene.fog = nanofl_engine_NullTools.clone(this.scene.fog);
		mesh.scene.add(mesh.group = new THREE.Group());
		var _g = 0;
		var _g1 = this.scene.children;
		while(_g < _g1.length) {
			var object = _g1[_g];
			++_g;
			var _g2 = object.type;
			switch(_g2) {
			case "AmbientLight":case "DirectionalLight":case "SpotLight":case "PointLight":case "HemisphereLight":
				if(this.loadLights) mesh.group.add(object.clone());
				break;
			default:
				mesh.group.add(object.clone());
			}
		}
		mesh.update();
	}
	,get_renderer: function() {
		if(this._rendererLoadLights != this.loadLights) this._renderer = null;
		if(this._renderer != null) {
			if(!nanofl_Mesh.forceSoftwareRenderer && nanofl_engine_libraryitems_MeshItem.isWebGLSupported()) {
				if(!js_Boot.__instanceof(this._renderer,THREE.WebGLRenderer)) this._renderer = null;
			} else if(!js_Boot.__instanceof(this._renderer,THREE.CanvasRenderer)) this._renderer = null;
		}
		if(this._renderer == null) {
			var canvas = window.document.createElement("canvas");
			canvas.width = canvas.height = this.renderAreaSize;
			if(!nanofl_Mesh.forceSoftwareRenderer && nanofl_engine_libraryitems_MeshItem.isWebGLSupported()) this._renderer = new THREE.WebGLRenderer({ canvas : canvas, alpha : true}); else this._renderer = new THREE.CanvasRenderer({ canvas : canvas, alpha : true});
			this._renderer.setSize(this.renderAreaSize,this.renderAreaSize);
			this._rendererLoadLights = this.loadLights;
		}
		return this._renderer;
	}
	,getDisplayObjectClassName: function() {
		return "nanofl.Mesh";
	}
	,equ: function(item) {
		if(item.namePath != this.namePath) return false;
		if(!js_Boot.__instanceof(item,nanofl_engine_libraryitems_MeshItem)) return false;
		if(item.ext != this.ext) return false;
		if(item.textureAtlas != this.textureAtlas) return false;
		if(item.renderAreaSize != this.renderAreaSize) return false;
		if(item.loadLights != this.loadLights) return false;
		return true;
	}
	,getNearestPoint: function(pos) {
		var d = this.renderAreaSize / 2;
		var bounds = { minX : -d, minY : -d, maxX : d, maxY : d};
		return nanofl_engine_geom_BoundsTools.getNearestPoint(bounds,pos);
	}
	,toString: function() {
		return "MeshItem(" + this.namePath + ")";
	}
	,hxUnserialize: function(s) {
		var _g = this;
		Object.defineProperty(this,"renderer",{ get : function() {
			return _g.get_renderer();
		}});
		nanofl_engine_libraryitems_InstancableItem.prototype.hxUnserialize.call(this,s);
	}
	,__class__: nanofl_engine_libraryitems_MeshItem
});
var nanofl_engine_libraryitems_MovieClipItem = function(namePath) {
	this.exportAsSpriteSheet = false;
	this.loop = true;
	this.autoPlay = true;
	this.likeButton = false;
	this._layers = [];
	var _g = this;
	Object.defineProperty(this,"layers",{ get : function() {
		return _g._layers;
	}});
	nanofl_engine_libraryitems_InstancableItem.call(this,namePath);
	this._layers = [];
};
$hxClasses["nanofl.engine.libraryitems.MovieClipItem"] = nanofl_engine_libraryitems_MovieClipItem;
nanofl_engine_libraryitems_MovieClipItem.__name__ = ["nanofl","engine","libraryitems","MovieClipItem"];
nanofl_engine_libraryitems_MovieClipItem.__interfaces__ = [nanofl_engine_ITextureItem,nanofl_engine_ISpriteSheetableItem,nanofl_engine_IFramedItem,nanofl_engine_ITimeline,nanofl_engine_ILayersContainer];
nanofl_engine_libraryitems_MovieClipItem.parse = function(namePath,itemNode) {
	if(itemNode.name != "movieclip") return null;
	var version = itemNode.getAttribute("version");
	if(version == null || version == "") version = "1.0.0";
	var r = new nanofl_engine_libraryitems_MovieClipItem(namePath);
	r.loadProperties(itemNode);
	var layers = [];
	var _g = 0;
	var _g1 = itemNode.children;
	while(_g < _g1.length) {
		var layerNode = _g1[_g];
		++_g;
		if(layerNode.name == "layer") layers.push(nanofl_engine_Layer.parse(layerNode,version));
	}
	r.addLayersBlock(layers);
	return r;
};
nanofl_engine_libraryitems_MovieClipItem.createWithFrame = function(namePath,elements,layerName) {
	if(layerName == null) layerName = "Layer 0";
	var item = new nanofl_engine_libraryitems_MovieClipItem(namePath);
	var layer = new nanofl_engine_Layer(layerName);
	item.addLayer(layer);
	layer.addKeyFrame(new nanofl_engine_KeyFrame(null,null,null,elements));
	return item;
};
nanofl_engine_libraryitems_MovieClipItem.__super__ = nanofl_engine_libraryitems_InstancableItem;
nanofl_engine_libraryitems_MovieClipItem.prototype = $extend(nanofl_engine_libraryitems_InstancableItem.prototype,{
	_layers: null
	,layers: null
	,get_layers: function() {
		return this._layers;
	}
	,likeButton: null
	,autoPlay: null
	,loop: null
	,exportAsSpriteSheet: null
	,textureAtlas: null
	,getType: function() {
		return "movieclip";
	}
	,clone: function() {
		var obj = new nanofl_engine_libraryitems_MovieClipItem(this.namePath);
		obj._layers = [];
		var $it0 = HxOverrides.iter(this.layers);
		while( $it0.hasNext() ) {
			var layer = $it0.next();
			obj.addLayer(layer.clone());
		}
		obj.likeButton = this.likeButton;
		obj.autoPlay = this.autoPlay;
		obj.loop = this.loop;
		obj.exportAsSpriteSheet = this.exportAsSpriteSheet;
		obj.textureAtlas = this.textureAtlas;
		this.copyBaseProperties(obj);
		return obj;
	}
	,addLayer: function(layer) {
		layer.layersContainer = this;
		this._layers.push(layer);
	}
	,addLayersBlock: function(layersToAdd,index) {
		if(index == null || index < 0 || index > this.layers.length) index = this.layers.length;
		var $it0 = HxOverrides.iter(this.layers);
		while( $it0.hasNext() ) {
			var layer = $it0.next();
			if(layer.parentIndex != null && layer.parentIndex >= index) layer.parentIndex += layersToAdd.length;
		}
		var n = index;
		var _g = 0;
		while(_g < layersToAdd.length) {
			var layer1 = layersToAdd[_g];
			++_g;
			layer1.layersContainer = this;
			if(layer1.parentIndex != null) layer1.parentIndex += index;
			this._layers.splice(n,0,layer1);
			n++;
		}
	}
	,removeLayer: function(index) {
		this._layers.splice(index,1);
		var $it0 = HxOverrides.iter(this.layers);
		while( $it0.hasNext() ) {
			var layer = $it0.next();
			if(layer.parentIndex != null) {
				if(layer.parentIndex == index) layer.parentIndex = null; else if(layer.parentIndex > index) layer.parentIndex--;
			}
		}
	}
	,removeLayerWithChildren: function(index) {
		var n = index + 1;
		while(n < this.layers.length && this.isLayerChildOf(n,index)) n++;
		var _g = 0;
		var _g1 = this.layers.slice(n);
		while(_g < _g1.length) {
			var layer = _g1[_g];
			++_g;
			if(layer.parentIndex != null) layer.parentIndex -= n - index;
		}
		var removedLayers = this._layers.splice(index,n - index);
		var _g2 = 0;
		while(_g2 < removedLayers.length) {
			var layer1 = removedLayers[_g2];
			++_g2;
			layer1.parentIndex -= index;
		}
		removedLayers[0].parentIndex = null;
		return removedLayers;
	}
	,isLayerChildOf: function(childIndex,parentIndex) {
		var pi = this.layers[childIndex].parentIndex;
		if(pi == null) return false;
		if(pi == parentIndex) return true;
		return this.isLayerChildOf(pi,parentIndex);
	}
	,getFramesAt: function(frameIndex) {
		var r = [];
		var i = this.layers.length - 1;
		while(i >= 0) {
			if(this.layers[i].visible) {
				var frame = this.layers[i].getFrame(frameIndex);
				if(frame != null) r.push(frame);
			}
			i--;
		}
		return r;
	}
	,getIcon: function() {
		if(this.namePath == nanofl_engine_Library.SCENE_NAME_PATH) return "custom-icon-scene";
		if(this.likeButton) return "custom-icon-button";
		return "custom-icon-film";
	}
	,save: function(fileSystem) {
		var out = new htmlparser_XmlBuilder();
		this.saveToXml(out);
		fileSystem.saveContent(this.library.libraryDir + "/" + this.namePath + ".xml",out.toString());
	}
	,loadProperties: function(xml) {
		this.likeButton = htmlparser_HtmlParserTools.getAttr(xml,"likeButton",false);
		this.exportAsSpriteSheet = htmlparser_HtmlParserTools.getAttr(xml,"exportAsSpriteSheet",false);
		this.autoPlay = htmlparser_HtmlParserTools.getAttr(xml,"autoPlay",true);
		this.loop = htmlparser_HtmlParserTools.getAttr(xml,"loop",true);
		this.textureAtlas = htmlparser_HtmlParserTools.getAttr(xml,"textureAtlas",null);
		nanofl_engine_libraryitems_InstancableItem.prototype.loadProperties.call(this,xml);
	}
	,saveProperties: function(xml) {
		xml.attr("likeButton",this.likeButton,false);
		xml.attr("exportAsSpriteSheet",this.exportAsSpriteSheet,false);
		xml.attr("autoPlay",this.autoPlay,true);
		xml.attr("loop",this.loop,true);
		xml.attr("textureAtlas",this.textureAtlas,null);
		nanofl_engine_libraryitems_InstancableItem.prototype.saveProperties.call(this,xml);
	}
	,hasXmlToSave: function() {
		return true;
	}
	,saveToXml: function(out) {
		out.begin("movieclip").attr("version",nanofl_engine_Version.document);
		this.saveProperties(out);
		var $it0 = HxOverrides.iter(this.layers);
		while( $it0.hasNext() ) {
			var layer = $it0.next();
			layer.save(out);
		}
		out.end();
	}
	,getTotalFrames: function() {
		var r = 0;
		var $it0 = HxOverrides.iter(this.layers);
		while( $it0.hasNext() ) {
			var layer = $it0.next();
			r = stdlib_Std.max(r,layer.getTotalFrames());
		}
		return r;
	}
	,setLibrary: function(library) {
		nanofl_engine_libraryitems_InstancableItem.prototype.setLibrary.call(this,library);
		var $it0 = HxOverrides.iter(this.layers);
		while( $it0.hasNext() ) {
			var layer = $it0.next();
			layer.setLibrary(library);
		}
	}
	,createDisplayObject: function(initFrameIndex,childFrameIndexes) {
		var r = nanofl_engine_libraryitems_InstancableItem.prototype.createDisplayObject.call(this,initFrameIndex,childFrameIndexes);
		if(r != null) return r;
		var spriteSheet = nanofl_engine_TextureItemTools.getSpriteSheet(this);
		if(spriteSheet == null && this.exportAsSpriteSheet) spriteSheet = this.asSpriteSheet();
		if(spriteSheet == null) if(!this.likeButton) return new nanofl_MovieClip(this,initFrameIndex,childFrameIndexes); else return new nanofl_Button(this); else if(!this.likeButton) return new createjs.Sprite(spriteSheet,initFrameIndex); else return new nanofl_SpriteButton(spriteSheet);
	}
	,updateDisplayObject: function(dispObj,childFrameIndexes) {
		if(this.exportAsSpriteSheet) {
		} else {
			stdlib_Debug.assert(js_Boot.__instanceof(dispObj,nanofl_MovieClip),null,{ fileName : "MovieClipItem.hx", lineNumber : 295, className : "nanofl.engine.libraryitems.MovieClipItem", methodName : "updateDisplayObject"});
			var movieClip = dispObj;
			movieClip.removeAllChildren();
			movieClip.alpha = 1.0;
			var topElement = null;
			var topElementLayer = null;
			var i = this.layers.length - 1;
			while(i >= 0) {
				var _g = 0;
				var _g1 = this.layers[i].getTweenedElements(movieClip.currentFrame);
				while(_g < _g1.length) {
					var tweenedElement = _g1[_g];
					++_g;
					if(childFrameIndexes == null || childFrameIndexes.length == 0 || childFrameIndexes[0].element != tweenedElement.original) {
						var obj = tweenedElement.current.createDisplayObject(childFrameIndexes);
						obj.visible = this.layers[i].type == "normal";
						movieClip.addChildToLayer(obj,i);
					} else if(childFrameIndexes != null && childFrameIndexes.length != 0 && childFrameIndexes[0].element == tweenedElement.original) {
						topElement = tweenedElement.current;
						topElementLayer = i;
					}
				}
				i--;
			}
			if(topElement != null) movieClip.addChildToLayer(topElement.createDisplayObject(childFrameIndexes),topElementLayer);
		}
	}
	,spriteSheet: null
	,asSpriteSheet: function() {
		if(this.spriteSheet == null) {
			var builder = new createjs.SpriteSheetBuilder();
			var t = this.exportAsSpriteSheet;
			this.exportAsSpriteSheet = false;
			var _g1 = 0;
			var _g = this.getTotalFrames();
			while(_g1 < _g) {
				var i = _g1++;
				var mc = new nanofl_MovieClip(this,i,null);
				builder.addFrame(mc);
			}
			this.exportAsSpriteSheet = t;
			this.spriteSheet = builder.build();
		}
		return this.spriteSheet;
	}
	,getNearestPoint: function(pos) {
		var points = [];
		var $it0 = HxOverrides.iter(this.layers);
		while( $it0.hasNext() ) {
			var layer = $it0.next();
			if(layer.keyFrames.length > 0) {
				var $it1 = HxOverrides.iter(layer.keyFrames[0].elements);
				while( $it1.hasNext() ) {
					var element = $it1.next();
					points.push(element.getNearestPoint(pos));
				}
			}
		}
		points.sort(function(a,b) {
			return Reflect.compare(nanofl_engine_geom_PointTools.getDist(pos.x,pos.y,a.x,a.y),nanofl_engine_geom_PointTools.getDist(pos.x,pos.y,b.x,b.y));
		});
		if(points.length > 0) return points[0]; else return { x : 1e100, y : 1e100};
	}
	,getDisplayObjectClassName: function() {
		if(!this.likeButton) return "nanofl.MovieClip"; else return "nanofl.Button";
	}
	,transform: function(m) {
		var $it0 = HxOverrides.iter(this.layers);
		while( $it0.hasNext() ) {
			var layer = $it0.next();
			var $it1 = HxOverrides.iter(layer.keyFrames);
			while( $it1.hasNext() ) {
				var keyFrame = $it1.next();
				var $it2 = HxOverrides.iter(keyFrame.elements);
				while( $it2.hasNext() ) {
					var element = $it2.next();
					element.transform(m);
				}
			}
		}
	}
	,preload: function(ready) {
		nanofl_engine_TextureItemTools.preload(this,ready);
	}
	,equ: function(item) {
		if(item.namePath != this.namePath) return false;
		if(!js_Boot.__instanceof(item,nanofl_engine_libraryitems_MovieClipItem)) return false;
		if(item.linkedClass != this.linkedClass) return false;
		if(!nanofl_engine_ArrayTools.equ(item._layers,this._layers)) return false;
		if(item.likeButton != this.likeButton) return false;
		if(item.autoPlay != this.autoPlay) return false;
		if(item.loop != this.loop) return false;
		if(item.exportAsSpriteSheet != this.exportAsSpriteSheet) return false;
		if(item.textureAtlas != this.textureAtlas) return false;
		return true;
	}
	,toString: function() {
		return "MovieClipItem(" + this.namePath + ")";
	}
	,hxUnserialize: function(s) {
		var _g = this;
		Object.defineProperty(this,"layers",{ get : function() {
			return _g._layers;
		}});
		nanofl_engine_libraryitems_InstancableItem.prototype.hxUnserialize.call(this,s);
	}
	,__class__: nanofl_engine_libraryitems_MovieClipItem
});
var nanofl_engine_libraryitems_SoundItem = function(namePath,ext) {
	this.linkage = "";
	nanofl_engine_libraryitems_LibraryItem.call(this,namePath);
	this.ext = ext;
};
$hxClasses["nanofl.engine.libraryitems.SoundItem"] = nanofl_engine_libraryitems_SoundItem;
nanofl_engine_libraryitems_SoundItem.__name__ = ["nanofl","engine","libraryitems","SoundItem"];
nanofl_engine_libraryitems_SoundItem.parse = function(namePath,itemNode) {
	if(itemNode.name != "sound") return null;
	return new nanofl_engine_libraryitems_SoundItem(namePath,itemNode.getAttribute("ext"));
};
nanofl_engine_libraryitems_SoundItem.__super__ = nanofl_engine_libraryitems_LibraryItem;
nanofl_engine_libraryitems_SoundItem.prototype = $extend(nanofl_engine_libraryitems_LibraryItem.prototype,{
	ext: null
	,linkage: null
	,getType: function() {
		return "sound";
	}
	,clone: function() {
		var obj = new nanofl_engine_libraryitems_SoundItem(this.namePath,this.ext);
		obj.linkage = this.linkage;
		this.copyBaseProperties(obj);
		return obj;
	}
	,getIcon: function() {
		return "custom-icon-sound";
	}
	,save: function(fileSystem) {
		var xmlPath = this.library.libraryDir + "/" + this.namePath + ".xml";
		if(this.hasXmlToSave()) {
			var out = new htmlparser_XmlBuilder();
			this.saveToXml(out);
			fileSystem.saveContent(xmlPath,out.toString());
		} else fileSystem.remove(xmlPath);
	}
	,hasXmlToSave: function() {
		return nanofl_engine_libraryitems_LibraryItem.prototype.hasXmlToSave.call(this) || this.linkage != "";
	}
	,saveToXml: function(out) {
		out.begin("sound").attr("version",nanofl_engine_Version.document);
		this.saveProperties(out);
		out.end();
	}
	,saveProperties: function(xml) {
		nanofl_engine_libraryitems_LibraryItem.prototype.saveProperties.call(this,xml);
		xml.attr("linkage",this.linkage,"");
	}
	,loadProperties: function(xml) {
		nanofl_engine_libraryitems_LibraryItem.prototype.loadProperties.call(this,xml);
		this.linkage = htmlparser_HtmlParserTools.getAttr(xml,"linkage","");
	}
	,getUrl: function() {
		return this.library.realUrl(this.namePath + "." + this.ext);
	}
	,equ: function(item) {
		if(item.namePath != this.namePath) return false;
		if(!js_Boot.__instanceof(item,nanofl_engine_libraryitems_SoundItem)) return false;
		if(item.ext != this.ext) return false;
		if(item.linkage != this.linkage) return false;
		return true;
	}
	,toString: function() {
		return "SoundItem(" + this.namePath + ")";
	}
	,__class__: nanofl_engine_libraryitems_SoundItem
});
var nanofl_engine_libraryitems_SpriteItem = function(namePath,frames) {
	this.loop = true;
	this.autoPlay = true;
	this.likeButton = false;
	var _g = this;
	Object.defineProperty(this,"layers",{ get : function() {
		return _g.get_layers();
	}});
	nanofl_engine_libraryitems_InstancableItem.call(this,namePath);
	this.frames = frames;
};
$hxClasses["nanofl.engine.libraryitems.SpriteItem"] = nanofl_engine_libraryitems_SpriteItem;
nanofl_engine_libraryitems_SpriteItem.__name__ = ["nanofl","engine","libraryitems","SpriteItem"];
nanofl_engine_libraryitems_SpriteItem.__interfaces__ = [nanofl_engine_ITextureItem,nanofl_engine_ILayersContainer];
nanofl_engine_libraryitems_SpriteItem.parse = function(namePath,itemNode) {
	if(itemNode.name != "sprite") return null;
	var r = new nanofl_engine_libraryitems_SpriteItem(namePath,itemNode.children.map(function(xml) {
		return { image : htmlparser_HtmlParserTools.getAttrString(xml,"image"), x : htmlparser_HtmlParserTools.getAttrInt(xml,"x"), y : htmlparser_HtmlParserTools.getAttrInt(xml,"y"), width : htmlparser_HtmlParserTools.getAttrInt(xml,"width"), height : htmlparser_HtmlParserTools.getAttrInt(xml,"height"), regX : htmlparser_HtmlParserTools.getAttrFloat(xml,"regX"), regY : htmlparser_HtmlParserTools.getAttrFloat(xml,"regY")};
	}));
	r.loadProperties(itemNode);
	return r;
};
nanofl_engine_libraryitems_SpriteItem.__super__ = nanofl_engine_libraryitems_InstancableItem;
nanofl_engine_libraryitems_SpriteItem.prototype = $extend(nanofl_engine_libraryitems_InstancableItem.prototype,{
	frames: null
	,_layers: null
	,layers: null
	,get_layers: function() {
		if(this._layers == null) {
			var layer = new nanofl_engine_Layer("auto");
			layer.layersContainer = this;
			var _g1 = 0;
			var _g = this.frames.length;
			while(_g1 < _g) {
				var i = _g1++;
				layer.addKeyFrame(new nanofl_engine_KeyFrame(null,1,null,[new nanofl_engine_elements_SpriteFrameElement(this,i)]));
			}
			this._layers = [layer];
		}
		return this._layers;
	}
	,likeButton: null
	,autoPlay: null
	,loop: null
	,textureAtlas: null
	,spriteSheet: null
	,getNotSerializableFields: function() {
		return nanofl_engine_libraryitems_InstancableItem.prototype.getNotSerializableFields.call(this).concat(["_layers","spriteSheet"]);
	}
	,getType: function() {
		return "sprite";
	}
	,clone: function() {
		var obj = new nanofl_engine_libraryitems_SpriteItem(this.namePath,this.frames);
		obj.likeButton = this.likeButton;
		obj.autoPlay = this.autoPlay;
		obj.loop = this.loop;
		obj.textureAtlas = this.textureAtlas;
		obj.spriteSheet = this.spriteSheet;
		this.copyBaseProperties(obj);
		return obj;
	}
	,getIcon: function() {
		return "custom-icon-picture";
	}
	,loadProperties: function(xml) {
		this.likeButton = htmlparser_HtmlParserTools.getAttr(xml,"likeButton",false);
		this.autoPlay = htmlparser_HtmlParserTools.getAttr(xml,"autoPlay",true);
		this.loop = htmlparser_HtmlParserTools.getAttr(xml,"loop",true);
		this.textureAtlas = htmlparser_HtmlParserTools.getAttr(xml,"textureAtlas",null);
		nanofl_engine_libraryitems_InstancableItem.prototype.loadProperties.call(this,xml);
	}
	,saveProperties: function(xml) {
		xml.attr("likeButton",this.likeButton,false);
		xml.attr("autoPlay",this.autoPlay,true);
		xml.attr("loop",this.loop,true);
		xml.attr("textureAtlas",this.textureAtlas,null);
		nanofl_engine_libraryitems_InstancableItem.prototype.saveProperties.call(this,xml);
	}
	,hasXmlToSave: function() {
		return true;
	}
	,saveToXml: function(out) {
		out.begin("sprite").attr("version",nanofl_engine_Version.document);
		this.saveProperties(out);
		var _g = 0;
		var _g1 = this.frames;
		while(_g < _g1.length) {
			var frame = _g1[_g];
			++_g;
			out.begin("frame");
			out.attr("image",frame.image);
			out.attr("x",frame.x);
			out.attr("y",frame.y);
			out.attr("width",frame.width);
			out.attr("height",frame.height);
			out.attr("regX",frame.regX);
			out.attr("regY",frame.regY);
			out.end();
		}
		out.end();
	}
	,preload: function(ready) {
		stdlib_Debug.assert(this.library != null,"You need to add item '" + this.namePath + "' to the library before preload call.",{ fileName : "SpriteItem.hx", lineNumber : 148, className : "nanofl.engine.libraryitems.SpriteItem", methodName : "preload"});
		if(nanofl_engine_TextureItemTools.getSpriteSheet(this) == null) this.ensureSpriteSheet(ready); else nanofl_engine_TextureItemTools.preload(this,ready);
	}
	,createDisplayObject: function(initFrameIndex,childFrameIndexes) {
		var r = nanofl_engine_libraryitems_InstancableItem.prototype.createDisplayObject.call(this,initFrameIndex,childFrameIndexes);
		if(r != null) return r;
		var spriteSheet = nanofl_engine_TextureItemTools.getSpriteSheet(this);
		if(spriteSheet == null) spriteSheet = this.spriteSheet;
		stdlib_Debug.assert(spriteSheet != null,null,{ fileName : "SpriteItem.hx", lineNumber : 167, className : "nanofl.engine.libraryitems.SpriteItem", methodName : "createDisplayObject"});
		stdlib_Debug.assert(spriteSheet.complete,null,{ fileName : "SpriteItem.hx", lineNumber : 168, className : "nanofl.engine.libraryitems.SpriteItem", methodName : "createDisplayObject"});
		var sprite = new createjs.Sprite(spriteSheet);
		sprite.gotoAndStop(initFrameIndex);
		return sprite;
	}
	,updateDisplayObject: function(dispObj,childFrameIndexes) {
	}
	,ensureSpriteSheet: function(ready) {
		var _g = this;
		if(this.spriteSheet == null) {
			var images = [];
			var _g1 = 0;
			var _g11 = this.frames;
			while(_g1 < _g11.length) {
				var f1 = _g11[_g1];
				++_g1;
				if(HxOverrides.indexOf(images,f1.image,0) < 0) images.push(f1.image);
			}
			var data = { images : images.map(function(image) {
				return _g.library.realUrl(image);
			}), frames : this.frames.map(function(f) {
				return [f.x,f.y,f.width,f.height,HxOverrides.indexOf(images,f.image,0),f.regX,f.regY];
			})};
			this.spriteSheet = new createjs.SpriteSheet(data);
		}
		if(!this.spriteSheet.complete) this.spriteSheet.addEventListener("complete",function(_) {
			ready();
		},null); else ready();
	}
	,getNearestPoint: function(pos) {
		if(this.frames.length == 0) return { x : 1e100, y : 1e100};
		var frame = this.frames[0];
		var bounds = { minX : -frame.regX, minY : -frame.regY, maxX : frame.width - frame.regX, maxY : frame.height - frame.regY};
		return nanofl_engine_geom_BoundsTools.getNearestPoint(bounds,pos);
	}
	,getDisplayObjectClassName: function() {
		if(!this.likeButton) return "nanofl.Sprite"; else return "nanofl.SpriteButton";
	}
	,toString: function() {
		return "SpriteItem(" + this.namePath + ")";
	}
	,hxUnserialize: function(s) {
		var _g = this;
		Object.defineProperty(this,"layers",{ get : function() {
			return _g.get_layers();
		}});
		nanofl_engine_libraryitems_InstancableItem.prototype.hxUnserialize.call(this,s);
	}
	,__class__: nanofl_engine_libraryitems_SpriteItem
});
var nanofl_engine_plugins_FilterPlugins = $hx_exports.nanofl.engine.plugins.FilterPlugins = function() { };
$hxClasses["nanofl.engine.plugins.FilterPlugins"] = nanofl_engine_plugins_FilterPlugins;
nanofl_engine_plugins_FilterPlugins.__name__ = ["nanofl","engine","plugins","FilterPlugins"];
nanofl_engine_plugins_FilterPlugins.register = function(plugin) {
	nanofl_engine_plugins_FilterPlugins.plugins.set(plugin.name,plugin);
};
var nanofl_engine_plugins_IFilterPlugin = $hx_exports.nanofl.engine.plugins.IFilterPlugin = function() { };
$hxClasses["nanofl.engine.plugins.IFilterPlugin"] = nanofl_engine_plugins_IFilterPlugin;
nanofl_engine_plugins_IFilterPlugin.__name__ = ["nanofl","engine","plugins","IFilterPlugin"];
nanofl_engine_plugins_IFilterPlugin.prototype = {
	name: null
	,label: null
	,properties: null
	,getFilter: null
	,__class__: nanofl_engine_plugins_IFilterPlugin
};
var nanofl_engine_strokes_BaseStroke = function(thickness,caps,joints,miterLimit,ignoreScale) {
	if(ignoreScale == null) ignoreScale = false;
	if(miterLimit == null) miterLimit = 3.0;
	if(joints == null) joints = "round";
	if(caps == null) caps = "round";
	if(thickness == null) thickness = 1.0;
	this.thickness = thickness;
	this.caps = caps;
	this.joints = joints;
	this.miterLimit = miterLimit;
	this.ignoreScale = ignoreScale;
};
$hxClasses["nanofl.engine.strokes.BaseStroke"] = nanofl_engine_strokes_BaseStroke;
nanofl_engine_strokes_BaseStroke.__name__ = ["nanofl","engine","strokes","BaseStroke"];
nanofl_engine_strokes_BaseStroke.load = function(node,version) {
	var r;
	var _g = htmlparser_HtmlParserTools.getAttr(node,"type");
	switch(_g) {
	case "solid":
		r = new nanofl_engine_strokes_SolidStroke();
		break;
	case "linear":
		r = new nanofl_engine_strokes_LinearStroke([],[],0,0,0,0);
		break;
	case "bitmap":
		r = new nanofl_engine_strokes_BitmapStroke();
		break;
	default:
		throw new js__$Boot_HaxeError("Unknow stroke type '" + Std.string(htmlparser_HtmlParserTools.getAttr(node,"type")) + "'.");
	}
	r.loadProperties(node);
	return r;
};
nanofl_engine_strokes_BaseStroke.prototype = {
	thickness: null
	,caps: null
	,joints: null
	,miterLimit: null
	,ignoreScale: null
	,loadProperties: function(node) {
		this.thickness = htmlparser_HtmlParserTools.getAttr(node,"thickness",1.0);
		this.caps = htmlparser_HtmlParserTools.getAttr(node,"caps","round");
		this.joints = htmlparser_HtmlParserTools.getAttr(node,"joints","round");
		this.miterLimit = htmlparser_HtmlParserTools.getAttr(node,"miterLimit",3.0);
		this.ignoreScale = htmlparser_HtmlParserTools.getAttr(node,"ignoreScale",false);
	}
	,saveProperties: function(out) {
		out.attr("thickness",this.thickness,1.0);
		out.attr("caps",this.caps,"round");
		out.attr("joints",this.joints,"round");
		out.attr("miterLimit",this.miterLimit,3.0);
		out.attr("ignoreScale",this.ignoreScale,false);
	}
	,setStrokeStyle: function(g) {
		g.setStrokeStyle(this.thickness,this.caps,this.joints,this.miterLimit,this.ignoreScale);
	}
	,clone: function() {
		throw new js__$Boot_HaxeError("Cloning of " + Type.getClassName(js_Boot.getClass(this)) + " is not supported.");
		return null;
	}
	,equ: function(e) {
		var ee = e;
		return ee.thickness == this.thickness && ee.caps == this.caps && ee.joints == this.joints && ee.miterLimit == this.miterLimit && ee.ignoreScale == this.ignoreScale;
	}
	,setLibrary: function(library) {
	}
	,getTransformed: function(m,applyToThickness) {
		var r = this.clone();
		if(applyToThickness) r.thickness *= m.getAverageScale();
		return r;
	}
	,__class__: nanofl_engine_strokes_BaseStroke
};
var nanofl_engine_strokes_IStroke = function() { };
$hxClasses["nanofl.engine.strokes.IStroke"] = nanofl_engine_strokes_IStroke;
nanofl_engine_strokes_IStroke.__name__ = ["nanofl","engine","strokes","IStroke"];
nanofl_engine_strokes_IStroke.prototype = {
	thickness: null
	,caps: null
	,joints: null
	,miterLimit: null
	,ignoreScale: null
	,begin: null
	,clone: null
	,equ: null
	,applyAlpha: null
	,getTransformed: null
	,getTyped: null
	,save: null
	,swapInstance: null
	,setLibrary: null
	,toString: null
	,__class__: nanofl_engine_strokes_IStroke
};
var nanofl_engine_strokes_BitmapStroke = function(bitmapPath,repeat,thickness,caps,joints,miterLimit,ignoreScale) {
	if(ignoreScale == null) ignoreScale = false;
	if(miterLimit == null) miterLimit = 3.0;
	if(joints == null) joints = "round";
	if(caps == null) caps = "round";
	if(thickness == null) thickness = 1.0;
	if(repeat == null) repeat = "repeat";
	nanofl_engine_strokes_BaseStroke.call(this,thickness,caps,joints,miterLimit,ignoreScale);
	this.bitmapPath = bitmapPath;
	this.repeat = repeat;
};
$hxClasses["nanofl.engine.strokes.BitmapStroke"] = nanofl_engine_strokes_BitmapStroke;
nanofl_engine_strokes_BitmapStroke.__name__ = ["nanofl","engine","strokes","BitmapStroke"];
nanofl_engine_strokes_BitmapStroke.__interfaces__ = [nanofl_engine_strokes_IStroke];
nanofl_engine_strokes_BitmapStroke.__super__ = nanofl_engine_strokes_BaseStroke;
nanofl_engine_strokes_BitmapStroke.prototype = $extend(nanofl_engine_strokes_BaseStroke.prototype,{
	library: null
	,bitmapPath: null
	,repeat: null
	,loadProperties: function(node) {
		nanofl_engine_strokes_BaseStroke.prototype.loadProperties.call(this,node);
		this.bitmapPath = htmlparser_HtmlParserTools.getAttr(node,"bitmapPath");
		this.repeat = htmlparser_HtmlParserTools.getAttr(node,"repeat");
	}
	,save: function(out) {
		out.begin("stroke").attr("type","bitmap");
		this.saveProperties(out);
		out.end();
	}
	,saveProperties: function(out) {
		out.attr("bitmapPath",this.bitmapPath);
		out.attr("repeat",this.repeat,"repeat");
		nanofl_engine_strokes_BaseStroke.prototype.saveProperties.call(this,out);
	}
	,begin: function(g) {
		if(this.library.hasItem(this.bitmapPath)) {
			var image;
			image = (js_Boot.__cast(this.library.getItem(this.bitmapPath) , nanofl_engine_libraryitems_BitmapItem)).image;
			g.beginBitmapStroke(image,this.repeat);
			this.setStrokeStyle(g);
		} else g.beginStroke("rgba(0,0,0,0)");
	}
	,clone: function() {
		var obj = new nanofl_engine_strokes_BitmapStroke(this.bitmapPath,this.repeat,this.thickness,this.caps,this.joints,this.miterLimit,this.ignoreScale);
		obj.library = this.library;
		return obj;
	}
	,equ: function(e) {
		if(e == this) return true;
		if(!js_Boot.__instanceof(e,nanofl_engine_strokes_BitmapStroke) || !nanofl_engine_strokes_BaseStroke.prototype.equ.call(this,e)) return false;
		var ee = e;
		return ee.bitmapPath == this.bitmapPath && ee.repeat == this.repeat;
	}
	,swapInstance: function(oldNamePath,newNamePath) {
		if(this.bitmapPath == oldNamePath) this.bitmapPath = newNamePath;
	}
	,setLibrary: function(library) {
		this.library = library;
	}
	,applyAlpha: function(alpha) {
	}
	,getTyped: function() {
		return nanofl_engine_strokes_TypedStroke.BITMAP(this);
	}
	,toString: function() {
		return "new BitmapStroke(\"" + this.bitmapPath + "\")";
	}
	,__class__: nanofl_engine_strokes_BitmapStroke
});
var nanofl_engine_strokes_LinearStroke = function(colors,ratios,x0,y0,x1,y1,thickness,caps,joints,miterLimit,ignoreScale) {
	if(ignoreScale == null) ignoreScale = false;
	if(miterLimit == null) miterLimit = 3.0;
	if(joints == null) joints = "round";
	if(caps == null) caps = "round";
	if(thickness == null) thickness = 1.0;
	nanofl_engine_strokes_BaseStroke.call(this,thickness,caps,joints,miterLimit,ignoreScale);
	this.colors = colors;
	this.ratios = ratios;
	this.x0 = x0;
	this.y0 = y0;
	this.x1 = x1;
	this.y1 = y1;
};
$hxClasses["nanofl.engine.strokes.LinearStroke"] = nanofl_engine_strokes_LinearStroke;
nanofl_engine_strokes_LinearStroke.__name__ = ["nanofl","engine","strokes","LinearStroke"];
nanofl_engine_strokes_LinearStroke.__interfaces__ = [nanofl_engine_strokes_IStroke];
nanofl_engine_strokes_LinearStroke.__super__ = nanofl_engine_strokes_BaseStroke;
nanofl_engine_strokes_LinearStroke.prototype = $extend(nanofl_engine_strokes_BaseStroke.prototype,{
	colors: null
	,ratios: null
	,x0: null
	,y0: null
	,x1: null
	,y1: null
	,loadProperties: function(node) {
		nanofl_engine_strokes_BaseStroke.prototype.loadProperties.call(this,node);
		this.colors = htmlparser_HtmlParserTools.getAttr(node,"colors",[]);
		this.ratios = htmlparser_HtmlParserTools.getAttr(node,"ratios",[0.0]);
		this.x0 = htmlparser_HtmlParserTools.getAttr(node,"x0",0.0);
		this.y0 = htmlparser_HtmlParserTools.getAttr(node,"y0",0.0);
		this.x1 = htmlparser_HtmlParserTools.getAttr(node,"x1",0.0);
		this.y1 = htmlparser_HtmlParserTools.getAttr(node,"y1",0.0);
	}
	,save: function(out) {
		out.begin("stroke").attr("type","linear");
		this.saveProperties(out);
		out.end();
	}
	,saveProperties: function(out) {
		out.attr("colors",this.colors);
		out.attr("ratios",this.ratios);
		out.attr("x0",this.x0);
		out.attr("y0",this.y0);
		out.attr("x1",this.x1);
		out.attr("y1",this.y1);
		nanofl_engine_strokes_BaseStroke.prototype.saveProperties.call(this,out);
	}
	,begin: function(g) {
		g.beginLinearGradientStroke(this.colors,this.ratios,this.x0,this.y0,this.x1,this.y1);
		this.setStrokeStyle(g);
	}
	,clone: function() {
		return new nanofl_engine_strokes_LinearStroke(this.colors,this.ratios,this.x0,this.y0,this.x1,this.y1,this.thickness,this.caps,this.joints,this.miterLimit,this.ignoreScale);
	}
	,equ: function(e) {
		if(e == this) return true;
		if(!js_Boot.__instanceof(e,nanofl_engine_strokes_LinearStroke) || !nanofl_engine_strokes_BaseStroke.prototype.equ.call(this,e)) return false;
		var ee = e;
		return this.arrEqu(ee.colors,this.colors) && this.arrEqu(ee.ratios,this.ratios) && ee.x0 == this.x0 && ee.y0 == this.y0 && ee.x1 == this.x1 && ee.y1 == this.y1;
	}
	,swapInstance: function(oldNamePath,newNamePath) {
	}
	,applyAlpha: function(alpha) {
		var _g1 = 0;
		var _g = this.colors.length;
		while(_g1 < _g) {
			var i = _g1++;
			var rgba = nanofl_engine_ColorTools.parse(this.colors[i]);
			rgba.a *= alpha;
			this.colors[i] = nanofl_engine_ColorTools.rgbaToString(rgba);
		}
	}
	,getTransformed: function(m,applyToThickness) {
		var r = nanofl_engine_strokes_BaseStroke.prototype.getTransformed.call(this,m,applyToThickness);
		var p0 = m.transformPoint(this.x0,this.y0);
		r.x0 = p0.x;
		r.y0 = p0.y;
		var p1 = m.transformPoint(this.x1,this.y1);
		r.x1 = p1.x;
		r.y1 = p1.y;
		return r;
	}
	,getTyped: function() {
		return nanofl_engine_strokes_TypedStroke.LINEAR(this);
	}
	,toString: function() {
		return "new LinearStroke(" + Std.string(this.colors.map(function(s) {
			return "\"" + s + "\"";
		})) + (", " + Std.string(this.ratios) + ", " + this.x0 + ", " + this.y0 + ", " + this.x1 + ", " + this.y1 + ")");
	}
	,arrEqu: function(a,b) {
		if(a.length != b.length) return false;
		var _g1 = 0;
		var _g = a.length;
		while(_g1 < _g) {
			var i = _g1++;
			if(a[i] != b[i]) return false;
		}
		return true;
	}
	,__class__: nanofl_engine_strokes_LinearStroke
});
var nanofl_engine_strokes_RadialStroke = function(colors,ratios,cx,cy,r,fx,fy,thickness,caps,joints,miterLimit,ignoreScale) {
	if(ignoreScale == null) ignoreScale = false;
	if(miterLimit == null) miterLimit = 3.0;
	if(joints == null) joints = "round";
	if(caps == null) caps = "round";
	if(thickness == null) thickness = 1.0;
	nanofl_engine_strokes_BaseStroke.call(this,thickness,caps,joints,miterLimit,ignoreScale);
	this.colors = colors;
	this.ratios = ratios;
	this.cx = cx;
	this.cy = cy;
	this.r = r;
	this.fx = fx;
	this.fy = fy;
};
$hxClasses["nanofl.engine.strokes.RadialStroke"] = nanofl_engine_strokes_RadialStroke;
nanofl_engine_strokes_RadialStroke.__name__ = ["nanofl","engine","strokes","RadialStroke"];
nanofl_engine_strokes_RadialStroke.__interfaces__ = [nanofl_engine_strokes_IStroke];
nanofl_engine_strokes_RadialStroke.__super__ = nanofl_engine_strokes_BaseStroke;
nanofl_engine_strokes_RadialStroke.prototype = $extend(nanofl_engine_strokes_BaseStroke.prototype,{
	colors: null
	,ratios: null
	,cx: null
	,cy: null
	,r: null
	,fx: null
	,fy: null
	,loadProperties: function(node) {
		nanofl_engine_strokes_BaseStroke.prototype.loadProperties.call(this,node);
		this.colors = htmlparser_HtmlParserTools.getAttr(node,"colors",[]);
		this.ratios = htmlparser_HtmlParserTools.getAttr(node,"ratios",[0.0]);
		this.cx = htmlparser_HtmlParserTools.getAttr(node,"cx",0.0);
		this.cy = htmlparser_HtmlParserTools.getAttr(node,"cy",0.0);
		this.r = htmlparser_HtmlParserTools.getAttr(node,"r",0.0);
		this.fx = htmlparser_HtmlParserTools.getAttr(node,"fx",this.cx);
		this.fy = htmlparser_HtmlParserTools.getAttr(node,"fy",this.cy);
	}
	,save: function(out) {
		out.begin("stroke").attr("type","linear");
		this.saveProperties(out);
		out.end();
	}
	,saveProperties: function(out) {
		out.attr("colors",this.colors);
		out.attr("ratios",this.ratios);
		out.attr("cx",this.cx);
		out.attr("cy",this.cy);
		out.attr("r",this.r);
		out.attr("fx",this.fx,this.cx);
		out.attr("fy",this.fy,this.cy);
		nanofl_engine_strokes_BaseStroke.prototype.saveProperties.call(this,out);
	}
	,begin: function(g) {
		g.beginRadialGradientStroke(this.colors,this.ratios,this.fx,this.fy,0,this.cx,this.cy,this.r);
		this.setStrokeStyle(g);
	}
	,clone: function() {
		return new nanofl_engine_strokes_RadialStroke(this.colors,this.ratios,this.cx,this.cy,this.r,this.fx,this.fy,this.thickness,this.caps,this.joints,this.miterLimit,this.ignoreScale);
	}
	,equ: function(e) {
		if(e == this) return true;
		if(!js_Boot.__instanceof(e,nanofl_engine_strokes_RadialStroke) || !nanofl_engine_strokes_BaseStroke.prototype.equ.call(this,e)) return false;
		var ee = e;
		return this.arrEqu(ee.colors,this.colors) && this.arrEqu(ee.ratios,this.ratios) && ee.cx == this.cx && ee.cy == this.cy && ee.r == this.r && ee.fx == this.fx && ee.fy == this.fy;
	}
	,swapInstance: function(oldNamePath,newNamePath) {
	}
	,applyAlpha: function(alpha) {
		var _g1 = 0;
		var _g = this.colors.length;
		while(_g1 < _g) {
			var i = _g1++;
			var rgba = nanofl_engine_ColorTools.parse(this.colors[i]);
			rgba.a *= alpha;
			this.colors[i] = nanofl_engine_ColorTools.rgbaToString(rgba);
		}
	}
	,getTransformed: function(m,applyToThickness) {
		var stroke = nanofl_engine_strokes_BaseStroke.prototype.getTransformed.call(this,m,applyToThickness);
		var c = m.transformPoint(this.cx,this.cy);
		stroke.cx = c.x;
		stroke.cy = c.y;
		var f = m.transformPoint(this.fx,this.fy);
		stroke.fx = f.x;
		stroke.fy = f.y;
		stroke.r *= m.getAverageScale();
		return stroke;
	}
	,getTyped: function() {
		return nanofl_engine_strokes_TypedStroke.RADIAL(this);
	}
	,toString: function() {
		return "new RadialStroke(" + Std.string(this.colors.map(function(s) {
			return "\"" + s + "\"";
		})) + (", " + Std.string(this.ratios) + ", " + this.cx + ", " + this.cy + ", " + this.r + ", " + this.fx + ", " + this.fy + ")");
	}
	,arrEqu: function(a,b) {
		if(a.length != b.length) return false;
		var _g1 = 0;
		var _g = a.length;
		while(_g1 < _g) {
			var i = _g1++;
			if(a[i] != b[i]) return false;
		}
		return true;
	}
	,__class__: nanofl_engine_strokes_RadialStroke
});
var nanofl_engine_strokes_SelectionStroke = function(base,scale) {
	if(nanofl_engine_strokes_SelectionStroke.pattern == null) {
		nanofl_engine_strokes_SelectionStroke.pattern = new createjs.Shape();
		nanofl_engine_strokes_SelectionStroke.pattern.graphics.beginFill("rgba(0,0,0,0.75)").rect(0,0,2,2).rect(2,2,2,2).endFill().beginFill("rgba(255,255,255,0.75)").rect(2,0,2,2).rect(0,2,2,2).endFill();
		nanofl_engine_strokes_SelectionStroke.pattern.cache(0,0,4,4);
	}
	nanofl_engine_strokes_BaseStroke.call(this,Math.max(4,base.ignoreScale?base.thickness:base.thickness / scale),base.caps,base.joints,base.miterLimit,true);
};
$hxClasses["nanofl.engine.strokes.SelectionStroke"] = nanofl_engine_strokes_SelectionStroke;
nanofl_engine_strokes_SelectionStroke.__name__ = ["nanofl","engine","strokes","SelectionStroke"];
nanofl_engine_strokes_SelectionStroke.__interfaces__ = [nanofl_engine_strokes_IStroke];
nanofl_engine_strokes_SelectionStroke.__super__ = nanofl_engine_strokes_BaseStroke;
nanofl_engine_strokes_SelectionStroke.prototype = $extend(nanofl_engine_strokes_BaseStroke.prototype,{
	save: function(out) {
		throw new js__$Boot_HaxeError("Unsupported.");
	}
	,begin: function(g) {
		g.beginBitmapStroke(nanofl_engine_strokes_SelectionStroke.pattern.cacheCanvas,"repeat");
		this.setStrokeStyle(g);
	}
	,swapInstance: function(oldNamePath,newNamePath) {
	}
	,applyAlpha: function(alpha) {
	}
	,getTyped: function() {
		return null;
	}
	,toString: function() {
		return "new SelectionStroke()";
	}
	,__class__: nanofl_engine_strokes_SelectionStroke
});
var nanofl_engine_strokes_SolidStroke = function(color,thickness,caps,joints,miterLimit,ignoreScale) {
	if(ignoreScale == null) ignoreScale = false;
	if(miterLimit == null) miterLimit = 3.0;
	if(joints == null) joints = "round";
	if(caps == null) caps = "round";
	if(thickness == null) thickness = 1.0;
	if(color == null) color = "black";
	nanofl_engine_strokes_BaseStroke.call(this,thickness,caps,joints,miterLimit,ignoreScale);
	this.color = color;
};
$hxClasses["nanofl.engine.strokes.SolidStroke"] = nanofl_engine_strokes_SolidStroke;
nanofl_engine_strokes_SolidStroke.__name__ = ["nanofl","engine","strokes","SolidStroke"];
nanofl_engine_strokes_SolidStroke.__interfaces__ = [nanofl_engine_strokes_IStroke];
nanofl_engine_strokes_SolidStroke.__super__ = nanofl_engine_strokes_BaseStroke;
nanofl_engine_strokes_SolidStroke.prototype = $extend(nanofl_engine_strokes_BaseStroke.prototype,{
	color: null
	,loadProperties: function(node) {
		nanofl_engine_strokes_BaseStroke.prototype.loadProperties.call(this,node);
		this.color = htmlparser_HtmlParserTools.getAttr(node,"color","#000000");
	}
	,save: function(out) {
		out.begin("stroke").attr("type","solid");
		this.saveProperties(out);
		out.end();
	}
	,saveProperties: function(out) {
		out.attr("color",this.color);
		nanofl_engine_strokes_BaseStroke.prototype.saveProperties.call(this,out);
	}
	,begin: function(g) {
		g.beginStroke(this.color);
		this.setStrokeStyle(g);
	}
	,clone: function() {
		return new nanofl_engine_strokes_SolidStroke(this.color,this.thickness,this.caps,this.joints,this.miterLimit,this.ignoreScale);
	}
	,equ: function(e) {
		if(e == this) return true;
		if(!js_Boot.__instanceof(e,nanofl_engine_strokes_SolidStroke) || !nanofl_engine_strokes_BaseStroke.prototype.equ.call(this,e)) return false;
		var ee = e;
		return ee.color == this.color;
	}
	,swapInstance: function(oldNamePath,newNamePath) {
	}
	,applyAlpha: function(alpha) {
		var rgba = nanofl_engine_ColorTools.parse(this.color);
		if(rgba == null) throw new js__$Boot_HaxeError(new stdlib_Exception("Can't parse color '" + this.color + "'."));
		rgba.a *= alpha;
		this.color = nanofl_engine_ColorTools.rgbaToString(rgba);
	}
	,getTyped: function() {
		return nanofl_engine_strokes_TypedStroke.SOLID(this);
	}
	,toString: function() {
		return "new SolidStroke(\"" + this.color + "\")";
	}
	,__class__: nanofl_engine_strokes_SolidStroke
});
var nanofl_engine_strokes_TypedStroke = $hxClasses["nanofl.engine.strokes.TypedStroke"] = { __ename__ : ["nanofl","engine","strokes","TypedStroke"], __constructs__ : ["SOLID","LINEAR","RADIAL","BITMAP"] };
nanofl_engine_strokes_TypedStroke.SOLID = function(stroke) { var $x = ["SOLID",0,stroke]; $x.__enum__ = nanofl_engine_strokes_TypedStroke; $x.toString = $estr; return $x; };
nanofl_engine_strokes_TypedStroke.LINEAR = function(stroke) { var $x = ["LINEAR",1,stroke]; $x.__enum__ = nanofl_engine_strokes_TypedStroke; $x.toString = $estr; return $x; };
nanofl_engine_strokes_TypedStroke.RADIAL = function(stroke) { var $x = ["RADIAL",2,stroke]; $x.__enum__ = nanofl_engine_strokes_TypedStroke; $x.toString = $estr; return $x; };
nanofl_engine_strokes_TypedStroke.BITMAP = function(stroke) { var $x = ["BITMAP",3,stroke]; $x.__enum__ = nanofl_engine_strokes_TypedStroke; $x.toString = $estr; return $x; };
var stdlib_AbstractClassBuilder = function() { };
$hxClasses["stdlib.AbstractClassBuilder"] = stdlib_AbstractClassBuilder;
stdlib_AbstractClassBuilder.__name__ = ["stdlib","AbstractClassBuilder"];
var stdlib_Debug = function() { };
$hxClasses["stdlib.Debug"] = stdlib_Debug;
stdlib_Debug.__name__ = ["stdlib","Debug"];
stdlib_Debug.getDump = function(v,limit,level,prefix) {
	if(prefix == null) prefix = "";
	if(level == null) level = 0;
	if(limit == null) limit = 10;
	if(level >= limit) return "...\n";
	prefix += "\t";
	var s = "?\n";
	{
		var _g = Type["typeof"](v);
		switch(_g[1]) {
		case 3:
			s = "BOOL(" + (v?"true":"false") + ")\n";
			break;
		case 0:
			s = "NULL\n";
			break;
		case 6:
			var c = _g[2];
			if(c == String) s = "STRING(" + Std.string(v) + ")\n"; else if(c == Array) {
				s = "ARRAY(" + Std.string(v.length) + ")\n";
				var _g1 = 0;
				var _g2;
				_g2 = js_Boot.__cast(v , Array);
				while(_g1 < _g2.length) {
					var item = _g2[_g1];
					++_g1;
					s += prefix + stdlib_Debug.getDump(item,limit,level + 1,prefix);
				}
			} else if(c == List) {
				s = "LIST(" + Lambda.count(v) + ")\n";
				var _g11 = (js_Boot.__cast(v , List)).iterator();
				while(_g11.head != null) {
					var item1;
					_g11.val = _g11.head[0];
					_g11.head = _g11.head[1];
					item1 = _g11.val;
					s += prefix + stdlib_Debug.getDump(item1,limit,level + 1,prefix);
				}
			} else if(c == haxe_ds_StringMap) {
				s = "StringMap\n";
				var map;
				map = js_Boot.__cast(v , haxe_ds_StringMap);
				var $it0 = map.keys();
				while( $it0.hasNext() ) {
					var key = $it0.next();
					s += prefix + key + " => " + stdlib_Debug.getDump(__map_reserved[key] != null?map.getReserved(key):map.h[key],limit,level + 1,prefix);
				}
			} else s = "CLASS(" + Type.getClassName(c) + ")\n" + stdlib_Debug.getObjectDump(v,limit,level + 1,prefix);
			break;
		case 7:
			var e = _g[2];
			s = "ENUM(" + Type.getEnumName(e) + ") = " + Type.enumConstructor(v) + "\n";
			break;
		case 2:
			s = "FLOAT(" + Std.string(v) + ")\n";
			break;
		case 1:
			s = "INT(" + Std.string(v) + ")\n";
			break;
		case 4:
			s = "OBJECT" + "\n" + stdlib_Debug.getObjectDump(v,limit,level + 1,prefix);
			break;
		case 5:
			s = "FUNCTION\n";
			break;
		case 8:
			s = "UNKNOW\n";
			break;
		}
	}
	return s;
};
stdlib_Debug.getObjectDump = function(obj,limit,level,prefix) {
	var s = "";
	var _g = 0;
	var _g1 = Reflect.fields(obj);
	while(_g < _g1.length) {
		var fieldName = _g1[_g];
		++_g;
		s += prefix + fieldName + " : " + stdlib_Debug.getDump(Reflect.field(obj,fieldName),limit,level,prefix);
	}
	return s;
};
stdlib_Debug.assert = function(e,message,pos) {
	if(!e) {
		if(message == null) message = "error"; else if(Reflect.isFunction(message)) message = message();
		var s = "ASSERT " + Std.string(message) + " in " + pos.fileName + " at line " + pos.lineNumber;
		var r = new stdlib_Exception(s);
		r.stack.shift();
		throw new js__$Boot_HaxeError(r);
	}
};
stdlib_Debug.traceStack = function(v,pos) {
	var stack = stdlib_StringTools.trim(stdlib_StringTools.replace(haxe_CallStack.toString(haxe_CallStack.callStack()),"prototype<.",""));
	var lines = stack.split("\n").filter(function(s) {
		return s != "Called from module";
	}).map(function(s1) {
		return s1.split("@").map(function(ss) {
			return stdlib_StringTools.rtrim(ss,"</");
		}).join("@");
	});
	var len = 0;
	var _g = 0;
	while(_g < lines.length) {
		var line = lines[_g];
		++_g;
		len = stdlib_Std.max(len,line.indexOf("@"));
	}
	lines = lines.map(function(line1) {
		var ss1 = line1.split("@");
		return ss1[0] + StringTools.rpad(""," ",len - ss1[0].length + 1) + ss1[1];
	});
	stack = lines.slice(1).join("\n");
	haxe_Log.trace("TRACE " + (typeof(v) == "string"?v:stdlib_StringTools.trim(stdlib_Debug.getDump(v))) + "\nStack trace:\n" + stack,{ fileName : "Debug.hx", lineNumber : 187, className : "stdlib.Debug", methodName : "traceStack", customParams : [pos]});
};
stdlib_Debug.methodMustBeOverriden = function(_this,pos) {
	throw new js__$Boot_HaxeError(new stdlib_Exception("Method " + pos.methodName + "() must be overriden in class " + Type.getClassName(Type.getClass(_this)) + "."));
	return null;
};
stdlib_Debug.methodNotSupported = function(_this,pos) {
	throw new js__$Boot_HaxeError(new stdlib_Exception("Method " + pos.methodName + "() is not supported by class " + Type.getClassName(Type.getClass(_this)) + "."));
	return null;
};
var stdlib_Event = function(target) {
	this.target = target;
	this.handlers = [];
};
$hxClasses["stdlib.Event"] = stdlib_Event;
stdlib_Event.__name__ = ["stdlib","Event"];
stdlib_Event.prototype = {
	target: null
	,handlers: null
	,bind: function(handler) {
		this.handlers.push(handler);
	}
	,unbind: function(handler) {
		while(HxOverrides.remove(this.handlers,handler)) {
		}
	}
	,unbindAll: function() {
		this.handlers = [];
	}
	,call: function(args) {
		var _g = 0;
		var _g1 = this.handlers;
		while(_g < _g1.length) {
			var handler = _g1[_g];
			++_g;
			handler.apply(null,[this.target,args]);
		}
	}
	,__class__: stdlib_Event
};
var stdlib_Exception = function(message) {
	if(message == null) this.message = ""; else this.message = message;
	this.stack = haxe_CallStack.callStack();
	this.stack.shift();
};
$hxClasses["stdlib.Exception"] = stdlib_Exception;
stdlib_Exception.__name__ = ["stdlib","Exception"];
stdlib_Exception.string = function(e) {
	return Std.string(e);
};
stdlib_Exception.rethrow = function(exception) {
	throw new js__$Boot_HaxeError(stdlib_Exception.wrap(exception));
};
stdlib_Exception.wrap = function(e) {
	if(!js_Boot.__instanceof(e,stdlib_Exception)) {
		var r = new stdlib_Exception(Std.string(e));
		r.stack = haxe_CallStack.exceptionStack();
		return r;
	}
	return e;
};
stdlib_Exception.prototype = {
	message: null
	,stack: null
	,toString: function() {
		return this.message;
	}
	,__class__: stdlib_Exception
};
var stdlib_LambdaArray = function() { };
$hxClasses["stdlib.LambdaArray"] = stdlib_LambdaArray;
stdlib_LambdaArray.__name__ = ["stdlib","LambdaArray"];
stdlib_LambdaArray.addRange = function(arr,range) {
	var _g = 0;
	while(_g < range.length) {
		var e = range[_g];
		++_g;
		arr.push(e);
	}
};
stdlib_LambdaArray.insertRange = function(arr,pos,range) {
	var _g = 0;
	while(_g < range.length) {
		var e = range[_g];
		++_g;
		var pos1 = pos++;
		arr.splice(pos1,0,e);
	}
};
stdlib_LambdaArray.extract = function(arr,f) {
	var r = [];
	var i = 0;
	while(i < arr.length) if(f(arr[i])) {
		r.push(arr[i]);
		arr.splice(i,1);
	} else i++;
	return r;
};
stdlib_LambdaArray.spliceEx = function(arr,pos,len,replacement) {
	var r = arr.splice(pos,len != null?len:arr.length - pos);
	if(replacement != null) stdlib_LambdaArray.insertRange(arr,pos,replacement);
	return r;
};
var stdlib_LambdaIterable = function() { };
$hxClasses["stdlib.LambdaIterable"] = stdlib_LambdaIterable;
stdlib_LambdaIterable.__name__ = ["stdlib","LambdaIterable"];
stdlib_LambdaIterable.findIndex = function(it,f) {
	var n = 0;
	var $it0 = $iterator(it)();
	while( $it0.hasNext() ) {
		var x = $it0.next();
		if(f(x)) return n;
		n++;
	}
	return -1;
};
stdlib_LambdaIterable.sorted = function(it,cmp) {
	var r = Lambda.array(it);
	r.sort(cmp != null?cmp:Reflect.compare);
	return r;
};
var stdlib_LambdaIterator = function() { };
$hxClasses["stdlib.LambdaIterator"] = stdlib_LambdaIterator;
stdlib_LambdaIterator.__name__ = ["stdlib","LambdaIterator"];
stdlib_LambdaIterator.array = function(it) {
	var r = [];
	while( it.hasNext() ) {
		var e = it.next();
		r.push(e);
	}
	return r;
};
stdlib_LambdaIterator.indexOf = function(it,elem) {
	var r = 0;
	while(it.hasNext()) {
		if(it.next() == elem) return r;
		r++;
	}
	return -1;
};
stdlib_LambdaIterator.map = function(it,conv) {
	var r = [];
	while( it.hasNext() ) {
		var e = it.next();
		r.push(conv(e));
	}
	return r;
};
stdlib_LambdaIterator.filter = function(it,pred) {
	var r = [];
	while( it.hasNext() ) {
		var e = it.next();
		if(pred(e)) r.push(e);
	}
	return r;
};
stdlib_LambdaIterator.exists = function(it,pred) {
	while( it.hasNext() ) {
		var e = it.next();
		if(pred(e)) return true;
	}
	return false;
};
stdlib_LambdaIterator.count = function(it,pred) {
	var n = 0;
	if(pred == null) {
		while( it.hasNext() ) {
			var _ = it.next();
			n++;
		}
	} else {
		while( it.hasNext() ) {
			var x = it.next();
			if(pred(x)) n++;
		}
	}
	return n;
};
stdlib_LambdaIterator.findIndex = function(it,f) {
	var n = 0;
	while( it.hasNext() ) {
		var x = it.next();
		if(f(x)) return n;
		n++;
	}
	return -1;
};
stdlib_LambdaIterator.sorted = function(it,cmp) {
	var r = stdlib_LambdaIterator.array(it);
	r.sort(cmp != null?cmp:Reflect.compare);
	return r;
};
var stdlib_Serializer = function() {
	haxe_Serializer.call(this);
};
$hxClasses["stdlib.Serializer"] = stdlib_Serializer;
stdlib_Serializer.__name__ = ["stdlib","Serializer"];
stdlib_Serializer.run = function(v,useCache) {
	if(useCache == null) useCache = false;
	var serializer = new haxe_Serializer();
	serializer.useCache = useCache;
	serializer.serialize(v);
	return serializer.toString();
};
stdlib_Serializer.__super__ = haxe_Serializer;
stdlib_Serializer.prototype = $extend(haxe_Serializer.prototype,{
	__class__: stdlib_Serializer
});
var stdlib_Std = function() { };
$hxClasses["stdlib.Std"] = stdlib_Std;
stdlib_Std.__name__ = ["stdlib","Std"];
stdlib_Std.parseInt = function(x,defaultValue) {
	if(x != null) {
		if(new EReg("^\\s*[+-]?\\s*((?:0x[0-9a-fA-F]{1,7})|(?:\\d{1,9}))\\s*$","").match(x)) return Std.parseInt(x); else return defaultValue;
	} else return defaultValue;
};
stdlib_Std.parseFloat = function(x,defaultValue) {
	if(x == null) return defaultValue;
	if(new EReg("^\\s*[+-]?\\s*\\d{1,20}(?:[.]\\d+)?(?:e[+-]?\\d{1,20})?\\s*$","").match(x)) {
		var r = parseFloat(x);
		if(!isNaN(r)) return r; else return defaultValue;
	}
	return defaultValue;
};
stdlib_Std.bool = function(v) {
	return v != false && v != null && v != 0 && v != "" && v != "0" && (!(typeof(v) == "string") || (js_Boot.__cast(v , String)).toLowerCase() != "false" && (js_Boot.__cast(v , String)).toLowerCase() != "off" && (js_Boot.__cast(v , String)).toLowerCase() != "null");
};
stdlib_Std.parseValue = function(x) {
	var value = x;
	var valueLC;
	if(value != null) valueLC = value.toLowerCase(); else valueLC = null;
	var parsedValue;
	if(valueLC == "true") value = true; else if(valueLC == "false") value = false; else if(valueLC == "null") value = null; else if((parsedValue = stdlib_Std.parseInt(value)) != null) value = parsedValue; else if((parsedValue = stdlib_Std.parseFloat(value)) != null) value = parsedValue;
	return value;
};
stdlib_Std.hash = function(obj) {
	var r = new haxe_ds_StringMap();
	var _g = 0;
	var _g1 = Reflect.fields(obj);
	while(_g < _g1.length) {
		var key = _g1[_g];
		++_g;
		var value = Reflect.field(obj,key);
		r.set(key,value);
	}
	return r;
};
stdlib_Std.min = function(a,b) {
	if(a < b) return a; else return b;
};
stdlib_Std.max = function(a,b) {
	if(a > b) return a; else return b;
};
stdlib_Std.abs = function(x) {
	if(x >= 0) return x; else return -x;
};
stdlib_Std.sign = function(n) {
	if(n > 0) return 1; else if(n < 0) return -1; else return 0;
};
stdlib_Std["is"] = function(v,t) {
	return js_Boot.__instanceof(v,t);
};
stdlib_Std.instance = function(value,c) {
	return (value instanceof c)?value:null;
};
stdlib_Std.string = function(s) {
	return Std.string(s);
};
stdlib_Std["int"] = function(x) {
	return x | 0;
};
stdlib_Std.random = function(x) {
	return Std.random(x);
};
var stdlib_StringTools = function() { };
$hxClasses["stdlib.StringTools"] = stdlib_StringTools;
stdlib_StringTools.__name__ = ["stdlib","StringTools"];
stdlib_StringTools.ltrim = function(s,chars) {
	if(chars == null) return StringTools.ltrim(s);
	while(s.length > 0 && chars.indexOf(HxOverrides.substr(s,0,1)) >= 0) s = HxOverrides.substr(s,1,null);
	return s;
};
stdlib_StringTools.rtrim = function(s,chars) {
	if(chars == null) return StringTools.rtrim(s);
	while(s.length > 0 && chars.indexOf(HxOverrides.substr(s,s.length - 1,1)) >= 0) s = HxOverrides.substr(s,0,s.length - 1);
	return s;
};
stdlib_StringTools.trim = function(s,chars) {
	if(chars == null) return StringTools.trim(s);
	return stdlib_StringTools.rtrim(stdlib_StringTools.ltrim(s,chars),chars);
};
stdlib_StringTools.hexdec = function(s) {
	return stdlib_Std.parseInt("0x" + s);
};
stdlib_StringTools.addcslashes = function(s) {
	return new EReg("['\"\t\r\n\\\\]","g").map(s,function(re) {
		return "\\" + re.matched(0);
	});
};
stdlib_StringTools.stripTags = function(str,allowedTags) {
	if(allowedTags == null) allowedTags = "";
	var allowedTagsArray = [];
	if(allowedTags != "") {
		var re1 = new EReg("[a-zA-Z0-9]+","i");
		var pos = 0;
		while(re1.matchSub(allowedTags,pos)) {
			allowedTagsArray.push(re1.matched(0));
			pos = re1.matchedPos().pos + re1.matchedPos().len;
		}
	}
	var matches = [];
	var re = new EReg("</?[\\S][^>]*>","g");
	str = re.map(str,function(_) {
		var html = re.matched(0);
		var allowed = false;
		if(allowedTagsArray.length > 0) {
			var htmlLC = html.toLowerCase();
			var _g = 0;
			while(_g < allowedTagsArray.length) {
				var allowedTag = allowedTagsArray[_g];
				++_g;
				if(StringTools.startsWith(htmlLC,"<" + allowedTag + ">") || StringTools.startsWith(htmlLC,"<" + allowedTag + " ") || StringTools.startsWith(htmlLC,"</" + allowedTag)) {
					allowed = true;
					break;
				}
			}
		}
		if(allowed) return html; else return "";
	});
	return str;
};
stdlib_StringTools.regexEscape = function(s) {
	return new EReg("([\\-\\[\\]/\\{\\}\\(\\)\\*\\+\\?\\.\\\\\\^\\$\\|])","g").replace(s,"\\$1");
};
stdlib_StringTools.jsonEscape = function(s) {
	if(s == null) return "null";
	var r = new stdlib_Utf8(s.length + (s.length / 5 | 0));
	r.__b += "\"";
	haxe_Utf8.iter(s,function(c) {
		switch(c) {
		case 92:
			r.__b += "\\";
			r.__b += "\\";
			break;
		case 34:
			r.__b += "\\";
			r.__b += "\"";
			break;
		case 9:
			r.__b += "\\";
			r.__b += "t";
			break;
		case 10:
			r.__b += "\\";
			r.__b += "n";
			break;
		case 13:
			r.__b += "\\";
			r.__b += "r";
			break;
		default:
			if(c < 32) {
				r.__b += "\\";
				r.__b += "u";
				var t = StringTools.hex(c,4);
				r.addChar(t.charCodeAt(0));
				r.addChar(t.charCodeAt(1));
				r.addChar(t.charCodeAt(2));
				r.addChar(t.charCodeAt(3));
			} else r.__b += String.fromCharCode(c);
		}
	});
	r.__b += "\"";
	return r.__b;
};
stdlib_StringTools.isEmpty = function(s) {
	return s == null || s == "";
};
stdlib_StringTools.capitalize = function(s) {
	if(stdlib_StringTools.isEmpty(s)) return s; else return HxOverrides.substr(s,0,1).toUpperCase() + HxOverrides.substr(s,1,null);
};
stdlib_StringTools.urlEncode = function(s) {
	return encodeURIComponent(s);
};
stdlib_StringTools.urlDecode = function(s) {
	return decodeURIComponent(s.split("+").join(" "));
};
stdlib_StringTools.htmlEscape = function(s,quotes) {
	return StringTools.htmlEscape(s,quotes);
};
stdlib_StringTools.htmlUnescape = function(s) {
	return StringTools.htmlUnescape(s);
};
stdlib_StringTools.startsWith = function(s,start) {
	return StringTools.startsWith(s,start);
};
stdlib_StringTools.endsWith = function(s,end) {
	return StringTools.endsWith(s,end);
};
stdlib_StringTools.isSpace = function(s,pos) {
	return StringTools.isSpace(s,pos);
};
stdlib_StringTools.lpad = function(s,c,l) {
	return StringTools.lpad(s,c,l);
};
stdlib_StringTools.rpad = function(s,c,l) {
	return StringTools.rpad(s,c,l);
};
stdlib_StringTools.replace = function(s,sub,by) {
	return StringTools.replace(s,sub,by);
};
stdlib_StringTools.hex = function(n,digits) {
	return StringTools.hex(n,digits);
};
stdlib_StringTools.fastCodeAt = function(s,index) {
	return s.charCodeAt(index);
};
stdlib_StringTools.isEof = function(c) {
	return c != c;
};
var stdlib_Unserializer = function(buf) {
	haxe_Unserializer.call(this,buf);
};
$hxClasses["stdlib.Unserializer"] = stdlib_Unserializer;
stdlib_Unserializer.__name__ = ["stdlib","Unserializer"];
stdlib_Unserializer.run = function(v,r) {
	var unserializer = new haxe_Unserializer(v);
	if(r != null) unserializer.setResolver(r);
	return unserializer.unserialize();
};
stdlib_Unserializer.__super__ = haxe_Unserializer;
stdlib_Unserializer.prototype = $extend(haxe_Unserializer.prototype,{
	__class__: stdlib_Unserializer
});
var stdlib_Utf8 = function(size) {
	haxe_Utf8.call(this,size);
};
$hxClasses["stdlib.Utf8"] = stdlib_Utf8;
stdlib_Utf8.__name__ = ["stdlib","Utf8"];
stdlib_Utf8.replace = function(s,from,to) {
	var codes = [];
	haxe_Utf8.iter(s,function(c) {
		codes.push(c);
	});
	var r = new stdlib_Utf8();
	var len = from.length;
	if(codes.length < len) return s;
	var _g1 = 0;
	var _g = codes.length - len + 1;
	while(_g1 < _g) {
		var i = [_g1++];
		var found = [true];
		var j = [0];
		haxe_Utf8.iter(from,(function(j,found,i) {
			return function(cc) {
				if(found[0]) {
					if(codes[i[0] + j[0]] != cc) found[0] = false;
					j[0]++;
				}
			};
		})(j,found,i));
		if(found[0]) r.addString(to); else r.__b += String.fromCharCode(codes[i[0]]);
	}
	var _g11 = codes.length - len + 1;
	var _g2 = codes.length;
	while(_g11 < _g2) {
		var i1 = _g11++;
		r.__b += String.fromCharCode(codes[i1]);
	}
	return r.__b;
};
stdlib_Utf8.compactSpaces = function(s) {
	var r = new stdlib_Utf8();
	var prevSpace = false;
	haxe_Utf8.iter(s,function(c) {
		if(c == 32 || c == 13 || c == 10 || c == 9) {
			if(!prevSpace) {
				r.__b += " ";
				prevSpace = true;
			}
		} else {
			r.__b += String.fromCharCode(c);
			prevSpace = false;
		}
	});
	return r.__b;
};
stdlib_Utf8.htmlUnescape = function(s) {
	var r = new stdlib_Utf8();
	var $escape = null;
	haxe_Utf8.iter(s,function(c) {
		if($escape != null) {
			if(c == 59) {
				var chr = stdlib_Utf8.htmlUnescapeChar($escape);
				if(chr != null) r.__b += String.fromCharCode(chr);
				$escape = null;
			} else $escape += String.fromCharCode(c);
		} else if(c == 38) $escape = ""; else r.__b += String.fromCharCode(c);
	});
	return r.__b;
};
stdlib_Utf8.htmlEscape = function(utf8Str,chars) {
	if(chars == null) chars = "";
	chars = "&<>" + chars;
	var r = new stdlib_Utf8();
	haxe_Utf8.iter(utf8Str,function(c) {
		var s;
		var this1 = stdlib_Utf8.get_htmlEscapeMap();
		s = this1.get(c);
		if(s != null && c >= 0 && c <= 255 && chars.indexOf(String.fromCharCode(c)) >= 0) r.addString(s); else r.__b += String.fromCharCode(c);
	});
	return r.__b;
};
stdlib_Utf8.htmlUnescapeChar = function(escape) {
	if(StringTools.startsWith(escape,"#x")) return stdlib_Std.parseInt("0x" + HxOverrides.substr(escape,2,null)); else if(StringTools.startsWith(escape,"#")) return stdlib_Std.parseInt(HxOverrides.substr(escape,1,null)); else {
		var r;
		var this1 = stdlib_Utf8.get_htmlUnescapeMap();
		r = this1.get(escape);
		if(r != null) return r;
	}
	haxe_Log.trace("Unknow escape sequence: " + escape,{ fileName : "Utf8.hx", lineNumber : 131, className : "stdlib.Utf8", methodName : "htmlUnescapeChar"});
	return null;
};
stdlib_Utf8.get_htmlEscapeMap = function() {
	if(stdlib_Utf8.htmlEscapeMap == null) {
		var _g = new haxe_ds_IntMap();
		_g.h[32] = "&nbsp;";
		_g.h[38] = "&amp;";
		_g.h[60] = "&lt;";
		_g.h[62] = "&gt;";
		_g.h[34] = "&quot;";
		_g.h[39] = "&apos;";
		_g.h[13] = "&#xD;";
		_g.h[10] = "&#xA;";
		stdlib_Utf8.htmlEscapeMap = _g;
	}
	return stdlib_Utf8.htmlEscapeMap;
};
stdlib_Utf8.get_htmlUnescapeMap = function() {
	if(stdlib_Utf8.htmlUnescapeMap == null) {
		var _g = new haxe_ds_StringMap();
		if(__map_reserved.nbsp != null) _g.setReserved("nbsp",32); else _g.h["nbsp"] = 32;
		if(__map_reserved.amp != null) _g.setReserved("amp",38); else _g.h["amp"] = 38;
		if(__map_reserved.lt != null) _g.setReserved("lt",60); else _g.h["lt"] = 60;
		if(__map_reserved.gt != null) _g.setReserved("gt",62); else _g.h["gt"] = 62;
		if(__map_reserved.quot != null) _g.setReserved("quot",34); else _g.h["quot"] = 34;
		if(__map_reserved.apos != null) _g.setReserved("apos",39); else _g.h["apos"] = 39;
		if(__map_reserved.euro != null) _g.setReserved("euro",8364); else _g.h["euro"] = 8364;
		if(__map_reserved.iexcl != null) _g.setReserved("iexcl",161); else _g.h["iexcl"] = 161;
		if(__map_reserved.cent != null) _g.setReserved("cent",162); else _g.h["cent"] = 162;
		if(__map_reserved.pound != null) _g.setReserved("pound",163); else _g.h["pound"] = 163;
		if(__map_reserved.curren != null) _g.setReserved("curren",164); else _g.h["curren"] = 164;
		if(__map_reserved.yen != null) _g.setReserved("yen",165); else _g.h["yen"] = 165;
		if(__map_reserved.brvbar != null) _g.setReserved("brvbar",166); else _g.h["brvbar"] = 166;
		if(__map_reserved.sect != null) _g.setReserved("sect",167); else _g.h["sect"] = 167;
		if(__map_reserved.uml != null) _g.setReserved("uml",168); else _g.h["uml"] = 168;
		if(__map_reserved.copy != null) _g.setReserved("copy",169); else _g.h["copy"] = 169;
		if(__map_reserved.ordf != null) _g.setReserved("ordf",170); else _g.h["ordf"] = 170;
		if(__map_reserved.not != null) _g.setReserved("not",172); else _g.h["not"] = 172;
		if(__map_reserved.shy != null) _g.setReserved("shy",173); else _g.h["shy"] = 173;
		if(__map_reserved.reg != null) _g.setReserved("reg",174); else _g.h["reg"] = 174;
		if(__map_reserved.macr != null) _g.setReserved("macr",175); else _g.h["macr"] = 175;
		if(__map_reserved.deg != null) _g.setReserved("deg",176); else _g.h["deg"] = 176;
		if(__map_reserved.plusmn != null) _g.setReserved("plusmn",177); else _g.h["plusmn"] = 177;
		if(__map_reserved.sup2 != null) _g.setReserved("sup2",178); else _g.h["sup2"] = 178;
		if(__map_reserved.sup3 != null) _g.setReserved("sup3",179); else _g.h["sup3"] = 179;
		if(__map_reserved.acute != null) _g.setReserved("acute",180); else _g.h["acute"] = 180;
		if(__map_reserved.micro != null) _g.setReserved("micro",181); else _g.h["micro"] = 181;
		if(__map_reserved.para != null) _g.setReserved("para",182); else _g.h["para"] = 182;
		if(__map_reserved.middot != null) _g.setReserved("middot",183); else _g.h["middot"] = 183;
		if(__map_reserved.cedil != null) _g.setReserved("cedil",184); else _g.h["cedil"] = 184;
		if(__map_reserved.sup1 != null) _g.setReserved("sup1",185); else _g.h["sup1"] = 185;
		if(__map_reserved.ordm != null) _g.setReserved("ordm",186); else _g.h["ordm"] = 186;
		if(__map_reserved.raquo != null) _g.setReserved("raquo",187); else _g.h["raquo"] = 187;
		if(__map_reserved.frac14 != null) _g.setReserved("frac14",188); else _g.h["frac14"] = 188;
		if(__map_reserved.frac12 != null) _g.setReserved("frac12",189); else _g.h["frac12"] = 189;
		if(__map_reserved.frac34 != null) _g.setReserved("frac34",190); else _g.h["frac34"] = 190;
		if(__map_reserved.iquest != null) _g.setReserved("iquest",191); else _g.h["iquest"] = 191;
		if(__map_reserved.Agrave != null) _g.setReserved("Agrave",192); else _g.h["Agrave"] = 192;
		if(__map_reserved.Aacute != null) _g.setReserved("Aacute",193); else _g.h["Aacute"] = 193;
		if(__map_reserved.Acirc != null) _g.setReserved("Acirc",194); else _g.h["Acirc"] = 194;
		if(__map_reserved.Atilde != null) _g.setReserved("Atilde",195); else _g.h["Atilde"] = 195;
		if(__map_reserved.Auml != null) _g.setReserved("Auml",196); else _g.h["Auml"] = 196;
		if(__map_reserved.Aring != null) _g.setReserved("Aring",197); else _g.h["Aring"] = 197;
		if(__map_reserved.AElig != null) _g.setReserved("AElig",198); else _g.h["AElig"] = 198;
		if(__map_reserved.Ccedil != null) _g.setReserved("Ccedil",199); else _g.h["Ccedil"] = 199;
		if(__map_reserved.Egrave != null) _g.setReserved("Egrave",200); else _g.h["Egrave"] = 200;
		if(__map_reserved.Eacute != null) _g.setReserved("Eacute",201); else _g.h["Eacute"] = 201;
		if(__map_reserved.Ecirc != null) _g.setReserved("Ecirc",202); else _g.h["Ecirc"] = 202;
		if(__map_reserved.Euml != null) _g.setReserved("Euml",203); else _g.h["Euml"] = 203;
		if(__map_reserved.Igrave != null) _g.setReserved("Igrave",204); else _g.h["Igrave"] = 204;
		if(__map_reserved.Iacute != null) _g.setReserved("Iacute",205); else _g.h["Iacute"] = 205;
		if(__map_reserved.Icirc != null) _g.setReserved("Icirc",206); else _g.h["Icirc"] = 206;
		if(__map_reserved.Iuml != null) _g.setReserved("Iuml",207); else _g.h["Iuml"] = 207;
		if(__map_reserved.ETH != null) _g.setReserved("ETH",208); else _g.h["ETH"] = 208;
		if(__map_reserved.Ntilde != null) _g.setReserved("Ntilde",209); else _g.h["Ntilde"] = 209;
		if(__map_reserved.Ograve != null) _g.setReserved("Ograve",210); else _g.h["Ograve"] = 210;
		if(__map_reserved.Oacute != null) _g.setReserved("Oacute",211); else _g.h["Oacute"] = 211;
		if(__map_reserved.Ocirc != null) _g.setReserved("Ocirc",212); else _g.h["Ocirc"] = 212;
		if(__map_reserved.Otilde != null) _g.setReserved("Otilde",213); else _g.h["Otilde"] = 213;
		if(__map_reserved.Ouml != null) _g.setReserved("Ouml",214); else _g.h["Ouml"] = 214;
		if(__map_reserved.times != null) _g.setReserved("times",215); else _g.h["times"] = 215;
		if(__map_reserved.Oslash != null) _g.setReserved("Oslash",216); else _g.h["Oslash"] = 216;
		if(__map_reserved.Ugrave != null) _g.setReserved("Ugrave",217); else _g.h["Ugrave"] = 217;
		if(__map_reserved.Uacute != null) _g.setReserved("Uacute",218); else _g.h["Uacute"] = 218;
		if(__map_reserved.Ucirc != null) _g.setReserved("Ucirc",219); else _g.h["Ucirc"] = 219;
		if(__map_reserved.Uuml != null) _g.setReserved("Uuml",220); else _g.h["Uuml"] = 220;
		if(__map_reserved.Yacute != null) _g.setReserved("Yacute",221); else _g.h["Yacute"] = 221;
		if(__map_reserved.THORN != null) _g.setReserved("THORN",222); else _g.h["THORN"] = 222;
		if(__map_reserved.szlig != null) _g.setReserved("szlig",223); else _g.h["szlig"] = 223;
		if(__map_reserved.agrave != null) _g.setReserved("agrave",224); else _g.h["agrave"] = 224;
		if(__map_reserved.aacute != null) _g.setReserved("aacute",225); else _g.h["aacute"] = 225;
		if(__map_reserved.acirc != null) _g.setReserved("acirc",226); else _g.h["acirc"] = 226;
		if(__map_reserved.atilde != null) _g.setReserved("atilde",227); else _g.h["atilde"] = 227;
		if(__map_reserved.auml != null) _g.setReserved("auml",228); else _g.h["auml"] = 228;
		if(__map_reserved.aring != null) _g.setReserved("aring",229); else _g.h["aring"] = 229;
		if(__map_reserved.aelig != null) _g.setReserved("aelig",230); else _g.h["aelig"] = 230;
		if(__map_reserved.ccedil != null) _g.setReserved("ccedil",231); else _g.h["ccedil"] = 231;
		if(__map_reserved.egrave != null) _g.setReserved("egrave",232); else _g.h["egrave"] = 232;
		if(__map_reserved.eacute != null) _g.setReserved("eacute",233); else _g.h["eacute"] = 233;
		if(__map_reserved.ecirc != null) _g.setReserved("ecirc",234); else _g.h["ecirc"] = 234;
		if(__map_reserved.euml != null) _g.setReserved("euml",235); else _g.h["euml"] = 235;
		if(__map_reserved.igrave != null) _g.setReserved("igrave",236); else _g.h["igrave"] = 236;
		if(__map_reserved.iacute != null) _g.setReserved("iacute",237); else _g.h["iacute"] = 237;
		if(__map_reserved.icirc != null) _g.setReserved("icirc",238); else _g.h["icirc"] = 238;
		if(__map_reserved.iuml != null) _g.setReserved("iuml",239); else _g.h["iuml"] = 239;
		if(__map_reserved.eth != null) _g.setReserved("eth",240); else _g.h["eth"] = 240;
		if(__map_reserved.ntilde != null) _g.setReserved("ntilde",241); else _g.h["ntilde"] = 241;
		if(__map_reserved.ograve != null) _g.setReserved("ograve",242); else _g.h["ograve"] = 242;
		if(__map_reserved.oacute != null) _g.setReserved("oacute",243); else _g.h["oacute"] = 243;
		if(__map_reserved.ocirc != null) _g.setReserved("ocirc",244); else _g.h["ocirc"] = 244;
		if(__map_reserved.otilde != null) _g.setReserved("otilde",245); else _g.h["otilde"] = 245;
		if(__map_reserved.ouml != null) _g.setReserved("ouml",246); else _g.h["ouml"] = 246;
		if(__map_reserved.divide != null) _g.setReserved("divide",247); else _g.h["divide"] = 247;
		if(__map_reserved.oslash != null) _g.setReserved("oslash",248); else _g.h["oslash"] = 248;
		if(__map_reserved.ugrave != null) _g.setReserved("ugrave",249); else _g.h["ugrave"] = 249;
		if(__map_reserved.uacute != null) _g.setReserved("uacute",250); else _g.h["uacute"] = 250;
		if(__map_reserved.ucirc != null) _g.setReserved("ucirc",251); else _g.h["ucirc"] = 251;
		if(__map_reserved.uuml != null) _g.setReserved("uuml",252); else _g.h["uuml"] = 252;
		if(__map_reserved.yacute != null) _g.setReserved("yacute",253); else _g.h["yacute"] = 253;
		if(__map_reserved.thorn != null) _g.setReserved("thorn",254); else _g.h["thorn"] = 254;
		stdlib_Utf8.htmlUnescapeMap = _g;
	}
	return stdlib_Utf8.htmlUnescapeMap;
};
stdlib_Utf8.iter = function(s,chars) {
	haxe_Utf8.iter(s,chars);
	return;
};
stdlib_Utf8.encode = function(s) {
	return haxe_Utf8.encode(s);
};
stdlib_Utf8.decode = function(s) {
	return haxe_Utf8.decode(s);
};
stdlib_Utf8.charCodeAt = function(s,index) {
	return HxOverrides.cca(s,index);
};
stdlib_Utf8.validate = function(s) {
	return true;
};
stdlib_Utf8.$length = function(s) {
	return s.length;
};
stdlib_Utf8.compare = function(a,b) {
	return haxe_Utf8.compare(a,b);
};
stdlib_Utf8.sub = function(s,pos,len) {
	return HxOverrides.substr(s,pos,len);
};
stdlib_Utf8.__super__ = haxe_Utf8;
stdlib_Utf8.prototype = $extend(haxe_Utf8.prototype,{
	addString: function(s) {
		var _g = this;
		haxe_Utf8.iter(s,function(c) {
			_g.__b += String.fromCharCode(c);
		});
	}
	,__class__: stdlib_Utf8
});
var tjson_TJSON = function() { };
$hxClasses["tjson.TJSON"] = tjson_TJSON;
tjson_TJSON.__name__ = ["tjson","TJSON"];
tjson_TJSON.parse = function(json,fileName,stringProcessor) {
	if(fileName == null) fileName = "JSON Data";
	var t = new tjson_TJSONParser(json,fileName,stringProcessor);
	return t.doParse();
};
tjson_TJSON.encode = function(obj,style,useCache) {
	if(useCache == null) useCache = true;
	var t = new tjson_TJSONEncoder(useCache);
	return t.doEncode(obj,style);
};
var tjson_TJSONParser = function(vjson,vfileName,stringProcessor) {
	if(vfileName == null) vfileName = "JSON Data";
	this.json = vjson;
	this.fileName = vfileName;
	this.currentLine = 1;
	this.lastSymbolQuoted = false;
	this.pos = 0;
	this.floatRegex = new EReg("^-?[0-9]*\\.[0-9]+$","");
	this.intRegex = new EReg("^-?[0-9]+$","");
	if(stringProcessor == null) this.strProcessor = $bind(this,this.defaultStringProcessor); else this.strProcessor = stringProcessor;
	this.cache = [];
};
$hxClasses["tjson.TJSONParser"] = tjson_TJSONParser;
tjson_TJSONParser.__name__ = ["tjson","TJSONParser"];
tjson_TJSONParser.prototype = {
	pos: null
	,json: null
	,lastSymbolQuoted: null
	,fileName: null
	,currentLine: null
	,cache: null
	,floatRegex: null
	,intRegex: null
	,strProcessor: null
	,doParse: function() {
		try {
			var _g = this.getNextSymbol();
			var s = _g;
			switch(_g) {
			case "{":
				return this.doObject();
			case "[":
				return this.doArray();
			default:
				return this.convertSymbolToProperType(s);
			}
		} catch( e ) {
			haxe_CallStack.lastException = e;
			if (e instanceof js__$Boot_HaxeError) e = e.val;
			if( js_Boot.__instanceof(e,String) ) {
				throw new js__$Boot_HaxeError(this.fileName + " on line " + this.currentLine + ": " + e);
			} else throw(e);
		}
	}
	,doObject: function() {
		var o = { };
		var val = "";
		var key;
		var isClassOb = false;
		this.cache.push(o);
		while(this.pos < this.json.length) {
			key = this.getNextSymbol();
			if(key == "," && !this.lastSymbolQuoted) continue;
			if(key == "}" && !this.lastSymbolQuoted) {
				if(isClassOb && o.TJ_unserialize != null) o.TJ_unserialize();
				return o;
			}
			var seperator = this.getNextSymbol();
			if(seperator != ":") throw new js__$Boot_HaxeError("Expected ':' but got '" + seperator + "' instead.");
			var v = this.getNextSymbol();
			if(key == "_hxcls") {
				var cls = Type.resolveClass(v);
				if(cls == null) throw new js__$Boot_HaxeError("Invalid class name - " + v);
				o = Type.createEmptyInstance(cls);
				this.cache.pop();
				this.cache.push(o);
				isClassOb = true;
				continue;
			}
			if(v == "{" && !this.lastSymbolQuoted) val = this.doObject(); else if(v == "[" && !this.lastSymbolQuoted) val = this.doArray(); else val = this.convertSymbolToProperType(v);
			o[key] = val;
		}
		throw new js__$Boot_HaxeError("Unexpected end of file. Expected '}'");
	}
	,doArray: function() {
		var a = [];
		var val;
		while(this.pos < this.json.length) {
			val = this.getNextSymbol();
			if(val == "," && !this.lastSymbolQuoted) continue; else if(val == "]" && !this.lastSymbolQuoted) return a; else if(val == "{" && !this.lastSymbolQuoted) val = this.doObject(); else if(val == "[" && !this.lastSymbolQuoted) val = this.doArray(); else val = this.convertSymbolToProperType(val);
			a.push(val);
		}
		throw new js__$Boot_HaxeError("Unexpected end of file. Expected ']'");
	}
	,convertSymbolToProperType: function(symbol) {
		if(this.lastSymbolQuoted) {
			if(StringTools.startsWith(symbol,tjson_TJSON.OBJECT_REFERENCE_PREFIX)) {
				var idx = Std.parseInt(HxOverrides.substr(symbol,tjson_TJSON.OBJECT_REFERENCE_PREFIX.length,null));
				return this.cache[idx];
			}
			return symbol;
		}
		if(this.looksLikeFloat(symbol)) return parseFloat(symbol);
		if(this.looksLikeInt(symbol)) return Std.parseInt(symbol);
		if(symbol.toLowerCase() == "true") return true;
		if(symbol.toLowerCase() == "false") return false;
		if(symbol.toLowerCase() == "null") return null;
		return symbol;
	}
	,looksLikeFloat: function(s) {
		return this.floatRegex.match(s) || this.intRegex.match(s) && (function($this) {
			var $r;
			var intStr = $this.intRegex.matched(0);
			$r = HxOverrides.cca(intStr,0) == 45?intStr > "-2147483648":intStr > "2147483647";
			return $r;
		}(this));
	}
	,looksLikeInt: function(s) {
		return this.intRegex.match(s);
	}
	,getNextSymbol: function() {
		this.lastSymbolQuoted = false;
		var c = "";
		var inQuote = false;
		var quoteType = "";
		var symbol = "";
		var inEscape = false;
		var inSymbol = false;
		var inLineComment = false;
		var inBlockComment = false;
		while(this.pos < this.json.length) {
			c = this.json.charAt(this.pos++);
			if(c == "\n" && !inSymbol) this.currentLine++;
			if(inLineComment) {
				if(c == "\n" || c == "\r") {
					inLineComment = false;
					this.pos++;
				}
				continue;
			}
			if(inBlockComment) {
				if(c == "*" && this.json.charAt(this.pos) == "/") {
					inBlockComment = false;
					this.pos++;
				}
				continue;
			}
			if(inQuote) {
				if(inEscape) {
					inEscape = false;
					if(c == "'" || c == "\"") {
						symbol += c;
						continue;
					}
					if(c == "t") {
						symbol += "\t";
						continue;
					}
					if(c == "n") {
						symbol += "\n";
						continue;
					}
					if(c == "\\") {
						symbol += "\\";
						continue;
					}
					if(c == "r") {
						symbol += "\r";
						continue;
					}
					if(c == "/") {
						symbol += "/";
						continue;
					}
					if(c == "u") {
						var hexValue = 0;
						var _g = 0;
						while(_g < 4) {
							var i = _g++;
							if(this.pos >= this.json.length) throw new js__$Boot_HaxeError("Unfinished UTF8 character");
							var nc;
							var index = this.pos++;
							nc = HxOverrides.cca(this.json,index);
							hexValue = hexValue << 4;
							if(nc >= 48 && nc <= 57) hexValue += nc - 48; else if(nc >= 65 && nc <= 70) hexValue += 10 + nc - 65; else if(nc >= 97 && nc <= 102) hexValue += 10 + nc - 95; else throw new js__$Boot_HaxeError("Not a hex digit");
						}
						var utf = new haxe_Utf8();
						utf.__b += String.fromCharCode(hexValue);
						symbol += utf.__b;
						continue;
					}
					throw new js__$Boot_HaxeError("Invalid escape sequence '\\" + c + "'");
				} else {
					if(c == "\\") {
						inEscape = true;
						continue;
					}
					if(c == quoteType) return symbol;
					symbol += c;
					continue;
				}
			} else if(c == "/") {
				var c2 = this.json.charAt(this.pos);
				if(c2 == "/") {
					inLineComment = true;
					this.pos++;
					continue;
				} else if(c2 == "*") {
					inBlockComment = true;
					this.pos++;
					continue;
				}
			}
			if(inSymbol) {
				if(c == " " || c == "\n" || c == "\r" || c == "\t" || c == "," || c == ":" || c == "}" || c == "]") {
					this.pos--;
					return symbol;
				} else {
					symbol += c;
					continue;
				}
			} else {
				if(c == " " || c == "\t" || c == "\n" || c == "\r") continue;
				if(c == "{" || c == "}" || c == "[" || c == "]" || c == "," || c == ":") return c;
				if(c == "'" || c == "\"") {
					inQuote = true;
					quoteType = c;
					this.lastSymbolQuoted = true;
					continue;
				} else {
					inSymbol = true;
					symbol = c;
					continue;
				}
			}
		}
		if(inQuote) throw new js__$Boot_HaxeError("Unexpected end of data. Expected ( " + quoteType + " )");
		return symbol;
	}
	,defaultStringProcessor: function(str) {
		return str;
	}
	,__class__: tjson_TJSONParser
};
var tjson_TJSONEncoder = function(useCache) {
	if(useCache == null) useCache = true;
	this.uCache = useCache;
	if(this.uCache) this.cache = [];
};
$hxClasses["tjson.TJSONEncoder"] = tjson_TJSONEncoder;
tjson_TJSONEncoder.__name__ = ["tjson","TJSONEncoder"];
tjson_TJSONEncoder.prototype = {
	cache: null
	,uCache: null
	,doEncode: function(obj,style) {
		if(!Reflect.isObject(obj)) throw new js__$Boot_HaxeError("Provided object is not an object.");
		var st;
		if(js_Boot.__instanceof(style,tjson_EncodeStyle)) st = style; else if(style == "fancy") st = new tjson_FancyStyle(); else st = new tjson_SimpleStyle();
		var buffer = new StringBuf();
		if((obj instanceof Array) && obj.__enum__ == null || js_Boot.__instanceof(obj,List)) buffer.add(this.encodeIterable(obj,st,0)); else if(js_Boot.__instanceof(obj,haxe_ds_StringMap)) buffer.add(this.encodeMap(obj,st,0)); else {
			this.cacheEncode(obj);
			buffer.add(this.encodeObject(obj,st,0));
		}
		return buffer.b;
	}
	,encodeObject: function(obj,style,depth) {
		var buffer = new StringBuf();
		buffer.add(style.beginObject(depth));
		var fieldCount = 0;
		var fields;
		var dontEncodeFields = null;
		var cls = Type.getClass(obj);
		if(cls != null) fields = Type.getInstanceFields(cls); else fields = Reflect.fields(obj);
		{
			var _g = Type["typeof"](obj);
			switch(_g[1]) {
			case 6:
				var c = _g[2];
				if(fieldCount++ > 0) buffer.add(style.entrySeperator(depth)); else buffer.add(style.firstEntry(depth));
				buffer.add("\"_hxcls\"" + style.keyValueSeperator(depth));
				buffer.add(this.encodeValue(Type.getClassName(c),style,depth));
				if(obj.TJ_noEncode != null) dontEncodeFields = obj.TJ_noEncode();
				break;
			default:
			}
		}
		var _g1 = 0;
		while(_g1 < fields.length) {
			var field = fields[_g1];
			++_g1;
			if(dontEncodeFields != null && HxOverrides.indexOf(dontEncodeFields,field,0) >= 0) continue;
			var value = Reflect.field(obj,field);
			var vStr = this.encodeValue(value,style,depth);
			if(vStr != null) {
				if(fieldCount++ > 0) buffer.add(style.entrySeperator(depth)); else buffer.add(style.firstEntry(depth));
				buffer.add("\"" + field + "\"" + style.keyValueSeperator(depth) + vStr);
			}
		}
		buffer.add(style.endObject(depth));
		return buffer.b;
	}
	,encodeMap: function(obj,style,depth) {
		var buffer = new StringBuf();
		buffer.add(style.beginObject(depth));
		var fieldCount = 0;
		var $it0 = obj.keys();
		while( $it0.hasNext() ) {
			var field = $it0.next();
			if(fieldCount++ > 0) buffer.add(style.entrySeperator(depth)); else buffer.add(style.firstEntry(depth));
			var value = obj.get(field);
			buffer.add("\"" + field + "\"" + style.keyValueSeperator(depth));
			buffer.add(this.encodeValue(value,style,depth));
		}
		buffer.add(style.endObject(depth));
		return buffer.b;
	}
	,encodeIterable: function(obj,style,depth) {
		var buffer = new StringBuf();
		buffer.add(style.beginArray(depth));
		var fieldCount = 0;
		var $it0 = $iterator(obj)();
		while( $it0.hasNext() ) {
			var value = $it0.next();
			if(fieldCount++ > 0) buffer.add(style.entrySeperator(depth)); else buffer.add(style.firstEntry(depth));
			buffer.add(this.encodeValue(value,style,depth));
		}
		buffer.add(style.endArray(depth));
		return buffer.b;
	}
	,cacheEncode: function(value) {
		if(!this.uCache) return null;
		var _g1 = 0;
		var _g = this.cache.length;
		while(_g1 < _g) {
			var c = _g1++;
			if(this.cache[c] == value) return "\"" + tjson_TJSON.OBJECT_REFERENCE_PREFIX + c + "\"";
		}
		this.cache.push(value);
		return null;
	}
	,encodeValue: function(value,style,depth) {
		if(((value | 0) === value) || typeof(value) == "number") return value; else if((value instanceof Array) && value.__enum__ == null || js_Boot.__instanceof(value,List)) {
			var v = value;
			return this.encodeIterable(v,style,depth + 1);
		} else if(js_Boot.__instanceof(value,List)) {
			var v1 = value;
			return this.encodeIterable(v1,style,depth + 1);
		} else if(js_Boot.__instanceof(value,haxe_ds_StringMap)) return this.encodeMap(value,style,depth + 1); else if(typeof(value) == "string") return "\"" + StringTools.replace(StringTools.replace(StringTools.replace(StringTools.replace(Std.string(value),"\\","\\\\"),"\n","\\n"),"\r","\\r"),"\"","\\\"") + "\""; else if(typeof(value) == "boolean") return value; else if(Reflect.isObject(value)) {
			var ret = this.cacheEncode(value);
			if(ret != null) return ret;
			return this.encodeObject(value,style,depth + 1);
		} else if(value == null) return "null"; else return null;
	}
	,__class__: tjson_TJSONEncoder
};
var tjson_EncodeStyle = function() { };
$hxClasses["tjson.EncodeStyle"] = tjson_EncodeStyle;
tjson_EncodeStyle.__name__ = ["tjson","EncodeStyle"];
tjson_EncodeStyle.prototype = {
	beginObject: null
	,endObject: null
	,beginArray: null
	,endArray: null
	,firstEntry: null
	,entrySeperator: null
	,keyValueSeperator: null
	,__class__: tjson_EncodeStyle
};
var tjson_SimpleStyle = function() {
};
$hxClasses["tjson.SimpleStyle"] = tjson_SimpleStyle;
tjson_SimpleStyle.__name__ = ["tjson","SimpleStyle"];
tjson_SimpleStyle.__interfaces__ = [tjson_EncodeStyle];
tjson_SimpleStyle.prototype = {
	beginObject: function(depth) {
		return "{";
	}
	,endObject: function(depth) {
		return "}";
	}
	,beginArray: function(depth) {
		return "[";
	}
	,endArray: function(depth) {
		return "]";
	}
	,firstEntry: function(depth) {
		return "";
	}
	,entrySeperator: function(depth) {
		return ",";
	}
	,keyValueSeperator: function(depth) {
		return ":";
	}
	,__class__: tjson_SimpleStyle
};
var tjson_FancyStyle = function(tab) {
	if(tab == null) tab = "    ";
	this.tab = tab;
	this.charTimesNCache = [""];
};
$hxClasses["tjson.FancyStyle"] = tjson_FancyStyle;
tjson_FancyStyle.__name__ = ["tjson","FancyStyle"];
tjson_FancyStyle.__interfaces__ = [tjson_EncodeStyle];
tjson_FancyStyle.prototype = {
	tab: null
	,beginObject: function(depth) {
		return "{\n";
	}
	,endObject: function(depth) {
		return "\n" + this.charTimesN(depth) + "}";
	}
	,beginArray: function(depth) {
		return "[\n";
	}
	,endArray: function(depth) {
		return "\n" + this.charTimesN(depth) + "]";
	}
	,firstEntry: function(depth) {
		return this.charTimesN(depth + 1) + " ";
	}
	,entrySeperator: function(depth) {
		return "\n" + this.charTimesN(depth + 1) + ",";
	}
	,keyValueSeperator: function(depth) {
		return " : ";
	}
	,charTimesNCache: null
	,charTimesN: function(n) {
		if(n < this.charTimesNCache.length) return this.charTimesNCache[n]; else return this.charTimesNCache[n] = this.charTimesN(n - 1) + this.tab;
	}
	,__class__: tjson_FancyStyle
};
function $iterator(o) { if( o instanceof Array ) return function() { return HxOverrides.iter(o); }; return typeof(o.iterator) == 'function' ? $bind(o,o.iterator) : o.iterator; }
var $_, $fid = 0;
function $bind(o,m) { if( m == null ) return null; if( m.__id__ == null ) m.__id__ = $fid++; var f; if( o.hx__closures__ == null ) o.hx__closures__ = {}; else f = o.hx__closures__[m.__id__]; if( f == null ) { f = function(){ return f.method.apply(f.scope, arguments); }; f.scope = o; f.method = m; o.hx__closures__[m.__id__] = f; } return f; }
if(Array.prototype.indexOf) HxOverrides.indexOf = function(a,o,i) {
	return Array.prototype.indexOf.call(a,o,i);
};
if(Array.prototype.lastIndexOf) HxOverrides.lastIndexOf = function(a1,o1,i1) {
	return Array.prototype.lastIndexOf.call(a1,o1,i1);
};
$hxClasses.Math = Math;
String.prototype.__class__ = $hxClasses.String = String;
String.__name__ = ["String"];
$hxClasses.Array = Array;
Array.__name__ = ["Array"];
Date.prototype.__class__ = $hxClasses.Date = Date;
Date.__name__ = ["Date"];
var Int = $hxClasses.Int = { __name__ : ["Int"]};
var Dynamic = $hxClasses.Dynamic = { __name__ : ["Dynamic"]};
var Float = $hxClasses.Float = Number;
Float.__name__ = ["Float"];
var Bool = $hxClasses.Bool = Boolean;
Bool.__ename__ = ["Bool"];
var Class = $hxClasses.Class = { __name__ : ["Class"]};
var Enum = { };
if(Array.prototype.map == null) Array.prototype.map = function(f) {
	var a = [];
	var _g1 = 0;
	var _g = this.length;
	while(_g1 < _g) {
		var i = _g1++;
		a[i] = f(this[i]);
	}
	return a;
};
if(Array.prototype.filter == null) Array.prototype.filter = function(f1) {
	var a1 = [];
	var _g11 = 0;
	var _g2 = this.length;
	while(_g11 < _g2) {
		var i1 = _g11++;
		var e = this[i1];
		if(f1(e)) a1.push(e);
	}
	return a1;
};
createjs.DisplayObject.prototype.setBounds = function(x, y, width, height) { this._bounds = x != null ? (this._bounds || new createjs.Rectangle()).setValues(x, y, width, height) : null; };;
var __map_reserved = {};
(function (global, define) {
	"use strict";

	define(function() {
	
		var doc = global.document;
		var html = doc.documentElement;
		var body, fakeBody, div, span;
		var overflow;
		var style = "&#173;<style>@font-face{font-family:test-woff2;src:url(data:font/woff2;base64,d09GMgABAAAAAAIkAAoAAAAABVwAAAHcAAEAAAAAAAAAAAAAAAAAAAAAAAAAAAAABlYAgloKLEoBNgIkAxgLDgAEIAWDcgc1G7IEyB6SJAFID5YA3nAHC6h4+H7s27nP1kTyOoQkGuJWtNGIJKYznRI3VEL7IaHq985ZUuKryZKcAtJsi5eULwUybm9KzajBBhywZ5ZwoJNuwDX5C/xBjvz5DbsoNsvG1NGQiqp0NMLZ7JlnW+5MaM3HwcHheUQeiVokekHkn/FRdefvJaTp2PczN+I1Sc3k9VuX51Tb0Tqqf1deVXGdJsDOhz0/EffMOPOzHNH06pYkDDjs+P8fb/z/8n9Iq8ITzWywkP6PBMMN9L/O7vY2FNoTAkp5PpD6g1nV9WmyQnM5uPpAMHR2fe06jbfvzPriekVTQxC6lpKr43oDtRZfCATl5OVAUKykqwm9o8R/kg37cxa6eZikS7cjK4aIwoyh6jOFplhFrz2b833G3Jii9AjDUiAZ9AxZtxdEYV6imvRF0+0Nej3wu6nPZrTLh81AVcV3kmMVdQj6Qbe9qetzbuDZ7vXOlRrqooFSxCv6SfrDICA6rnHZXQPVcUHJYGcoqa3jVH7ATrjWBNYYkEqF3RFpVIl0q2JvMOJd7/TyjXHw2NyAuJpNaEbz8RTEVtCbSH7JrwQQOqwGl7sTUOtdBZIY2DKqKlvOmPvUxJaURAZZcviTT0SKHCXqzwc=) format(\"woff2\");font-weight:400}@font-face{font-family:test-woff;src:url(data:font/woff;base64,d09GRgABAAAAAAOEAAoAAAAABVwAAQAAAAAAAAAAAAAAAAAAAAAAAAAAAABPUy8yAAAA9AAAAEEAAABWXgxFo2NtYXAAAAE4AAAASQAAAVrCBCIvZ2x5ZgAAAYQAAAApAAAALBOjUapoZWFkAAABsAAAAC0AAAA2BMSve2hoZWEAAAHgAAAAHgAAACQG0gUHaG10eAAAAgAAAAATAAAAGBfUAABsb2NhAAACFAAAAA4AAAAOACwAJG1heHAAAAIkAAAAHwAAACABEQAQbmFtZQAAAkQAAAEeAAAB8l01citwb3N0AAADZAAAAB8AAAA1AyQCCHicY2Bk/sk4gYGVgYP5O0sCAwPDAwjNzMDgxziHgYGJgRXIxAYC0lxTGByAGoCa/x1gmMDKwAjkMTCC5AAZ5wtJAAAAeJxjYGBgZoBgGQZGBhAIAfIYwXwWBgsgzcXAwcAEhAwMvAx6Dxj+/wergrP/f/l/RYEZqhcKGNkYUAEjAwHAREjBkAMAewYLEAAAAHicY2BkAAJGB1YGBmYGBkFFQUVGh38HWBn+HQAJM8AAUM6SGQBoaQSxAAAAeJxjYGRgYABiE72TQvH8Nl8ZuNkcgCIMl4yN5yPTjA6sIIqDgQlEAQDiBwcuAAAAeJxjYGRgYGX4d4BhApsDAxAwOjAwMqACNgBPYgLjAAB4nGP8wsDA5gDBzAoIDAAiXAHrAAAAAAAAAAAOABYAFgAWAAB4nGNgZGBgYGNgYQDRDAxMQMwFhAwM/8F8BgAJZwEiAHicXY6/bsIwEMa/QEhbkFqkSu1qdWCplAAjDwBzGdgDOAGUxJFjkFg7duxTdOxT9Ln6xT064JPvfvfdHxvAED8I0J4At963p4MbZn/cRYgH4ZD2KNzDAM/CEfUX4T5eMRIesPuNG4LwjsoQW+EO7uGEu3zpXTgkfwj38IRP4Yj6l3AfK3wLDzAKosxUTheFWer8WKTW6ca1d6VtszeVmsTjNl3oStvU6a1an1VzyqfOZSqzplRzmVe1NQe9cfHOuXqWJJe98caUyGBQ8c8aBc1gScpxJKewXm/oL3HFaEl7P6UwQYzxf3XBWPmO1Gtbdqxxpm9w4tap35Qxz9hjUJLmV+8r1L52oLKhHmPnp2rMkNCu/xuzi5t+Abr4U+YAAHicY2BigAABBuyAjYGBkYmRmZGFkZWRDSoGAATyADIA) format(\"woff\");font-weight:400}@font-face{font-family:test-ttf;src:url(data:font/ttf;base64,AAEAAAAKAIAAAwAgT1MvMl4MRaMAAAEoAAAAVmNtYXDCBCIvAAABmAAAAVpnbHlmE6NRqgAAAwQAAAAsaGVhZATEr3sAAADQAAAANmhoZWEG0gUHAAAArAAAACRobXR4F9QAAAAAAYAAAAAYbG9jYQAsACQAAAL0AAAADm1heHABEQAQAAABCAAAACBuYW1lXTVyKwAAAzAAAAHycG9zdAMkAggAAAUkAAAANQABAAAFAP7AAJAGQAAAAAABQAABAAAAAAAAAAAAAAAAAAAABgABAAAAAQAANC7Orl8PPPUACwZAAAAAANIzM58AAAAA0jMznwAAAAABQAUAAAAACAACAAAAAAAAAAEAAAAGAAQAAQAAAAAAAgAAAAoACgAAAP8AAAAAAAAAAQP5AZAABQAAA/cEYAAAAOAD9wRgAAADAABOAZwAAAIABQMAAAAAAAAAAAAAAAAAAAAAAAAAAAAAUGZFZABAAADgAAUA/sAAkAUAAUAAAAABAAAAAAAAAfQAAAZAAAAGQAAAAyAAAAMgAAADIAAAAAAAAwAAAAMAAAAcAAEAAAAAAFQAAwABAAAAHAAEADgAAAAKAAgAAgACAAAADQAu4AD//wAAAAAADQAu4AD//wAA//T/1CADAAEAAAAAAAAAAAAAAAABBgAAAAAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA4AFgAWABYAAAABAAAAAAFABQAAAwAAESERIQFA/sAFAP7AAAAAAQAAAAAAAAAAAAMAADkDAAAAEADGAAEAAAAAAAEACAAAAAEAAAAAAAIABwAIAAEAAAAAAAMABAAPAAEAAAAAAAQABAATAAEAAAAAAAUACwAXAAEAAAAAAAYABAAiAAEAAAAAAAoAKwAmAAEAAAAAAAsAEwBRAAMAAQQJAAEAEABkAAMAAQQJAAIADgB0AAMAAQQJAAMACACCAAMAAQQJAAQACACKAAMAAQQJAAUAFgCSAAMAAQQJAAYACACoAAMAAQQJAAoAVgCwAAMAAQQJAAsAJgEGZm9udGVsbG9SZWd1bGFydGVzdHRlc3RWZXJzaW9uIDEuMHRlc3RHZW5lcmF0ZWQgYnkgc3ZnMnR0ZiBmcm9tIEZvbnRlbGxvIHByb2plY3QuaHR0cDovL2ZvbnRlbGxvLmNvbQBmAG8AbgB0AGUAbABsAG8AUgBlAGcAdQBsAGEAcgB0AGUAcwB0AHQAZQBzAHQAVgBlAHIAcwBpAG8AbgAgADEALgAwAHQAZQBzAHQARwBlAG4AZQByAGEAdABlAGQAIABiAHkAIABzAHYAZwAyAHQAdABmACAAZgByAG8AbQAgAEYAbwBuAHQAZQBsAGwAbwAgAHAAcgBvAGoAZQBjAHQALgBoAHQAdABwADoALwAvAGYAbwBuAHQAZQBsAGwAbwAuAGMAbwBtAAAAAgAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAGAAABAgEDAQQBBQEGAAAAAAAAAAAAAA==) format(\"truetype\");font-weight:400}@font-face{font-family:test-svg;src:url(data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBzdGFuZGFsb25lPSJubyI/Pgo8IURPQ1RZUEUgc3ZnIFBVQkxJQyAiLS8vVzNDLy9EVEQgU1ZHIDEuMS8vRU4iICJodHRwOi8vd3d3LnczLm9yZy9HcmFwaGljcy9TVkcvMS4xL0RURC9zdmcxMS5kdGQiID4KPHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciPgo8ZGVmcz4KPGZvbnQgaWQ9InRlc3QiIGhvcml6LWFkdi14PSIxNjAwIiA+Cjxmb250LWZhY2UgdW5pdHMtcGVyLWVtPSIxNjAwIiBhc2NlbnQ9IjEyODAiIGRlc2NlbnQ9Ii0zMjAiIC8+CjxtaXNzaW5nLWdseXBoIGhvcml6LWFkdi14PSI1MDAiIC8+CjxnbHlwaCBob3Jpei1hZHYteD0iODAwIiAvPgo8Z2x5cGggaG9yaXotYWR2LXg9IjgwMCIgLz4KPGdseXBoIHVuaWNvZGU9IiYjeGQ7IiAvPgo8Z2x5cGggdW5pY29kZT0iLiIgZD0iTTAgMTI4MGgzMjB2LTMyMGgtMzIwdjMyMHoiIC8+CjxnbHlwaCB1bmljb2RlPSImI3hlMDAwOyIgaG9yaXotYWR2LXg9IjgwMCIgZD0iTTAgMHYwdjB2MHYweiIgLz4KPC9mb250Pgo8L2RlZnM+PC9zdmc+IA==) format(\"svg\");font-weight:400}.test-woff2,.test-woff,.test-ttf,.test-svg{font-size:10px;font-weight:400}.test-woff2{font-family:test-woff2}.test-woff{font-family:test-woff}.test-ttf{font-family:test-ttf}.test-svg{font-family:test-svg}</style>";
		var formats = ["woff2", "woff", "ttf", "svg"];
		var isComplete = false;
		var isRunning = false;
		var callbacks = [];
		var support = {};

		return function (callback, returnOption) {
			
			callbacks.push({callback: callback, option: returnOption || null});

			if (isComplete) {
				handleCallbacks();
			}
			else {
				
				if (isRunning) {
					return;
				}
				
				detect();
			}

		};
		
		function formatResult (option) {
			var result;
			if (!option) {
				result = support;
			}
			else if (typeof option == "string") {
				result = support[option];
			}
			else {
				result = [];
				var i = 0;
				var l = option.length;
				while (i < l) {
					(function (format) {
						if (support[format]) {
							result.push(format);
						}
					}(option[i++]));
				}
				result = 0 in result && result[0] || null;
			}
			return result;
		}
		
		function handleCallbacks () {
			var data;
			while (callbacks.length) {
				data = callbacks.shift();
				data.callback(formatResult(data.option));
			}
		}
		
		function detect () {
			isRunning = true;
			body = doc.body,
			fakeBody = body || doc.createElement("body"),
			div = doc.createElement("div"),
			span = doc.createElement("span"),

			span.innerHTML = ".";

			(body ? div : fakeBody).innerHTML += style;
			fakeBody.appendChild(div);
			if (!body) {
				fakeBody.style.background = "";
				fakeBody.style.overflow = "hidden";
				overflow = html.style.overflow;
				html.style.overflow = "hidden";
				html.appendChild(fakeBody);
			}

			var i = 0;
			var l = formats.length;
			var countdown = l;
			var clones = [];
			var detected;
			var start = new Date();
			var timeout = 2000;

			while (i < l) {
				(function (format, clone) {
					clone.className = "test-" + format;
					clones.push(clone);
					div.appendChild(clone);
				}(formats[i++], span.cloneNode(true)));
			}

			(function check() {
				var i = 0;
				while (i < l) {
					if (clones[i].offsetWidth == 10) {
						detected = true;
						support[formats[i]] = true;
					}
					i++;
				}
				if (detected) {
					isComplete = true;
					cleanup();
				}
				else if (new Date() - start > timeout) {
					cleanup();
				}
				else {
					setTimeout(check, 100);
				}
			}());
		}
		
		function cleanup() {
			if (!body) {
				fakeBody.parentNode.removeChild(fakeBody);
				html.style.overflow = overflow;
			} else {
				div.parentNode.removeChild(div);
			}
			handleCallbacks();
			isRunning = false;
		}
		
	});

}(window, typeof define == "function" && define.amd ? define : function(factory) { window.fontSupport = factory() } ));;
var q = window.jQuery;
var js = js || {}
js.JQuery = q;
var ArrayBuffer = (Function("return typeof ArrayBuffer != 'undefined' ? ArrayBuffer : null"))() || js_html_compat_ArrayBuffer;
if(ArrayBuffer.prototype.slice == null) ArrayBuffer.prototype.slice = js_html_compat_ArrayBuffer.sliceImpl;
var DataView = (Function("return typeof DataView != 'undefined' ? DataView : null"))() || js_html_compat_DataView;
var Uint8Array = (Function("return typeof Uint8Array != 'undefined' ? Uint8Array : null"))() || js_html_compat_Uint8Array._new;
$hx_exports.$extend = $extend;
if(typeof THREE != 'undefined') {
	/**
 * @author mrdoob / http://mrdoob.com/
 * @author supereggbert / http://www.paulbrunt.co.uk/
 * @author julianwa / https://github.com/julianwa
 */

THREE.RenderableObject = function () {

	this.id = 0;

	this.object = null;
	this.z = 0;
	this.renderOrder = 0;

};

//

THREE.RenderableFace = function () {

	this.id = 0;

	this.v1 = new THREE.RenderableVertex();
	this.v2 = new THREE.RenderableVertex();
	this.v3 = new THREE.RenderableVertex();

	this.normalModel = new THREE.Vector3();

	this.vertexNormalsModel = [ new THREE.Vector3(), new THREE.Vector3(), new THREE.Vector3() ];
	this.vertexNormalsLength = 0;

	this.color = new THREE.Color();
	this.material = null;
	this.uvs = [ new THREE.Vector2(), new THREE.Vector2(), new THREE.Vector2() ];

	this.z = 0;
	this.renderOrder = 0;

};

//

THREE.RenderableVertex = function () {

	this.position = new THREE.Vector3();
	this.positionWorld = new THREE.Vector3();
	this.positionScreen = new THREE.Vector4();

	this.visible = true;

};

THREE.RenderableVertex.prototype.copy = function ( vertex ) {

	this.positionWorld.copy( vertex.positionWorld );
	this.positionScreen.copy( vertex.positionScreen );

};

//

THREE.RenderableLine = function () {

	this.id = 0;

	this.v1 = new THREE.RenderableVertex();
	this.v2 = new THREE.RenderableVertex();

	this.vertexColors = [ new THREE.Color(), new THREE.Color() ];
	this.material = null;

	this.z = 0;
	this.renderOrder = 0;

};

//

THREE.RenderableSprite = function () {

	this.id = 0;

	this.object = null;

	this.x = 0;
	this.y = 0;
	this.z = 0;

	this.rotation = 0;
	this.scale = new THREE.Vector2();

	this.material = null;
	this.renderOrder = 0;

};

//

THREE.Projector = function () {

	var _object, _objectCount, _objectPool = [], _objectPoolLength = 0,
	_vertex, _vertexCount, _vertexPool = [], _vertexPoolLength = 0,
	_face, _faceCount, _facePool = [], _facePoolLength = 0,
	_line, _lineCount, _linePool = [], _linePoolLength = 0,
	_sprite, _spriteCount, _spritePool = [], _spritePoolLength = 0,

	_renderData = { objects: [], lights: [], elements: [] },

	_vector3 = new THREE.Vector3(),
	_vector4 = new THREE.Vector4(),

	_clipBox = new THREE.Box3( new THREE.Vector3( - 1, - 1, - 1 ), new THREE.Vector3( 1, 1, 1 ) ),
	_boundingBox = new THREE.Box3(),
	_points3 = new Array( 3 ),
	_points4 = new Array( 4 ),

	_viewMatrix = new THREE.Matrix4(),
	_viewProjectionMatrix = new THREE.Matrix4(),

	_modelMatrix,
	_modelViewProjectionMatrix = new THREE.Matrix4(),

	_normalMatrix = new THREE.Matrix3(),

	_frustum = new THREE.Frustum(),

	_clippedVertex1PositionScreen = new THREE.Vector4(),
	_clippedVertex2PositionScreen = new THREE.Vector4();

	//

	this.projectVector = function ( vector, camera ) {

		console.warn( 'THREE.Projector: .projectVector() is now vector.project().' );
		vector.project( camera );

	};

	this.unprojectVector = function ( vector, camera ) {

		console.warn( 'THREE.Projector: .unprojectVector() is now vector.unproject().' );
		vector.unproject( camera );

	};

	this.pickingRay = function ( vector, camera ) {

		console.error( 'THREE.Projector: .pickingRay() is now raycaster.setFromCamera().' );

	};

	//

	var RenderList = function () {

		var normals = [];
		var uvs = [];

		var object = null;
		var material = null;

		var normalMatrix = new THREE.Matrix3();

		var setObject = function ( value ) {

			object = value;
			material = object.material;

			normalMatrix.getNormalMatrix( object.matrixWorld );

			normals.length = 0;
			uvs.length = 0;

		};

		var projectVertex = function ( vertex ) {

			var position = vertex.position;
			var positionWorld = vertex.positionWorld;
			var positionScreen = vertex.positionScreen;

			positionWorld.copy( position ).applyMatrix4( _modelMatrix );
			positionScreen.copy( positionWorld ).applyMatrix4( _viewProjectionMatrix );

			var invW = 1 / positionScreen.w;

			positionScreen.x *= invW;
			positionScreen.y *= invW;
			positionScreen.z *= invW;

			vertex.visible = positionScreen.x >= - 1 && positionScreen.x <= 1 &&
					 positionScreen.y >= - 1 && positionScreen.y <= 1 &&
					 positionScreen.z >= - 1 && positionScreen.z <= 1;

		};

		var pushVertex = function ( x, y, z ) {

			_vertex = getNextVertexInPool();
			_vertex.position.set( x, y, z );

			projectVertex( _vertex );

		};

		var pushNormal = function ( x, y, z ) {

			normals.push( x, y, z );

		};

		var pushUv = function ( x, y ) {

			uvs.push( x, y );

		};

		var checkTriangleVisibility = function ( v1, v2, v3 ) {

			if ( v1.visible === true || v2.visible === true || v3.visible === true ) return true;

			_points3[ 0 ] = v1.positionScreen;
			_points3[ 1 ] = v2.positionScreen;
			_points3[ 2 ] = v3.positionScreen;

			return _clipBox.isIntersectionBox( _boundingBox.setFromPoints( _points3 ) );

		};

		var checkBackfaceCulling = function ( v1, v2, v3 ) {

			return ( ( v3.positionScreen.x - v1.positionScreen.x ) *
				    ( v2.positionScreen.y - v1.positionScreen.y ) -
				    ( v3.positionScreen.y - v1.positionScreen.y ) *
				    ( v2.positionScreen.x - v1.positionScreen.x ) ) < 0;

		};

		var pushLine = function ( a, b ) {

			var v1 = _vertexPool[ a ];
			var v2 = _vertexPool[ b ];

			_line = getNextLineInPool();

			_line.id = object.id;
			_line.v1.copy( v1 );
			_line.v2.copy( v2 );
			_line.z = ( v1.positionScreen.z + v2.positionScreen.z ) / 2;
			_line.renderOrder = object.renderOrder;

			_line.material = object.material;

			_renderData.elements.push( _line );

		};

		var pushTriangle = function ( a, b, c ) {

			var v1 = _vertexPool[ a ];
			var v2 = _vertexPool[ b ];
			var v3 = _vertexPool[ c ];

			if ( checkTriangleVisibility( v1, v2, v3 ) === false ) return;

			if ( material.side === THREE.DoubleSide || checkBackfaceCulling( v1, v2, v3 ) === true ) {

				_face = getNextFaceInPool();

				_face.id = object.id;
				_face.v1.copy( v1 );
				_face.v2.copy( v2 );
				_face.v3.copy( v3 );
				_face.z = ( v1.positionScreen.z + v2.positionScreen.z + v3.positionScreen.z ) / 3;
				_face.renderOrder = object.renderOrder;

				// use first vertex normal as face normal

				_face.normalModel.fromArray( normals, a * 3 );
				_face.normalModel.applyMatrix3( normalMatrix ).normalize();

				for ( var i = 0; i < 3; i ++ ) {

					var normal = _face.vertexNormalsModel[ i ];
					normal.fromArray( normals, arguments[ i ] * 3 );
					normal.applyMatrix3( normalMatrix ).normalize();

					var uv = _face.uvs[ i ];
					uv.fromArray( uvs, arguments[ i ] * 2 );

				}

				_face.vertexNormalsLength = 3;

				_face.material = object.material;

				_renderData.elements.push( _face );

			}

		};

		return {
			setObject: setObject,
			projectVertex: projectVertex,
			checkTriangleVisibility: checkTriangleVisibility,
			checkBackfaceCulling: checkBackfaceCulling,
			pushVertex: pushVertex,
			pushNormal: pushNormal,
			pushUv: pushUv,
			pushLine: pushLine,
			pushTriangle: pushTriangle
		}

	};

	var renderList = new RenderList();

	this.projectScene = function ( scene, camera, sortObjects, sortElements ) {

		_faceCount = 0;
		_lineCount = 0;
		_spriteCount = 0;

		_renderData.elements.length = 0;

		if ( scene.autoUpdate === true ) scene.updateMatrixWorld();
		if ( camera.parent === null ) camera.updateMatrixWorld();

		_viewMatrix.copy( camera.matrixWorldInverse.getInverse( camera.matrixWorld ) );
		_viewProjectionMatrix.multiplyMatrices( camera.projectionMatrix, _viewMatrix );

		_frustum.setFromMatrix( _viewProjectionMatrix );

		//

		_objectCount = 0;

		_renderData.objects.length = 0;
		_renderData.lights.length = 0;

		scene.traverseVisible( function ( object ) {

			if ( object instanceof THREE.Light ) {

				_renderData.lights.push( object );

			} else if ( object instanceof THREE.Mesh || object instanceof THREE.Line || object instanceof THREE.Sprite ) {

				var material = object.material;

				if ( material.visible === false ) return;

				if ( object.frustumCulled === false || _frustum.intersectsObject( object ) === true ) {

					_object = getNextObjectInPool();
					_object.id = object.id;
					_object.object = object;

					_vector3.setFromMatrixPosition( object.matrixWorld );
					_vector3.applyProjection( _viewProjectionMatrix );
					_object.z = _vector3.z;
					_object.renderOrder = object.renderOrder;

					_renderData.objects.push( _object );

				}

			}

		} );

		if ( sortObjects === true ) {

			_renderData.objects.sort( painterSort );

		}

		//

		for ( var o = 0, ol = _renderData.objects.length; o < ol; o ++ ) {

			var object = _renderData.objects[ o ].object;
			var geometry = object.geometry;

			renderList.setObject( object );

			_modelMatrix = object.matrixWorld;

			_vertexCount = 0;

			if ( object instanceof THREE.Mesh ) {

				if ( geometry instanceof THREE.BufferGeometry ) {

					var attributes = geometry.attributes;
					var groups = geometry.groups;

					if ( attributes.position === undefined ) continue;

					var positions = attributes.position.array;

					for ( var i = 0, l = positions.length; i < l; i += 3 ) {

						renderList.pushVertex( positions[ i ], positions[ i + 1 ], positions[ i + 2 ] );

					}

					if ( attributes.normal !== undefined ) {

						var normals = attributes.normal.array;

						for ( var i = 0, l = normals.length; i < l; i += 3 ) {

							renderList.pushNormal( normals[ i ], normals[ i + 1 ], normals[ i + 2 ] );

						}

					}

					if ( attributes.uv !== undefined ) {

						var uvs = attributes.uv.array;

						for ( var i = 0, l = uvs.length; i < l; i += 2 ) {

							renderList.pushUv( uvs[ i ], uvs[ i + 1 ] );

						}

					}

					if ( geometry.index !== null ) {

						var indices = geometry.index.array;

						if ( groups.length > 0 ) {

							for ( var o = 0; o < groups.length; o ++ ) {

								var group = groups[ o ];

								for ( var i = group.start, l = group.start + group.count; i < l; i += 3 ) {

									renderList.pushTriangle( indices[ i ], indices[ i + 1 ], indices[ i + 2 ] );

								}

							}

						} else {

							for ( var i = 0, l = indices.length; i < l; i += 3 ) {

								renderList.pushTriangle( indices[ i ], indices[ i + 1 ], indices[ i + 2 ] );

							}

						}

					} else {

						for ( var i = 0, l = positions.length / 3; i < l; i += 3 ) {

							renderList.pushTriangle( i, i + 1, i + 2 );

						}

					}

				} else if ( geometry instanceof THREE.Geometry ) {

					var vertices = geometry.vertices;
					var faces = geometry.faces;
					var faceVertexUvs = geometry.faceVertexUvs[ 0 ];

					_normalMatrix.getNormalMatrix( _modelMatrix );

					var material = object.material;

					var isFaceMaterial = material instanceof THREE.MeshFaceMaterial;
					var objectMaterials = isFaceMaterial === true ? object.material : null;

					for ( var v = 0, vl = vertices.length; v < vl; v ++ ) {

						var vertex = vertices[ v ];

						_vector3.copy( vertex );

						if ( material.morphTargets === true ) {

							var morphTargets = geometry.morphTargets;
							var morphInfluences = object.morphTargetInfluences;

							for ( var t = 0, tl = morphTargets.length; t < tl; t ++ ) {

								var influence = morphInfluences[ t ];

								if ( influence === 0 ) continue;

								var target = morphTargets[ t ];
								var targetVertex = target.vertices[ v ];

								_vector3.x += ( targetVertex.x - vertex.x ) * influence;
								_vector3.y += ( targetVertex.y - vertex.y ) * influence;
								_vector3.z += ( targetVertex.z - vertex.z ) * influence;

							}

						}

						renderList.pushVertex( _vector3.x, _vector3.y, _vector3.z );

					}

					for ( var f = 0, fl = faces.length; f < fl; f ++ ) {

						var face = faces[ f ];

						material = isFaceMaterial === true
							 ? objectMaterials.materials[ face.materialIndex ]
							 : object.material;

						if ( material === undefined ) continue;

						var side = material.side;

						var v1 = _vertexPool[ face.a ];
						var v2 = _vertexPool[ face.b ];
						var v3 = _vertexPool[ face.c ];

						if ( renderList.checkTriangleVisibility( v1, v2, v3 ) === false ) continue;

						var visible = renderList.checkBackfaceCulling( v1, v2, v3 );

						if ( side !== THREE.DoubleSide ) {

							if ( side === THREE.FrontSide && visible === false ) continue;
							if ( side === THREE.BackSide && visible === true ) continue;

						}

						_face = getNextFaceInPool();

						_face.id = object.id;
						_face.v1.copy( v1 );
						_face.v2.copy( v2 );
						_face.v3.copy( v3 );

						_face.normalModel.copy( face.normal );

						if ( visible === false && ( side === THREE.BackSide || side === THREE.DoubleSide ) ) {

							_face.normalModel.negate();

						}

						_face.normalModel.applyMatrix3( _normalMatrix ).normalize();

						var faceVertexNormals = face.vertexNormals;

						for ( var n = 0, nl = Math.min( faceVertexNormals.length, 3 ); n < nl; n ++ ) {

							var normalModel = _face.vertexNormalsModel[ n ];
							normalModel.copy( faceVertexNormals[ n ] );

							if ( visible === false && ( side === THREE.BackSide || side === THREE.DoubleSide ) ) {

								normalModel.negate();

							}

							normalModel.applyMatrix3( _normalMatrix ).normalize();

						}

						_face.vertexNormalsLength = faceVertexNormals.length;

						var vertexUvs = faceVertexUvs[ f ];

						if ( vertexUvs !== undefined ) {

							for ( var u = 0; u < 3; u ++ ) {

								_face.uvs[ u ].copy( vertexUvs[ u ] );

							}

						}

						_face.color = face.color;
						_face.material = material;

						_face.z = ( v1.positionScreen.z + v2.positionScreen.z + v3.positionScreen.z ) / 3;
						_face.renderOrder = object.renderOrder;

						_renderData.elements.push( _face );

					}

				}

			} else if ( object instanceof THREE.Line ) {

				if ( geometry instanceof THREE.BufferGeometry ) {

					var attributes = geometry.attributes;

					if ( attributes.position !== undefined ) {

						var positions = attributes.position.array;

						for ( var i = 0, l = positions.length; i < l; i += 3 ) {

							renderList.pushVertex( positions[ i ], positions[ i + 1 ], positions[ i + 2 ] );

						}

						if ( geometry.index !== null ) {

							var indices = geometry.index.array;

							for ( var i = 0, l = indices.length; i < l; i += 2 ) {

								renderList.pushLine( indices[ i ], indices[ i + 1 ] );

							}

						} else {

							var step = object instanceof THREE.LineSegments ? 2 : 1;

							for ( var i = 0, l = ( positions.length / 3 ) - 1; i < l; i += step ) {

								renderList.pushLine( i, i + 1 );

							}

						}

					}

				} else if ( geometry instanceof THREE.Geometry ) {

					_modelViewProjectionMatrix.multiplyMatrices( _viewProjectionMatrix, _modelMatrix );

					var vertices = object.geometry.vertices;

					if ( vertices.length === 0 ) continue;

					v1 = getNextVertexInPool();
					v1.positionScreen.copy( vertices[ 0 ] ).applyMatrix4( _modelViewProjectionMatrix );

					var step = object instanceof THREE.LineSegments ? 2 : 1;

					for ( var v = 1, vl = vertices.length; v < vl; v ++ ) {

						v1 = getNextVertexInPool();
						v1.positionScreen.copy( vertices[ v ] ).applyMatrix4( _modelViewProjectionMatrix );

						if ( ( v + 1 ) % step > 0 ) continue;

						v2 = _vertexPool[ _vertexCount - 2 ];

						_clippedVertex1PositionScreen.copy( v1.positionScreen );
						_clippedVertex2PositionScreen.copy( v2.positionScreen );

						if ( clipLine( _clippedVertex1PositionScreen, _clippedVertex2PositionScreen ) === true ) {

							// Perform the perspective divide
							_clippedVertex1PositionScreen.multiplyScalar( 1 / _clippedVertex1PositionScreen.w );
							_clippedVertex2PositionScreen.multiplyScalar( 1 / _clippedVertex2PositionScreen.w );

							_line = getNextLineInPool();

							_line.id = object.id;
							_line.v1.positionScreen.copy( _clippedVertex1PositionScreen );
							_line.v2.positionScreen.copy( _clippedVertex2PositionScreen );

							_line.z = Math.max( _clippedVertex1PositionScreen.z, _clippedVertex2PositionScreen.z );
							_line.renderOrder = object.renderOrder;

							_line.material = object.material;

							if ( object.material.vertexColors === THREE.VertexColors ) {

								_line.vertexColors[ 0 ].copy( object.geometry.colors[ v ] );
								_line.vertexColors[ 1 ].copy( object.geometry.colors[ v - 1 ] );

							}

							_renderData.elements.push( _line );

						}

					}

				}

			} else if ( object instanceof THREE.Sprite ) {

				_vector4.set( _modelMatrix.elements[ 12 ], _modelMatrix.elements[ 13 ], _modelMatrix.elements[ 14 ], 1 );
				_vector4.applyMatrix4( _viewProjectionMatrix );

				var invW = 1 / _vector4.w;

				_vector4.z *= invW;

				if ( _vector4.z >= - 1 && _vector4.z <= 1 ) {

					_sprite = getNextSpriteInPool();
					_sprite.id = object.id;
					_sprite.x = _vector4.x * invW;
					_sprite.y = _vector4.y * invW;
					_sprite.z = _vector4.z;
					_sprite.renderOrder = object.renderOrder;
					_sprite.object = object;

					_sprite.rotation = object.rotation;

					_sprite.scale.x = object.scale.x * Math.abs( _sprite.x - ( _vector4.x + camera.projectionMatrix.elements[ 0 ] ) / ( _vector4.w + camera.projectionMatrix.elements[ 12 ] ) );
					_sprite.scale.y = object.scale.y * Math.abs( _sprite.y - ( _vector4.y + camera.projectionMatrix.elements[ 5 ] ) / ( _vector4.w + camera.projectionMatrix.elements[ 13 ] ) );

					_sprite.material = object.material;

					_renderData.elements.push( _sprite );

				}

			}

		}

		if ( sortElements === true ) {

			_renderData.elements.sort( painterSort );

		}

		return _renderData;

	};

	// Pools

	function getNextObjectInPool() {

		if ( _objectCount === _objectPoolLength ) {

			var object = new THREE.RenderableObject();
			_objectPool.push( object );
			_objectPoolLength ++;
			_objectCount ++;
			return object;

		}

		return _objectPool[ _objectCount ++ ];

	}

	function getNextVertexInPool() {

		if ( _vertexCount === _vertexPoolLength ) {

			var vertex = new THREE.RenderableVertex();
			_vertexPool.push( vertex );
			_vertexPoolLength ++;
			_vertexCount ++;
			return vertex;

		}

		return _vertexPool[ _vertexCount ++ ];

	}

	function getNextFaceInPool() {

		if ( _faceCount === _facePoolLength ) {

			var face = new THREE.RenderableFace();
			_facePool.push( face );
			_facePoolLength ++;
			_faceCount ++;
			return face;

		}

		return _facePool[ _faceCount ++ ];


	}

	function getNextLineInPool() {

		if ( _lineCount === _linePoolLength ) {

			var line = new THREE.RenderableLine();
			_linePool.push( line );
			_linePoolLength ++;
			_lineCount ++;
			return line;

		}

		return _linePool[ _lineCount ++ ];

	}

	function getNextSpriteInPool() {

		if ( _spriteCount === _spritePoolLength ) {

			var sprite = new THREE.RenderableSprite();
			_spritePool.push( sprite );
			_spritePoolLength ++;
			_spriteCount ++;
			return sprite;

		}

		return _spritePool[ _spriteCount ++ ];

	}

	//

	function painterSort( a, b ) {

		if ( a.renderOrder !== b.renderOrder ) {

			return a.renderOrder - b.renderOrder;

		} else if ( a.z !== b.z ) {

			return b.z - a.z;

		} else if ( a.id !== b.id ) {

			return a.id - b.id;

		} else {

			return 0;

		}

	}

	function clipLine( s1, s2 ) {

		var alpha1 = 0, alpha2 = 1,

		// Calculate the boundary coordinate of each vertex for the near and far clip planes,
		// Z = -1 and Z = +1, respectively.
		bc1near =  s1.z + s1.w,
		bc2near =  s2.z + s2.w,
		bc1far =  - s1.z + s1.w,
		bc2far =  - s2.z + s2.w;

		if ( bc1near >= 0 && bc2near >= 0 && bc1far >= 0 && bc2far >= 0 ) {

			// Both vertices lie entirely within all clip planes.
			return true;

		} else if ( ( bc1near < 0 && bc2near < 0 ) || ( bc1far < 0 && bc2far < 0 ) ) {

			// Both vertices lie entirely outside one of the clip planes.
			return false;

		} else {

			// The line segment spans at least one clip plane.

			if ( bc1near < 0 ) {

				// v1 lies outside the near plane, v2 inside
				alpha1 = Math.max( alpha1, bc1near / ( bc1near - bc2near ) );

			} else if ( bc2near < 0 ) {

				// v2 lies outside the near plane, v1 inside
				alpha2 = Math.min( alpha2, bc1near / ( bc1near - bc2near ) );

			}

			if ( bc1far < 0 ) {

				// v1 lies outside the far plane, v2 inside
				alpha1 = Math.max( alpha1, bc1far / ( bc1far - bc2far ) );

			} else if ( bc2far < 0 ) {

				// v2 lies outside the far plane, v2 inside
				alpha2 = Math.min( alpha2, bc1far / ( bc1far - bc2far ) );

			}

			if ( alpha2 < alpha1 ) {

				// The line segment spans two boundaries, but is outside both of them.
				// (This can't happen when we're only clipping against just near/far but good
				//  to leave the check here for future usage if other clip planes are added.)
				return false;

			} else {

				// Update the s1 and s2 vertices to match the clipped line segment.
				s1.lerp( s2, alpha1 );
				s2.lerp( s1, 1 - alpha2 );

				return true;

			}

		}

	}

};
;
	/**
 * @author mrdoob / http://mrdoob.com/
 */

THREE.SpriteCanvasMaterial = function ( parameters ) {

	THREE.Material.call( this );

	this.type = 'SpriteCanvasMaterial';

	this.color = new THREE.Color( 0xffffff );
	this.program = function ( context, color ) {};

	this.setValues( parameters );

};

THREE.SpriteCanvasMaterial.prototype = Object.create( THREE.Material.prototype );
THREE.SpriteCanvasMaterial.prototype.constructor = THREE.SpriteCanvasMaterial;

THREE.SpriteCanvasMaterial.prototype.clone = function () {

	var material = new THREE.SpriteCanvasMaterial();

	material.copy( this );
	material.color.copy( this.color );
	material.program = this.program;

	return material;

};

//

THREE.CanvasRenderer = function ( parameters ) {

	//console.log( 'THREE.CanvasRenderer', THREE.REVISION );

	parameters = parameters || {};

	var _this = this,
	_renderData, _elements, _lights,
	_projector = new THREE.Projector(),

	_canvas = parameters.canvas !== undefined
			 ? parameters.canvas
			 : document.createElement( 'canvas' ),

	_canvasWidth = _canvas.width,
	_canvasHeight = _canvas.height,
	_canvasWidthHalf = Math.floor( _canvasWidth / 2 ),
	_canvasHeightHalf = Math.floor( _canvasHeight / 2 ),

	_viewportX = 0,
	_viewportY = 0,
	_viewportWidth = _canvasWidth,
	_viewportHeight = _canvasHeight,

	pixelRatio = 1,

	_context = _canvas.getContext( '2d', {
		alpha: parameters.alpha === true
	} ),

	_clearColor = new THREE.Color( 0x000000 ),
	_clearAlpha = parameters.alpha === true ? 0 : 1,

	_contextGlobalAlpha = 1,
	_contextGlobalCompositeOperation = 0,
	_contextStrokeStyle = null,
	_contextFillStyle = null,
	_contextLineWidth = null,
	_contextLineCap = null,
	_contextLineJoin = null,
	_contextLineDash = [],

	_camera,

	_v1, _v2, _v3, _v4,
	_v5 = new THREE.RenderableVertex(),
	_v6 = new THREE.RenderableVertex(),

	_v1x, _v1y, _v2x, _v2y, _v3x, _v3y,
	_v4x, _v4y, _v5x, _v5y, _v6x, _v6y,

	_color = new THREE.Color(),
	_color1 = new THREE.Color(),
	_color2 = new THREE.Color(),
	_color3 = new THREE.Color(),
	_color4 = new THREE.Color(),

	_diffuseColor = new THREE.Color(),
	_emissiveColor = new THREE.Color(),

	_lightColor = new THREE.Color(),

	_patterns = {},

	_image, _uvs,
	_uv1x, _uv1y, _uv2x, _uv2y, _uv3x, _uv3y,

	_clipBox = new THREE.Box2(),
	_clearBox = new THREE.Box2(),
	_elemBox = new THREE.Box2(),

	_ambientLight = new THREE.Color(),
	_directionalLights = new THREE.Color(),
	_pointLights = new THREE.Color(),

	_vector3 = new THREE.Vector3(), // Needed for PointLight
	_centroid = new THREE.Vector3(),
	_normal = new THREE.Vector3(),
	_normalViewMatrix = new THREE.Matrix3();

	// dash+gap fallbacks for Firefox and everything else

	if ( _context.setLineDash === undefined ) {

		_context.setLineDash = function () {}

	}

	this.domElement = _canvas;

	this.autoClear = true;
	this.sortObjects = true;
	this.sortElements = true;

	this.info = {

		render: {

			vertices: 0,
			faces: 0

		}

	};

	// WebGLRenderer compatibility

	this.supportsVertexTextures = function () {};
	this.setFaceCulling = function () {};

	// API

	this.getContext = function () {

		return _context;

	};

	this.getContextAttributes = function () {

		return _context.getContextAttributes();

	};

	this.getPixelRatio = function () {

		return pixelRatio;

	};

	this.setPixelRatio = function ( value ) {

		if ( value !== undefined ) pixelRatio = value;

	};

	this.setSize = function ( width, height, updateStyle ) {

		_canvasWidth = width * pixelRatio;
		_canvasHeight = height * pixelRatio;

		_canvas.width = _canvasWidth;
		_canvas.height = _canvasHeight;

		_canvasWidthHalf = Math.floor( _canvasWidth / 2 );
		_canvasHeightHalf = Math.floor( _canvasHeight / 2 );

		if ( updateStyle !== false ) {

			_canvas.style.width = width + 'px';
			_canvas.style.height = height + 'px';

		}

		_clipBox.min.set( - _canvasWidthHalf, - _canvasHeightHalf );
		_clipBox.max.set(   _canvasWidthHalf,   _canvasHeightHalf );

		_clearBox.min.set( - _canvasWidthHalf, - _canvasHeightHalf );
		_clearBox.max.set(   _canvasWidthHalf,   _canvasHeightHalf );

		_contextGlobalAlpha = 1;
		_contextGlobalCompositeOperation = 0;
		_contextStrokeStyle = null;
		_contextFillStyle = null;
		_contextLineWidth = null;
		_contextLineCap = null;
		_contextLineJoin = null;

		this.setViewport( 0, 0, width, height );

	};

	this.setViewport = function ( x, y, width, height ) {

		_viewportX = x * pixelRatio;
		_viewportY = y * pixelRatio;

		_viewportWidth = width * pixelRatio;
		_viewportHeight = height * pixelRatio;

	};

	this.setScissor = function () {};
	this.enableScissorTest = function () {};

	this.setClearColor = function ( color, alpha ) {

		_clearColor.set( color );
		_clearAlpha = alpha !== undefined ? alpha : 1;

		_clearBox.min.set( - _canvasWidthHalf, - _canvasHeightHalf );
		_clearBox.max.set(   _canvasWidthHalf,   _canvasHeightHalf );

	};

	this.setClearColorHex = function ( hex, alpha ) {

		console.warn( 'THREE.CanvasRenderer: .setClearColorHex() is being removed. Use .setClearColor() instead.' );
		this.setClearColor( hex, alpha );

	};

	this.getClearColor = function () {

		return _clearColor;

	};

	this.getClearAlpha = function () {

		return _clearAlpha;

	};

	this.getMaxAnisotropy = function () {

		return 0;

	};

	this.clear = function () {

		if ( _clearBox.empty() === false ) {

			_clearBox.intersect( _clipBox );
			_clearBox.expandByScalar( 2 );

			_clearBox.min.x = _clearBox.min.x + _canvasWidthHalf;
			_clearBox.min.y =  - _clearBox.min.y + _canvasHeightHalf;		// higher y value !
			_clearBox.max.x = _clearBox.max.x + _canvasWidthHalf;
			_clearBox.max.y =  - _clearBox.max.y + _canvasHeightHalf;		// lower y value !

			if ( _clearAlpha < 1 ) {

				_context.clearRect(
					_clearBox.min.x | 0,
					_clearBox.max.y | 0,
					( _clearBox.max.x - _clearBox.min.x ) | 0,
					( _clearBox.min.y - _clearBox.max.y ) | 0
				);

			}

			if ( _clearAlpha > 0 ) {

				setBlending( THREE.NormalBlending );
				setOpacity( 1 );

				setFillStyle( 'rgba(' + Math.floor( _clearColor.r * 255 ) + ',' + Math.floor( _clearColor.g * 255 ) + ',' + Math.floor( _clearColor.b * 255 ) + ',' + _clearAlpha + ')' );

				_context.fillRect(
					_clearBox.min.x | 0,
					_clearBox.max.y | 0,
					( _clearBox.max.x - _clearBox.min.x ) | 0,
					( _clearBox.min.y - _clearBox.max.y ) | 0
				);

			}

			_clearBox.makeEmpty();

		}

	};

	// compatibility

	this.clearColor = function () {};
	this.clearDepth = function () {};
	this.clearStencil = function () {};

	this.render = function ( scene, camera ) {

		if ( camera instanceof THREE.Camera === false ) {

			console.error( 'THREE.CanvasRenderer.render: camera is not an instance of THREE.Camera.' );
			return;

		}

		if ( this.autoClear === true ) this.clear();

		_this.info.render.vertices = 0;
		_this.info.render.faces = 0;

		_context.setTransform( _viewportWidth / _canvasWidth, 0, 0, - _viewportHeight / _canvasHeight, _viewportX, _canvasHeight - _viewportY );
		_context.translate( _canvasWidthHalf, _canvasHeightHalf );

		_renderData = _projector.projectScene( scene, camera, this.sortObjects, this.sortElements );
		_elements = _renderData.elements;
		_lights = _renderData.lights;
		_camera = camera;

		_normalViewMatrix.getNormalMatrix( camera.matrixWorldInverse );

		/* DEBUG
		setFillStyle( 'rgba( 0, 255, 255, 0.5 )' );
		_context.fillRect( _clipBox.min.x, _clipBox.min.y, _clipBox.max.x - _clipBox.min.x, _clipBox.max.y - _clipBox.min.y );
		*/

		calculateLights();

		for ( var e = 0, el = _elements.length; e < el; e ++ ) {

			var element = _elements[ e ];

			var material = element.material;

			if ( material === undefined || material.opacity === 0 ) continue;

			_elemBox.makeEmpty();

			if ( element instanceof THREE.RenderableSprite ) {

				_v1 = element;
				_v1.x *= _canvasWidthHalf; _v1.y *= _canvasHeightHalf;

				renderSprite( _v1, element, material );

			} else if ( element instanceof THREE.RenderableLine ) {

				_v1 = element.v1; _v2 = element.v2;

				_v1.positionScreen.x *= _canvasWidthHalf; _v1.positionScreen.y *= _canvasHeightHalf;
				_v2.positionScreen.x *= _canvasWidthHalf; _v2.positionScreen.y *= _canvasHeightHalf;

				_elemBox.setFromPoints( [
					_v1.positionScreen,
					_v2.positionScreen
				] );

				if ( _clipBox.isIntersectionBox( _elemBox ) === true ) {

					renderLine( _v1, _v2, element, material );

				}

			} else if ( element instanceof THREE.RenderableFace ) {

				_v1 = element.v1; _v2 = element.v2; _v3 = element.v3;

				if ( _v1.positionScreen.z < - 1 || _v1.positionScreen.z > 1 ) continue;
				if ( _v2.positionScreen.z < - 1 || _v2.positionScreen.z > 1 ) continue;
				if ( _v3.positionScreen.z < - 1 || _v3.positionScreen.z > 1 ) continue;

				_v1.positionScreen.x *= _canvasWidthHalf; _v1.positionScreen.y *= _canvasHeightHalf;
				_v2.positionScreen.x *= _canvasWidthHalf; _v2.positionScreen.y *= _canvasHeightHalf;
				_v3.positionScreen.x *= _canvasWidthHalf; _v3.positionScreen.y *= _canvasHeightHalf;

				if ( material.overdraw > 0 ) {

					expand( _v1.positionScreen, _v2.positionScreen, material.overdraw );
					expand( _v2.positionScreen, _v3.positionScreen, material.overdraw );
					expand( _v3.positionScreen, _v1.positionScreen, material.overdraw );

				}

				_elemBox.setFromPoints( [
					_v1.positionScreen,
					_v2.positionScreen,
					_v3.positionScreen
				] );

				if ( _clipBox.isIntersectionBox( _elemBox ) === true ) {

					renderFace3( _v1, _v2, _v3, 0, 1, 2, element, material );

				}

			}

			/* DEBUG
			setLineWidth( 1 );
			setStrokeStyle( 'rgba( 0, 255, 0, 0.5 )' );
			_context.strokeRect( _elemBox.min.x, _elemBox.min.y, _elemBox.max.x - _elemBox.min.x, _elemBox.max.y - _elemBox.min.y );
			*/

			_clearBox.union( _elemBox );

		}

		/* DEBUG
		setLineWidth( 1 );
		setStrokeStyle( 'rgba( 255, 0, 0, 0.5 )' );
		_context.strokeRect( _clearBox.min.x, _clearBox.min.y, _clearBox.max.x - _clearBox.min.x, _clearBox.max.y - _clearBox.min.y );
		*/

		_context.setTransform( 1, 0, 0, 1, 0, 0 );

	};

	//

	function calculateLights() {

		_ambientLight.setRGB( 0, 0, 0 );
		_directionalLights.setRGB( 0, 0, 0 );
		_pointLights.setRGB( 0, 0, 0 );

		for ( var l = 0, ll = _lights.length; l < ll; l ++ ) {

			var light = _lights[ l ];
			var lightColor = light.color;

			if ( light instanceof THREE.AmbientLight ) {

				_ambientLight.add( lightColor );

			} else if ( light instanceof THREE.DirectionalLight ) {

				// for sprites

				_directionalLights.add( lightColor );

			} else if ( light instanceof THREE.PointLight ) {

				// for sprites

				_pointLights.add( lightColor );

			}

		}

	}

	function calculateLight( position, normal, color ) {

		for ( var l = 0, ll = _lights.length; l < ll; l ++ ) {

			var light = _lights[ l ];

			_lightColor.copy( light.color );

			if ( light instanceof THREE.DirectionalLight ) {

				var lightPosition = _vector3.setFromMatrixPosition( light.matrixWorld ).normalize();

				var amount = normal.dot( lightPosition );

				if ( amount <= 0 ) continue;

				amount *= light.intensity;

				color.add( _lightColor.multiplyScalar( amount ) );

			} else if ( light instanceof THREE.PointLight ) {

				var lightPosition = _vector3.setFromMatrixPosition( light.matrixWorld );

				var amount = normal.dot( _vector3.subVectors( lightPosition, position ).normalize() );

				if ( amount <= 0 ) continue;

				amount *= light.distance == 0 ? 1 : 1 - Math.min( position.distanceTo( lightPosition ) / light.distance, 1 );

				if ( amount == 0 ) continue;

				amount *= light.intensity;

				color.add( _lightColor.multiplyScalar( amount ) );

			}

		}

	}

	function renderSprite( v1, element, material ) {

		setOpacity( material.opacity );
		setBlending( material.blending );

		var scaleX = element.scale.x * _canvasWidthHalf;
		var scaleY = element.scale.y * _canvasHeightHalf;

		var dist = 0.5 * Math.sqrt( scaleX * scaleX + scaleY * scaleY ); // allow for rotated sprite
		_elemBox.min.set( v1.x - dist, v1.y - dist );
		_elemBox.max.set( v1.x + dist, v1.y + dist );

		if ( material instanceof THREE.SpriteMaterial ) {

			var texture = material.map;

			if ( texture !== null ) {

				var pattern = _patterns[ texture.id ];

				if ( pattern === undefined || pattern.version !== texture.version ) {

					pattern = textureToPattern( texture );
					_patterns[ texture.id ] = pattern;

				}

				if ( pattern.canvas !== undefined ) {

					setFillStyle( pattern.canvas );

					var bitmap = texture.image;

					var ox = bitmap.width * texture.offset.x;
					var oy = bitmap.height * texture.offset.y;

					var sx = bitmap.width * texture.repeat.x;
					var sy = bitmap.height * texture.repeat.y;

					var cx = scaleX / sx;
					var cy = scaleY / sy;

					_context.save();
					_context.translate( v1.x, v1.y );
					if ( material.rotation !== 0 ) _context.rotate( material.rotation );
					_context.translate( - scaleX / 2, - scaleY / 2 );
					_context.scale( cx, cy );
					_context.translate( - ox, - oy );
					_context.fillRect( ox, oy, sx, sy );
					_context.restore();

				}

			} else {

				// no texture

				setFillStyle( material.color.getStyle() );

				_context.save();
				_context.translate( v1.x, v1.y );
				if ( material.rotation !== 0 ) _context.rotate( material.rotation );
				_context.scale( scaleX, - scaleY );
				_context.fillRect( - 0.5, - 0.5, 1, 1 );
				_context.restore();

			}

		} else if ( material instanceof THREE.SpriteCanvasMaterial ) {

			setStrokeStyle( material.color.getStyle() );
			setFillStyle( material.color.getStyle() );

			_context.save();
			_context.translate( v1.x, v1.y );
			if ( material.rotation !== 0 ) _context.rotate( material.rotation );
			_context.scale( scaleX, scaleY );

			material.program( _context );

			_context.restore();

		}

		/* DEBUG
		setStrokeStyle( 'rgb(255,255,0)' );
		_context.beginPath();
		_context.moveTo( v1.x - 10, v1.y );
		_context.lineTo( v1.x + 10, v1.y );
		_context.moveTo( v1.x, v1.y - 10 );
		_context.lineTo( v1.x, v1.y + 10 );
		_context.stroke();
		*/

	}

	function renderLine( v1, v2, element, material ) {

		setOpacity( material.opacity );
		setBlending( material.blending );

		_context.beginPath();
		_context.moveTo( v1.positionScreen.x, v1.positionScreen.y );
		_context.lineTo( v2.positionScreen.x, v2.positionScreen.y );

		if ( material instanceof THREE.LineBasicMaterial ) {

			setLineWidth( material.linewidth );
			setLineCap( material.linecap );
			setLineJoin( material.linejoin );

			if ( material.vertexColors !== THREE.VertexColors ) {

				setStrokeStyle( material.color.getStyle() );

			} else {

				var colorStyle1 = element.vertexColors[ 0 ].getStyle();
				var colorStyle2 = element.vertexColors[ 1 ].getStyle();

				if ( colorStyle1 === colorStyle2 ) {

					setStrokeStyle( colorStyle1 );

				} else {

					try {

						var grad = _context.createLinearGradient(
							v1.positionScreen.x,
							v1.positionScreen.y,
							v2.positionScreen.x,
							v2.positionScreen.y
						);
						grad.addColorStop( 0, colorStyle1 );
						grad.addColorStop( 1, colorStyle2 );

					} catch ( exception ) {

						grad = colorStyle1;

					}

					setStrokeStyle( grad );

				}

			}

			_context.stroke();
			_elemBox.expandByScalar( material.linewidth * 2 );

		} else if ( material instanceof THREE.LineDashedMaterial ) {

			setLineWidth( material.linewidth );
			setLineCap( material.linecap );
			setLineJoin( material.linejoin );
			setStrokeStyle( material.color.getStyle() );
			setLineDash( [ material.dashSize, material.gapSize ] );

			_context.stroke();

			_elemBox.expandByScalar( material.linewidth * 2 );

			setLineDash( [] );

		}

	}

	function renderFace3( v1, v2, v3, uv1, uv2, uv3, element, material ) {

		_this.info.render.vertices += 3;
		_this.info.render.faces ++;

		setOpacity( material.opacity );
		setBlending( material.blending );

		_v1x = v1.positionScreen.x; _v1y = v1.positionScreen.y;
		_v2x = v2.positionScreen.x; _v2y = v2.positionScreen.y;
		_v3x = v3.positionScreen.x; _v3y = v3.positionScreen.y;

		drawTriangle( _v1x, _v1y, _v2x, _v2y, _v3x, _v3y );

		if ( ( material instanceof THREE.MeshLambertMaterial || material instanceof THREE.MeshPhongMaterial ) && material.map === null ) {

			_diffuseColor.copy( material.color );
			_emissiveColor.copy( material.emissive );

			if ( material.vertexColors === THREE.FaceColors ) {

				_diffuseColor.multiply( element.color );

			}

			_color.copy( _ambientLight );

			_centroid.copy( v1.positionWorld ).add( v2.positionWorld ).add( v3.positionWorld ).divideScalar( 3 );

			calculateLight( _centroid, element.normalModel, _color );

			_color.multiply( _diffuseColor ).add( _emissiveColor );

			material.wireframe === true
				 ? strokePath( _color, material.wireframeLinewidth, material.wireframeLinecap, material.wireframeLinejoin )
				 : fillPath( _color );

		} else if ( material instanceof THREE.MeshBasicMaterial ||
				    material instanceof THREE.MeshLambertMaterial ||
				    material instanceof THREE.MeshPhongMaterial ) {

			if ( material.map !== null ) {

				var mapping = material.map.mapping;

				if ( mapping === THREE.UVMapping ) {

					_uvs = element.uvs;
					patternPath( _v1x, _v1y, _v2x, _v2y, _v3x, _v3y, _uvs[ uv1 ].x, _uvs[ uv1 ].y, _uvs[ uv2 ].x, _uvs[ uv2 ].y, _uvs[ uv3 ].x, _uvs[ uv3 ].y, material.map );

				}

			} else if ( material.envMap !== null ) {

				if ( material.envMap.mapping === THREE.SphericalReflectionMapping ) {

					_normal.copy( element.vertexNormalsModel[ uv1 ] ).applyMatrix3( _normalViewMatrix );
					_uv1x = 0.5 * _normal.x + 0.5;
					_uv1y = 0.5 * _normal.y + 0.5;

					_normal.copy( element.vertexNormalsModel[ uv2 ] ).applyMatrix3( _normalViewMatrix );
					_uv2x = 0.5 * _normal.x + 0.5;
					_uv2y = 0.5 * _normal.y + 0.5;

					_normal.copy( element.vertexNormalsModel[ uv3 ] ).applyMatrix3( _normalViewMatrix );
					_uv3x = 0.5 * _normal.x + 0.5;
					_uv3y = 0.5 * _normal.y + 0.5;

					patternPath( _v1x, _v1y, _v2x, _v2y, _v3x, _v3y, _uv1x, _uv1y, _uv2x, _uv2y, _uv3x, _uv3y, material.envMap );

				}

			} else {

				_color.copy( material.color );

				if ( material.vertexColors === THREE.FaceColors ) {

					_color.multiply( element.color );

				}

				material.wireframe === true
					 ? strokePath( _color, material.wireframeLinewidth, material.wireframeLinecap, material.wireframeLinejoin )
					 : fillPath( _color );

			}

		} else if ( material instanceof THREE.MeshNormalMaterial ) {

			_normal.copy( element.normalModel ).applyMatrix3( _normalViewMatrix );

			_color.setRGB( _normal.x, _normal.y, _normal.z ).multiplyScalar( 0.5 ).addScalar( 0.5 );

			material.wireframe === true
				 ? strokePath( _color, material.wireframeLinewidth, material.wireframeLinecap, material.wireframeLinejoin )
				 : fillPath( _color );

		} else {

			_color.setRGB( 1, 1, 1 );

			material.wireframe === true
				 ? strokePath( _color, material.wireframeLinewidth, material.wireframeLinecap, material.wireframeLinejoin )
				 : fillPath( _color );

		}

	}

	//

	function drawTriangle( x0, y0, x1, y1, x2, y2 ) {

		_context.beginPath();
		_context.moveTo( x0, y0 );
		_context.lineTo( x1, y1 );
		_context.lineTo( x2, y2 );
		_context.closePath();

	}

	function strokePath( color, linewidth, linecap, linejoin ) {

		setLineWidth( linewidth );
		setLineCap( linecap );
		setLineJoin( linejoin );
		setStrokeStyle( color.getStyle() );

		_context.stroke();

		_elemBox.expandByScalar( linewidth * 2 );

	}

	function fillPath( color ) {

		setFillStyle( color.getStyle() );
		_context.fill();

	}

	function textureToPattern( texture ) {

		if ( texture.version === 0 ||
			texture instanceof THREE.CompressedTexture ||
			texture instanceof THREE.DataTexture ) {

			return {
					canvas: undefined,
					version: texture.version
				}

		}

		var image = texture.image;

		var canvas = document.createElement( 'canvas' );
		canvas.width = image.width;
		canvas.height = image.height;

		var context = canvas.getContext( '2d' );
		context.setTransform( 1, 0, 0, - 1, 0, image.height );
		context.drawImage( image, 0, 0 );

		var repeatX = texture.wrapS === THREE.RepeatWrapping;
		var repeatY = texture.wrapT === THREE.RepeatWrapping;

		var repeat = 'no-repeat';

		if ( repeatX === true && repeatY === true ) {

			repeat = 'repeat';

		} else if ( repeatX === true ) {

			repeat = 'repeat-x';

		} else if ( repeatY === true ) {

			repeat = 'repeat-y';

		}

		return {
			canvas: _context.createPattern( canvas, repeat ),
			version: texture.version
		}

	}

	function patternPath( x0, y0, x1, y1, x2, y2, u0, v0, u1, v1, u2, v2, texture ) {

		var pattern = _patterns[ texture.id ];

		if ( pattern === undefined || pattern.version !== texture.version ) {

			pattern = textureToPattern( texture );
			_patterns[ texture.id ] = pattern;

		}

		if ( pattern.canvas !== undefined ) {

			setFillStyle( pattern.canvas );

		} else {

			setFillStyle( 'rgba( 0, 0, 0, 1)' );
			_context.fill();
			return;

		}

		// http://extremelysatisfactorytotalitarianism.com/blog/?p=2120

		var a, b, c, d, e, f, det, idet,
		offsetX = texture.offset.x / texture.repeat.x,
		offsetY = texture.offset.y / texture.repeat.y,
		width = texture.image.width * texture.repeat.x,
		height = texture.image.height * texture.repeat.y;

		u0 = ( u0 + offsetX ) * width;
		v0 = ( v0 + offsetY ) * height;

		u1 = ( u1 + offsetX ) * width;
		v1 = ( v1 + offsetY ) * height;

		u2 = ( u2 + offsetX ) * width;
		v2 = ( v2 + offsetY ) * height;

		x1 -= x0; y1 -= y0;
		x2 -= x0; y2 -= y0;

		u1 -= u0; v1 -= v0;
		u2 -= u0; v2 -= v0;

		det = u1 * v2 - u2 * v1;

		if ( det === 0 ) return;

		idet = 1 / det;

		a = ( v2 * x1 - v1 * x2 ) * idet;
		b = ( v2 * y1 - v1 * y2 ) * idet;
		c = ( u1 * x2 - u2 * x1 ) * idet;
		d = ( u1 * y2 - u2 * y1 ) * idet;

		e = x0 - a * u0 - c * v0;
		f = y0 - b * u0 - d * v0;

		_context.save();
		_context.transform( a, b, c, d, e, f );
		_context.fill();
		_context.restore();

	}

	function clipImage( x0, y0, x1, y1, x2, y2, u0, v0, u1, v1, u2, v2, image ) {

		// http://extremelysatisfactorytotalitarianism.com/blog/?p=2120

		var a, b, c, d, e, f, det, idet,
		width = image.width - 1,
		height = image.height - 1;

		u0 *= width; v0 *= height;
		u1 *= width; v1 *= height;
		u2 *= width; v2 *= height;

		x1 -= x0; y1 -= y0;
		x2 -= x0; y2 -= y0;

		u1 -= u0; v1 -= v0;
		u2 -= u0; v2 -= v0;

		det = u1 * v2 - u2 * v1;

		idet = 1 / det;

		a = ( v2 * x1 - v1 * x2 ) * idet;
		b = ( v2 * y1 - v1 * y2 ) * idet;
		c = ( u1 * x2 - u2 * x1 ) * idet;
		d = ( u1 * y2 - u2 * y1 ) * idet;

		e = x0 - a * u0 - c * v0;
		f = y0 - b * u0 - d * v0;

		_context.save();
		_context.transform( a, b, c, d, e, f );
		_context.clip();
		_context.drawImage( image, 0, 0 );
		_context.restore();

	}

	// Hide anti-alias gaps

	function expand( v1, v2, pixels ) {

		var x = v2.x - v1.x, y = v2.y - v1.y,
		det = x * x + y * y, idet;

		if ( det === 0 ) return;

		idet = pixels / Math.sqrt( det );

		x *= idet; y *= idet;

		v2.x += x; v2.y += y;
		v1.x -= x; v1.y -= y;

	}

	// Context cached methods.

	function setOpacity( value ) {

		if ( _contextGlobalAlpha !== value ) {

			_context.globalAlpha = value;
			_contextGlobalAlpha = value;

		}

	}

	function setBlending( value ) {

		if ( _contextGlobalCompositeOperation !== value ) {

			if ( value === THREE.NormalBlending ) {

				_context.globalCompositeOperation = 'source-over';

			} else if ( value === THREE.AdditiveBlending ) {

				_context.globalCompositeOperation = 'lighter';

			} else if ( value === THREE.SubtractiveBlending ) {

				_context.globalCompositeOperation = 'darker';

			}

			_contextGlobalCompositeOperation = value;

		}

	}

	function setLineWidth( value ) {

		if ( _contextLineWidth !== value ) {

			_context.lineWidth = value;
			_contextLineWidth = value;

		}

	}

	function setLineCap( value ) {

		// "butt", "round", "square"

		if ( _contextLineCap !== value ) {

			_context.lineCap = value;
			_contextLineCap = value;

		}

	}

	function setLineJoin( value ) {

		// "round", "bevel", "miter"

		if ( _contextLineJoin !== value ) {

			_context.lineJoin = value;
			_contextLineJoin = value;

		}

	}

	function setStrokeStyle( value ) {

		if ( _contextStrokeStyle !== value ) {

			_context.strokeStyle = value;
			_contextStrokeStyle = value;

		}

	}

	function setFillStyle( value ) {

		if ( _contextFillStyle !== value ) {

			_context.fillStyle = value;
			_contextFillStyle = value;

		}

	}

	function setLineDash( value ) {

		if ( _contextLineDash.length !== value.length ) {

			_context.setLineDash( value );
			_contextLineDash = value;

		}

	}

};
;
}
haxe_Serializer.USE_CACHE = false;
haxe_Serializer.USE_ENUM_INDEX = false;
haxe_Serializer.BASE64 = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789%:";
haxe_Unserializer.DEFAULT_RESOLVER = Type;
haxe_Unserializer.BASE64 = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789%:";
haxe_ds_ObjectMap.count = 0;
haxe_io_FPHelper.i64tmp = (function($this) {
	var $r;
	var x = new haxe__$Int64__$_$_$Int64(0,0);
	$r = x;
	return $r;
}(this));
htmlparser_CssSelector.reID = "[a-z](?:-?[_a-z0-9])*";
htmlparser_CssSelector.reNamespacedID = htmlparser_CssSelector.reID + "(?::" + htmlparser_CssSelector.reID + ")?";
htmlparser_CssSelector.reSelector = "(\\s*)((?:[>]\\s*)?)([.#]?)(" + htmlparser_CssSelector.reNamespacedID + "|[*])((?:\\[\\d+\\])?)";
htmlparser_HtmlParser.SELF_CLOSING_TAGS_HTML = { img : 1, br : 1, input : 1, meta : 1, link : 1, hr : 1, base : 1, embed : 1, spacer : 1, source : 1, param : 1};
htmlparser_HtmlParser.reID = "[a-z](?:-?[_a-z0-9])*";
htmlparser_HtmlParser.reNamespacedID = htmlparser_HtmlParser.reID + "(?::" + htmlparser_HtmlParser.reID + ")?";
htmlparser_HtmlParser.reCDATA = "[<]!\\[CDATA\\[[\\s\\S]*?\\]\\][>]";
htmlparser_HtmlParser.reScript = "[<]\\s*script\\s*([^>]*)>([\\s\\S]*?)<\\s*/\\s*script\\s*>";
htmlparser_HtmlParser.reStyle = "<\\s*style\\s*([^>]*)>([\\s\\S]*?)<\\s*/\\s*style\\s*>";
htmlparser_HtmlParser.reElementOpen = "<\\s*(" + htmlparser_HtmlParser.reNamespacedID + ")";
htmlparser_HtmlParser.reAttr = htmlparser_HtmlParser.reNamespacedID + "\\s*=\\s*(?:'[^']*'|\"[^\"]*\"|[-_a-z0-9]+)";
htmlparser_HtmlParser.reElementEnd = "(/)?\\s*>";
htmlparser_HtmlParser.reElementClose = "<\\s*/\\s*(" + htmlparser_HtmlParser.reNamespacedID + ")\\s*>";
htmlparser_HtmlParser.reComment = "<!--[\\s\\S]*?-->";
htmlparser_HtmlParser.reMain = new EReg("(" + htmlparser_HtmlParser.reCDATA + ")|(" + htmlparser_HtmlParser.reScript + ")|(" + htmlparser_HtmlParser.reStyle + ")|(" + htmlparser_HtmlParser.reElementOpen + "((?:\\s+" + htmlparser_HtmlParser.reAttr + ")*)\\s*" + htmlparser_HtmlParser.reElementEnd + ")|(" + htmlparser_HtmlParser.reElementClose + ")|(" + htmlparser_HtmlParser.reComment + ")","ig");
htmlparser_HtmlParser.reParseAttrs = new EReg("(" + htmlparser_HtmlParser.reNamespacedID + ")\\s*=\\s*('[^']*'|\"[^\"]*\"|[-_a-z0-9]+)","ig");
js_Boot.__toStr = {}.toString;
js_html_compat_Uint8Array.BYTES_PER_ELEMENT = 1;
js_three_ObjectType.Scene = "Scene";
js_three_ObjectType.PerspectiveCamera = "PerspectiveCamera";
js_three_ObjectType.OrthographicCamera = "OrthographicCamera";
js_three_ObjectType.AmbientLight = "AmbientLight";
js_three_ObjectType.DirectionalLight = "DirectionalLight";
js_three_ObjectType.PointLight = "PointLight";
js_three_ObjectType.SpotLight = "SpotLight";
js_three_ObjectType.HemisphereLight = "HemisphereLight";
js_three_ObjectType.Mesh = "Mesh";
js_three_ObjectType.LOD = "LOD";
js_three_ObjectType.Line = "Line";
js_three_ObjectType.PointCloud = "PointCloud";
js_three_ObjectType.Points = "Points";
js_three_ObjectType.Sprite = "Sprite";
js_three_ObjectType.Group = "Group";
nanofl_DisplayObjectTools.autoHitArea = false;
nanofl_Mesh.DEG_TO_RAD = Math.PI / 180;
nanofl_Mesh.forceSoftwareRenderer = false;
nanofl_Player.spriteSheets = { };
nanofl_TextField.PADDING = 2.0;
nanofl_TextField.fontHeightCache = new haxe_ds_StringMap();
nanofl_TextField.fontBaselineCoefCache = new haxe_ds_StringMap();
nanofl_TextField.editing = false;
nanofl_TextField.selectionStart = 0;
nanofl_TextField.selectionEnd = 0;
nanofl_engine_ColorTools.colors = { 'aliceblue' : "#f0f8ff", 'antiquewhite' : "#faebd7", 'aqua' : "#00ffff", 'aquamarine' : "#7fffd4", 'azure' : "#f0ffff", 'beige' : "#f5f5dc", 'bisque' : "#ffe4c4", 'black' : "#000000", 'blanchedalmond' : "#ffebcd", 'blue' : "#0000ff", 'blueviolet' : "#8a2be2", 'brown' : "#a52a2a", 'burlywood' : "#deb887", 'cadetblue' : "#5f9ea0", 'chartreuse' : "#7fff00", 'chocolate' : "#d2691e", 'coral' : "#ff7f50", 'cornflowerblue' : "#6495ed", 'cornsilk' : "#fff8dc", 'crimson' : "#dc143c", 'cyan' : "#00ffff", 'darkblue' : "#00008b", 'darkcyan' : "#008b8b", 'darkgoldenrod' : "#b8860b", 'darkgray' : "#a9a9a9", 'darkgreen' : "#006400", 'darkkhaki' : "#bdb76b", 'darkmagenta' : "#8b008b", 'darkolivegreen' : "#556b2f", 'darkorange' : "#ff8c00", 'darkorchid' : "#9932cc", 'darkred' : "#8b0000", 'darksalmon' : "#e9967a", 'darkseagreen' : "#8fbc8f", 'darkslateblue' : "#483d8b", 'darkslategray' : "#2f4f4f", 'darkturquoise' : "#00ced1", 'darkviolet' : "#9400d3", 'deeppink' : "#ff1493", 'deepskyblue' : "#00bfff", 'dimgray' : "#696969", 'dodgerblue' : "#1e90ff", 'firebrick' : "#b22222", 'floralwhite' : "#fffaf0", 'forestgreen' : "#228b22", 'fuchsia' : "#ff00ff", 'gainsboro' : "#dcdcdc", 'ghostwhite' : "#f8f8ff", 'gold' : "#ffd700", 'goldenrod' : "#daa520", 'gray' : "#808080", 'grey' : "#808080", 'green' : "#008000", 'greenyellow' : "#adff2f", 'honeydew' : "#f0fff0", 'hotpink' : "#ff69b4", 'indianred ' : "#cd5c5c", 'indigo' : "#4b0082", 'ivory' : "#fffff0", 'khaki' : "#f0e68c", 'lavender' : "#e6e6fa", 'lavenderblush' : "#fff0f5", 'lawngreen' : "#7cfc00", 'lemonchiffon' : "#fffacd", 'lightblue' : "#add8e6", 'lightcoral' : "#f08080", 'lightcyan' : "#e0ffff", 'lightgoldenrodyellow' : "#fafad2", 'lightgrey' : "#d3d3d3", 'lightgreen' : "#90ee90", 'lightpink' : "#ffb6c1", 'lightsalmon' : "#ffa07a", 'lightseagreen' : "#20b2aa", 'lightskyblue' : "#87cefa", 'lightslategray' : "#778899", 'lightsteelblue' : "#b0c4de", 'lightyellow' : "#ffffe0", 'lime' : "#00ff00", 'limegreen' : "#32cd32", 'linen' : "#faf0e6", 'magenta' : "#ff00ff", 'maroon' : "#800000", 'mediumaquamarine' : "#66cdaa", 'mediumblue' : "#0000cd", 'mediumorchid' : "#ba55d3", 'mediumpurple' : "#9370d8", 'mediumseagreen' : "#3cb371", 'mediumslateblue' : "#7b68ee", 'mediumspringgreen' : "#00fa9a", 'mediumturquoise' : "#48d1cc", 'mediumvioletred' : "#c71585", 'midnightblue' : "#191970", 'mintcream' : "#f5fffa", 'mistyrose' : "#ffe4e1", 'moccasin' : "#ffe4b5", 'navajowhite' : "#ffdead", 'navy' : "#000080", 'oldlace' : "#fdf5e6", 'olive' : "#808000", 'olivedrab' : "#6b8e23", 'orange' : "#ffa500", 'orangered' : "#ff4500", 'orchid' : "#da70d6", 'palegoldenrod' : "#eee8aa", 'palegreen' : "#98fb98", 'paleturquoise' : "#afeeee", 'palevioletred' : "#d87093", 'papayawhip' : "#ffefd5", 'peachpuff' : "#ffdab9", 'peru' : "#cd853f", 'pink' : "#ffc0cb", 'plum' : "#dda0dd", 'powderblue' : "#b0e0e6", 'purple' : "#800080", 'red' : "#ff0000", 'rosybrown' : "#bc8f8f", 'royalblue' : "#4169e1", 'saddlebrown' : "#8b4513", 'salmon' : "#fa8072", 'sandybrown' : "#f4a460", 'seagreen' : "#2e8b57", 'seashell' : "#fff5ee", 'sienna' : "#a0522d", 'silver' : "#c0c0c0", 'skyblue' : "#87ceeb", 'slateblue' : "#6a5acd", 'slategray' : "#708090", 'snow' : "#fffafa", 'springgreen' : "#00ff7f", 'steelblue' : "#4682b4", 'tan' : "#d2b48c", 'teal' : "#008080", 'thistle' : "#d8bfd8", 'tomato' : "#ff6347", 'turquoise' : "#40e0d0", 'violet' : "#ee82ee", 'wheat' : "#f5deb3", 'white' : "#ffffff", 'whitesmoke' : "#f5f5f5", 'yellow' : "#ffff00", 'yellowgreen' : "#9acd32", 'transparent' : "rgba(0,0,0,0)"};
nanofl_engine_Debug.console = new nanofl_engine_Console();
nanofl_engine_Library.SCENE_NAME_PATH = "scene";
nanofl_engine_ScaleMode.noScale = "noScale";
nanofl_engine_ScaleMode.fit = "fit";
nanofl_engine_ScaleMode.fill = "fill";
nanofl_engine_ScaleMode.stretch = "stretch";
nanofl_engine_ScaleMode.custom = "custom";
nanofl_engine_Version.ide = "4.0.3";
nanofl_engine_Version.player = "3.1.0";
nanofl_engine_Version.document = "2.2.0";
nanofl_engine_geom_BezierCurve.EPS = 1e-10;
nanofl_engine_geom_BezierCurve.GAP = 0.01;
nanofl_engine_geom_Contour.EPS = 1e-7;
nanofl_engine_geom_Edge.GAP = 0.01;
nanofl_engine_geom_Edges.GAP = 0.01;
nanofl_engine_geom_Edges.reFloat2 = new EReg("([-+0-9.]+),([-+0-9.]+)","");
nanofl_engine_geom_Edges.reFloat4 = new EReg("([-+0-9.]+),([-+0-9.]+),([-+0-9.]+),([-+0-9.]+)","");
nanofl_engine_geom_Edges.showSelection = true;
nanofl_engine_geom_Equation.EPS = 1e-10;
nanofl_engine_geom_Matrix.DEG_TO_RAD = Math.PI / 180;
nanofl_engine_geom_Polygon.showSelection = true;
nanofl_engine_geom_StraightLine.EPS = 1e-10;
nanofl_engine_libraryitems_MeshItem.DEFAULT_RENDER_AREA_SIZE = 256;
nanofl_engine_plugins_FilterPlugins.plugins = new haxe_ds_StringMap();
tjson_TJSON.OBJECT_REFERENCE_PREFIX = "@~obRef#";
})(typeof console != "undefined" ? console : {log:function(){}}, typeof window != "undefined" ? window : exports);
