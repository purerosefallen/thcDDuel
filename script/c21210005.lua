--Grim 鏡の国のアリス
function c21210005.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,21210005)
	e1:SetCondition(c21210005.spcon)
	e1:SetOperation(c21210005.spop)
	c:RegisterEffect(e1)
	--atk
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(LOCATION_MZONE,0)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetTarget(aux.TargetBoolFunction(c21210005.tgfilter))
	e2:SetValue(c21210005.val)
	c:RegisterEffect(e2)
	--tohand
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(21210005,0))
	e3:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_HAND)
	e3:SetCountLimit(1)
	e3:SetCost(c21210005.cost)
	e3:SetTarget(c21210005.target)
	e3:SetOperation(c21210005.operation)
	c:RegisterEffect(e3)
	--spsummon
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(21210005,1))
	e4:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e4:SetCode(EVENT_BATTLED)
	e4:SetRange(LOCATION_HAND)
	e4:SetCountLimit(1)
	e4:SetCondition(c21210005.cacon)
	e4:SetTarget(c21210005.sptg)
	e4:SetOperation(c21210005.caop)
	c:RegisterEffect(e4)
	--damage
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_SINGLE)
	e6:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e6:SetCode(EVENT_PRE_BATTLE_DAMAGE)
	e6:SetOperation(c21210005.damop)
	c:RegisterEffect(e6)
	--cannot be xyzmat
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_SINGLE)
	e6:SetCode(EFFECT_CANNOT_BE_XYZ_MATERIAL)
	e6:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e6:SetValue(1)
	c:RegisterEffect(e6)
end
c21210005.named_with_Grim=1
c21210005.named_with_Alice=1
function c21210005.IsGrim(c)
	local m=_G["c"..c:GetCode()]
	return m and m.named_with_Grim
end
function c21210005.IsAlice(c)
	local m=_G["c"..c:GetCode()]
	return m and m.named_with_Alice
end
function c21210005.IsRedHat(c)
	local m=_G["c"..c:GetCode()]
	return m and m.named_with_RedHat
end
function c21210005.spfilter(c)
	return c:IsFaceup() and c21210005.IsGrim(c) and c:IsType(TYPE_MONSTER)
end
function c21210005.spcon(e,c)
	if c==nil then return true end
	return Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0 and Duel.IsExistingMatchingCard(c21210005.spfilter,c:GetControler(),LOCATION_MZONE,0,1,nil) and Duel.CheckLPCost(tp,500)
end
function c21210005.spop(e,tp,eg,ep,ev,re,r,rp,chk)
	Duel.PayLPCost(tp,500)
end
function c21210005.vfilter(c)
	return c:IsFaceup() and c21210005.IsAlice(c) and c:IsType(TYPE_MONSTER)
end
function c21210005.val(e,c)
	return Duel.GetMatchingGroupCount(c21210005.vfilter,tp,LOCATION_MZONE,0,nil)*200
end
function c21210005.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,500) end
	Duel.PayLPCost(tp,500)
	Duel.Remove(e:GetHandler(),POS_FACEUP,REASON_COST)
end
function c21210005.filter(c)
	return c21210005.IsGrim(c) and c:IsType(TYPE_MONSTER) and c:IsAbleToHand()
end
function c21210005.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c21210005.filter,tp,LOCATION_DECK+LOCATION_REMOVED,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK+LOCATION_REMOVED)
end
function c21210005.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c21210005.filter,tp,LOCATION_DECK+LOCATION_REMOVED,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
function c21210005.tgfilter(c)
	return c:IsFaceup() and c21210005.IsGrim(c) and c:IsType(TYPE_MONSTER)
end
function c21210005.cacon(e,tp,eg,ep,ev,re,r,rp)
	local a=Duel.GetAttacker()
	local d=Duel.GetAttackTarget()
	if not d then return false end
	if not c21210005.IsGrim(a) then return false end
	if a:IsStatus(STATUS_OPPO_BATTLE) and d:IsControler(tp) and c21210005.IsGrim(d) then a,d=d,a end
	return not a:IsStatus(STATUS_BATTLE_DESTROYED) and d:IsStatus(STATUS_BATTLE_DESTROYED)
end
function c21210005.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c21210005.caop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and Duel.GetLocationCount(tp,LOCATION_MZONE)>0 then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(300)
		e1:SetReset(RESET_EVENT+0xfe0000)
		c:RegisterEffect(e1)
		Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
	end
end
function c21210005.damop(e,tp,eg,ep,ev,re,r,rp)
	Duel.ChangeBattleDamage(1-tp,0,false)
	Duel.ChangeBattleDamage(tp,ev,false)
end