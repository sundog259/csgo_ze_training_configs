BOSS <- 1;
BossText <- null;
BossOrigin <- "";
BossRadiusDetect <- 0;
ticking <- true;
once <- true;
TotalZombies <- 0;
Zombies <- 0;
TotalHumans <- 0;
Humans <- 0;
CountMaxP <- true;
BossTime <- 0.00;
end <- true;
Timer <- 62;

function Start()
{
    SetBossOrigin()
    EntFireByHandle(self, "RunScriptCode", " StartBoss() ", 0.50, null, null);
    EntFireByHandle(self, "RunScriptCode", " CountMaxP=false ", 1.00, null, null);
    EntFireByHandle(self, "RunScriptCode", " StartBoss() ", 1.05, null, null);
    EntFireByHandle(self, "RunScriptCode", " ShowText() ", 1.50, null, null);
    EntFireByHandle(self, "RunScriptCode", " CheckerPlayers() ", 2.00, null, null);
    EntFireByHandle(self, "RunScriptCode", " ticking=false ", (BossTime-1), null, null);
    EntFireByHandle(self, "RunScriptCode", " Win() ", BossTime, null, null);
    if(once)
    {
        BossText = Entities.CreateByClassname("game_text");
        EntFireByHandle(BossText, "AddOutput", "targetname Boss_count", 0.00, null, null);
        EntFireByHandle(BossText, "AddOutput", "spawnflags 1", 0.00, null, null);
        EntFireByHandle(BossText, "AddOutput", "x -1", 0.00, null, null);
        EntFireByHandle(BossText, "AddOutput", "y .05", 0.00, null, null);
        EntFire("Boss_count","AddOutput","channel 4",0.00,null);
        EntFire("Boss_count","AddOutput","holdtime 1",0.00,null);
        EntFire("Boss_count","AddOutput","color 219 112 147",0.00,null);
        EntFire("Boss_count","AddOutput","color2 255 0 255",0.00,null);
        once = false;
    }
}

function SetBossOrigin()
{
    if(BOSS == 1)
    {
        BossOrigin = Vector(-11690,-4896,-1604);
        BossRadiusDetect = 600;
        BossTime = 25.00;
    }
    else if(BOSS == 2)
    {
        BossOrigin = Vector(-3202,5536,722);
        BossRadiusDetect = 2500;
        BossTime = 68.00;
    }
    else if(BOSS == 3)
    {
        BossOrigin = Vector(3584,-4744,-3076);
        BossRadiusDetect = 300;
        BossTime = 62.00;
        EntFireByHandle(self, "RunScriptCode", " SpawnMCode() ", 3.00, null, null);
    }
}

function StartBoss()
{
    if(ticking)
    {
        local b = null;
        Humans = 0;
        Zombies = 0;
        while(null != (b = Entities.FindInSphere(b,BossOrigin,BossRadiusDetect)))
        {
            if(b.GetTeam() == 3 && b.GetHealth() > 0 && b.IsValid() && CountMaxP)
            {
                TotalHumans++;
            }
            if(b.GetTeam() == 2 && b.GetHealth() > 0 && b.IsValid() && CountMaxP)
            {
                TotalZombies++;
            }
            if(b.GetTeam() == 3 && b.GetHealth() > 0 && b.IsValid() && !CountMaxP)
            {
                Humans++;
                Humans = Humans - TotalHumans + TotalHumans;
            }
            if(b.GetTeam() == 2 && b.GetHealth() > 0 && b.IsValid() && !CountMaxP)
            {
                Zombies++;
                Zombies = Zombies - TotalZombies + TotalZombies;
            }
        }
    }
    if(!CountMaxP)
    {
        EntFireByHandle(self, "RunScriptCode", " StartBoss() ", 0.50, null, null);
    }
}

function CheckerPlayers()
{
    if(Humans <= 0)
    {
        if(BOSS == 1)
        {
            EntFire("Console","Command","say *** YOU FAILED! ***",0.00,null);
             EntFire("nuke_jail","Enable","",5.00,null);
            EntFire("safe_door","Close","",0.00,null);
            EntFire("fade_red","Fade","",0.00,null);
            EntFire("fade_red","FadeReverse","",1.00,null);
        }
        if(BOSS == 2)
        {
            EntFire("Console","Command","say *** YOU FAILED! ***",0.00,null);
             EntFire("nuke_jail","Enable","",5.00,null);
            EntFire("nuke_jail","AddOutput","origin -2195 4523 3410",4.00,null);
            EntFire("fade_red","Fade","",0.00,null);
            EntFire("fade_red","FadeReverse","",1.00,null);
        }
        if(BOSS == 3)
        {
            EntFire("fade_red","Fade","",0.00,null);
            EntFire("Console","Command","say *** YOU FAILED! ***",1.00,null);
            EntFire("fade_red","FadeReverse","",1.00,null);
            EntFire("scr_overlay_neo","StartOverlays","",1.00,null);
            EntFire("nuke_jail","AddOutput","origin 3584 -5460 -2616",5.00,null);
            EntFire("nuke_jail","Enable","",6.00,null);
            EntFire("scr_overlay_neo","StopOverlays","",6.00,null);
        }
        ticking = false;
    }
    if(Zombies == 0)
    {
        if(BOSS == 1)
        {
            EntFire("safe_door_zm","Close","",0.22,null);
        }
        //else if(BOSS == 2)
        //{
            //EntFire("safe_door_zm","Close","",0.22,null);
        //}
    }
    if(ticking)
    EntFireByHandle(self, "RunScriptCode", " CheckerPlayers() ", 0.55, null, null);
}

function SpawnMCode()
{
    local Morigin1 = "origin "+RandomInt(3440,3728)+" "+RandomInt(-4888,-4600)+" "+-2164
    local Morigin2 = "origin "+RandomInt(3440,3728)+" "+RandomInt(-4888,-4600)+" "+-2164
    local Morigin3 = "origin "+RandomInt(3440,3728)+" "+RandomInt(-4888,-4600)+" "+-2164
    local Morigin4 = "origin "+RandomInt(3440,3728)+" "+RandomInt(-4888,-4600)+" "+-2164
    local Morigin5 = "origin "+RandomInt(3440,3728)+" "+RandomInt(-4888,-4600)+" "+-2164
    local Morigin6 = "origin "+RandomInt(3440,3728)+" "+RandomInt(-4888,-4600)+" "+-2164
    if(ticking)
    {
        EntFire("entmaker_code1","AddOutput",Morigin1,0.02,null);
        EntFire("entmaker_code1","ForceSpawn","",0.04,null);
        EntFire("entmaker_code2","AddOutput",Morigin2,0.06,null);
        EntFire("entmaker_code2","ForceSpawn","",0.08,null);
        EntFire("entmaker_code3","AddOutput",Morigin3,0.10,null);
        EntFire("entmaker_code3","ForceSpawn","",0.12,null);
        EntFire("entmaker_code4","AddOutput",Morigin4,0.14,null);
        EntFire("entmaker_code4","ForceSpawn","",0.16,null);
        EntFire("entmaker_code5","AddOutput",Morigin5,0.18,null);
        EntFire("entmaker_code5","ForceSpawn","",0.20,null);
        EntFire("entmaker_code6","AddOutput",Morigin6,0.28,null);
        EntFire("entmaker_code6","ForceSpawn","",0.30,null);
        EntFireByHandle(self, "RunScriptCode", " SpawnMCode() ", RandomFloat(0.40,0.80), null, null);
    }        
}

function SpawnECode()
{
    local EnMorigin1 = "origin "+RandomInt(2922,4246)+" "+RandomInt(-5406,-4082)+" "+-2164
    local EnMorigin2 = "origin "+RandomInt(2922,4246)+" "+RandomInt(-5406,-4082)+" "+-2164
    local EnMorigin3 = "origin "+RandomInt(2922,4246)+" "+RandomInt(-5406,-4082)+" "+-2164
    local EnMorigin4 = "origin "+RandomInt(2922,4246)+" "+RandomInt(-5406,-4082)+" "+-2164
    local EnMorigin5 = "origin "+RandomInt(2922,4246)+" "+RandomInt(-5406,-4082)+" "+-2164
    local EnMorigin6 = "origin "+RandomInt(2922,4246)+" "+RandomInt(-5406,-4082)+" "+-2164
    if(end)
    {
        EntFire("entmaker_code1","AddOutput",EnMorigin1,0.02,null);
        EntFire("entmaker_code1","ForceSpawn","",0.04,null);
        EntFire("entmaker_code2","AddOutput",EnMorigin2,0.06,null);
        EntFire("entmaker_code2","ForceSpawn","",0.08,null);
        EntFire("entmaker_code3","AddOutput",EnMorigin3,0.10,null);
        EntFire("entmaker_code3","ForceSpawn","",0.12,null);
        EntFire("entmaker_code4","AddOutput",EnMorigin4,0.14,null);
        EntFire("entmaker_code4","ForceSpawn","",0.16,null);
        EntFire("entmaker_code5","AddOutput",EnMorigin5,0.18,null);
        EntFire("entmaker_code5","ForceSpawn","",0.20,null);
        EntFire("entmaker_code6","AddOutput",EnMorigin6,0.28,null);
        EntFire("entmaker_code6","ForceSpawn","",0.30,null);
        EntFire("tele_code*","AddOutput","target ",0.31,null);        
        EntFire("zombie_filter","AddOutput","OnPass !activator:AddOutput:origin 3584 -4759 -3311:0.00:-1",0.31,null);
        EntFire("tele_code*","AddOutput","OnStartTouch zombie_filter:TestActivator::0.00:-1 ",0.32,null);
        EntFireByHandle(self, "RunScriptCode", " SpawnECode() ", RandomFloat(0.50,1.00), null, null);
    }        
}

function Win()
{

    if(Humans == 1 && !ticking)
    {
        if(BOSS == 1)
        {
            EntFire("Console","Command","say *** SOLO WIN! ***",0.00,null);
             EntFire("tele_safeboss_win","Enable","",18.00,null);
            EntFire("tele_safeboss_jail","Enable","",18.00,null);
            EntFire("safeboss_bridge","Enable","",0.00,null);
            EntFire("Console","Command","say *** HUMAN ITEM SPAWNED! ***",1.00,null);
            EntFire("money_temp","ForceSpawn","",0.00,null);
            EntFire("fade_green","Fade","",0.00,null);
            EntFire("ball_out","PlaySound","",0.00,null);
            EntFire("fade_green","FadeReverse","",1.00,null);
            EntFire("tele_safeboss_win_zm","Enable","",18.00,null);
            EntFire("relay_safebossend","Trigger","",18.10,null);
            EntFire("ball_out","Volume","0",18.10,null);
            EntFire("ball_out","StopSound","",18.10,null);
        }
        else if(BOSS == 2)
        {
            EntFire("Console","Command","say *** SOLO WIN! ***",0.00,null);
            EntFire("tele_retroboss_win","Enable","",10.00,null);
            EntFire("tele_retroboss_jailzone","Enable","",10.00,null);
            EntFire("relay_retroboss_kill1","Trigger","",0.00,null);
            EntFire("fade_green","Fade","",0.00,null);
            EntFire("sound_retro_end","PlaySound","",0.00,null);
            EntFire("tele_retroboss_jailzone_zm","Enable","",20.00,null);
            EntFire("tele_retrosurf_lasthold","Enable","",64.00,null);
            EntFire("fade_tele_dust","Fade","",63.00,null);
            EntFire("tele_retrosurf_lasthold_zm","Enable","",64.10,null);
            EntFire("tele_surf_afk1","Enable","",53.00,null);
            EntFire("relay_retroboss_kill2","Trigger","",21.00,null);
            EntFire("relay_retroboss_kill3","Trigger","",65.00,null);
            EntFire("fade_green","FadeReverse","",1.00,null);
             EntFire("tele_surf_afk2","Enable","",53.00,null);
            EntFire("Console","Command","sv_airaccelerate 100",10.00,null);
            EntFire("tele_retroboss_win_zm","Enable","",20.00,null);
            EntFire("retroboss_platform","Enable","",0.10,null);
            EntFire("retroboss_platform","Disable","",21.00,null);
            EntFire("Console","Command","say *** HUMAN ITEM SPAWNED! ***",0.10,null);
            EntFire("trigger_retroboss_zm","Enable","",0.10,null);
             EntFire("wall_temp","ForceSpawn","",0.10,null);
        }
        else if(BOSS == 3)
        {
            EntFire("Console","Command","say *** SOLO WIN! ***",0.00,null);
            EntFire("tele_matrixboss_jailzone","Enable","",3.00,null);
            EntFire("fade_green","Fade","",0.00,null);
            EntFire("tele_matrixboss_jailzone_zm","Enable","",6.00,null);
            EntFire("fade_green","FadeReverse","",1.00,null);
            EntFire("tele_matrixboss_jailzone_zm","Disable","",36.00,null);
            EntFire("brush_matrixboss","Enable","",5.00,null);
            EntFire("Console","Command","say *** SURVIVE THE LAST HOLD! ***",2.00,null);
            EntFireByHandle(self, "RunScriptCode", " SpawnECode() ", 3.00, null, null);
            EntFire("fade_white","Fade","",37.00,null);
            EntFire("fade_white","FadeReverse","",38.00,null);
            EntFire("tele_winroom","Enable","",38.00,null);
            EntFireByHandle(self, "RunScriptCode", " end=false ", 38.00, null, null);
            EntFire("tele_matrixboss_jailzone","AddOutput","target td_matrixboss_jail_zm",6.00,null);
            EntFire("sound_last_hold","PlaySound","",5.00,null);
            EntFire("sound_matrix_boss","FadeOut","2",3.50,null);
            EntFire("brush_matrixboss","Disable","",37.00,null);
            EntFire("tele_matrixboss_jailzone","AddOutput","target td_matrix_boss",2.00,null);
            EntFire("ammo_trigger","FireUser1","",5.00,null);
            EntFire("timer_matrixboss_circle","Enable","",3.00,null);
            EntFire("timer_matrixboss_circle","Disable","",3.00,null);
        }
    }
    else if(Humans == 2 && !ticking)
    {
        if(BOSS == 1)
        {
            EntFire("Console","Command","say *** DUO WIN! ***",0.00,null);
             EntFire("tele_safeboss_win","Enable","",18.00,null);
            EntFire("tele_safeboss_jail","Enable","",18.00,null);
            EntFire("safeboss_bridge","Enable","",0.00,null);
            EntFire("Console","Command","say *** HUMAN ITEM SPAWNED! ***",1.00,null);
            EntFire("money_temp","ForceSpawn","",0.00,null);
            EntFire("fade_green","Fade","",0.00,null);
            EntFire("ball_out","PlaySound","",0.00,null);
            EntFire("fade_green","FadeReverse","",1.00,null);
            EntFire("tele_safeboss_win_zm","Enable","",18.00,null);
            EntFire("relay_safebossend","Trigger","",18.10,null);
            EntFire("ball_out","Volume","0",18.10,null);
            EntFire("ball_out","StopSound","",18.10,null);
        }
        else if(BOSS == 2)
        {
            EntFire("Console","Command","say *** DUO WIN! ***",0.00,null);
            EntFire("tele_retroboss_win","Enable","",10.00,null);
            EntFire("tele_retroboss_jailzone","Enable","",10.00,null);
            EntFire("relay_retroboss_kill1","Trigger","",0.00,null);
            EntFire("fade_green","Fade","",0.00,null);
            EntFire("sound_retro_end","PlaySound","",0.00,null);
            EntFire("tele_retroboss_jailzone_zm","Enable","",20.00,null);
            EntFire("tele_retrosurf_lasthold","Enable","",64.00,null);
            EntFire("fade_tele_dust","Fade","",63.00,null);
            EntFire("tele_retrosurf_lasthold_zm","Enable","",64.10,null);
            EntFire("tele_surf_afk1","Enable","",53.00,null);
            EntFire("relay_retroboss_kill2","Trigger","",21.00,null);
            EntFire("relay_retroboss_kill3","Trigger","",65.00,null);
            EntFire("fade_green","FadeReverse","",1.00,null);
             EntFire("tele_surf_afk2","Enable","",53.00,null);
            EntFire("Console","Command","sv_airaccelerate 100",10.00,null);
            EntFire("tele_retroboss_win_zm","Enable","",20.00,null);
            EntFire("retroboss_platform","Enable","",0.10,null);
            EntFire("retroboss_platform","Disable","",21.00,null);
            EntFire("Console","Command","say *** HUMAN ITEM SPAWNED! ***",0.10,null);
            EntFire("trigger_retroboss_zm","Enable","",0.10,null);
             EntFire("wall_temp","ForceSpawn","",0.10,null);
        }
        else if(BOSS == 3)
        {
            EntFire("Console","Command","say *** DUO WIN! ***",0.00,null);
            EntFire("tele_matrixboss_jailzone","Enable","",3.00,null);
            EntFire("fade_green","Fade","",0.00,null);
            EntFire("tele_matrixboss_jailzone_zm","Enable","",6.00,null);
            EntFire("fade_green","FadeReverse","",1.00,null);
            EntFire("tele_matrixboss_jailzone_zm","Disable","",36.00,null);
            EntFire("brush_matrixboss","Enable","",5.00,null);
            EntFire("Console","Command","say *** SURVIVE THE LAST HOLD! ***",2.00,null);
            EntFire("fade_white","Fade","",37.00,null);
            EntFire("fade_white","FadeReverse","",38.00,null);
            EntFireByHandle(self, "RunScriptCode", " SpawnECode() ", 6.00, null, null);
            EntFireByHandle(self, "RunScriptCode", " end=false ", 35.00, null, null);
            EntFire("tele_winroom","Enable","",38.00,null);
            EntFire("tele_matrixboss_jailzone","AddOutput","target td_matrixboss_jail_zm",6.00,null);
            EntFire("sound_last_hold","PlaySound","",5.00,null);
            EntFire("sound_matrix_boss","FadeOut","2",3.50,null);
            EntFire("brush_matrixboss","Disable","",37.00,null);
            EntFire("tele_matrixboss_jailzone","AddOutput","target td_matrix_boss",2.00,null);
            EntFire("ammo_trigger","FireUser1","",5.00,null);
            EntFire("timer_matrixboss_circle","Enable","",3.00,null);
            EntFire("timer_matrixboss_circle","Disable","",3.00,null);
        }
    }
    else if(Humans == 3 && !ticking)
    {
        if(BOSS == 1)
        {
            EntFire("Console","Command","say *** TRIO WIN! ***",0.00,null);
             EntFire("tele_safeboss_win","Enable","",18.00,null);
            EntFire("tele_safeboss_jail","Enable","",18.00,null);
            EntFire("safeboss_bridge","Enable","",0.00,null);
            EntFire("Console","Command","say *** HUMAN ITEM SPAWNED! ***",1.00,null);
            EntFire("money_temp","ForceSpawn","",0.00,null);
            EntFire("fade_green","Fade","",0.00,null);
            EntFire("ball_out","PlaySound","",0.00,null);
            EntFire("fade_green","FadeReverse","",1.00,null);
            EntFire("tele_safeboss_win_zm","Enable","",18.00,null);
            EntFire("relay_safebossend","Trigger","",18.10,null);
            EntFire("ball_out","Volume","0",18.10,null);
            EntFire("ball_out","StopSound","",18.10,null);
        }
        else if(BOSS == 2)
        {
            EntFire("Console","Command","say *** TRIO WIN! ***",0.00,null);
            EntFire("tele_retroboss_win","Enable","",10.00,null);
            EntFire("tele_retroboss_jailzone","Enable","",10.00,null);
            EntFire("relay_retroboss_kill1","Trigger","",0.00,null);
            EntFire("fade_green","Fade","",0.00,null);
            EntFire("sound_retro_end","PlaySound","",0.00,null);
            EntFire("tele_retroboss_jailzone_zm","Enable","",20.00,null);
            EntFire("tele_retrosurf_lasthold","Enable","",64.00,null);
            EntFire("fade_tele_dust","Fade","",63.00,null);
            EntFire("tele_retrosurf_lasthold_zm","Enable","",64.10,null);
            EntFire("tele_surf_afk1","Enable","",53.00,null);
            EntFire("relay_retroboss_kill2","Trigger","",21.00,null);
            EntFire("relay_retroboss_kill3","Trigger","",65.00,null);
            EntFire("fade_green","FadeReverse","",1.00,null);
             EntFire("tele_surf_afk2","Enable","",53.00,null);
            EntFire("Console","Command","sv_airaccelerate 100",10.00,null);
            EntFire("tele_retroboss_win_zm","Enable","",20.00,null);
            EntFire("retroboss_platform","Enable","",0.10,null);
            EntFire("retroboss_platform","Disable","",21.00,null);
            EntFire("Console","Command","say *** HUMAN ITEM SPAWNED! ***",0.10,null);
            EntFire("trigger_retroboss_zm","Enable","",0.10,null);
             EntFire("wall_temp","ForceSpawn","",0.10,null);
        }
        else if(BOSS == 3)
        {
            EntFire("Console","Command","say *** TRIO WIN! ***",0.00,null);
            EntFire("tele_matrixboss_jailzone","Enable","",3.00,null);
            EntFire("fade_green","Fade","",0.00,null);
            EntFire("tele_matrixboss_jailzone_zm","Enable","",6.00,null);
            EntFire("fade_green","FadeReverse","",1.00,null);
            EntFire("tele_matrixboss_jailzone_zm","Disable","",36.00,null);
            EntFire("brush_matrixboss","Enable","",5.00,null);
            EntFire("Console","Command","say *** SURVIVE THE LAST HOLD! ***",2.00,null);
            EntFire("fade_white","Fade","",37.00,null);
            EntFire("fade_white","FadeReverse","",38.00,null);
            EntFireByHandle(self, "RunScriptCode", " SpawnECode() ", 6.00, null, null);
            EntFireByHandle(self, "RunScriptCode", " end=false ", 32.00, null, null);
            EntFire("tele_winroom","Enable","",38.00,null);
            EntFire("tele_matrixboss_jailzone","AddOutput","target td_matrixboss_jail_zm",6.00,null);
            EntFire("sound_last_hold","PlaySound","",5.00,null);
            EntFire("sound_matrix_boss","FadeOut","2",3.50,null);
            EntFire("brush_matrixboss","Disable","",37.00,null);
            EntFire("tele_matrixboss_jailzone","AddOutput","target td_matrix_boss",2.00,null);
            EntFire("ammo_trigger","FireUser1","",5.00,null);
            EntFire("timer_matrixboss_circle","Enable","",3.00,null);
            EntFire("timer_matrixboss_circle","Disable","",3.00,null);
        }
    }
    else if(Humans >= 4 && !ticking)
    {
        if(BOSS == 1)
        {
            EntFire("Console","Command","say *** GOOD JOB, YOU DID IT! ***",0.00,null);
             EntFire("tele_safeboss_win","Enable","",18.00,null);
            EntFire("tele_safeboss_jail","Enable","",18.00,null);
            EntFire("safeboss_bridge","Enable","",0.00,null);
            EntFire("Console","Command","say *** HUMAN ITEM SPAWNED! ***",1.00,null);
            EntFire("money_temp","ForceSpawn","",0.00,null);
            EntFire("fade_green","Fade","",0.00,null);
            EntFire("ball_out","PlaySound","",0.00,null);
            EntFire("fade_green","FadeReverse","",1.00,null);
            EntFire("tele_safeboss_win_zm","Enable","",18.00,null);
            EntFire("relay_safebossend","Trigger","",18.10,null);
            EntFire("ball_out","Volume","0",18.10,null);
            EntFire("ball_out","StopSound","",18.10,null);
        }
        else if(BOSS == 2)
        {
            EntFire("Console","Command","say *** GOOD JOB, YOU DID IT! ***",0.00,null);
            EntFire("tele_retroboss_win","Enable","",10.00,null);
            EntFire("tele_retroboss_jailzone","Enable","",10.00,null);
            EntFire("relay_retroboss_kill1","Trigger","",0.00,null);
            EntFire("fade_green","Fade","",0.00,null);
            EntFire("sound_retro_end","PlaySound","",0.00,null);
            EntFire("tele_retroboss_jailzone_zm","Enable","",20.00,null);
            EntFire("tele_retrosurf_lasthold","Enable","",64.00,null);
            EntFire("fade_tele_dust","Fade","",63.00,null);
            EntFire("tele_retrosurf_lasthold_zm","Enable","",64.10,null);
            EntFire("tele_surf_afk1","Enable","",53.00,null);
            EntFire("relay_retroboss_kill2","Trigger","",21.00,null);
            EntFire("relay_retroboss_kill3","Trigger","",65.00,null);
            EntFire("fade_green","FadeReverse","",1.00,null);
             EntFire("tele_surf_afk2","Enable","",53.00,null);
            EntFire("Console","Command","sv_airaccelerate 100",10.00,null);
            EntFire("tele_retroboss_win_zm","Enable","",20.00,null);
            EntFire("retroboss_platform","Enable","",0.10,null);
            EntFire("retroboss_platform","Disable","",21.00,null);
            EntFire("Console","Command","say *** HUMAN ITEM SPAWNED! ***",0.10,null);
            EntFire("trigger_retroboss_zm","Enable","",0.10,null);
             EntFire("wall_temp","ForceSpawn","",0.10,null);
        }
        else if(BOSS == 3)
        {
            EntFire("Console","Command","say *** GOOD JOB, YOU DID IT! ***",0.00,null);
            EntFire("tele_matrixboss_jailzone","Enable","",3.00,null);
            EntFire("fade_green","Fade","",0.00,null);
            EntFire("tele_matrixboss_jailzone_zm","Enable","",6.00,null);
            EntFire("fade_green","FadeReverse","",1.00,null);
            EntFire("tele_matrixboss_jailzone_zm","Disable","",36.00,null);
            EntFire("brush_matrixboss","Enable","",5.00,null);
            EntFire("Console","Command","say *** SURVIVE THE LAST HOLD! ***",2.00,null);
            EntFire("fade_white","Fade","",37.00,null);
            EntFireByHandle(self, "RunScriptCode", " SpawnECode() ", 6.00, null, null);
            EntFireByHandle(self, "RunScriptCode", " end=false ", 30.00, null, null);
            EntFire("fade_white","FadeReverse","",38.00,null);
            EntFire("tele_winroom","Enable","",38.00,null);
            EntFire("tele_matrixboss_jailzone","AddOutput","target td_matrixboss_jail_zm",6.00,null);
            EntFire("sound_last_hold","PlaySound","",5.00,null);
            EntFire("sound_matrix_boss","FadeOut","2",3.50,null);
            EntFire("brush_matrixboss","Disable","",37.00,null);
            EntFire("tele_matrixboss_jailzone","AddOutput","target td_matrix_boss",2.00,null);
            EntFire("ammo_trigger","FireUser1","",5.00,null);
            EntFire("timer_matrixboss_circle","Enable","",3.00,null);
            EntFire("timer_matrixboss_circle","Disable","",3.00,null);
        }
    }
    if(Zombies >= 1 && !ticking)
    {
        if(BOSS == 1)
        {
            EntFire("Console","Command","say *** ZOMBIE ITEM SPAWNED! ***",0.22,null);
            EntFire("safeboss_bridge_zm","Enable","",0.22,null);
            EntFire("jihad_maker","ForceSpawn","",0.22,null);
        }
        else if(BOSS == 2)
        {
            EntFire("Console","Command","say *** ZOMBIE ITEM SPAWNED! ***",0.00,null);
            EntFire("retroboss_platform_zm","Enable","",0.00,null);
            EntFire("fidget_spawn_template","ForceSpawn","",0.00,null);
            EntFire("retroboss_platform_zm","Disable","",20.50,null);
        }
    }
    EntFireByHandle(self, "RunScriptCode", " Stop() ", 1.00, null, null);
}

function ShowText()
{
    if(ticking && BOSS <= 2)
    {
        EntFire("Boss_count","SetText","Humans: "+Humans+"\nZombies: "+Zombies,0.00,null);
        EntFire("Boss_count","Display","",0.45,null);
        EntFireByHandle(self, "RunScriptCode", " ShowText() ", 0.45, null, null);
    }
    else if(ticking && BOSS > 2)
    {
        Timer -= 0.50;
        EntFire("Boss_count","SetText","Humans: "+Humans+"\nSurvive: "+Timer,0.00,null);
        EntFire("Boss_count","Display","",0.50,null);
        EntFireByHandle(self, "RunScriptCode", " ShowText() ", 0.50, null, null);
    }
}

function Stop()
{
    BOSS++;
    ticking = true;
    TotalZombies = 0;
    Zombies = 0;
    TotalHumans = 0;
    Humans = 0;
    CountMaxP = true;
}
    
