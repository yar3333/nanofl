package components.nanofl.popups.fontimportpopup;

import js.html.TextDecoder;
import htmlparser.HtmlDocument;
import nanofl.engine.FontVariant;
import nanofl.ide.Application;
import nanofl.ide.sys.HttpUtils;
import nanofl.ide.ui.View;
using stdlib.StringTools;

@:rtti
class Code extends components.nanofl.popups.basepopup.Code
{
	@inject var app : Application;
	@inject var httpUtils : HttpUtils;
	@inject var view : View;

    override function init()
    {
        super.init();
        template().text.attr("placeholder", template().text.attr("placeholder").replace("\\n", "\n"));
    }
	
	public function show()
	{
		showPopup();
	}
	
	override function ok_click(_)
	{
		template().ok.addClass('disabled');
		
		var doc : HtmlDocument = null;
		try
		{
			doc = new HtmlDocument(template().text.val());
		}
		catch (e:Dynamic)
		{
			js.Browser.alert("Can't parse links.");
			template().ok.removeClass('disabled');
			return;
		}
		
		var userAgents =
		[
			//"", // truetype
			//"IE9", // eot
			"Firefox/30", // woff
			"Firefox/40", // woff2
			//"Mozilla/4.0 (iPad; CPU OS 4_0_1 like Mac OS X) AppleWebKit/534.46 (KHTML, like Gecko) Version/4.1 Mobile/9A405 Safari/7534.48.3", // svg
		];
		
		app.document.undoQueue.beginTransaction({ libraryAddItems:true });
		
		var links = doc.find(">link").filter(x -> x.getAttribute("rel") == "stylesheet");
		var loadCount = links.length * userAgents.length;
		for (link in links)
		{
			var url = link.getAttribute("href");
			if (url != null && url != "")
			{
				for (userAgent in userAgents)
				{
					httpUtils.requestGet(url, [ { name:"User-Agent", value:userAgent } ]).then((r:HttpRequestResult) ->
					{
						parseGoogleFontCss(new TextDecoder("utf-8").decode(r.arrayBuffer));
						loadCount--;
						if (loadCount == 0) done();
					});
				}
			}
			else
			{
				loadCount -= userAgents.length;
				if (loadCount == 0) done();
			}
		}
	}
	
	function done()
	{
		app.document.undoQueue.commitTransaction();
		
		app.document.library.preload().then((_) ->
		{
			template().ok.removeClass('disabled');
			app.document.library.update();
			hide();
		});
	}
	
	function parseGoogleFontCss(css:String)
	{
		if (css == null) return;
		
		var re = ~/@font-face\s*{([^}]+)}/;
		while (re.match(css))
		{
			var lines = re.matched(1).split(";");
			
			var family : String = null;
			var variant = new FontVariant(null, null);
			var format : String = "eot";
			var url : String = null;
			
			
			for (line in lines)
			{
				var nameAndValue = line.split(":");
				if (nameAndValue.length >= 2)
				{
					var name = nameAndValue[0].trim();
					var value = nameAndValue.slice(1).join(":").trim();
					switch (name)
					{
						case "font-family": family = value.trim("'\"");
						case "font-style": variant.style = value;
						case "font-weight": variant.weight = Std.parseInt(value);
						case "src":
							for (v in value.split(","))
							{
								v = v.trim();
								
								if (v.startsWith("local"))
								{
									variant.locals.push(v.substr("local".length).trim("('\")"));
								}
								else
								if (v.startsWith("url") || v.startsWith("format"))
								{
									var reUrl = ~/\burl\s*[(]([^)]+)[)]/;
									if (reUrl.match(v))
									{
										url = reUrl.matched(1).trim("'\"");
									}
									
									var reFormat = ~/\bformat\s*[(]([^)]+)[)]/;
									if (reFormat.match(v))
									{
										format = reFormat.matched(1).trim("'\"");
									}
								}
							}
					}
				}
			}
			
			if (family != null && family != "" && format != "" && url != null && url != "")
			{
				variant.urls.set(format, url);
				app.document.library.addFont(family, [variant]);
			}
			
			css = re.matchedRight();
		}
		
		app.document.library.update();
		view.properties.update();
	}
}