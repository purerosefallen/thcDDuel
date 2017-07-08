--JibrilつChefdoeuvre
function c74561101.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOKEN)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,74561101+EFFECT_COUNT_CODE_OATH)
	e1:SetCondition(c74561101.condition)
	e1:SetTarget(c74561101.target)
	e1:SetOperation(c74561101.activate)
	c:RegisterEffect(e1)
end
c74561101.named_with_Die=1
function c74561101.IsDie(c)
	local m=_G["c"..c:GetCode()]
	return m and m.named_with_Die
end
function c74561101.cfilter(c)
	return c:IsFaceup() and c:IsCode(74561501)
end
function c74561101.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c74561101.cfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil)
end
function c74561101.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local ct=Duel.GetLocationCount(tp,LOCATION_MZONE)
	if chk==0 then return ct>1 and Duel.IsPlayerCanSpecialSummonMonster(tp,74560012,nil,0x4011,0,0,1,RACE_ZOMBIE,ATTRIBUTE_DARK) end
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,ct,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,ct,0,0)
end
function c74561101.activate(e,tp,eg,ep,ev,re,r,rp)
	local ct1=Duel.GetLocationCount(tp,LOCATION_MZONE)
	if ct1<=1 then return end
	if Duel.IsPlayerCanSpecialSummonMonster(tp,74560012,nil,0x4011,0,0,1,RACE_ZOMBIE,ATTRIBUTE_DARK) then
		for i = 1,ct1-1 do
			local token=Duel.CreateToken(tp,74560012)
			Duel.SpecialSummonStep(token,0,tp,tp,false,false,POS_FACEUP)
		end
		Duel.SpecialSummonComplete()
	end
end