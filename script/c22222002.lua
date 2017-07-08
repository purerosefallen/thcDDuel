--白泽球的落穴
function c22222002.initial_effect(c)
	 --Activate(summon)
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY+CATEGORY_REMOVE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetCondition(c22222002.condition)
	e1:SetTarget(c22222002.target)
	e1:SetOperation(c22222002.activate)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_DESTROY+CATEGORY_REMOVE)
	e2:SetType(EFFECT_TYPE_ACTIVATE)
	e2:SetCode(EVENT_FLIP_SUMMON_SUCCESS)
	e2:SetCondition(c22222002.condition)
	e2:SetTarget(c22222002.target)
	e2:SetOperation(c22222002.activate)
	c:RegisterEffect(e2)
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_DESTROY+CATEGORY_REMOVE)
	e3:SetType(EFFECT_TYPE_ACTIVATE)
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	e3:SetCondition(c22222002.condition)
	e3:SetTarget(c22222002.target2)
	e3:SetOperation(c22222002.activate2)
	c:RegisterEffect(e3)
end
c22222002.named_with_Shirasawa_Tama=1
function c22222002.IsShirasawaTama(c)
	local m=_G["c"..c:GetCode()]
	return m and m.named_with_Shirasawa_Tama
end
function c22222002.cfilter(c)
	return c:IsFaceup() and c22222002.IsShirasawaTama(c)
end
function c22222002.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c22222002.cfilter,tp,LOCATION_ONFIELD,0,1,nil)
end
function c22222002.filter(c,tp,ep)
	return c:IsLocation(LOCATION_MZONE) and c:IsFaceup()
		and ep~=tp
end
function c22222002.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local tc=eg:GetFirst()
	if chk==0 then return c22222002.filter(tc,tp,ep) end
	Duel.SetTargetCard(eg)
	Duel.SetOperationInfo(0,CATEGORY_ATKCHANGE,tc,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_DEFCHANGE,tc,1,0,0)
end
function c22222002.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:GetFirst()
		Duel.NegateRelatedChain(tc,RESET_TURN_SET)
		local e1=Effect.CreateEffect(tc)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_ATTACK)
		e1:SetValue(300)
		tc:RegisterEffect(e1)
		local e1=Effect.CreateEffect(tc)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_DEFENSE)
		e1:SetValue(200)
		tc:RegisterEffect(e1)
		local e2=Effect.CreateEffect(tc)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_CANNOT_TRIGGER)
		e2:SetReset(RESET_EVENT+0x1fe0000)
		e2:SetValue(1)
		tc:RegisterEffect(e2)
end
function c22222002.filter2(c,tp)
	return c:IsLocation(LOCATION_MZONE) and c:IsFaceup() and c:GetSummonPlayer()~=tp
end
function c22222002.target2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return eg:IsExists(c22222002.filter2,1,nil,tp) end
	local g=eg:Filter(c22222002.filter2,nil,tp)
	Duel.SetTargetCard(eg)
	Duel.SetOperationInfo(0,CATEGORY_ATKCHANGE,tc,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_DEFCHANGE,tc,1,0,0)
end
function c22222002.filter3(c,e,tp)
	return c:IsFaceup() and c:GetSummonPlayer()~=tp
		and c:IsRelateToEffect(e) and c:IsLocation(LOCATION_MZONE)
end
function c22222002.activate2(e,tp,eg,ep,ev,re,r,rp)
	local g=eg:Filter(c22222002.filter3,nil,e,tp)
	local tc=g:GetFirst()
	while tc do
		local e1=Effect.CreateEffect(tc)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_ATTACK)
		e1:SetValue(300)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e1)
		local e1=Effect.CreateEffect(tc)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_DEFENSE)
		e1:SetValue(200)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e1)
		local e2=Effect.CreateEffect(tc)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_CANNOT_TRIGGER)
		e2:SetReset(RESET_EVENT+0x1fe0000)
		e2:SetValue(1)
		tc:RegisterEffect(e2)
		tc=g:GetNext()
	end
end