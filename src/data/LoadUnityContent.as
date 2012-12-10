package data
{
	import com.unity.IUnityContentHost;
	import com.unity.UnityContentLoader;
	import com.unity.UnityLoaderParams;
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	import mx.core.UIComponent;
	
	public class LoadUnityContent extends Sprite implements IUnityContentHost
	{
		public static const UNITY_INIT				: String = "Unity.Init";
		public static const UNITY_LOAD_COMPLETE		: String = "Unity.Load.Complete";
		
		public var unityObj							: Object;
		private var _unityContentLoader				: UnityContentLoader;
		
		public function LoadUnityContent()
		{
			this.alpha = .5;
		}
		
		/**
		 * 
		 * Initial method that starts the
		 * load of the Unity content.
		 * 
		 * @param $url : String
		 */		
		public function startLoad($url:String) : void
		{
			var params : UnityLoaderParams = new UnityLoaderParams(false, 720, 400, false);
			_unityContentLoader = new UnityContentLoader($url, this, params, true);
			_unityContentLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, _onUnityContentLoaderComplete);
			_unityContentLoader.loadUnity();
		}
		
		private function _onUnityContentLoaderComplete($e:Event) : void
		{
			dispatchEvent(new Event(LoadUnityContent.UNITY_LOAD_COMPLETE));
		}
		
		/**
		 * 
		 * IUnityContentHost - Handlers
		 *
		 */
		
		// unityInitStart has to be implemented by whatever implements IUnityContentHost
		public function unityInitStart() : void
		{
			// This is called when the content is loaded and the initialization of the unity engine is started.	
		}
		
		// unityInitComplete has to be implemented by whatever implements IUnityContentHost
		public function unityInitComplete() : void
		{
			// This is called when the unity engine is done initializing and the first level is loaded.
			// from this point on, you can use sendMessage to send over messages...in this case we send this instance, which is
			// used by the send to flash script to send over variables, use an anonymouse object.
			dispatchEvent(new Event(LoadUnityContent.UNITY_INIT));
		}
		
		/**
		 * 
		 * Getter
		 * @return UnityContentLoader
		 * 
		 */		
		public function get unityContentLoader() : UnityContentLoader
		{
			return _unityContentLoader;
		}
		
		/**
		 * 
		 * Setter 
		 * @param $value : UnityContentLoader
		 * 
		 */		
		public function set unityContentLoader($value:UnityContentLoader) : void
		{
			_unityContentLoader = $value;
		}
	}
}