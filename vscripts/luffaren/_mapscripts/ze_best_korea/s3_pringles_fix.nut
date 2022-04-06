//===================================\\
// Script by Luffaren (STEAM_1:1:22521282)
// (PUT THIS IN: csgo/scripts/vscripts/luffaren/_mapscripts/ze_best_korea/)
//===================================\\

TICKRATE <- 0.10;
HOLE_WAIT <- 60.00;

stage <- 1;
ticking <- false;
waiting <- false;

function Start()
{
	ticking = true;
	EntFire("s3_pringles_rot","Start","",0.00,null);
	EntFire("s3_pringles_rot","AddOutput","rendermode 2",0.00,null);
	EntFireByHandle(self,"StartForward","",0.00,null,null);
	EntFireByHandle(self,"SetSpeedReal","100",0.00,null,null);
	EntFireByHandle(self,"SetSpeedReal","100",0.50,null,null);
	EntFireByHandle(self,"SetSpeedReal","200",1.00,null,null);
	EntFireByHandle(self,"SetSpeedReal","250",1.50,null,null);
	EntFireByHandle(self,"SetSpeedReal","300",2.00,null,null);
	EntFireByHandle(self,"SetSpeedReal","400",3.00,null,null);
	EntFireByHandle(self,"SetSpeedReal","500",4.00,null,null);
	EntFireByHandle(self,"SetSpeedReal","600",5.00,null,null);
	EntFireByHandle(self,"SetSpeedReal","700",6.00,null,null);
	EntFire("s3_pringles_sound1","PlaySound","",0.00,null);
	EntFire("server","Command","say ***DO YOU WANT SOME PRINGLES?***",0.00,null);
	EntFire("server","Command","say ***LET ME ROLL TO YOU***",1.00,null);
	EntFire("server","Command","say ***EAT ME DADDY***",2.00,null);
	EntFire("mapmanager","RunScriptCode"," CheckChewie(); ",25.00,null);
	Tick();
}

path_index <- 0;
function PathPassed()
{
	path_index++;
	if(path_index==1){EntFireByHandle(self,"SetSpeed","XXXXX",0.00,null,null);}
}

function Tick()
{
	local o = self.GetOrigin();
	if(stage==1)		//roll down, check for safe X pos
	{
		if(o.x>7450)
		{
			stage++;
			EntFire("s3_pringles_safe_break_1","Break","",0.00,null);
			EntFire("s3_pringles_safe_break_2","Break","",5.00,null);
		}
	}
	else if(stage==2)	//roll down, check for hole Z pos (and wait <HOLE_WAIT>)
	{
		if(o.z<7000)
		{
			stage++;
			waiting = true;
			local t = 0.05;
			for(local i=255;i>0;i-=2)
			{
				local c = ("rendercolor "+i+" "+i+" "+i+" "+i).tostring();
				EntFire("s3_pringles_rot","AddOutput",c,t,null);
				t+=0.01;
			}
			local h = null;while(null!=(h=Entities.FindInSphere(h,self.GetOrigin(),500000)))
			EntFire("s3_pringles_rot","Stop","",0.00,null);
		}
	}
	else if(stage==3)	//roll up, check for hole X pos
	{
		if(o.x<10700)
		{
			stage++;
			EntFire("sound_panicmode","PlaySound","",3.20,null);
		}
	}
	else if(stage==4)	//roll up, check for ladder-spawn X pos
	{
		if(o.x<6300)
		{
			stage++;
			EntFire("s3_pringles_ladder","Close","",0.50,null);
			EntFire("s3_pringles_ladder2","Close","",10.50,null);
			EntFire("s3_pringles_roof_break","Break","",0.50,null);
			EntFire("server","Command","say ***QUICK, CLIMB THE LADDER!***",0.50,null);
			EntFire("server","Command","say ***QUICK, CLIMB THE LADDER!***",0.51,null);
			EntFire("server","Command","say ***QUICK, CLIMB THE LADDER!***",0.52,null);
		}
	}
	else if(stage==5)	//roll up, check for ladder X pos
	{
		if(o.x<3750)
		{
			stage++;
			EntFire("s3_pringles_ladder_break","Break","",0.00,null);
		}
	}
	else if(stage==6)	//roll up, check for door X pos
	{
		if(o.x<3300)
		{
			ticking = false;
			EntFire("s3_pringles_hurt_hugwall","Enable","",0.00,null);
			EntFire("s3_pringles_hurt_hugwall","Disable","",1.00,null);
			EntFireByHandle(self,"Break","",5.00,null,null);
			EntFire("s3_pringles_sound3","PlaySound","",0.00,null);
			EntFire("s3_pringles_boomparticle","Stop","",0.00,null);
			EntFire("s3_pringles_boomparticle","Start","",0.02,null);
			EntFire("s3_pringles_rot","Stop","",0.00,null);
		}
	}
	if(ticking)
	{
		if(!waiting)
			EntFireByHandle(self,"RunScriptCode"," Tick(); ",TICKRATE,null,null);
		else
		{
			waiting = false;
			EntFireByHandle(self,"RunScriptCode"," Tick(); ",HOLE_WAIT,null,null);
			EntFireByHandle(self,"StartBackward","",HOLE_WAIT,null,null);
			EntFire("s3_pringles_zteleporter","Disable","",HOLE_WAIT,null);
			EntFire("s3_pringles_rot","StartBackward","",HOLE_WAIT,null);
			EntFireByHandle(self,"SetSpeedReal","100",HOLE_WAIT,null,null);
			EntFireByHandle(self,"SetSpeedReal","150",HOLE_WAIT+0.50,null,null);
			EntFireByHandle(self,"SetSpeedReal","200",HOLE_WAIT+1.00,null,null);
			EntFireByHandle(self,"SetSpeedReal","250",HOLE_WAIT+1.50,null,null);
			EntFireByHandle(self,"SetSpeedReal","300",HOLE_WAIT+2.00,null,null);
			EntFireByHandle(self,"SetSpeedReal","400",HOLE_WAIT+3.00,null,null);
			EntFireByHandle(self,"SetSpeedReal","500",HOLE_WAIT+4.00,null,null);
			EntFireByHandle(self,"SetSpeedReal","600",HOLE_WAIT+5.00,null,null);
			EntFireByHandle(self,"SetSpeedReal","700",HOLE_WAIT+6.00,null,null);
			local t = HOLE_WAIT+1.00;
			for(local i=0;i<255;i+=2)
			{
				local c = ("rendercolor "+i+" "+i+" "+i+" "+i).tostring();
				EntFire("s3_pringles_rot","AddOutput",c,t,null);
				t+=0.01;
			}
			EntFire("s3_pringles_rot","AddOutput","rendercolor 255 255 255 255",t,null);
			EntFire("server","Command","say ***MISSILE SILO DOOR OPENS IN "+HOLE_WAIT+" SECONDS***",0.00,null);
			EntFire("server","Command","say ***BE SURE TO DEFEND HARD***",1.00,null);
			EntFire("server","Command","say ***MISSILE SILO DOOR OPENS IN 30 SECONDS***",HOLE_WAIT-25,null);
			EntFire("server","Command","say ***MISSILE SILO DOOR OPENS IN 20 SECONDS***",HOLE_WAIT-15,null);
			EntFire("server","Command","say ***MISSILE SILO DOOR OPENS IN 10 SECONDS***",HOLE_WAIT-5,null);
			EntFire("server","Command","say ***WAIT...***",HOLE_WAIT+7,null);
			EntFire("server","Command","say ***PRINGLES IS BACK!***",HOLE_WAIT+10,null);
			EntFire("s3_pringles_sound2","PlaySound","",HOLE_WAIT+2,null);
		}
	}
}