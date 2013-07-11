package sacrifice.managers
{
	import flash.utils.Dictionary;
	
	import org.flixel.plugin.photonstorm.FlxWeapon;

	public class WeaponManager
	{
		//----------------------------------------------------------------------
		//
		//  Class constants
		//
		//----------------------------------------------------------------------
		
		[Embed("../assets/data/weapons.xml", mimeType="application/octet-stream")]
		private static const weaponsClass:Class;
		
		//----------------------------------------------------------------------
		//
		//  Class variables
		//
		//----------------------------------------------------------------------
		
		private static var weapons:Dictionary = new Dictionary();
		
		//----------------------------------------------------------------------
		//
		//  Class methods
		//
		//----------------------------------------------------------------------
		
		public static function init():void
		{
			var weaponsXML:XML = new XML(new weaponsClass);
			var weapon:XML;
			
			for each (weapon in weaponsXML.weapon) {
				weapons[String(weapon.@name)] = weapon;
			}
		}
		
		public static function createWeapon(name:String, weaponClass:Class = null):FlxWeapon
		{
			if (!name) {
				throw new Error("Weapon name is required");
			}
			
			var weapon:XML = weapons[name];
			if (!weapon) {
				throw new Error("Unknown weapon '" + name + "'");
			}
			
			if (!weaponClass) {
				weaponClass = FlxWeapon;
			}
			
			var object:FlxWeapon = FlxWeapon(new weaponClass(name));
			
			object.bulletDamage = Math.min(1, weapon.characteristics.damage);
			object.setFireRate(weapon.characteristics.fireRate);
			object.setBulletSpeed(weapon.characteristics.bulletSpeed);
			
			var width:uint = uint(weapon.bullet.width);
			var height:uint = uint(weapon.bullet.height);
			var offsetX:uint = uint(weapon.bullet.x);
			var offsetY:uint = uint(weapon.bullet.y);
			
			if ("pixel" == weapon.bullet.@type) {
				if (!width) {
					width = 2;
				}
				
				if (!height) {
					height = 2;
				}
				
				var color:uint;
				if (weapon.bullet.color.length()) {
					color = uint(weapon.bullet.color);
				} else {
					color = 0xffffffff;
				}
				
				object.makePixelBullet(20, width, height, color, offsetX, offsetY);
			} else if ("bitmap" == weapon.bullet.@type) {
				object.makeAnimatedBullet(20, AssetManager.getClass(weapon.bullet.asset), width, height, [0, 1], 20, true, offsetX, offsetY);
			}
			
			return object;
		}
	}
}