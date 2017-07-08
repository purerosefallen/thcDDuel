--美妙的巫女¤白泽球
function c22220009.initial_effect(c)
	aux.EnablePendulumAttribute(c)
	--DESTROY_REPLACE
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EFFECT_DESTROY_REPLACE)
	e2:SetRange(LOCATION_PZONE)
	e2:SetCountLimit(1)
	e2:SetTarget(c22220009.indtg)
	e2:SetValue(c22220009.indval)
	c:RegisterEffect(e2)
	--CATEGORY_DISABLE
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(22220009,0))
	e2:SetCategory(CATEGORY_DISABLE)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_CHAINING)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e2:SetRange(LOCATION_HAND)
	e2:SetCondition(c22220009.negcon)
	e2:SetCost(c22220009.negcost)
	e2:SetTarget(c22220009.negtg)
	e2:SetOperation(c22220009.negop)
	c:RegisterEffect(e2)
	--destroy replace
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EFFECT_DESTROY_REPLACE)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetTarget(c22220009.reptg)
	e2:SetValue(c22220009.repval)
	e2:SetOperation(c22220009.repop)
	c:RegisterEffect(e2)
	--tohand
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(22220009,2))
	e4:SetCategory(CATEGORY_TOHAND)
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e4:SetCode(EVENT_BATTLED)
	e4:SetRange(LOCATION_GRAVE+LOCATION_REMOVED)
	e4:SetCountLimit(1,22220009+EFFECT_COUNT_CODE_DUEL)
	e4:SetCondition(c22220009.cacon)
	e4:SetTarget(c22220009.sptg)
	e4:SetOperation(c22220009.caop)
	c:RegisterEffect(e4)
end
c22220009.named_with_Shirasawa_Tama=1
function c22220009.IsShirasawaTama(c)
	local m=_G["c"..c:GetCode()]
	return m and m.named_with_Shirasawa_Tama
end
function c22220009.filterp(c,tp)
	return c:IsControler(tp) and c22220009.IsShirasawaTama(c) and c:IsType(TYPE_MONSTER)
		and c:IsReason(REASON_EFFECT) and c:GetReasonPlayer()==1-tp
end
function c22220009.indtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return eg:IsExists(c22220009.filterp,1,nil,tp) end
	return true
end
function c22220009.indval(e,c)
	return c22220009.filterp(c,e:GetHandlerPlayer())
end

function c22220009.tfilter(c)
	return c:IsLocation(LOCATION_MZONE) and c:IsFaceup() and c22220009.IsShirasawaTama(c)
end
function c22220009.negcon(e,tp,eg,ep,ev,re,r,rp)
	if not re:IsHasProperty(EFFECT_FLAG_CARD_TARGET) then return false end
	local g=Duel.GetChainInfo(ev,CHAININFO_TARGET_CARDS)
	return g:IsExists(c22220009.tfilter,1,nil)
end
function c22220009.negcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsDiscardable() end
	Duel.SendtoGrave(e:GetHandler(),REASON_COST+REASON_DISCARD)
end
function c22220009.negtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DISABLE,eg,1,0,0)
end
function c22220009.negop(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateEffect(ev)
end
function c22220009.repfilter(c,tp)
	return c:IsFaceup() and c22220009.IsShirasawaTama(c) and c:IsLocation(LOCATION_MZONE)
		and c:IsControler(tp) and c:IsReason(REASON_EFFECT+REASON_BATTLE)
end
function c22220009.reptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToRemove() and eg:IsExists(c22220009.repfilter,1,nil,tp) end
	return Duel.SelectYesNo(tp,aux.Stringid(22220009,1))
end
function c22220009.repval(e,c)
	return c22220009.repfilter(c,e:GetHandlerPlayer())
end
function c22220009.repop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Remove(e:GetHandler(),POS_FACEUP,REASON_EFFECT)
end
function c22220009.cacon(e,tp,eg,ep,ev,re,r,rp)
	local a=Duel.GetAttacker()
	local d=Duel.GetAttackTarget()
	if not d then return false end
	if d:IsControler(tp) then a,d=d,a end
	return c22220009.IsShirasawaTama(a)
		and not a:IsStatus(STATUS_BATTLE_DESTROYED) and d:IsStatus(STATUS_BATTLE_DESTROYED)
end
function c22220009.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and e:GetHandler():IsAbleToHand() end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,e:GetHandler(),1,0,0)
end
function c22220009.caop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	Duel.SendtoHand(c,nil,REASON_EFFECT)
end