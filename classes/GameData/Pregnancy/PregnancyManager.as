package classes.GameData.Pregnancy 
{
	import classes.Characters.PlayerCharacter;
	import classes.Creature;
	/**
	 * ...
	 * @author Gedan
	 */
	public class PregnancyManager 
	{
		{
			_pregHandlers = new Array();
		}
		
		// Would use a vector, but vectors can't store derived types. WORST VECTOR CLASS EVER.
		private static var _pregHandlers:Array;
		
		// System data functions
		public static function insertNewHandler(pHandler:BasePregnancyHandler):void
		{
			_pregHandlers[pHandler.handlesType] = pHandler;
		}
		
		public static function findHandler(pType:String):BasePregnancyHandler
		{
			if (_pregHandlers[pType] != undefined) return _pregHandlers[pType];
			return null;
		}
		
		// Usage functions
		public static function updatePregnancyStages(creatures:Array, tMinutes:int):void
		{
			for (var i:int = 0; i < creatures.length; i++)
			{
				updateStageForCreature(creatures[i], tMinutes);
			}
		}
		
		private static function updateStageForCreature(tarCreature:Creature, tMinutes:int):void
		{
			if (tarCreature.isPregnant())
			{
				for (var i:int = 0; i < tarCreature.pregnancyData.length; i++)
				{
					if (_pregHandlers[tarCreature.pregnancyData[i].pregnancyType] != null)
					{
						_pregHandlers[tarCreature.pregnancyData[i].pregnancyType].updatePregnancyStage(tarCreature, tMinutes, i);
					}
				}
			}
		}
		
		public static function tryKnockUp(father:Creature, mother:Creature, pregSlot:int):Boolean
		{
			// Split off to a special handler for pregnancy mechanics when the player ISN'T involved... to come. (dohoh)
			if (!father is PlayerCharacter && !mother is PlayerCharacter) return tryKnockUpNPCs(father, mother, pregSlot);
			
			// Determine which of the Creatures involved declares the pregHandler we need to use
			var npc:Creature = (father is PlayerCharacter) ? mother : father;
			
			// Grab the pregtype from the NPC and find the handler we need to process it
			var pHandler:BasePregnancyHandler = PregnancyManager.findHandler(npc.impregnationType);
			
			if (pHandler != null) 
			{
				return pHandler.tryKnockUp(father, mother, pregSlot);
			}
			else
			{
				return false;
			}
		}
		
		public static function tryKnockUpNPCs(father:Creature, mother:Creature, pregSlot:int):Boolean
		{
			throw new Error("Not implemented yet.");
		}
	}

}