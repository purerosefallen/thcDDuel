--KiraつKarin
function c74560011.initial_effect(c)
	--print
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND)
	e1:SetDescription(aux.Stringid(74560011,0))
	e1:SetCountLimit(1,74560011)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCost(c74560011.cost)
	e1:SetTarget(c74560011.target)
	e1:SetOperation(c74560011.operation)
	c:RegisterEffect(e1)
	--print
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(74560011,1))
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e2:SetCode(EVENT_CUSTOM+74567456)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCountLimit(1)
	e2:SetCost(c74560011.cost)
	e2:SetOperation(c74560011.op)
	c:RegisterEffect(e2)
end
c74560011.named_with_Die=1
function c74560011.IsDie(c)
	local m=_G["c"..c:GetCode()]
	return m and m.named_with_Die
end
function c74560011.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SendtoDeck(e:GetHandler(),tp,-1,REASON_COST)
	Duel.RaiseEvent(e:GetHandler(),EVENT_CUSTOM+74567456,e,0,tp,0,0)
end
function c74560011.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(1-tp,LOCATION_SZONE)>0 end
end
function c74560011.operation(e,tp,eg,ep,ev,re,r,rp)
	local m=Duel.GetLocationCount(1-tp,LOCATION_SZONE)
	if m>=3 then m=3 end
	while m>0 do
		local token=Duel.CreateToken(tp,74561201)
		Duel.MoveToField(token,tp,1-tp,LOCATION_SZONE,POS_FACEDOWN,true)
		m=m-1
	end
end
function c74560011.op(e,tp,eg,ep,ev,re,r,rp,c)
	local g=Duel.GetMatchingGroup(Card.IsFaceup,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	if g:GetCount()>0 then
		local tg=g:GetMaxGroup(Card.GetAttack)
		if tg:GetCount()>1 then
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
			local sg=tg:Select(tp,1,1,nil)
			Duel.HintSelection(sg)
			local tc1=sg:GetFirst()
			local og=tc1:GetOverlayGroup()
			Duel.SendtoGrave(og,REASON_EFFECT)
			Duel.SendtoDeck(tc1,nil,-1,REASON_COST)
			Duel.RaiseEvent(tc1,EVENT_CUSTOM+74567456,e,0,tp,0,0)
			Duel.Draw(tc1:GetControler(),1,REASON_EFFECT)
		else	
			local tc2=tg:GetFirst()
			local og=tc2:GetOverlayGroup()
			Duel.SendtoGrave(og,REASON_EFFECT)
			Duel.SendtoDeck(tc2,nil,-1,REASON_COST)
			Duel.RaiseEvent(tc2,EVENT_CUSTOM+74567456,e,0,tp,0,0)
			Duel.Draw(tc2:GetControler(),1,REASON_EFFECT)
		end
	end
end







