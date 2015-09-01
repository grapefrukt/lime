package lime.net.curl;


import lime.net.curl.CURL;

#if !macro
@:build(lime.system.CFFI.build())
#end


class CURLEasy {
	
	
	public static function cleanup (handle:CURL):Void {
		
		#if ((cpp || neko || nodejs) && lime_curl)
		lime_curl_easy_cleanup (handle);
		#end
		
	}
	
	
	public static function duphandle (handle:CURL):CURL {
		
		#if ((cpp || neko || nodejs) && lime_curl)
		return lime_curl_easy_duphandle (handle);
		#else
		return 0;
		#end
		
	}
	
	
	public static function escape (handle:CURL, url:String, length:Int):String {
		
		#if ((cpp || neko || nodejs) && lime_curl)
		return lime_curl_easy_escape (handle, url, length);
		#else
		return null;
		#end
		
	}
	
	
	public static function getinfo (handle:CURL, info:CURLInfo):Dynamic {
		
		#if ((cpp || neko || nodejs) && lime_curl)
		return lime_curl_easy_getinfo (handle, cast (info, Int));
		#else
		return null;
		#end
		
	}
	
	
	public static function init ():CURL {
		
		#if ((cpp || neko || nodejs) && lime_curl)
		return lime_curl_easy_init ();
		#else
		return 0;
		#end
		
	}
	
	
	public static function pause (handle:CURL, bitMask:Int):CURLCode {
		
		#if ((cpp || neko || nodejs) && lime_curl)
		return cast lime_curl_easy_pause (handle, bitMask);
		#else
		return cast 0;
		#end
		
	}
	
	
	public static function perform (handle:CURL):CURLCode {
		
		#if ((cpp || neko || nodejs) && lime_curl)
		return cast lime_curl_easy_perform (handle);
		#else
		return cast 0;
		#end
		
	}
	
	
	/*public static function recv (handle:Dynamic):CURLCode {
		
		#if ((cpp || neko || nodejs) && lime_curl)
		return cast lime_curl_easy_perform (handle);
		#else
		return cast 0;
		#end
		
	}*/
	
	
	public static function reset (handle:CURL):CURLCode {
		
		#if ((cpp || neko || nodejs) && lime_curl)
		return cast lime_curl_easy_reset (handle);
		#else
		return cast 0;
		#end
		
	}
	
	
	/*public static function send (handle:Dynamic):CURLCode {
		
		#if ((cpp || neko || nodejs) && lime_curl)
		return cast lime_curl_easy_perform (handle);
		#else
		return cast 0;
		#end
		
	}*/
	
	
	public static function setopt (handle:CURL, option:CURLOption, parameter:Dynamic):CURLCode {
		
		#if ((cpp || neko || nodejs) && lime_curl)
		return cast lime_curl_easy_setopt (handle, cast (option, Int), parameter);
		#else
		return cast 0;
		#end
		
	}
	
	
	public static function strerror (code:CURLCode):String {
		
		#if ((cpp || neko || nodejs) && lime_curl)
		return lime_curl_easy_strerror (cast (code, Int));
		#else
		return null;
		#end
		
	}
	
	
	public static function unescape (handle:CURL, url:String, inLength:Int, outLength:Int):String {
		
		#if ((cpp || neko || nodejs) && lime_curl)
		return lime_curl_easy_unescape (handle, url, inLength, outLength);
		#else
		return null;
		#end
		
	}
	
	
	#if ((cpp || neko || nodejs) && lime_curl)
	@:cffi private static function lime_curl_easy_cleanup (handle:Float):Void;
	@:cffi private static function lime_curl_easy_duphandle (handle:Float):Float;
	@:cffi private static function lime_curl_easy_escape (curl:Float, url:String, length:Int):String;
	@:cffi private static function lime_curl_easy_getinfo (curl:Float, info:Int):Dynamic;
	@:cffi private static function lime_curl_easy_init ():Float;
	@:cffi private static function lime_curl_easy_pause (handle:Float, bitmask:Int):Int;
	@:cffi private static function lime_curl_easy_perform (easy_handle:Float):Int;
	@:cffi private static function lime_curl_easy_recv (curl:Float, buffer:Dynamic, buflen:Int, n:Int):Int;
	@:cffi private static function lime_curl_easy_reset (curl:Float):Void;
	@:cffi private static function lime_curl_easy_send (curl:Float, buffer:Dynamic, buflen:Int, n:Int):Int;
	@:cffi private static function lime_curl_easy_setopt (handle:Float, option:Int, parameter:Dynamic):Int;
	@:cffi private static function lime_curl_easy_strerror (errornum:Int):String;
	@:cffi private static function lime_curl_easy_unescape (curl:Float, url:String, inlength:Int, outlength:Int):String;
	#end
	
	
}