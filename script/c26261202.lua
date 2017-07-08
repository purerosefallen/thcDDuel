--魔导机关-魔术研究局
function c26261202.initial_effect(c)
	c:SetUniqueOnField(1,0,26261202)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--search
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(26261202,0))
	e2:SetCategory(CATEGORY_TOHAND)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCountLimit(1)
	e2:SetCost(c26261202.cost)
	e2:SetTarget(c26261202.target)
	e2:SetOperation(c26261202.operation)
	c:RegisterEffect(e2)
	--Draw
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(26261202,1))
	e2:SetCategory(CATEGORY_TOGRAVE)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCountLimit(1)
	e2:SetCondition(c26261202.condition2)
	e2:SetTarget(c26261202.target2)
	e2:SetOperation(c26261202.operation2)
	c:RegisterEffect(e2)
end
c26261202.named_with_Modaojiguan=1
function c26261202.IsModaoqiaoke(c)
	local m=_G["c"..c:GetCode()]
	return m and m.named_with_Modaoqiaoke
end
function c26261202.IsModaozhuangshu(c)
	local m=_G["c"..c:GetCode()]
	return m and m.named_with_Modaozhuangshu
end
function c26261202.IsModaozhanshu(c)
	local m=_G["c"..c:GetCode()]
	return m and m.named_with_Modaozhanshu
end
function c26261202.IsModaojiguan(c)
	local m=_G["c"..c:GetCode()]
	return m and m.named_with_Modaojiguan
end
function c26261202.cfilter(c)
	return (c26261202.IsModaozhuangshu(c) or c26261202.IsModaoqiaoke(c)) and c:IsAbleToRemoveAsCost()
end
function c26261202.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c26261202.cfilter,tp,LOCATION_HAND,0,1,nil) end
	local g=Duel.SelectMatchingCard(tp,c26261202.cfilter,tp,LOCATION_HAND,0,1,1,nil)
	Duel.Remove(g,POS_FACEUP,REASON_COST)
end
function c26261202.tgfilter(c)
	return c26261202.IsModaozhanshu(c) and c:IsAbleToHand()
end
function c26261202.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c26261202.tgfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c26261202.operation(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c26261202.tgfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
function c26261202.condition2(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:GetFirst()
	e:SetLabel(tc:GetCode()+900)
	return eg:GetFirst():GetSummonType()==SUMMON_TYPE_SYNCHRO and eg:GetFirst():IsControler(tp) and c26261202.IsModaoqiaoke(tc)
end
function c26261202.target2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
end
function c26261202.operation2(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local token=Duel.CreateToken(tp,e:GetLabel())
	Duel.SendtoGrave(token,REASON_EFFECT)
end