//vscript from Mavis STEAM_0:0:7203955

breakable_boss <- Entities.FindByName(null, "bosss_hp")
boss_hp_text <- Entities.FindByName(null, "yingwu") 
tick1 <- false;
tick2 <- false;
tick3 <- false;

function UpdateHealth()
{
	if (tick1)
	{
		return;
	}
	tick1 = true;
	boss_hp_text.__KeyValueFromString("message", "SMALL SANTA HP: " + breakable_boss.GetHealth())
	EntFire("yingwu", "Display", "", 0.05, null);
	EntFire("boss_hp_script","RunScriptCode"," tick1=false; ",0.2,null);
}

function UpdateDeath()
{
	tick1 = true;
	boss_hp_text.__KeyValueFromString("message", "SMALL SANTA HAS BEEN SLAIN")
	EntFire("yingwu", "Display", "", 0.05, null);
}

breakable_boss2 <- Entities.FindByName(null, "bosss_hp1")
boss_hp_text2<- Entities.FindByName(null, "yingwu") 

function UpdateHealth2()
{
	if (tick2)
	{
		return;
	}
	boss_hp_text2.__KeyValueFromString("message", "BIG SANTA HP: " + breakable_boss2.GetHealth())
	EntFire("yingwu", "Display", "", 0.05, null);
	EntFire("boss_hp_script","RunScriptCode"," tick2=false; ",0.2,null);	
}

function UpdateDeath2()
{
	tick2 = true;
	boss_hp_text2.__KeyValueFromString("message", "BIG SANTA HAS BEEN SLAIN")
	EntFire("yingwu", "Display", "", 0.05, null);
}

breakable_boss3 <- Entities.FindByName(null, "bosss_hp2")
boss_hp_text3<- Entities.FindByName(null, "yingwu") 

function UpdateHealth3()
{
	if (tick3)
	{
		return;
	}
	boss_hp_text3.__KeyValueFromString("message", "SOCRATES HP: " + breakable_boss3.GetHealth())
	EntFire("yingwu", "Display", "", 0.05, null);
	EntFire("boss_hp_script","RunScriptCode"," tick3=false; ",0.2,null);
}

function UpdateDeath3()
{
	tick3 = true;
	boss_hp_text3.__KeyValueFromString("message", "SOCRATES HAS BEEN SLAIN")
	EntFire("yingwu", "Display", "", 0.05, null);
}
