--幸运¤白泽球
function c22220004.initial_effect(c)
	aux.EnablePendulumAttribute(c)
	--draw
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(22220004,3))
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetRange(LOCATION_PZONE)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_DRAW)
	e2:SetCountLimit(3)
	e2:SetCondition(c22220004.drcon)
	e2:SetCost(c22220004.drcost)
	e2:SetTarget(c22220004.drtg)
	e2:SetOperation(c22220004.drop)
	c:RegisterEffect(e2)
	--equip
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(22220004,0))
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCategory(CATEGORY_EQUIP)
	e1:SetRange(LOCATION_MZONE)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,0x1e0)
	e1:SetTarget(c22220004.eqtg1)
	e1:SetOperation(c22220004.eqop)
	c:RegisterEffect(e1)
	--todeck 
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(22220004,2))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_GRAVE)
	e1:SetCountLimit(1)
	e1:SetCost(c22220004.cost)
	e1:SetTarget(c22220004.target)
	e1:SetOperation(c22220004.operation)
	c:RegisterEffect(e1)
end
c22220004.named_with_Shirasawa_Tama=1
function c22220004.IsShirasawaTama(c)
	local m=_G["c"..c:GetCode()]
	return m and m.named_with_Shirasawa_Tama
end
function c22220004.drcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp
end
function c22220004.filterp(c)
	return c22220004.IsShirasawaTama(c) and c:IsType(TYPE_MONSTER) and not c:IsPublic()
end
function c22220004.drcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return ep==tp and eg:IsExists(c22220004.filterp,1,nil) end
	local g=eg:Filter(c22220004.filterp,nil)
	if g:GetCount()==1 then
		Duel.ConfirmCards(1-tp,g)
		Duel.DiscardHand(tp,Card.IsDiscardable,1,1,REASON_COST+REASON_DISCARD)
		Duel.ShuffleHand(tp)
	else
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONFIRM)
		local sg=g:Select(tp,1,1,nil)
		Duel.ConfirmCards(1-tp,sg)
		Duel.DiscardHand(tp,Card.IsDiscardable,1,1,REASON_COST+REASON_DISCARD)
		Duel.ShuffleHand(tp)
	end
end
function c22220004.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,1) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(1)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c22220004.drop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
end
function c22220004.filter(c)
	return c:IsFaceup() and c22220004.IsShirasawaTama(c)
end
function c22220004.eqtg1(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsFaceup() and chkc~=e:GetHandler() end
	if chk==0 then return e:GetHandler():GetFlagEffect(22220004)==0 and Duel.GetLocationCount(tp,LOCATION_SZONE)>0
		and Duel.IsExistingTarget(c22220004.filter,tp,LOCATION_MZONE,0,1,e:GetHandler()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	local g=Duel.SelectTarget(tp,c22220004.filter,tp,LOCATION_MZONE,0,1,1,e:GetHandler())
	Duel.SetOperationInfo(0,CATEGORY_EQUIP,g,1,0,0)
	e:GetHandler():RegisterFlagEffect(22220004,RESET_EVENT+0x7e0000+RESET_PHASE+PHASE_END,0,1)
end
function c22220004.eqop(e,tp,eg,ep,ev,re,r,rp)
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
	e1:SetDescription(aux.Stringid(22220004,1))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,0x1e0)
	e1:SetRange(LOCATION_SZONE)
	e1:SetTarget(c22220004.sptg)
	e1:SetOperation(c22220004.spop)
	e1:SetReset(RESET_EVENT+0x1fe0000)
	c:RegisterEffect(e1)
	--immune
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_EQUIP)
	e5:SetCode(EFFECT_IMMUNE_EFFECT)
	e5:SetValue(c22220004.efilter)
	c:RegisterEffect(e5)
	--eqlimit
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetCode(EFFECT_EQUIP_LIMIT)
	e4:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e4:SetValue(c22220004.eqlimit)
	e4:SetReset(RESET_EVENT+0x1fe0000)
	e4:SetLabelObject(tc)
	c:RegisterEffect(e4)
end
function c22220004.efilter(e,te)
	return te:IsActiveType(TYPE_TRAP) and te:GetOwnerPlayer()~=e:GetHandlerPlayer()
end
function c22220004.eqlimit(e,c)
	return c==e:GetLabelObject()
end
function c22220004.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():GetFlagEffect(22220004)==0 and Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,true,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
	e:GetHandler():RegisterFlagEffect(22220004,RESET_EVENT+0x7e0000+RESET_PHASE+PHASE_END,0,1)
end
function c22220004.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.SpecialSummon(c,0,tp,tp,true,false,POS_FACEUP)
	end
end

function c22220004.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToRemoveAsCost() end
	Duel.Remove(e:GetHandler(),POS_FACEUP,REASON_COST)
end
function c22220004.filter(c)
	return c22220004.IsShirasawaTama(c) and c:IsType(TYPE_MONSTER) and c:IsAbleToHand()
end
function c22220004.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c22220004.filter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c22220004.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c22220004.filter,tp,LOCATION_DECK,0,nil)
	if g:GetCount()>0 then
		tc=g:RandomSelect(tp,1)
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,tc)
	end
end