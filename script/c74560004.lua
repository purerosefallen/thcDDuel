--TokoyoつAmato
function c74560004.initial_effect(c)
	--sp
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetDescription(aux.Stringid(74560004,0))
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c74560004.spcon)
	c:RegisterEffect(e1)
	--print
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TODECK)
	e1:SetDescription(aux.Stringid(74560004,1))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetCountLimit(1,74560004)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCost(c74560004.cost)
	e1:SetTarget(c74560004.target)
	e1:SetOperation(c74560004.operation)
	c:RegisterEffect(e1)


end
c74560004.named_with_Die=1
function c74560004.IsDie(c)
	local m=_G["c"..c:GetCode()]
	return m and m.named_with_Die
end
function c74560004.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return not Duel.IsExistingMatchingCard(aux.TRUE,tp,LOCATION_MZONE,0,1,nil)
end
function c74560004.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(nil,tp,LOCATION_HAND,0,1,nil) end
	local g=Duel.SelectMatchingCard(tp,nil,tp,LOCATION_HAND,0,1,1,nil)
	g:AddCard(e:GetHandler())
	Duel.SendtoDeck(g,tp,-1,REASON_COST)
	Duel.RaiseEvent(g,EVENT_CUSTOM+74567456,e,0,tp,0,0)
end
function c74560004.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(nil,tp,0,LOCATION_HAND+LOCATION_ONFIELD,1,nil) end
end
function c74560004.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetFieldGroup(tp,0,LOCATION_HAND+LOCATION_ONFIELD)
	if g:GetCount()<1 then return false end
	local sg=g:RandomSelect(tp,1)
	local tc=sg:GetFirst()
	local og=tc:GetOverlayGroup()
	Duel.SendtoGrave(og,REASON_EFFECT)
	Duel.SendtoDeck(tc,nil,-1,REASON_EFFECT)
	Duel.RaiseEvent(tc,EVENT_CUSTOM+74567456,e,0,tp,0,0)
	if tc:IsType(TYPE_MONSTER) then
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
		Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(74560001,12))
		local sel=Duel.SelectOption(tp,Nef.unpackOneMember(t, "desc"))+1
		local code=t[sel].code
		local token=Duel.CreateToken(tp,code)
		Duel.SendtoHand(token,tp,REASON_EFFECT)
	elseif tc:IsType(TYPE_SPELL) or tc:IsType(TYPE_TRAP) then
		local t = {
			[1] = {desc=aux.Stringid(74560004,13),code=74561101},
			[2] = {desc=aux.Stringid(74560004,14),code=74561501},
			[3] = {desc=aux.Stringid(74560004,15),code=74562201},
		}
		Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(74560001,12))
		local sel=Duel.SelectOption(tp,Nef.unpackOneMember(t, "desc"))+1
		local code=t[sel].code
		local token=Duel.CreateToken(tp,code)
		Duel.SendtoHand(token,tp,REASON_EFFECT)
	end
end
