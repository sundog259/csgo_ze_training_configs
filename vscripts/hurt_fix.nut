if(self.GetMoveParent()==null)return;

if(!("bugdmgfixprint" in getroottable())){
	::bugdmgfixprint<-true;
}

function checkInRepeat(name){
	if(Entities.FindByName(null, "load_script")==null){
		ent <- Entities.CreateByClassname("logic_relay");
		ent.__KeyValueFromString("targetname", "load_script");
	}
	ent <- Entities.FindByName(null, "load_script");
	printl(ent);
	if(!ent.ValidateScriptScope()){
		return true;
	}
	if(!("NAME_REPEAT_LIST" in ent.GetScriptScope())){
		ent.GetScriptScope().NAME_REPEAT_LIST<-[];
	}
	foreach(k in ent.GetScriptScope().NAME_REPEAT_LIST){
		printl(k);
		if(k==name){
			printl(true);
			return true;
		}
	}
	ent.GetScriptScope().NAME_REPEAT_LIST.push(name);
	return false;
}

local ent=null;
while ((ent = Entities.FindByName(ent, self.GetMoveParent().GetName())) != null)
{
	if(ent!=self.GetMoveParent()){
		if(!checkInRepeat(self.GetMoveParent().GetName())){
		}
		return;
	}
	if(ent==null){
		break;
	}
}

local hurtN=self.GetName();
if(hurtN==""){
	hurtN=UniqueString("bugdmgfix_hurt");
	self.__KeyValueFromString("targetname", hurtN);
}else if(hurtN == self.GetPreTemplateName() && self.GetMoveParent().GetName() != self.GetMoveParent().GetPreTemplateName()){
	hurtN=hurtN+"&&"+self.GetMoveParent().GetName();
	self.__KeyValueFromString("targetname", hurtN);
}
ent=null;
while ((ent = Entities.FindByName(ent, hurtN)) != null)
{
	if(ent!=self){
		if(!checkInRepeat(hurtN)){
		}
		return;
	}
	if(ent==null){
		break;
	}
}
local oldVec=self.GetAngles();

target <- Entities.CreateByClassname("info_target");
local targetN=UniqueString("bugdmgfix_tar");
target.__KeyValueFromString("targetname", targetN);
target.SetOrigin(self.GetOrigin());
target.SetAngles(oldVec.x, oldVec.y, oldVec.z);
EntFireByHandle(target, "SetParent", self.GetMoveParent().GetName(), 0, null, null);

EntFireByHandle(self, "ClearParent", "", 0, null, null);

move <- Entities.CreateByClassname("logic_measure_movement");
move.__KeyValueFromFloat("TargetScale", 1.0);
move.__KeyValueFromInt("MeasureType", 0);
EntFireByHandle(move, "SetMeasureReference", targetN, 0, self, self);
EntFireByHandle(move, "SetTarget", hurtN, 0, self, self);
EntFireByHandle(move, "SetTargetReference", targetN, 0, self, self);
EntFireByHandle(move, "SetMeasureTarget", targetN, 0, self, self);
EntFireByHandle(move, "Enable", "", 0, self, self);
EntFireByHandle(move, "RunScriptFile", "checktokill.nut", 0.0, self, self);
EntFireByHandle(move, "RunScriptCode", "SaveKillEnt(\""+targetN+"\",\""+hurtN+"\")", 0.1, self, self);

x<-null;
y<-null;
z<-null;
delay<-0.1;
isSetAngel<-false;
function ResetAngel(){
	if(!isSetAngel)return;
	EntFireByHandle(target, "addoutput", "angles 0 0 0", 0.0, null, null);
	EntFireByHandle(self, "runscriptcode", "ResetAngel()", delay, null, null);
}

function SetAng(x,y,z){
	this.x=x;
	this.y=y;
	this.z=z;
	if(!isSetAngel){
		isSetAngel=true;
		ResetAngel();
	}
}
