package
{
	import com.danielfreeman.madcomponents.UI;
	import com.danielfreeman.madcomponents.UIButton;
	import com.danielfreeman.madcomponents.UINavigation;

	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;

	import ru.kavolorn.ane.Notifications;
	import ru.kavolorn.ane.NotificationsEvent;

	public class Notifications_Demo extends Sprite
	{
		protected static const REQUEST_VIEW:XML = <vertical alignH="centre" alignV="centre" width="100">
			<label alignH="centre">Request message from server:</label>
			<button id="request" alignH="fill">Request</button>
		</vertical>;

		protected static const NAVIGATOR:XML = <navigation id="navigation" title="RequestView" leftArrow="">
	      {REQUEST_VIEW}
		</navigation>;

		protected var _navigation:UINavigation;
		protected var _token:String;

		public function Notifications_Demo()
		{
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;

			Notifications.setDebug(true);
			Notifications.getInstance().initialize('975118869517', 'eyJsaWNlbnNlIjoie1widGltZXN0YW1wXCI6MTQyMzExMjY3NyxcImlkc1wiOltcInJ1Lmthdm9sb3JuLmFuZS5Ob3RpZmljYXRpb25zLkRlbW9cIixcImFpci5ydS5rYXZvbG9ybi5hbmUuTm90aWZpY2F0aW9ucy5EZW1vXCIsXCJydS5rYXZvbG9ybi5hbmUuTm90aWZpY2F0aW9ucy5EZW1vLmRlYnVnXCIsXCJhaXIucnUua2F2b2xvcm4uYW5lLk5vdGlmaWNhdGlvbnMuRGVtby5kZWJ1Z1wiXX0iLCJzaWduYXR1cmUiOiJyaGM2QU9kSlhESnlqVXFsaFd2XC9DdVMraHU5U2VCK3BER1V1SlwvVnNYbldHWkRzanNTWnJHc3dTaFRTOWhpQndLNXhadVVBUVc0NFVndElobFRDTFM0ZGNCMWk4MklSalwvM0RldXYydFNWd1wvTGZVbmxISDAwZnFROEpqSTlUQXdBS1VHUFQ4SDFEanJXUmZWR3RZMlNEZ2x4b2NEYkY0VkdWYzg3TVpJSWlOQmtiUUVZKzl4cHdnZ2hTWTJZWU9BcUNkMjJ0cUhodnJWTnIrT0lKRWxFMGE3dENIRGlnVXlYSys3RmVLZGNja3lGeHZ2OWRiR3VyaVZOREdSWEZYNUdSM2d3QWtBNit6XC9PWjZRR1dFR1hsWUFPZ0VmYTI0ZExuWDA5MU1yN2MyaVZaS3VHVHpHVmZxT3Bzek05VVNVakpxSXBcL1BmbkQ3T3RiaVRWR3pDbGc9PSJ9');
			Notifications.getInstance().addEventListener(NotificationsEvent.INITIALIZATION_ERROR, initializationErrorHandler);
			Notifications.getInstance().addEventListener(NotificationsEvent.INITIALIZATION_SUCCESS, initializationSuccessHandler);
			Notifications.getInstance().addEventListener(NotificationsEvent.REGISTRATION_ERROR, registrationErrorHandler);
			Notifications.getInstance().addEventListener(NotificationsEvent.REGISTRATION_ID_RECEIVED, registrationIdReceivedHandler);
		}

		private function initializationErrorHandler(event:NotificationsEvent):void
		{
			trace('initializationErrorHandler', event.message);
		}

		private function initializationSuccessHandler(event:NotificationsEvent):void
		{
			trace('initializationSuccessHandler', event.message);
		}

		private function registrationErrorHandler(event:NotificationsEvent):void
		{
			trace('registrationErrorHandler', event.message);
		}

		private function registrationIdReceivedHandler(event:NotificationsEvent):void
		{
			trace('registrationIdReceivedHandler', event.message);
			
			_token = event.message;

			UI.create(this, NAVIGATOR);

			_navigation = UINavigation(UI.findViewById("navigation"));

			var request:UIButton = UIButton(UI.findViewById("request"));
			request.addEventListener(UIButton.CLICKED, requestClickedHandler);
		}

		protected function requestClickedHandler(event:Event):void
		{
			var request:URLRequest = new URLRequest('http://kavolorn.ru/pro-native-extensions/notifications/reply-message?token=' + _token);
			var loader:URLLoader = new URLLoader();
			loader.load(request);
		}
	}
}
