--魔导巧壳-露恩
function c26260002.initial_effect(c)
	aux.EnableDualAttribute(c)
	--search
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(26260002,0))
	e4:SetCategory(CATEGORY_TODECK+CATEGORY_DRAW)
	e4:SetType(EFFECT_TYPE_QUICK_O)
	e4:SetCode(EVENT_FREE_CHAIN)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCountLimit(1)
	e4:SetCondition(aux.IsDualState)
	e4:SetCost(c26260002.cost)
	e4:SetTarget(c26260002.target)
	e4:SetOperation(c26260002.operation)
	c:RegisterEffect(e4)
end
c26260002.named_with_Modaoqiaoke=1
function c26260002.IsModaoqiaoke(c)
	local m=_G["c"..c:GetCode()]
	return m and m.named_with_Modaoqiaoke
end
function c26260002.IsModaozhuangshu(c)
	local m=_G["c"..c:GetCode()]
	return m and m.named_with_Modaozhuangshu
end
function c26260002.IsModaozhanshu(c)
	local m=_G["c"..c:GetCode()]
	return m and m.named_with_Modaozhanshu
end
function c26260002.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToRemove() end
	Duel.Remove(e:GetHandler(),POS_FACEUP,REASON_COST)
end
function c26260002.filter(c)
	return (c26260002.IsModaozhuangshu(c) or c26260002.IsModaozhanshu(c) or c26260002.IsModaoqiaoke(c)) and c:IsAbleToDeck()
end
function c26260002.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c26260002.filter,tp,LOCATION_GRAVE+LOCATION_REMOVED,0,3,nil) and Duel.IsPlayerCanDraw(tp,2) end
	Duel.SetOperationInfo(0,CATEGORY_TODECK,nil,3,tp,LOCATION_GRAVE+LOCATION_REMOVED)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,2,tp,nil)
end
function c26260002.operation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.IsExistingMatchingCard(c26260002.filter,tp,LOCATION_GRAVE+LOCATION_REMOVED,0,3,nil) then
		local g=Duel.SelectMatchingCard(tp,c26260002.filter,tp,LOCATION_GRAVE+LOCATION_REMOVED,0,3,3,nil)
		Duel.SendtoDeck(g,nil,2,REASON_EFFECT)
		Duel.ShuffleDeck(tp)
		Duel.Draw(tp,2,REASON_EFFECT)
	end
end

