--Grim カオス·アリス
function c21210012.initial_effect(c)
	c:EnableReviveLimit()
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c21210012.ttcon)
	e1:SetOperation(c21210012.ttop)
	c:RegisterEffect(e1)
	--cannot special summon
	local e3=Effect.CreateEffect(c)
	e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_SPSUMMON_CONDITION)
	c:RegisterEffect(e3)
	--base def
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SET_BASE_ATTACK)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetValue(c21210012.atkval)
	c:RegisterEffect(e1)
	--base atk
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SET_BASE_DEFENSE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetValue(c21210012.atkval)
	c:RegisterEffect(e1)
	--immune
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetCode(EFFECT_IMMUNE_EFFECT)
	e2:SetRange(LOCATION_MZONE)
	e2:SetValue(c21210012.efilter)
	c:RegisterEffect(e2)
	--disable
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(21210012,0))
	e3:SetCategory(CATEGORY_DESTROY+CATEGORY_DISABLE)
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetCode(EVENT_CHAINING)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1)
	e3:SetCondition(c21210012.discon)
	e3:SetCost(c21210012.discost)
	e3:SetTarget(c21210012.distg)
	e3:SetOperation(c21210012.disop)
	c:RegisterEffect(e3)
	--Cost Change
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_LPCOST_CHANGE)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(1,0)
	e2:SetValue(c21210012.costchange)
	c:RegisterEffect(e2)
	--damage
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_SINGLE)
	e6:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e6:SetCode(EVENT_PRE_BATTLE_DAMAGE)
	e6:SetOperation(c21210012.damop)
	c:RegisterEffect(e6)
	--cannot be xyzmat
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_SINGLE)
	e6:SetCode(EFFECT_CANNOT_BE_XYZ_MATERIAL)
	e6:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e6:SetValue(1)
	c:RegisterEffect(e6)
end
c21210012.named_with_Grim=1
c21210012.named_with_Alice=1
function c21210012.IsGrim(c)
	local m=_G["c"..c:GetCode()]
	return m and m.named_with_Grim
end
function c21210012.IsAlice(c)
	local m=_G["c"..c:GetCode()]
	return m and m.named_with_Alice
end
function c21210012.IsRedHat(c)
	local m=_G["c"..c:GetCode()]
	return m and m.named_with_RedHat
end
function c21210012.spfilter(c)
	return c21210012.IsAlice(c) and c:IsType(TYPE_MONSTER) and c:IsAbleToRemoveAsCost()
end
function c21210012.ttcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c21210012.spfilter,tp,LOCATION_GRAVE+LOCATION_ONFIELD,0,1,nil)
end
function c21210012.ttop(e,c)
	local tp=e:GetHandler():GetControler()
	local g=Duel.GetMatchingGroup(c21210012.spfilter,tp,LOCATION_GRAVE+LOCATION_ONFIELD,0,nil)
	Duel.Remove(g,POS_FACEUP,REASON_COST)
end
function c21210012.valfilter(c)
	return c:IsFaceup() and c21210012.IsAlice(c)
end
function c21210012.atkval(e,c)
	return Duel.GetMatchingGroupCount(c21210012.valfilter,c:GetControler(),LOCATION_REMOVED,0,nil)*800
end
function c21210012.efilter(e,te)
	return te:IsActiveType(TYPE_SPELL+TYPE_TRAP)
end
function c21210012.discon(e,tp,eg,ep,ev,re,r,rp)
	return not e:GetHandler():IsStatus(STATUS_BATTLE_DESTROYED)
		and ep~=tp and re:IsActiveType(TYPE_MONSTER) and Duel.IsChainNegatable(ev)
end
function c21210012.cfilter(c)
	return c21210012.IsAlice(c) and c:IsType(TYPE_MONSTER) and c:IsAbleToDeckAsCost() and c:IsFaceup()
end
function c21210012.discost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c21210012.cfilter,tp,LOCATION_REMOVED,0,1,nil) end
	local g=Duel.SelectMatchingCard(tp,c21210012.cfilter,tp,LOCATION_REMOVED,0,1,1,nil)
	Duel.SendtoDeck(g,nil,2,REASON_COST)
end
function c21210012.distg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DISABLE,eg,1,0,0)
	local g=Duel.GetMatchingGroup(aux.TRUE,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c21210012.disop(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateEffect(ev)
	Duel.SendtoHand(eg,nil,REASON_EFFECT)
end
function c21210012.costchange(e,re,rp,val)
	if re and re:IsActiveType(TYPE_MONSTER) and c21210012.IsGrim(re:GetHandler()) then
		return 0
	else
		return val
	end
end
function c21210012.damop(e,tp,eg,ep,ev,re,r,rp)
	Duel.ChangeBattleDamage(1-tp,0,false)
	Duel.ChangeBattleDamage(tp,ev,false)
end