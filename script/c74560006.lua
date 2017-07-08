--SugarつHuuny
function c74560006.initial_effect(c)
	--negate
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(74560006,0))
	e2:SetCategory(CATEGORY_DISABLE)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_CHAINING)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e2:SetRange(LOCATION_HAND)
	e2:SetCountLimit(1)
	e2:SetCondition(c74560006.negcon)
	e2:SetCost(c74560006.negcost)
	e2:SetTarget(c74560006.negtg)
	e2:SetOperation(c74560006.negop)
	c:RegisterEffect(e2)
	--indes
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_INDESTRUCTABLE_COUNT)
	e1:SetCountLimit(1)
	e1:SetValue(c74560006.valcon)
	c:RegisterEffect(e1)
	--Draw
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_DRAW)
	e3:SetDescription(aux.Stringid(74560006,1))
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e3:SetCode(EVENT_SUMMON_SUCCESS)
	e3:SetTarget(c74560006.tg)
	e3:SetOperation(c74560006.op)
	c:RegisterEffect(e3)
	local e4=e3:Clone()
	e4:SetCode(EVENT_FLIP)
	c:RegisterEffect(e4)
end
c74560006.named_with_Die=1
function c74560006.IsDie(c)
	local m=_G["c"..c:GetCode()]
	return m and m.named_with_Die
end
function c74560006.negcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SendtoDeck(e:GetHandler(),tp,-1,REASON_COST)
	Duel.RaiseEvent(e:GetHandler(),EVENT_CUSTOM+74567456,e,0,tp,0,0)
end
function c74560006.tfilter(c)
	return c:IsLocation(LOCATION_MZONE) and c:IsFaceup() and (c74560006.IsDie(c) or c:IsCode(74560012))
end
function c74560006.negcon(e,tp,eg,ep,ev,re,r,rp)
	if not re:IsHasProperty(EFFECT_FLAG_CARD_TARGET) then return false end
	local g=Duel.GetChainInfo(ev,CHAININFO_TARGET_CARDS)
	if g:IsExists(c74560006.tfilter,1,nil) then return true
	else return false end
end
function c74560006.negtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DISABLE,eg,1,0,0)
end
function c74560006.negop(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateEffect(ev)
	Duel.Draw(tp,1,REASON_EFFECT)
end
function c74560006.valcon(e,re,r,rp)
	return bit.band(r,REASON_BATTLE+REASON_EFFECT)~=0
end
function c74560006.tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(nil,tp,LOCATION_HAND+LOCATION_ONFIELD,0,1,nil) and Duel.IsPlayerCanDraw(tp,1) end
end
function c74560006.filterc(c)
	return c74560006.IsDie(c) or c:IsCode(74560012)
end
function c74560006.op(e,tp,eg,ep,ev,re,r,rp)
	Duel.Draw(tp,1,REASON_EFFECT)
	local g=Duel.SelectMatchingCard(tp,c74560006.filterc,tp,LOCATION_ONFIELD+LOCATION_HAND,0,1,1,nil)
	Duel.SendtoDeck(g,nil,-1,REASON_EFFECT)
	Duel.RaiseEvent(g,EVENT_CUSTOM+74567456,e,0,tp,0,0)
end