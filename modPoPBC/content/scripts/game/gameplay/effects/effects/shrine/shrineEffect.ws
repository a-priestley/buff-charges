/***********************************************************************/
/** 	© 2015 CD PROJEKT S.A. All rights reserved.
/** 	THE WITCHER® is a trademark of CD PROJEKT S. A.
/** 	The Witcher game is based on the prose of Andrzej Sapkowski.
/***********************************************************************/


//Place of Power Buff Charges
class W3Effect_Shrine extends CBaseGameplayEffect
{
	private saved var isFromMutagen23 : bool;
	private saved var currCount : int;			
	private saved var maxCount : int;
	
	default isPositive = true;
		
	event OnEffectAdded(customParams : W3BuffCustomParams)
	{
		var shrineParams : W3ShrineEffectParams;
		
		shrineParams = (W3ShrineEffectParams)customParams;
		if(shrineParams)
		{			
			isFromMutagen23 = shrineParams.isFromMutagen23;
			currCount = shrineParams.currCount;
			maxCount = shrineParams.maxCount;
		}	
		
		super.OnEffectAdded(customParams);
	}
	
	protected function Show( visible : bool )
	{	
		if( visible )
		{
		}
		else
		{
			GetWitcherPlayer().RemoveBuff( this.effectType );
		}	
	}
	
	public final function Reapply( newMax : int )
	{
		maxCount = newMax;
		currCount = newMax;		
	}
		
	public final function ReduceAmmo()
		{
		if( currCount == 1 )
			{
			Show( false );
			}
			
		currCount = Max( 0, currCount - 1 );
		}
	
	public final function GetAmmoMaxCount() : int
		{
		return maxCount;
		}
		
	public final function GetAmmoCurrentCount() : int
	{
		return currCount;
	}
	
	public final function IsFromMutagen23() : bool		{return isFromMutagen23;}
}

class W3ShrineEffectParams extends W3BuffCustomParams
{
	var isFromMutagen23 : bool;
	var currCount : int;
	var maxCount : int;
}
//Place of Power Buff Charges End
