/***********************************************************************/
/** 	© 2015 CD PROJEKT S.A. All rights reserved.
/** 	THE WITCHER® is a trademark of CD PROJEKT S. A.
/** 	The Witcher game is based on the prose of Andrzej Sapkowski.
/***********************************************************************/


//Grindstone and Workbench Charges 
class W3RepairObjectEnhancement extends CBaseGameplayEffect
{
	private saved var currCount : int;			
	private saved var maxCount : int;	
	
	default isPositive = true;
	
	public function OnTimeUpdated(dt : float){}
	
	event OnEffectAdded(customParams : W3BuffCustomParams)
	{
		var enhancementParams : W3EnhancementBuffParams;		
		
		enhancementParams = (W3EnhancementBuffParams)customParams;
		if(enhancementParams)
		{
			currCount = enhancementParams.currCount;
			maxCount = enhancementParams.maxCount;
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
}

class W3EnhancementBuffParams extends W3BuffCustomParams
{
	var currCount : int;
	var maxCount : int;
}
//Grindstone and Workbench Charges End