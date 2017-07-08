--魔导机关-兵器制造所
function c26261203.initial_effect(c)
	c:SetUniqueOnField(1,0,26261203)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--Remove
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_REMOVE)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCode(EVENT_REMOVE)
	e2:SetCondition(c26261203.condition)
	e2:SetOperation(c26261203.operation)
	c:RegisterEffect(e2)
	--Remove
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_REMOVE+CATEGORY_DRAW)
	e2:SetDescription(aux.Stringid(26261203,1))
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCountLimit(1)
	e2:SetTarget(c26261203.target2)
	e2:SetOperation(c26261203.activate2)
	c:RegisterEffect(e2)
end
c26261203.named_with_Modaojiguan=1
function c26261203.IsModaozhuangshu(c)
	local m=_G["c"..c:GetCode()]
	return m and m.named_with_Modaozhuangshu
end
function c26261203.IsModaojiguan(c)
	local m=_G["c"..c:GetCode()]
	return m and m.named_with_Modaojiguan
end
function c26261203.cfilter(c,tp)
	return c26261203.IsModaozhuangshu(c) and c:GetPreviousControler()==tp
end
function c26261203.condition(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c26261203.cfilter,1,nil,tp) and Duel.IsExistingMatchingCard(Card.IsAbleToRemove,tp,LOCATION_GRAVE,0,2,nil)
end
function c26261203.operation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.SelectYesNo(tp,aux.Stringid(26261203,0)) then
		local g=Duel.SelectMatchingCard(tp,Card.IsAbleToRemove,tp,LOCATION_GRAVE,0,2,2,nil)
		Duel.Remove(g,POS_FACEUP,REASON_EFFECT)
	end
end
function c26261203.filter2(c)
	return c26261203.IsModaozhuangshu(c) and c:IsAbleToRemove()
end
function c26261203.target2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c26261203.filter2,tp,LOCATION_HAND+LOCATION_ONFIELD,0,1,nil) end
	local g=Duel.GetMatchingGroup(c26261203.filter2,tp,LOCATION_HAND+LOCATION_ONFIELD,0,nil)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,g:GetCount(),tp,LOCATION_HAND+LOCATION_ONFIELD)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c26261203.activate2(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local g=Duel.GetFieldGroup(tp,LOCATION_ONFIELD+LOCATION_HAND,0)
	local fg=g:Filter(c26261203.filter2,nil)
	if fg:GetCount()==0 then return end
	Duel.Remove(fg,POS_FACEUP,REASON_EFFECT)
	Duel.BreakEffect()
	Duel.Draw(tp,fg:GetCount(),REASON_EFFECT)
end




