--LunamelodyつPrincess
function c74560007.initial_effect(c)
	--can not disable summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_CANNOT_DISABLE_SPSUMMON)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	c:RegisterEffect(e1)
	--summon success
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e4:SetCode(EVENT_SPSUMMON_SUCCESS)
	e4:SetOperation(c74560007.sumsuc)
	c:RegisterEffect(e4)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(74560007,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_HAND+LOCATION_GRAVE+LOCATION_REMOVED)
	e1:SetTarget(c74560007.sptg)
	e1:SetOperation(c74560007.spop)
	c:RegisterEffect(e1)
end
c74560007.named_with_Die=1
function c74560007.IsDie(c)
	local m=_G["c"..c:GetCode()]
	return m and m.named_with_Die
end
function c74560007.sumsuc(e,tp,eg,ep,ev,re,r,rp)
	Duel.SetChainLimitTillChainEnd(aux.FALSE)
end
function c74560007.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and c:IsCanBeSpecialSummoned(e,0,tp,false,false) 
		and Duel.IsExistingMatchingCard(c74560007.spfilter,tp,LOCATION_ONFIELD+LOCATION_HAND,LOCATION_ONFIELD,3,c) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,c,1,0,0)
end
function c74560007.spfilter(c)
	return c74560007.IsDie(c) or c:IsCode(74560012) and c:IsFaceup()
end
function c74560007.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local m=Duel.GetMatchingGroupCount(c74560007.spfilter,tp,LOCATION_ONFIELD+LOCATION_HAND,LOCATION_ONFIELD,c)
	if m<3 then return end
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 or not c:IsCanBeSpecialSummoned(e,0,tp,false,false) then return end
	if not c:IsRelateToEffect(e) then return end
	local g=Duel.SelectMatchingCard(tp,c74560007.spfilter,tp,LOCATION_ONFIELD+LOCATION_HAND,LOCATION_ONFIELD,3,m,c)
	Duel.SendtoDeck(g,nil,-1,REASON_COST)
	Duel.RaiseEvent(g,EVENT_CUSTOM+74567456,e,0,tp,0,0)
	Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SET_BASE_ATTACK)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetValue(g:GetCount()*450)
	e1:SetReset(RESET_EVENT+0xff0000)
	c:RegisterEffect(e1)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SET_BASE_DEFENSE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetValue(g:GetCount()*450)
	e1:SetReset(RESET_EVENT+0xff0000)
	c:RegisterEffect(e1)
	if g:GetCount()>2 then
		--disable
		local e2=Effect.CreateEffect(c)
		e2:SetDescription(aux.Stringid(74560007,1))
		e2:SetCategory(CATEGORY_DISABLE)
		e2:SetType(EFFECT_TYPE_QUICK_O)
		e2:SetCode(EVENT_CHAINING)
		e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
		e2:SetRange(LOCATION_MZONE)
		e2:SetCountLimit(1)
		e2:SetCondition(c74560007.discon1)
		e2:SetCost(c74560007.discost)
		e2:SetTarget(c74560007.distg)
		e2:SetOperation(c74560007.disop)
		c:RegisterEffect(e2)
	end
	if g:GetCount()>5 then
		--disable
		local e2=Effect.CreateEffect(c)
		e2:SetDescription(aux.Stringid(74560007,2))
		e2:SetCategory(CATEGORY_DISABLE)
		e2:SetType(EFFECT_TYPE_QUICK_O)
		e2:SetCode(EVENT_CHAINING)
		e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
		e2:SetRange(LOCATION_MZONE)
		e2:SetCountLimit(1)
		e2:SetCondition(c74560007.discon2)
		e2:SetCost(c74560007.discost)
		e2:SetTarget(c74560007.distg)
		e2:SetOperation(c74560007.disop)
		c:RegisterEffect(e2)
	end
	if g:GetCount()>8 then
		--sisisi
		local e1=Effect.CreateEffect(c)
		e1:SetCategory(CATEGORY_TODECK)
		e1:SetDescription(aux.Stringid(74560007,3))
		e1:SetType(EFFECT_TYPE_IGNITION)
		e1:SetCountLimit(1)
		e1:SetRange(LOCATION_MZONE)
		e1:SetCost(c74560007.cost)
		e1:SetTarget(c74560007.target)
		e1:SetOperation(c74560007.operation)
		c:RegisterEffect(e1)
	end
	if g:GetCount()>11 then
		--sisisi
		local e1=Effect.CreateEffect(c)
		e1:SetCategory(CATEGORY_TODECK)
		e1:SetDescription(aux.Stringid(74560007,4))
		e1:SetType(EFFECT_TYPE_IGNITION)
		e1:SetCountLimit(1)
		e1:SetRange(LOCATION_MZONE)
		e1:SetCost(c74560007.cost2)
		e1:SetTarget(c74560007.target2)
		e1:SetOperation(c74560007.operation2)
		c:RegisterEffect(e1)
	end
	if g:GetCount()>14 then
		--immune
		local e3=Effect.CreateEffect(c)
		e3:SetType(EFFECT_TYPE_SINGLE)
		e3:SetCode(EFFECT_IMMUNE_EFFECT)
		e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
		e3:SetRange(LOCATION_MZONE)
		e3:SetValue(c74560007.efilter)
		c:RegisterEffect(e3)
	end
end
function c74560007.discon1(e,tp,eg,ep,ev,re,r,rp)
	return ep~=tp and not e:GetHandler():IsStatus(STATUS_BATTLE_DESTROYED)
		and re:IsActiveType(TYPE_MONSTER) and Duel.IsChainNegatable(ev) 
end
function c74560007.discon2(e,tp,eg,ep,ev,re,r,rp)
	return ep~=tp and not e:GetHandler():IsStatus(STATUS_BATTLE_DESTROYED)
		and (re:IsActiveType(TYPE_SPELL) or re:IsActiveType(TYPE_TRAP)) and Duel.IsChainNegatable(ev) 
end
function c74560007.discfilter(c)
	return c74560007.IsDie(c) or c:IsCode(74560012)
end
function c74560007.discost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c74560007.discfilter,tp,LOCATION_HAND,0,1,nil) end
	local g=Duel.SelectMatchingCard(tp,c74560007.discfilter,tp,LOCATION_HAND,0,1,1,nil)
	Duel.SendtoDeck(g,tp,-1,REASON_COST)
	Duel.RaiseEvent(g,EVENT_CUSTOM+74567456,e,0,tp,0,0)
end
function c74560007.distg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
end
function c74560007.disop(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateActivation(ev)
	if eg:GetFirst():IsType(TYPE_XYZ) then 
		local g=eg:GetFirst():GetOverlayGroup()
		Duel.SendtoGrave(g,REASON_EFFECT)
	end
	Duel.SendtoDeck(eg,nil,-1,REASON_EFFECT)
	Duel.RaiseEvent(eg,EVENT_CUSTOM+74567456,e,0,tp,0,0)
end
function c74560007.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c74560007.discfilter,tp,LOCATION_HAND+LOCATION_ONFIELD,0,1,nil) end
	local g=Duel.SelectMatchingCard(tp,c74560007.discfilter,tp,LOCATION_HAND+LOCATION_ONFIELD,0,1,1,nil)
	Duel.SendtoDeck(g,tp,-1,REASON_COST)
	Duel.RaiseEvent(g,EVENT_CUSTOM+74567456,e,0,tp,0,0)
end
function c74560007.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(nil,tp,0,LOCATION_ONFIELD,1,nil) end
end
function c74560007.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetFieldGroup(tp,0,LOCATION_ONFIELD)
	local sg=g:RandomSelect(tp,1)
	local tc=sg:GetFirst()
	local og=tc:GetOverlayGroup()
	Duel.SendtoGrave(og,REASON_EFFECT)
	Duel.SendtoDeck(tc,nil,-1,REASON_EFFECT)
	Duel.RaiseEvent(tc,EVENT_CUSTOM+74567456,e,0,tp,0,0)
end
function c74560007.cost2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(nil,tp,LOCATION_DECK,0,5,nil) end
	local g=Duel.GetDecktopGroup(tp,5)
	Duel.SendtoDeck(g,tp,-1,REASON_COST)
	Duel.RaiseEvent(g,EVENT_CUSTOM+74567456,e,0,tp,0,0) 
end
function c74560007.target2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(nil,tp,LOCATION_SZONE,LOCATION_SZONE,1,e:GetHandler()) end
end
function c74560007.operation2(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(nil,tp,LOCATION_SZONE,LOCATION_SZONE,e:GetHandler())
	Duel.SendtoDeck(g,tp,-1,REASON_COST)
	Duel.RaiseEvent(g,EVENT_CUSTOM+74567456,e,0,tp,0,0)
	local sg=Duel.GetFieldGroup(tp,0,LOCATION_DECK)
	local m=g:GetCount()
	local n=sg:GetCount()
	if n>0 then
		if m<=n then
			local ssg=Duel.SelectMatchingCard(1-tp,nil,tp,0,LOCATION_DECK,m,m,nil)
		else
			local ssg=Duel.SelectMatchingCard(1-tp,nil,tp,0,LOCATION_DECK,n,n,nil)
		end
		Duel.SendtoDeck(ssg,tp,-1,REASON_EFFECT)
		Duel.RaiseEvent(ssg,EVENT_CUSTOM+74567456,e,0,tp,0,0)
	end
end
function c74560007.efilter(e,te)
	return te:GetOwner()~=e:GetOwner()
end


