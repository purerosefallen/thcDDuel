--无限つ制
function c74561501.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--Damage
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_DAMAGE)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetProperty(EFFECT_FLAG_DELAY)
	e2:SetCode(EVENT_CUSTOM+74567456)
	e2:SetRange(LOCATION_FZONE)
	e2:SetOperation(c74561501.dop)
	c:RegisterEffect(e2)
	--token
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(74561501,0))
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOKEN)
	e2:SetRange(LOCATION_FZONE)
	e2:SetCountLimit(1,74561501)
	e2:SetCode(EVENT_SUMMON_SUCCESS)
	e2:SetTarget(c74561501.tokentg)
	e2:SetOperation(c74561501.tokenop)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EVENT_FLIP_SUMMON_SUCCESS)
	c:RegisterEffect(e3)
	local e5=e2:Clone()
	e5:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e5)
	--Destroy
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(74561501,1))
	e2:SetCategory(CATEGORY_DESTROY)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_QUICK_F)
	e2:SetCode(EVENT_CHAINING)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e2:SetRange(LOCATION_FZONE)
	e2:SetCountLimit(1)
	e2:SetCondition(c74561501.condition)
	e2:SetTarget(c74561501.target)
	e2:SetOperation(c74561501.operation)
	c:RegisterEffect(e2)
	--immune
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_IMMUNE_EFFECT)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCondition(c74561501.econ)
	e3:SetValue(c74561501.efilter)
	c:RegisterEffect(e3)

end
c74561501.named_with_Die=1
function c74561501.IsDie(c)
	local m=_G["c"..c:GetCode()]
	return m and m.named_with_Die
end
function c74561501.dop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Damage(1-tp,250,REASON_EFFECT)
end
function c74561501.tokentg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>1
		and Duel.IsPlayerCanSpecialSummonMonster(tp,74560012,0,nil,0,0,1,RACE_ZOMBIE,ATTRIBUTE_DARK) end
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,1,0,0)
end
function c74561501.tokenop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and e:GetHandler():IsRelateToEffect(e)
		and Duel.IsPlayerCanSpecialSummonMonster(tp,74560012,0,nil,0,0,1,RACE_ZOMBIE,ATTRIBUTE_DARK) then
		local token=Duel.CreateToken(tp,74560012)
		Duel.SpecialSummonStep(token,0,tp,tp,false,false,POS_FACEUP)
	end
	Duel.SpecialSummonComplete()
end
function c74561501.condition(e,tp,eg,ep,ev,re,r,rp)
	return not re:IsActiveType(TYPE_MONSTER) and not e:GetHandler():IsStatus(STATUS_CHAINING)
end
function c74561501.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_SZONE)>0 end
end
function c74561501.operation(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():IsRelateToEffect(e) then
		local token=Duel.CreateToken(tp,74561201)
		Duel.MoveToField(token,tp,tp,LOCATION_SZONE,POS_FACEDOWN,false)
	end
end
function c74561501.ecfilter(c)
	return c:IsCode(74560012,74561201) and c:IsFaceup()
end
function c74561501.econ(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c74561501.ecfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,3,nil)
end
function c74561501.efilter(e,te)
	return te:GetOwner()~=e:GetOwner()
end
