//===================================\\
// PlayerMod script by Luffaren (STEAM_1:1:22521282)
// (PUT THIS IN: csgo/scripts/vscripts/luffaren/)
//===================================\\
// 
// This script contains various functions for advanced movement-related things
// It is now possible to run accurate speedmod/gravity calls that STACKS the values instead of setting it
// It also has various other functions to help with your general needs
// 
// [FUNCTIONS]
// SpeedMod(speed,time);			  >	Increment SpeedModifier for X time   (does not SET, it ADDS)
// GravMod(gravity,time);			  >	Increment GravityModifier for X time (does not SET, it ADDS)
// SetVelocity(x,y,z);				  >	Sets global velocity
// AddVelocity(x,y,z);				  >	Adds global velocity
// VelocityExp(x,y,z,force,max_z);	  >	Sets velocity from XYZ origin and specified force/distance, max_z is height-velocity cap
// VelocityExpActivator(force,max_z); >	Same as above^ getting the XYZ origin directly from !activator
// VelocityExpCaller(force,max_z); 	  >	Same as above^ getting the XYZ origin directly from !caller
// DamageSlow(intensity,time);		  >	Spams SetHealth-1 to damage+damageslow at X intensity for X time -1hp each tick
// 
//===================================\\
::speedmod <- Entities.CreateByClassname("player_speedmod");
function GetPlayer(phandle){foreach(p in plist){if(p.player==phandle)return p;}return null;}
function IsPlayerValid(ph){if(ph!=null&&ph.IsValid()&&ph.GetClassname()=="player"&&ph.GetHealth()>0)return true;return false;}
class MovePlayer
{
	player = null;
	speed = 1.00;
	gravity = 1.00;
	constructor(_player,_speed,_gravity)
	{
		player = _player;
		if(_speed!=0.00)SetSpeed(_speed);
		if(_gravity!=0.00)SetGravity(_gravity);
	}
	function SetSpeed(_speed)
	{
		speed += (0.00+_speed);
		local spp = 0.00+speed;if(spp<0.00)spp=0.00;
		EntFireByHandle(::speedmod,"ModifySpeed",spp.tostring(),0.00,player,player);
	}
	function SetGravity(_gravity)
	{
		gravity += (0.00+_gravity);
		EntFireByHandle(player,"AddOutput","gravity "+gravity.tostring(),0.00,player,player);
	}
}
plist <- [];
function SpeedMod(speed,time)
{
	local pp = GetPlayer(activator);
	if(pp!=null)
	{
		pp.SetSpeed(speed);
		if(time!=null)EntFireByHandle(self,"RunScriptCode"," SpeedMod("+(-speed).tostring()+",null); ",time,activator,activator);
	}
	else if(IsPlayerValid(activator)&&time!=null)
	{
		plist.push(MovePlayer(activator,speed,0.00));
		EntFireByHandle(self,"RunScriptCode"," SpeedMod("+(-speed).tostring()+",null); ",time,activator,activator);
	}
}
function GravMod(gravity,time)
{
	local pp = GetPlayer(activator);
	if(pp!=null)
	{
		pp.SetGravity(gravity);
		if(time!=null)EntFireByHandle(self,"RunScriptCode"," GravMod("+(-gravity).tostring()+",null); ",time,activator,activator);
	}
	else if(IsPlayerValid(activator)&&time!=null)
	{
		plist.push(MovePlayer(activator,0.00,gravity));
		EntFireByHandle(self,"RunScriptCode"," GravMod("+(-gravity).tostring()+",null); ",time,activator,activator);
	}
}
function SetVelocity(x,y,z)
{
	if(!IsPlayerValid(activator))return null;
	local cv = activator.GetVelocity();
	if(x==null){x=0;cv.x=0;} 
	if(y==null){y=0;cv.y=0;} 
	if(z==null){z=0;cv.z=0;}
	EntFireByHandle(activator,"AddOutput","basevelocity "+(x-cv.x).tostring()+" "+(y-cv.y).tostring()+" "+(z-cv.z).tostring(),0.00,null,null);
}
function AddVelocity(x,y,z)
{
	if(!IsPlayerValid(activator))return null;
	if(x==null)x=0;if(y==null)y=0;if(z==null)z=0;
	EntFireByHandle(activator,"AddOutput","basevelocity "+x.tostring()+" "+y.tostring()+" "+z.tostring(),0.00,null,null);
}
function VelocityExpActivator(force,max_z){VelocityExp(activator.GetOrigin().x,activator.GetOrigin().y,activator.GetOrigin().z,force,max_z);}
function VelocityExpCaller(force,max_z){VelocityExp(caller.GetOrigin().x,caller.GetOrigin().y,caller.GetOrigin().z,force,max_z);}
function VelocityExp(x,y,z,force,max_z)
{
	local vec = Vector(x,y,z);
	local h=null;while(null!=(h=Entities.FindInSphere(h,vec,force)))
	{
		if(!IsPlayerValid(h))continue;
		local pvec = GVO(h.GetOrigin(),0,0,48);
		local dir = Vector(pvec.x-vec.x,pvec.y-vec.y,pvec.z-vec.z);dir.Norm();
		local len = force/((sqrt((vec.x-pvec.x)*(vec.x-pvec.x)+(vec.y-pvec.y)*(vec.y-pvec.y)+(vec.z-pvec.z)*(vec.z-pvec.z)))/20);
		dir.x*=len;dir.y*=len;dir.z*=len;
		if(h.GetVelocity().z+dir.z>max_z)dir.z=max_z-h.GetVelocity().z;
		EntFireByHandle(h,"AddOutput","basevelocity "+dir.x.tostring()+" "+dir.y.tostring()+" "+dir.z.tostring(),0.00,null,null);
	}
}
function DamageSlow(intensity,time)
{
	if(!IsPlayerValid(activator))return null;
	if(intensity<0.01)intensity=0.01;if(time<0.01)time=0.01;
	for(local i=0.00;i<time;i+=intensity){EntFireByHandle(self,"RunScriptCode"," DamageSlowTick(); ",i,activator,activator);}
}
function DamageSlowTick()
{
	if(!IsPlayerValid(activator))return null;
	EntFireByHandle(activator,"SetHealth",(activator.GetHealth()-1).tostring(),0.00,null,null);
}
function GVO(vec,_x,_y,_z){return Vector(vec.x+_x,vec.y+_y,vec.z+_z);}
