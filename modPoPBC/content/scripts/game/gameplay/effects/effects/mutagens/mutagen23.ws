/***********************************************************************/
/** 	© 2015 CD PROJEKT S.A. All rights reserved.
/** 	THE WITCHER® is a trademark of CD PROJEKT S. A.
/** 	The Witcher game is based on the prose of Andrzej Sapkowski.
/***********************************************************************/




class W3Mutagen23_Effect extends W3Mutagen_Effect
{
	default effectType = EET_Mutagen23;
	default dontAddAbilityOnTarget = true;
	
	event OnUpdate(dt : float)
	{
		var currentHour, currentMinutes, i : int;
		var gameTime : GameTime;
		var params : SCustomEffectParams;
		var shrineBuffs : array<EEffectType>;
		var addBuff : bool;
		var shrineParams : W3ShrineEffectParams;
		
		super.OnUpdate(dt);
		
		if(effectManager.HasAnyMutagen23ShrineBuff())
			return true;
		
		
		if( target == GetWitcherPlayer() && GetWitcherPlayer().CanUseSkill( S_Perk_14 ) && effectManager.HasAnyShrineBuff() )
		{
			return true;
		}
		
		gameTime = theGame.GetGameTime();
		currentHour = GameTimeHours(gameTime);
		currentMinutes = GameTimeMinutes(gameTime);	

		if( (currentHour == GetHourForDayPart(EDP_Dawn) && currentMinutes < 15) || ( (currentHour == (GetHourForDayPart(EDP_Dawn) - 1)) && currentMinutes > 45) )
		{
			addBuff = true;
		}
		else
		{
			if( (currentHour == GetHourForDayPart(EDP_Dusk) && currentMinutes < 15) || ( ( currentHour == (GetHourForDayPart(EDP_Dusk) - 1)) && currentMinutes > 45) )
				addBuff = true;
			else
				addBuff = false;
		}
		
		//Place of Power Buff Charges
		if(addBuff)
		{			
			shrineBuffs = GetMinorShrineBuffs();
			
			
			for(i=shrineBuffs.Size()-1; i>=0; i-=1)
			{
				if(target.HasBuff(shrineBuffs[i]))
					shrineBuffs.Erase(i);
			}
			
			
			if(shrineBuffs.Size() == 0)
				shrineBuffs = GetMinorShrineBuffs();
			
			shrineParams = new W3ShrineEffectParams in theGame;		
			
			params.effectType = shrineBuffs[ RandRange(shrineBuffs.Size()) ];
			params.sourceName = 'Mutagen23';
			
			switch(params.effectType)
			{
				case EET_ShrineAard:
					shrineParams.maxCount = 2 * StringToInt(theGame.GetInGameConfigWrapper().GetVarValue('popbc', 'popbc_Aard'));
					break;
					
				case EET_ShrineYrden:
					shrineParams.maxCount = 2 * StringToInt(theGame.GetInGameConfigWrapper().GetVarValue('popbc', 'popbc_Yrden'));
					break;					
			
				case EET_ShrineIgni:
					shrineParams.maxCount = 2 * StringToInt(theGame.GetInGameConfigWrapper().GetVarValue('popbc', 'popbc_Igni'));
					break;					
			
				case EET_ShrineQuen:
					shrineParams.maxCount = 2 * StringToInt(theGame.GetInGameConfigWrapper().GetVarValue('popbc', 'popbc_Quen'));
					break;
					
				case EET_ShrineAxii:
					shrineParams.maxCount = 2 * StringToInt(theGame.GetInGameConfigWrapper().GetVarValue('popbc', 'popbc_Axii'));
					break;					
			}
			
			if (shrineParams.maxCount == 0)
			{
				shrineParams.maxCount = 30;
			}			
			shrineParams.currCount = shrineParams.maxCount;
			shrineParams.isFromMutagen23 = true;
			params.buffSpecificParams = shrineParams;
			
			target.AddEffectCustom(params);
			
			delete shrineParams;
		}
		//Place of Power Buff Charges End
	}
}
