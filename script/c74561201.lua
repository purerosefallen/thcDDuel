--魔法衍生物つdie毛
function c74561201.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--print
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(74561201,0))
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCountLimit(1)
	e2:SetTarget(c74561201.target)
	e2:SetOperation(c74561201.activate)
	c:RegisterEffect(e2)
	--recover
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_RECOVER)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetProperty(EFFECT_FLAG_DELAY)
	e2:SetCode(EVENT_CUSTOM+74567456)
	e2:SetRange(LOCATION_SZONE)
	e2:SetOperation(c74561201.rdop)
	c:RegisterEffect(e2)
	--immune
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_IMMUNE_EFFECT)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e3:SetRange(LOCATION_SZONE)
	e3:SetValue(c74561201.efilter)
	c:RegisterEffect(e3)
	--ziwohuimie
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(74561201,1))
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCountLimit(1)
	e2:SetCost(c74561201.cost2)
	e2:SetOperation(c74561201.activate2)
	c:RegisterEffect(e2)
end
c74561201.named_with_Die=1
function c74561201.IsDie(c)
	local m=_G["c"..c:GetCode()]
	return m and m.named_with_Die
end
function c74561201.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(1-tp,LOCATION_SZONE)>0 end
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,0)
end
function c74561201.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(1-tp,LOCATION_SZONE)<=0 then return end
	local token=Duel.CreateToken(tp,74561201)
	Duel.MoveToField(token,tp,1-tp,LOCATION_SZONE,POS_FACEDOWN,false)
end
function c74561201.rdop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Recover(tp,250,REASON_EFFECT)
end
function c74561201.efilter(e,te)
	return te:GetOwner()~=e:GetOwner()
end
function c74561201.cost2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,1200) end
	Duel.PayLPCost(tp,1200)
end
function c74561201.activate2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	Duel.SendtoDeck(c,nil,-1,REASON_EFFECT)
	Duel.RaiseEvent(c,EVENT_CUSTOM+74567456,e,0,tp,0,0)
end