--NeigeつKoyuki
function c74560003.initial_effect(c)
	--sp
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetDescription(aux.Stringid(74560003,0))
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c74560003.spcon)
	c:RegisterEffect(e1)
	--search
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(74560003,1))
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_DAMAGE_STEP)
	e1:SetCountLimit(1,74560003)
	e1:SetCost(c74560003.cost)
	e1:SetTarget(c74560003.tg)
	e1:SetOperation(c74560003.op)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e2)


end
c74560003.named_with_Die=1
function c74560003.IsDie(c)
	local m=_G["c"..c:GetCode()]
	return m and m.named_with_Die
end
function c74560003.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return not Duel.IsExistingMatchingCard(aux.TRUE,tp,LOCATION_MZONE,0,1,nil)
end
function c74560003.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(nil,tp,LOCATION_DECK,0,1,nil) end
	local g=Duel.SelectMatchingCard(tp,nil,tp,LOCATION_DECK,0,1,1,nil)
	Duel.SendtoDeck(g,tp,-1,REASON_COST)
	Duel.RaiseEvent(g,EVENT_CUSTOM+74567456,e,0,tp,0,0)
end
function c74560003.tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(nil,tp,0,LOCATION_DECK+LOCATION_EXTRA,1,nil) end
end
function c74560003.filter(c,e,tp)
	return c:IsCanBeSpecialSummoned(e,0,tp,false,false) and c74560003.IsDie(c) and not c:IsCode(74560003)
end
function c74560003.filter2(c,e,tp)
	return c:IsSSetable() and c74560003.IsDie(c) and (c:IsType(TYPE_SPELL) or c:IsType(TYPE_TRAP))
end
function c74560003.op(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetFieldGroup(tp,0,LOCATION_DECK+LOCATION_EXTRA)
	local sg=g:RandomSelect(tp,1)
	local tc=sg:GetFirst()
	Duel.ConfirmCards(tp,tc)
	Duel.SendtoDeck(tc,nil,-1,REASON_EFFECT)
	Duel.RaiseEvent(tc,EVENT_CUSTOM+74567456,e,0,tp,0,0)
	if tc:IsType(TYPE_MONSTER) and Duel.IsExistingMatchingCard(c74560003.filter,tp,LOCATION_GRAVE+LOCATION_DECK,0,1,nil,e,tp) then
		local ssg=Duel.SelectMatchingCard(tp,c74560003.filter,tp,LOCATION_GRAVE+LOCATION_DECK,0,1,1,nil,e,tp)		  
		Duel.SpecialSummon(ssg,0,tp,tp,false,false,POS_FACEUP)
	elseif (tc:IsType(TYPE_SPELL) or tc:IsType(TYPE_TRAP)) and Duel.IsExistingMatchingCard(c74560003.filter2,tp,LOCATION_GRAVE+LOCATION_DECK,0,1,nil) then
		local ssg=Duel.SelectMatchingCard(tp,c74560003.filter2,tp,LOCATION_GRAVE+LOCATION_DECK,0,1,1,nil)		  
		Duel.SSet(tp,ssg)
	end
end