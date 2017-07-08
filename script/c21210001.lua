--Grim 不思議の国のアリス
function c21210001.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,21210001)
	e1:SetCondition(c21210001.spcon)
	e1:SetOperation(c21210001.spop)
	c:RegisterEffect(e1)
	--atkup
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetValue(c21210001.val)
	c:RegisterEffect(e2)
	--battle
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(21210001, 0))
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_DAMAGE_STEP_END)
	e2:SetCountLimit(1)
	e2:SetCost(c21210001.atcost)
	e2:SetTarget(c21210001.attg)
	e2:SetOperation(c21210001.atop)
	c:RegisterEffect(e2)
	--damage
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_SINGLE)
	e6:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e6:SetCode(EVENT_PRE_BATTLE_DAMAGE)
	e6:SetOperation(c21210001.damop)
	c:RegisterEffect(e6)
	--cannot be xyzmat
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_SINGLE)
	e6:SetCode(EFFECT_CANNOT_BE_XYZ_MATERIAL)
	e6:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e6:SetValue(1)
	c:RegisterEffect(e6)
end
c21210001.named_with_Grim=1
c21210001.named_with_Alice=1
function c21210001.IsGrim(c)
	local m=_G["c"..c:GetCode()]
	return m and m.named_with_Grim
end
function c21210001.IsAlice(c)
	local m=_G["c"..c:GetCode()]
	return m and m.named_with_Alice
end
function c21210001.IsRedHat(c)
	local m=_G["c"..c:GetCode()]
	return m and m.named_with_RedHat
end
function c21210001.spfilter(c)
	return c:IsFaceup() and c21210001.IsGrim(c) and c:IsType(TYPE_MONSTER)
end
function c21210001.spcon(e,c)
	if c==nil then return true end
	return Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0 and Duel.IsExistingMatchingCard(c21210001.spfilter,c:GetControler(),LOCATION_MZONE,0,1,nil) and Duel.CheckLPCost(tp,500)
end
function c21210001.spop(e,tp,eg,ep,ev,re,r,rp,chk)
	Duel.PayLPCost(tp,500)
end
function c21210001.val(e,c)
	return Duel.GetFieldGroupCount(c:GetControler(),0,LOCATION_MZONE)*300
end
function c21210001.atcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,500) end
	Duel.PayLPCost(tp,500)
end
function c21210001.attg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsLocation(LOCATION_MZONE) and e:GetHandler():IsChainAttackable() end
end
function c21210001.atop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToBattle() then return end
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetCode(EFFECT_EXTRA_ATTACK)
	e1:SetValue(1)
	e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_BATTLE)
	c:RegisterEffect(e1)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_CANNOT_DIRECT_ATTACK)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_BATTLE)
	c:RegisterEffect(e1)
end
function c21210001.damop(e,tp,eg,ep,ev,re,r,rp)
	Duel.ChangeBattleDamage(1-tp,0,false)
	Duel.ChangeBattleDamage(tp,ev,false)
end
