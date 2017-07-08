--黑暗的巫女¤白泽球
function c22220011.initial_effect(c)
	c:EnableCounterPermit(0x1222)
	c:SetCounterLimit(0x1222,4)  
	aux.EnablePendulumAttribute(c)
	--add counter
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetRange(LOCATION_PZONE)
	e2:SetCode(EVENT_TO_GRAVE)
	e2:SetOperation(c22220011.poperation)
	c:RegisterEffect(e2)
	local e5=e2:Clone()
	e5:SetCode(EVENT_REMOVE)
	c:RegisterEffect(e5)
	local e6=e2:Clone()
	e6:SetCode(EVENT_TO_DECK)
	c:RegisterEffect(e6)
	--pick counter
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(22220011,2))
	e3:SetCategory(CATEGORY_TOGRAVE)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_PZONE)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetCountLimit(1)
	e3:SetCost(c22220011.pcost2)
	e3:SetTarget(c22220011.ptg2)
	e3:SetOperation(c22220011.pop2)
	c:RegisterEffect(e3)
	--equip
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(22220011,1))
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCategory(CATEGORY_EQUIP)
	e1:SetRange(LOCATION_MZONE)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,0x1e0)
	e1:SetTarget(c22220011.eqtg1)
	e1:SetOperation(c22220011.eqop)
	c:RegisterEffect(e1)
	--spsummon proc
	local e7=Effect.CreateEffect(c)
	e7:SetType(EFFECT_TYPE_FIELD)
	e7:SetCode(EFFECT_SPSUMMON_PROC)
	e7:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e7:SetRange(LOCATION_HAND)
	e7:SetCountLimit(1,22220011)
	e7:SetCondition(c22220011.hspcon)
	e7:SetOperation(c22220011.hspop)
	c:RegisterEffect(e7)
	--remove
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_REMOVE+CATEGORY_DRAW)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	e3:SetOperation(c22220011.recop)
	c:RegisterEffect(e3)
end
c22220011.named_with_Shirasawa_Tama=1
function c22220011.IsShirasawaTama(c)
	local m=_G["c"..c:GetCode()]
	return m and m.named_with_Shirasawa_Tama
end
function c22220011.cfilter(c,tp)
	return c22220011.IsShirasawaTama(c) and c:GetPreviousControler()==tp and c:IsPreviousLocation(LOCATION_ONFIELD)
end
function c22220011.poperation(e,tp,eg,ep,ev,re,r,rp)
	if eg:IsExists(c22220011.cfilter,1,nil,tp) then
		e:GetHandler():AddCounter(0x1222,1)
	end
end
function c22220011.pcost2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsCanRemoveCounter(tp,0x1222,4,REASON_COST) end
	e:GetHandler():RemoveCounter(tp,0x1222,4,REASON_COST)
end
function c22220011.ptg2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c22220011.filter2,tp,LOCATION_DECK,0,1,nil) end
end
function c22220011.filter2(c,tp)
	return c22220011.IsShirasawaTama(c) and c:IsAbleToGrave()
end
function c22220011.pop2(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return false end
	if Duel.GetMatchingGroupCount(c22220011.filter2,tp,LOCATION_DECK,0,nil)<1 then return end
	local g=Duel.SelectMatchingCard(tp,c22220011.filter2,tp,LOCATION_DECK,0,1,1,nil)
	Duel.SendtoGrave(g,REASON_EFFECT)
end
function c22220011.filter(c)
	return c:IsFaceup() and c22220011.IsShirasawaTama(c)
end
function c22220011.eqtg1(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsFaceup() and chkc~=e:GetHandler() end
	if chk==0 then return e:GetHandler():GetFlagEffect(22220011)==0 and Duel.GetLocationCount(tp,LOCATION_SZONE)>0
		and Duel.IsExistingTarget(c22220011.filter,tp,LOCATION_MZONE,0,1,e:GetHandler()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	local g=Duel.SelectTarget(tp,c22220011.filter,tp,LOCATION_MZONE,0,1,1,e:GetHandler())
	Duel.SetOperationInfo(0,CATEGORY_EQUIP,g,1,0,0)
	e:GetHandler():RegisterFlagEffect(22220011,RESET_EVENT+0x7e0000+RESET_PHASE+PHASE_END,0,1)
end
function c22220011.eqop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if not c:IsRelateToEffect(e) or c:IsFacedown() then return end
	if not tc:IsRelateToEffect(e) or tc:IsFacedown() then
		Duel.SendtoGrave(c,REASON_EFFECT)
		return
	end
	if not Duel.Equip(tp,c,tc,false) then return end
	--unequip
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(22220011,2))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,0x1e0)
	e1:SetRange(LOCATION_SZONE)
	e1:SetTarget(c22220011.sptg)
	e1:SetOperation(c22220011.spop)
	e1:SetReset(RESET_EVENT+0x1fe0000)
	c:RegisterEffect(e1)
	--Atkup
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_EQUIP)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetValue(1200)
	c:RegisterEffect(e2)
	--Atkup
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_EQUIP)
	e2:SetCode(EFFECT_UPDATE_DEFENSE)
	e2:SetValue(800)
	c:RegisterEffect(e2)
	--eqlimit
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetCode(EFFECT_EQUIP_LIMIT)
	e4:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e4:SetValue(c22220011.eqlimit)
	e4:SetReset(RESET_EVENT+0x1fe0000)
	e4:SetLabelObject(tc)
	c:RegisterEffect(e4)
end
function c22220011.eqlimit(e,c)
	return c==e:GetLabelObject()
end
function c22220011.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():GetFlagEffect(22220011)==0 and Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,true,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
	e:GetHandler():RegisterFlagEffect(22220011,RESET_EVENT+0x7e0000+RESET_PHASE+PHASE_END,0,1)
end
function c22220011.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.SpecialSummon(c,0,tp,tp,true,false,POS_FACEUP)
	end
end
function c22220011.spfilter(c)
	return c:IsDestructable() and c:IsType(TYPE_PENDULUM) and not c:IsLocation(LOCATION_FZONE+LOCATION_MZONE)
end
function c22220011.spfilter2(c)
	return c22220011.IsShirasawaTama(c)
end
function c22220011.hspcon(e,c)
	local g=Duel.GetMatchingGroupCount(c22220011.spfilter2,e:GetHandler():GetControler(),LOCATION_ONFIELD,0,nil)
	return g>0 and Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c22220011.spfilter,e:GetHandler():GetControler(),LOCATION_ONFIELD,LOCATION_ONFIELD,2,nil)
end
function c22220011.hspop(e,tp,eg,ep,ev,re,r,rp,c)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectMatchingCard(tp,c22220011.spfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,2,2,nil)
	Duel.Destroy(g,REASON_COST)
end
function c22220011.recop(e,tp,eg,ep,ev,re,r,rp,c)
	local g=Duel.GetMatchingGroup(Card.IsFaceup,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	if g:GetCount()>0 then
		local tg=g:GetMaxGroup(Card.GetAttack)
		if tg:GetCount()>1 then
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
			local sg=tg:Select(tp,1,1,nil)
			Duel.HintSelection(sg)
			local tc1=sg:GetFirst()
			Duel.SendtoGrave(tc1,REASON_EFFECT)
			Duel.Draw(tc1:GetControler(),1,REASON_EFFECT)
		else	
			local tc2=tg:GetFirst()
			Duel.SendtoGrave(tc2,REASON_EFFECT) 
			Duel.Draw(tc2:GetControler(),1,REASON_EFFECT) end
	end
end