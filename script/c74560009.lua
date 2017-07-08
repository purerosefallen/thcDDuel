--RuftiつArnoria
function c74560009.initial_effect(c)
	--print
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TODECK)
	e1:SetDescription(aux.Stringid(74560009,0))
	e1:SetCountLimit(1)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetRange(LOCATION_GRAVE+LOCATION_MZONE)
	e1:SetCost(c74560009.cost)
	e1:SetOperation(c74560009.operation)
	c:RegisterEffect(e1)
	--qiangyuzhihu
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_TOHAND+CATEGORY_DRAW)
	e2:SetDescription(aux.Stringid(74560009,1))
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetProperty(EFFECT_FLAG_BOTH_SIDE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1,74560009)
	e2:SetLabelObject(e1)
	e2:SetTarget(c74560009.tg)
	e2:SetOperation(c74560009.op)
	c:RegisterEffect(e2)


end
c74560009.named_with_Die=1
function c74560009.IsDie(c)
	local m=_G["c"..c:GetCode()]
	return m and m.named_with_Die
end
function c74560009.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SendtoDeck(e:GetHandler(),tp,-1,REASON_COST)
	Duel.RaiseEvent(e:GetHandler(),EVENT_CUSTOM+74567456,e,0,tp,0,0)
end
function c74560009.operation(e,tp,eg,ep,ev,re,r,rp)
	local t = {
		[1] = {desc=aux.Stringid(74560004,2),code=74560001},
		[2] = {desc=aux.Stringid(74560004,3),code=74560002},
		[3] = {desc=aux.Stringid(74560004,4),code=74560003},
		[4] = {desc=aux.Stringid(74560004,5),code=74560004},
		[5] = {desc=aux.Stringid(74560004,6),code=74560005},
		[6] = {desc=aux.Stringid(74560004,7),code=74560006},
		[7] = {desc=aux.Stringid(74560004,8),code=74560008},
		[8] = {desc=aux.Stringid(74560004,9),code=74560009},
		[9] = {desc=aux.Stringid(74560004,10),code=74560010},
		[10] = {desc=aux.Stringid(74560004,11),code=74560011},
	}

	local g=Group.CreateGroup()
	local a=5
	while a>0 do
		Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(74560001,12))
		local sel=Duel.SelectOption(tp,Nef.unpackOneMember(t, "desc"))+1
		local code=t[sel].code
		local token=Duel.CreateToken(tp,code)
		g:AddCard(token)
		a=a-1
	end
	Duel.SendtoDeck(g,tp,2,REASON_EFFECT)
end
function c74560009.tg(e,tp,eg,ep,ev,re,r,rp,chk)
	local tc=Duel.GetDecktopGroup(tp,1):GetFirst()
	local tc2=Duel.GetDecktopGroup(1-tp,1):GetFirst()
	if chk==0 then return tc and tc:IsAbleToHand() and tc2 and tc2:IsAbleToHand() end
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(74560009,2))
	e:SetLabel(Duel.SelectOption(tp,70,71,72))
	Duel.Hint(HINT_SELECTMSG,1-tp,aux.Stringid(74560009,2))
	e:GetLabelObject():SetLabel(Duel.SelectOption(1-tp,70,71,72))
end
function c74560009.op(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetDecktopGroup(tp,1):GetFirst()
	local tc2=Duel.GetDecktopGroup(1-tp,1):GetFirst()
	if e:GetHandler():IsOnField() and tc and tc:IsAbleToHand() and tc2 and tc2:IsAbleToHand() then
	local right1=0
	local right2=0
	local t=0
	local opt=e:GetLabel()
	if opt==0 then t=TYPE_MONSTER
	else if opt==1 then t=TYPE_SPELL
		else t=TYPE_TRAP end
	end
	Duel.ConfirmDecktop(tp,1)
	if tc:IsType(t) then 
		Duel.SendtoHand(tc,tp,REASON_EFFECT) 
		right1=1
	else 
		Duel.SendtoDeck(tc,tp,-1,REASON_COST)
		Duel.RaiseEvent(tc,EVENT_CUSTOM+74567456,e,0,tp,0,0)
	end
	opt=e:GetLabelObject():GetLabel()   
	if opt==0 then t=TYPE_MONSTER
	else if opt==1 then t=TYPE_SPELL
		else t=TYPE_TRAP end
	end
	Duel.ConfirmDecktop(1-tp,1)
	if tc2:IsType(t) then 
		Duel.SendtoHand(tc2,1-tp,REASON_EFFECT)
		right2=1
	else 
		Duel.SendtoDeck(tc2,tp,-1,REASON_COST)
		Duel.RaiseEvent(tc2,EVENT_CUSTOM+74567456,e,0,tp,0,0)
	end
	if right1==1 and right2==0 then
		Duel.Draw(tp,1,REASON_EFFECT)
	end
	end
end


