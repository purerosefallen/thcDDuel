--Grim ジャンヌ
function c21210003.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,21210003)
	e1:SetCondition(c21210003.spcon)
	e1:SetOperation(c21210003.spop)
	c:RegisterEffect(e1)
	--actlimit
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetOperation(c21210003.atkop)
	c:RegisterEffect(e1)
	--avoid damage
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD)
	e4:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e4:SetCode(EFFECT_CHANGE_DAMAGE)
	e4:SetRange(LOCATION_MZONE)
	e4:SetTargetRange(1,0)
	e4:SetValue(c21210003.val)
	c:RegisterEffect(e4)
	--damage
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_SINGLE)
	e6:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e6:SetCode(EVENT_PRE_BATTLE_DAMAGE)
	e6:SetOperation(c21210003.damop)
	c:RegisterEffect(e6)
	--cannot be xyzmat
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_SINGLE)
	e6:SetCode(EFFECT_CANNOT_BE_XYZ_MATERIAL)
	e6:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e6:SetValue(1)
	c:RegisterEffect(e6)
end
c21210003.named_with_Grim=1
function c21210003.IsGrim(c)
	local m=_G["c"..c:GetCode()]
	return m and m.named_with_Grim
end
function c21210003.IsAlice(c)
	local m=_G["c"..c:GetCode()]
	return m and m.named_with_Alice
end
function c21210003.IsRedHat(c)
	local m=_G["c"..c:GetCode()]
	return m and m.named_with_RedHat
end
function c21210003.spfilter(c)
	return c:IsFaceup() and c21210003.IsGrim(c) and c:IsType(TYPE_MONSTER)
end
function c21210003.spcon(e,c)
	if c==nil then return true end
	return Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0 and Duel.IsExistingMatchingCard(c21210003.spfilter,c:GetControler(),LOCATION_MZONE,0,1,nil) and Duel.CheckLPCost(tp,500)
end
function c21210003.spop(e,tp,eg,ep,ev,re,r,rp,chk)
	Duel.PayLPCost(tp,500)
end
function c21210003.atkop(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetOwner())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_SELECT_EFFECT_TARGET)
	e1:SetProperty(EFFECT_FLAG_SET_AVAILABLE)
	e1:SetTargetRange(0,0xff)
	e1:SetValue(c21210003.etarget)
	e1:SetReset(RESET_PHASE+PHASE_DAMAGE)
	Duel.RegisterEffect(e1,tp)
end
function c21210003.etarget(e,re,c)
	return c:IsType(TYPE_MONSTER) and (c:IsFaceup() or c:IsLocation(LOCATION_MZONE)) and c21210003.IsGrim(c)
end
function c21210003.val(e,re,val,r,rp,rc)
	return val*0.7
end
function c21210003.damop(e,tp,eg,ep,ev,re,r,rp)
	Duel.ChangeBattleDamage(1-tp,0,false)
	Duel.ChangeBattleDamage(tp,ev,false)
end


