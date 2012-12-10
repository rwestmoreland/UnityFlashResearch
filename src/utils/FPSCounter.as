package utils  
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.utils.getTimer;
	
	public class FPSCounter extends Sprite
	{
		private var last:uint = getTimer();
		private var ticks:uint = 0;
		private var tf:TextField;
		
		public function FPSCounter(xPos:int = 0, yPos:int = 0, color:uint = 0x000000,
		fillBackground:Boolean = false, backgroundColor:uint = 0x000000) 
		{
			x = xPos;
			y = yPos;
			
			tf = new TextField();
			var format:TextFormat = new TextFormat();
			format.font = 'Arial';
			format.size = 14;
			
			tf.defaultTextFormat = format;
			tf.textColor = color;
			tf.text = '----- fps';
			tf.selectable = false;
			tf.background = fillBackground;
			tf.backgroundColor = backgroundColor;
			tf.autoSize = TextFieldAutoSize.LEFT;
			
			addChild(tf);
			width = tf.textWidth;
			height = tf.textHeight;
			
			addEventListener(Event.ENTER_FRAME, tick);
		}
		
		public function tick(e:Event):void
		{
			ticks++;
			var now:int = getTimer();
			var delta:int = now - last;
			if (delta >= 1000)
			{
				// Might add trace to output window here...
				var fps:int = (ticks / delta * 1000);
				tf.text = "Frame rate: " + fps;
				ticks = 0;
				last = now;
			}
		}
	}
	
}