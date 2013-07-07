package org.flixel.plugin.sacrifice
{
	import org.flixel.plugin.photonstorm.FlxWeapon;
	
	public class FlxExtendedWeapon extends FlxWeapon
	{
		//----------------------------------------------------------------------
		//
		//  Constructor
		//
		//----------------------------------------------------------------------
		
		public function FlxExtendedWeapon(name:String, parentRef:* = null, xVariable:String = "x", yVariable:String = "y")
		{
			super(name, parentRef, xVariable, yVariable);
		}
		
		//----------------------------------------------------------------------
		//
		//  Properties
		//
		//----------------------------------------------------------------------
		
		public var bulletDamage:uint = 1;
	}
}