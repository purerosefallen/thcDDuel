--Grim 鏡の国の赤ずきん
function c21210006.initial_effect(c)
	c:EnableReviveLimit()
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c21210006.ttcon)
	e1:SetOperation(c21210006.ttop)
	c:RegisterEffect(e1)
	--cannot special summon
	local e3=Effect.CreateEffect(c)
	e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_SPSUMMON_CONDITION)
	c:RegisterEffect(e3)
	--recover
	local e5=Effect.CreateEffect(c)
	e5:SetCategory(CATEGORY_ATKCHANGE)
	e5:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e5:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e5:SetRange(LOCATION_MZONE)
	e5:SetCountLimit(1)
	e5:SetTarget(c21210006.rctg)
	e5:SetOperation(c21210006.rcop)
	c:RegisterEffect(e5)
	--damage
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_SINGLE)
	e6:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e6:SetCode(EVENT_PRE_BATTLE_DAMAGE)
	e6:SetOperation(c21210006.damop)
	c:RegisterEffect(e6)
	--cannot be xyzmat
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_SINGLE)
	e6:SetCode(EFFECT_CANNOT_BE_XYZ_MATERIAL)
	e6:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e6:SetValue(1)
	c:RegisterEffect(e6)
end
c21210006.named_with_Grim=1
c21210006.named_with_RedHat=1
function c21210006.IsGrim(c)
	local m=_G["c"..c:GetCode()]
	return m and m.named_with_Grim
end
function c21210006.IsAlice(c)
	local m=_G["c"..c:GetCode()]
	return m and m.named_with_Alice
end
function c21210006.IsRedHat(c)
	local m=_G["c"..c:GetCode()]
	return m and m.named_with_RedHat
end
function c21210006.ntfilter(c)
	return (c:GetLevel()==4 or c:GetRank()==4) and c:IsAbleToRemoveAsCost()
end
function c21210006.ttcon(e,c)
	if c==nil then return true end
	return Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>-1
		and Duel.IsExistingMatchingCard(c21210006.ntfilter,c:GetControler(),LOCATION_MZONE,0,1,nil)
		and Duel.IsExistingMatchingCard(c21210006.ntfilter,1-c:GetControler(),LOCATION_MZONE,0,1,nil)
end
function c21210006.ttop(e,tp,eg,ep,ev,re,r,rp,c)
	local g=Group.CreateGroup()
	local g2=Duel.SelectMatchingCard(tp,c21210006.ntfilter,c:GetControler(),LOCATION_MZONE,0,1,1,nil)
		g:Merge(g2)
	local g3=Duel.SelectMatchingCard(tp,c21210006.ntfilter,1-c:GetControler(),LOCATION_MZONE,0,1,1,nil)
		g:Merge(g3)
	Duel.Remove(g,POS_FACEUP,REASON_COST)
end
function c21210006.rctg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
end
function c21210006.tgfilter(c)
	return c:IsFaceup() and c21210006.IsGrim(c) and c:IsType(TYPE_MONSTER)
end
function c21210006.rcop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c21210006.tgfilter,tp,LOCATION_MZONE,0,nil)
	local tc=g:GetFirst()
	while tc do
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_BASE_ATTACK)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		e1:SetValue(tc:GetBaseAttack()+300)
		tc:RegisterEffect(e1)
		tc=g:GetNext()
	end
end
function c21210006.damop(e,tp,eg,ep,ev,re,r,rp)
	Duel.ChangeBattleDamage(1-tp,0,false)
	Duel.ChangeBattleDamage(tp,ev,false)
end