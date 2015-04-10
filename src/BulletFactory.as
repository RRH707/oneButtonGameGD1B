package  
{
	/**
	 * ...
	 * @author Rishaad Hausil
	 */
	public class BulletFactory 
	{	
		public function createBullet(dir:int):Bullet
		{	//creates new bullets and returns them.
			var newBullet:Bullet = new Bullet(dir);
			return newBullet;
		}
	}

}