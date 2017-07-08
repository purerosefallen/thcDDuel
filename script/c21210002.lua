--Grim 赤ずきん
function c21210002.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,21210002)
	e1:SetCondition(c21210002.spcon)
	e1:SetOperation(c21210002.spop)
	c:RegisterEffect(e1)
	--destroy
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_DAMAGE)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e3:SetCode(EVENT_SUMMON_SUCCESS)
	e3:SetTarget(c21210002.damtg)
	e3:SetOperation(c21210002.damop)
	c:RegisterEffect(e3)
	local e4=e3:Clone()
	e4:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e4)
	--atk
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(LOCATION_MZONE,0)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetCondition(c21210002.con1)
	e2:SetTarget(aux.TargetBoolFunction(Card.IsAttribute,ATTRIBUTE_FIRE))
	e2:SetValue(c21210002.val)
	c:RegisterEffect(e2)
	local e5=e2:Clone()
	e5:SetCondition(c21210002.con2)
	e5:SetTarget(aux.TargetBoolFunction(Card.IsFaceup))
	c:RegisterEffect(e5)
	--damage
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_SINGLE)
	e6:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e6:SetCode(EVENT_PRE_BATTLE_DAMAGE)
	e6:SetOperation(c21210002.damop)
	c:RegisterEffect(e6)
	--cannot be xyzmat
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_SINGLE)
	e6:SetCode(EFFECT_CANNOT_BE_XYZ_MATERIAL)
	e6:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e6:SetValue(1)
	c:RegisterEffect(e6)
end
c21210002.named_with_Grim=1
c21210002.named_with_RedHat=1
function c21210002.IsGrim(c)
	local m=_G["c"..c:GetCode()]
	return m and m.named_with_Grim
end
function c21210002.IsAlice(c)
	local m=_G["c"..c:GetCode()]
	return m and m.named_with_Alice
end
function c21210002.IsRedHat(c)
	local m=_G["c"..c:GetCode()]
	return m and m.named_with_RedHat
end
function c21210002.spfilter(c)
	return c:IsFaceup() and c21210002.IsGrim(c) and c:IsType(TYPE_MONSTER)
end
function c21210002.spcon(e,c)
	if c==nil then return true end
	return Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0 and Duel.IsExistingMatchingCard(c21210002.spfilter,c:GetControler(),LOCATION_MZONE,0,1,nil) and Duel.CheckLPCost(tp,500)
end
function c21210002.spop(e,tp,eg,ep,ev,re,r,rp,chk)
	Duel.PayLPCost(tp,500)
end
function c21210002.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local m=Duel.GetFieldGroupCount(e:GetHandler():GetControler(),0,LOCATION_MZONE)*300
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(m)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,m)
end
function c21210002.damop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Damage(p,d,REASON_EFFECT)
end
function c21210002.con1(e)
	local tp=e:GetHandlerPlayer()
	return Duel.GetLP(tp)>Duel.GetLP(1-tp)
end
function c21210002.con2(e)
	local tp=e:GetHandlerPlayer()
	return Duel.GetLP(tp)<=Duel.GetLP(1-tp)
end
function c21210002.val(e,c)
	return c:GetBaseAttack()*.3
end
function c21210002.damop(e,tp,eg,ep,ev,re,r,rp)
	Duel.ChangeBattleDamage(1-tp,0,false)
	Duel.ChangeBattleDamage(tp,ev,false)
end
