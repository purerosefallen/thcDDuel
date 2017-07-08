--魔導巧殼-艾露
function c26260001.initial_effect(c)
	aux.EnableDualAttribute(c)
	--search
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(26260001,0))
	e4:SetCategory(CATEGORY_SEARCH)
	e4:SetType(EFFECT_TYPE_IGNITION)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCountLimit(1)
	e4:SetProperty(EFFECT_FLAG_NO_TURN_RESET)
	e4:SetCondition(aux.IsDualState)
	e4:SetTarget(c26260001.target)
	e4:SetOperation(c26260001.operation)
	c:RegisterEffect(e4)
	--active
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(26260001,1))
	e2:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_BE_BATTLE_TARGET)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetCondition(aux.IsDualState)
	e2:SetCost(c26260001.cost2)
	e2:SetTarget(c26260001.target2)
	e2:SetOperation(c26260001.operation2)
	c:RegisterEffect(e2)
end
c26260001.named_with_Modaoqiaoke=1
c26260001.named_with_Elu=1
function c26260001.IsModaoqiaoke(c)
	local m=_G["c"..c:GetCode()]
	return m and m.named_with_Modaoqiaoke
end
function c26260001.IsModaozhuangshu(c)
	local m=_G["c"..c:GetCode()]
	return m and m.named_with_Modaozhuangshu
end
function c26260001.IsModaozhanshu(c)
	local m=_G["c"..c:GetCode()]
	return m and m.named_with_Modaozhanshu
end
function c26260001.IsElu(c)
	local m=_G["c"..c:GetCode()]
	return m and m.named_with_Elu
end
function c26260001.thfilter(c)
	return (c26260001.IsModaozhuangshu(c) or c26260001.IsModaozhanshu(c)) and c:IsAbleToHand() and c:IsType(TYPE_SPELL)
end
function c26260001.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c26260001.thfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c26260001.operation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.IsExistingMatchingCard(c26260001.thfilter,tp,LOCATION_DECK,0,1,nil) then
		local g=Duel.SelectMatchingCard(tp,c26260001.thfilter,tp,LOCATION_DECK,0,1,1,nil)
		Duel.SendtoHand(g,tp,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
function c26260001.cost2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsAbleToGraveAsCost,tp,LOCATION_DECK,0,1,nil) end
	local g=Duel.GetDecktopGroup(tp,1)
	Duel.SendtoGrave(g,REASON_COST)
end
function c26260001.filter(c)
	return (c26260001.IsModaozhuangshu(c) or c26260001.IsModaozhanshu(c)) and c:IsSSetable() and c:IsType(TYPE_SPELL)
end
function c26260001.target2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c26260001.filter,tp,LOCATION_DECK+LOCATION_REMOVED,0,1,nil,tp) end
end
function c26260001.operation2(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.SelectMatchingCard(tp,c26260001.filter,tp,LOCATION_DECK+LOCATION_REMOVED,0,1,1,nil,tp)
	local tc=g:GetFirst()
	if tc then
		Duel.SSet(tp,tc)
	end
end