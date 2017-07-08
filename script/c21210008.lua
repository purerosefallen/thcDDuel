--Grim 赤ずきん（サマー）
function c21210008.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_DECK)
	e1:SetCountLimit(1,21210008)
	e1:SetCondition(c21210008.spcon)
	e1:SetOperation(c21210008.spop)
	c:RegisterEffect(e1)
	--sit
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e3:SetProperty(EFFECT_FLAG_DELAY)
	e3:SetCode(EVENT_SUMMON_SUCCESS)
	e3:SetTarget(c21210008.tg)
	e3:SetOperation(c21210008.op)
	c:RegisterEffect(e3)
	local e4=e3:Clone()
	e4:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e4)
	--spsummon
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_DAMAGE)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_DESTROYED)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e2:SetRange(LOCATION_HAND)
	e2:SetCountLimit(1)
	e2:SetCost(c21210008.cost)
	e2:SetCondition(c21210008.spcon1)
	e2:SetTarget(c21210008.sptg1)
	e2:SetOperation(c21210008.spop1)
	c:RegisterEffect(e2)
	--damage
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_SINGLE)
	e6:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e6:SetCode(EVENT_PRE_BATTLE_DAMAGE)
	e6:SetOperation(c21210008.damop)
	c:RegisterEffect(e6)
	--cannot be xyzmat
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_SINGLE)
	e6:SetCode(EFFECT_CANNOT_BE_XYZ_MATERIAL)
	e6:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e6:SetValue(1)
	c:RegisterEffect(e6)
end
c21210008.named_with_Grim=1
c21210008.named_with_RedHat=1
function c21210008.IsGrim(c)
	local m=_G["c"..c:GetCode()]
	return m and m.named_with_Grim
end
function c21210008.IsAlice(c)
	local m=_G["c"..c:GetCode()]
	return m and m.named_with_Alice
end
function c21210008.IsRedHat(c)
	local m=_G["c"..c:GetCode()]
	return m and m.named_with_RedHat
end
function c21210008.filter(c)
	return c:IsFaceup() and c:IsDisabled()
end
function c21210008.spcon(e,c)
	if c==nil then return true end
	return Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c21210008.filter,c:GetControler(),LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil)
end
function c21210008.spop(e,tp,eg,ep,ev,re,r,rp)
	Duel.PayLPCost(tp,500)
end
function c21210008.tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c21210008.filter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil) end
end
function c21210008.op(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c21210008.filter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,nil)
	Duel.ChangePosition(g,POS_FACEDOWN)
end
function c21210008.cfilter(c,tp)
	return c:IsReason(REASON_BATTLE+REASON_EFFECT) and c21210008.IsGrim(c)
		and c:IsPreviousLocation(LOCATION_MZONE)
end
function c21210008.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,500) end
	Duel.PayLPCost(tp,500)
end
function c21210008.spcon1(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c21210008.cfilter,1,nil,tp)
end
function c21210008.cfilter2(c,tp)
	return c:IsPreviousLocation(LOCATION_ONFIELD) and c:IsAbleToHand() and c:IsType(TYPE_MONSTER) and c21210008.IsGrim(c)
end
function c21210008.sptg1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	local g=eg:Filter(c21210008.cfilter2,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,g:GetCount(),0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c21210008.spop1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local g=eg:Filter(c21210008.cfilter2,nil,e,tp)
	Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
	Duel.SendtoHand(g,nil,REASON_EFFECT)
end
function c21210008.damop(e,tp,eg,ep,ev,re,r,rp)
	Duel.ChangeBattleDamage(1-tp,0,false)
	Duel.ChangeBattleDamage(tp,ev,false)
end