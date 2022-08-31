map_text <- null;
text_1 <- null;
text_2 <-  null;

function A()
{
	map_text = Entities.FindByName(null,"door_text");
}

function B(time)
{
	text_1 = "机甲大门将在"
	text_2 = "秒后打开"
	CountdownTimer(time);
}

function C(time)
{
	text_1 = "大桥将在"
	text_2 = "秒后爆炸"
	CountdownTimer(time);
}

function CountdownTimer(amount)
{
	local temp1 = map_text.GetName();
	local i = amount;
	local j;
	for(j = amount;j > 0;j--)
	{
		EntFire(temp1,"SetText",text_1 + j.tostring() + text_2,i-j);
		EntFire(temp1,"Display","",i-j);
	}
}
