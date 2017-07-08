--魔导机关-魔导开发部
function c26261201.initial_effect(c)
	c:SetUniqueOnField(1,0,26261201)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c26261201.target)
	e1:SetOperation(c26261201.activate)
	c:RegisterEffect(e1)
	--SearchCard
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_SEARCH+CATEGORY_TOHAND)
	e2:SetDescription(aux.Stringid(26261201,1))
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCountLimit(1)
	e2:SetTarget(c26261201.target2)
	e2:SetOperation(c26261201.activate2)
	c:RegisterEffect(e2)

	
end
c26261201.named_with_Modaojiguan=1
function c26261201.IsModaoqiaoke(c)
	local m=_G["c"..c:GetCode()]
	return m and m.named_with_Modaoqiaoke
end
function c26261201.IsModaojiguan(c)
	local m=_G["c"..c:GetCode()]
	return m and m.named_with_Modaojiguan
end
function c26261201.filter1(c)
	return c26261201.IsModaoqiaoke(c) and c:IsFaceup() and c:IsType(TYPE_MONSTER) and not c:IsDualState()
end
function c26261201.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
end
function c26261201.activate(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	if Duel.IsExistingMatchingCard(c26261201.filter1,tp,LOCATION_MZONE,0,1,nil) and Duel.SelectYesNo(tp,aux.Stringid(26261201,0)) then
		local g=Duel.SelectMatchingCard(tp,c26261201.filter1,tp,LOCATION_MZONE,0,1,1,nil) 
		local tc=g:GetFirst()
		tc:EnableDualState()
	end
end
function c26261201.filter2(c)
	return c26261201.IsModaoqiaoke(c) and c:IsType(TYPE_MONSTER) and c:IsAbleToHand()
end
function c26261201.target2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c26261201.filter2,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c26261201.activate2(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	if Duel.IsExistingMatchingCard(c26261201.filter2,tp,LOCATION_DECK,0,1,nil) then
		local g=Duel.SelectMatchingCard(tp,c26261201.filter2,tp,LOCATION_DECK,0,1,1,nil) 
		local tc=g:GetFirst()
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
		Duel.DiscardHand(tp,Card.IsDiscardable,1,1,REASON_EFFECT,nil)
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_FIELD)
		e1:SetCode(EFFECT_SET_SUMMON_COUNT_LIMIT)
		e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
		e1:SetTargetRange(1,0)
		e1:SetValue(2)
		e1:SetReset(RESET_PHASE+PHASE_END)
		Duel.RegisterEffect(e1,tp)
	end
end

