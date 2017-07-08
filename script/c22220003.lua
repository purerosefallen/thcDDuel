--竹林¤白泽球
function c22220003.initial_effect(c)
	aux.EnablePendulumAttribute(c)
	--destroy
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_DESTROY)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_PZONE)
	e2:SetCountLimit(1)
	e2:SetCondition(c22220003.conp)
	e2:SetCost(c22220003.costp)
	e2:SetTarget(c22220003.tgp)
	e2:SetOperation(c22220003.opp)
	c:RegisterEffect(e2)
	--equip
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(22220003,0))
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCategory(CATEGORY_EQUIP)
	e1:SetRange(LOCATION_MZONE)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,0x1e0)
	e1:SetTarget(c22220003.eqtg1)
	e1:SetOperation(c22220003.eqop)
	c:RegisterEffect(e1)
	--todeck 
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(22220003,2))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_GRAVE)
	e1:SetCountLimit(1)
	e1:SetCost(c22220003.cost)
	e1:SetTarget(c22220003.target)
	e1:SetOperation(c22220003.operation)
	c:RegisterEffect(e1)
end
c22220003.named_with_Shirasawa_Tama=1
function c22220003.IsShirasawaTama(c)
	local m=_G["c"..c:GetCode()]
	return m and m.named_with_Shirasawa_Tama
end

function c22220003.conp(e,tp,eg,ep,ev,re,r,rp)
	local seq=e:GetHandler():GetSequence()
	local tc=Duel.GetFieldCard(tp,LOCATION_SZONE,13-seq)
	return tc and c22220003.IsShirasawaTama(tc)
end
function c22220003.cfilter(c)
	return c:IsType(TYPE_PENDULUM) and c:IsAbleToRemoveAsCost()
end
function c22220003.costp(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c22220003.cfilter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectTarget(tp,c22220003.cfilter,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.Remove(g,POS_FACEUP,REASON_COST)
end
function c22220003.filter(c)
	return c:IsFaceup() and c:IsDestructable()
end
function c22220003.tgp(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and chkc:IsControler(1-tp) and chkc:IsDestructable() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsDestructable,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,Card.IsDestructable,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end
function c22220003.opp(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	local tg=g:Filter(Card.IsRelateToEffect,nil,e)
	if not c:IsRelateToEffect(e) then return false end
	if tg:GetCount()>0 then
		Duel.Destroy(tg,REASON_EFFECT)
	end
end
function c22220003.filter(c)
	return c:IsFaceup() and c22220003.IsShirasawaTama(c)
end
function c22220003.eqtg1(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsFaceup() and chkc~=e:GetHandler() end
	if chk==0 then return e:GetHandler():GetFlagEffect(22220003)==0 and Duel.GetLocationCount(tp,LOCATION_SZONE)>0
		and Duel.IsExistingTarget(c22220003.filter,tp,LOCATION_MZONE,0,1,e:GetHandler()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	local g=Duel.SelectTarget(tp,c22220003.filter,tp,LOCATION_MZONE,0,1,1,e:GetHandler())
	Duel.SetOperationInfo(0,CATEGORY_EQUIP,g,1,0,0)
	e:GetHandler():RegisterFlagEffect(22220003,RESET_EVENT+0x7e0000+RESET_PHASE+PHASE_END,0,1)
end
function c22220003.eqop(e,tp,eg,ep,ev,re,r,rp)
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
	e1:SetDescription(aux.Stringid(22220003,1))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,0x1e0)
	e1:SetRange(LOCATION_SZONE)
	e1:SetTarget(c22220003.sptg)
	e1:SetOperation(c22220003.spop)
	e1:SetReset(RESET_EVENT+0x1fe0000)
	c:RegisterEffect(e1)
	--immune
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_EQUIP)
	e5:SetCode(EFFECT_IMMUNE_EFFECT)
	e5:SetValue(c22220003.efilter)
	c:RegisterEffect(e5)
	--eqlimit
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetCode(EFFECT_EQUIP_LIMIT)
	e4:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e4:SetValue(c22220003.eqlimit)
	e4:SetReset(RESET_EVENT+0x1fe0000)
	e4:SetLabelObject(tc)
	c:RegisterEffect(e4)
end
function c22220003.efilter(e,te)
	return te:IsActiveType(TYPE_MONSTER) and te:GetOwnerPlayer()~=e:GetHandlerPlayer()
end
function c22220003.eqlimit(e,c)
	return c==e:GetLabelObject()
end
function c22220003.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():GetFlagEffect(22220003)==0 and Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,true,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
	e:GetHandler():RegisterFlagEffect(22220003,RESET_EVENT+0x7e0000+RESET_PHASE+PHASE_END,0,1)
end
function c22220003.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.SpecialSummon(c,0,tp,tp,true,false,POS_FACEUP)
	end
end

function c22220003.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToRemoveAsCost() end
	Duel.Remove(e:GetHandler(),POS_FACEUP,REASON_COST)
end
function c22220003.filter3(c,e,tp)
	return c22220003.IsShirasawaTama(c) and c:IsType(TYPE_MONSTER) and c:IsFaceup()
end
function c22220003.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,1)
		and Duel.IsExistingMatchingCard(c22220003.filter3,tp,LOCATION_GRAVE+LOCATION_REMOVED,0,3,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TODECK,nil,3,0,0)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c22220003.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c22220003.filter3,tp,LOCATION_GRAVE+LOCATION_REMOVED,0,nil)
	if g:GetCount()<3 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local sg=g:Select(tp,3,3,nil)
	Duel.SendtoDeck(sg,nil,0,REASON_EFFECT)
	Duel.ShuffleDeck(tp)
	Duel.Draw(tp,1,REASON_EFFECT)
end