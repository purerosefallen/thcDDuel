--魔导巧壳-贝露
function c26260004.initial_effect(c)
	aux.EnableDualAttribute(c)
	--search
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(26260004,0))
	e4:SetCategory(CATEGORY_TOHAND)
	e4:SetType(EFFECT_TYPE_QUICK_O)
	e4:SetCode(EVENT_FREE_CHAIN)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCountLimit(1)
	e4:SetCondition(aux.IsDualState)
	e4:SetCost(c26260004.cost)
	e4:SetTarget(c26260004.target)
	e4:SetOperation(c26260004.operation)
	c:RegisterEffect(e4)
end
c26260004.named_with_Modaoqiaoke=1
function c26260004.IsModaoqiaoke(c)
	local m=_G["c"..c:GetCode()]
	return m and m.named_with_Modaoqiaoke
end
function c26260004.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToRemove() end
	Duel.Remove(e:GetHandler(),POS_FACEUP,REASON_COST)
end
function c26260004.filter(c)
	return c:IsType(TYPE_SPELL) or c:IsType(TYPE_TRAP)
end
function c26260004.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c26260004.filter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil) end
end
function c26260004.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local g=Duel.GetMatchingGroup(c26260004.filter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,nil)
	Duel.SendtoHand(g,nil,REASON_EFFECT)
end