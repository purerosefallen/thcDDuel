--Grim アリス（サマー）
function c21210007.initial_effect(c)
	--SpecialSummon
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(21210007,0))
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1)
	e3:SetCost(c21210007.cost)
	e3:SetTarget(c21210007.target)
	e3:SetOperation(c21210007.operation)
	c:RegisterEffect(e3)
	--search
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(21210007,1))
	e2:SetCategory(CATEGORY_ATKCHANGE)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_BE_BATTLE_TARGET)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCost(c21210007.cost2)
	e2:SetTarget(c21210007.tg)
	e2:SetOperation(c21210007.op)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EVENT_BECOME_TARGET)
	e3:SetCondition(c21210007.condition)
	c:RegisterEffect(e3)
	--atk
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(LOCATION_MZONE,0)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetTarget(aux.TargetBoolFunction(c21210007.filter))
	e2:SetValue(c21210007.val)
	c:RegisterEffect(e2)
	--damage
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_SINGLE)
	e6:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e6:SetCode(EVENT_PRE_BATTLE_DAMAGE)
	e6:SetOperation(c21210007.damop)
	c:RegisterEffect(e6)
	--cannot be xyzmat
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_SINGLE)
	e6:SetCode(EFFECT_CANNOT_BE_XYZ_MATERIAL)
	e6:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e6:SetValue(1)
	c:RegisterEffect(e6)
end
c21210007.named_with_Grim=1
c21210007.named_with_Alice=1
function c21210007.IsGrim(c)
	local m=_G["c"..c:GetCode()]
	return m and m.named_with_Grim
end
function c21210007.IsAlice(c)
	local m=_G["c"..c:GetCode()]
	return m and m.named_with_Alice
end
function c21210007.IsRedHat(c)
	local m=_G["c"..c:GetCode()]
	return m and m.named_with_RedHat
end
function c21210007.cfilter(c)
	return c21210007.IsGrim(c) and c:IsType(TYPE_MONSTER) and c:IsAbleToRemoveAsCost()
end
function c21210007.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,500) and Duel.IsExistingMatchingCard(c21210007.cfilter,tp,LOCATION_HAND+LOCATION_MZONE,0,1,nil) end
	Duel.PayLPCost(tp,500)
	local g=Duel.SelectMatchingCard(tp,c21210007.cfilter,tp,LOCATION_HAND+LOCATION_MZONE,0,1,1,nil)
	Duel.Remove(g,POS_FACEUP,REASON_COST)
end
function c21210007.tgfilter(c,e,tp)
	return c21210007.IsAlice(c) and c:IsType(TYPE_MONSTER) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c21210007.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c21210007.tgfilter,tp,LOCATION_HAND+LOCATION_REMOVED,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND+LOCATION_REMOVED)
end
function c21210007.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c21210007.tgfilter,tp,LOCATION_HAND+LOCATION_REMOVED,0,1,1,nil,e,tp)
	local tc=g:GetFirst()
	if tc then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
function c21210007.cost2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,500) end
	Duel.PayLPCost(tp,500)
	Duel.SendtoGrave(e:GetHandler(),REASON_COST)
end
function c21210007.tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
end
function c21210007.filter(c,e,tp)
	return c21210007.IsGrim(c) and c:IsType(TYPE_MONSTER) and c:IsFaceup()
end
function c21210007.op(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c21210007.filter,tp,LOCATION_MZONE,0,nil)
	local tc=g:GetFirst()
	while tc do
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_BASE_ATTACK)
		e1:SetReset(RESET_EVENT+0x1ff0000+RESET_PHASE+PHASE_END)
		e1:SetValue(tc:GetBaseAttack()+500)
		tc:RegisterEffect(e1)
		tc=g:GetNext()
	end
end
function c21210007.condition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetLocation()==LOCATION_MZONE
end
function c21210007.val(e,c)
	return Duel.GetFieldGroupCount(1-e:GetHandler():GetControler(),LOCATION_MZONE,0)*200
end
function c21210007.damop(e,tp,eg,ep,ev,re,r,rp)
	Duel.ChangeBattleDamage(1-tp,0,false)
	Duel.ChangeBattleDamage(tp,ev,false)
end