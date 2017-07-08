--Grim 白雪姫
function c21210004.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SPECIAL_SUMMON)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,21210004)
	e1:SetCost(c21210004.cost)
	e1:SetCondition(c21210004.spcon)
	e1:SetOperation(c21210004.spop)
	c:RegisterEffect(e1)
	--Draw
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_DRAW+CATEGORY_REMOVE)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetProperty(EFFECT_FLAG_DELAY)
	e3:SetCode(EVENT_SUMMON_SUCCESS)
	e3:SetCost(c21210004.cost)
	e3:SetTarget(c21210004.tg)
	e3:SetOperation(c21210004.op)
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
	e2:SetCondition(c21210004.con1)
	e2:SetTarget(aux.TargetBoolFunction(c21210004.tgfilter))
	e2:SetValue(c21210004.val)
	c:RegisterEffect(e2)
	--damage
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_SINGLE)
	e6:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e6:SetCode(EVENT_PRE_BATTLE_DAMAGE)
	e6:SetOperation(c21210004.damop)
	c:RegisterEffect(e6)
	--cannot be xyzmat
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_SINGLE)
	e6:SetCode(EFFECT_CANNOT_BE_XYZ_MATERIAL)
	e6:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e6:SetValue(1)
	c:RegisterEffect(e6)
end
c21210004.named_with_Grim=1
function c21210004.IsGrim(c)
	local m=_G["c"..c:GetCode()]
	return m and m.named_with_Grim
end
function c21210004.IsAlice(c)
	local m=_G["c"..c:GetCode()]
	return m and m.named_with_Alice
end
function c21210004.IsRedHat(c)
	local m=_G["c"..c:GetCode()]
	return m and m.named_with_RedHat
end
function c21210004.spcon(e,c,tp)
	if c==nil then return true end
	return Duel.GetFieldGroupCount(e:GetHandler():GetControler(),LOCATION_MZONE,0)==0 and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c21210004.spfilter(c)
	return c21210004.IsGrim(c) and c:IsType(TYPE_MONSTER) and c:IsAbleToHand()
end
function c21210004.spop(e,tp,eg,ep,ev,re,r,rp,chk)
	Duel.SpecialSummon(e:GetHandler(),0,tp,tp,false,false,POS_FACEUP)
	if Duel.CheckLPCost(tp,500) and Duel.IsExistingMatchingCard(c21210004.spfilter,tp,LOCATION_DECK,0,1,nil) then 
		if Duel.SelectYesNo(tp,aux.Stringid(21210004,0)) then
			Duel.PayLPCost(tp,500)
			Duel.BreakEffect()
			local g=Duel.GetMatchingGroup(c21210004.spfilter,tp,LOCATION_DECK,0,nil)
			local sg=g:RandomSelect(tp,1)
			Duel.SendtoHand(sg,nil,REASON_EFFECT)
		end
	end
end
function c21210004.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,500) end
	Duel.PayLPCost(tp,500)
end
function c21210004.cfilter(c)
	return c21210004.IsGrim(c) and c:IsType(TYPE_MONSTER) and c:IsAbleToRemove()
end
function c21210004.tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c21210004.cfilter,tp,LOCATION_GRAVE,0,1,nil) and Duel.IsPlayerCanDraw(tp,1) end
end
function c21210004.op(e,tp,eg,ep,ev,re,r,rp,chk)
	local g=Duel.SelectMatchingCard(tp,c21210004.cfilter,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.Remove(g,POS_FACEUP,REASON_EFFECT)
	Duel.BreakEffect()
	Duel.Draw(tp,1,REASON_EFFECT)
end
function c21210004.con1(e)
	local tp=e:GetHandlerPlayer()
	return Duel.GetLP(tp)<=3000
end
function c21210004.tgfilter(c)
	return c21210004.IsGrim(c) and c:IsType(TYPE_MONSTER) and c:IsFaceup()
end
function c21210004.tg1(e,tp,eg,ep,ev,re,r,rp,chk)
	local g=Duel.GetMatchingGroup(c21210004.tgfilter,tp,LOCATION_MZONE,0,nil)
	return g
end
function c21210004.val(e,c)
	local m=Duel.GetLP(e:GetHandler():GetControler())
	local n=Duel.GetLP(1-e:GetHandler():GetControler())
	if m>=n then return false end
	return n-m
end
function c21210004.damop(e,tp,eg,ep,ev,re,r,rp)
	Duel.ChangeBattleDamage(1-tp,0,false)
	Duel.ChangeBattleDamage(tp,ev,false)
end

