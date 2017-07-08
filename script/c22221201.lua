--白泽球的团结
function c22221201.initial_effect(c)
	c:EnableCounterPermit(0x1222)
	c:SetCounterLimit(0x1222,3)  
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--add counter
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCode(EVENT_SUMMON_SUCCESS)
	e2:SetOperation(c22221201.ctop)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e3)
	--draw
	local e4=Effect.CreateEffect(c)
	e4:SetCategory(CATEGORY_DRAW)
	e4:SetDescription(aux.Stringid(22221201,0))
	e4:SetType(EFFECT_TYPE_IGNITION)
	e4:SetRange(LOCATION_SZONE)
	e4:SetCost(c22221201.drcost)
	e4:SetTarget(c22221201.drtg)
	e4:SetOperation(c22221201.drop)
	c:RegisterEffect(e4)
  
end
c22221201.named_with_Shirasawa_Tama=1
function c22221201.IsShirasawaTama(c)
	local m=_G["c"..c:GetCode()]
	return m and m.named_with_Shirasawa_Tama
end
function c22221201.ctfilter(c)
	return c:IsFaceup() and c22221201.IsShirasawaTama(c)
end
function c22221201.ctop(e,tp,eg,ep,ev,re,r,rp)
	if eg:IsExists(c22221201.ctfilter,1,nil) then
		e:GetHandler():AddCounter(0x1222,1)
	end
end
function c22221201.drcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToGraveAsCost() end
	local ct=e:GetHandler():GetCounter(0x1222)
	e:SetLabel(ct)
	Duel.SendtoGrave(e:GetHandler(),REASON_COST)
end
function c22221201.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:GetCounter(0x1222)>0 and Duel.IsPlayerCanDraw(tp,c:GetCounter(0x1222)) end
	local ct=e:GetLabel()
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(ct)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,ct)
end
function c22221201.drop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
	Duel.DiscardHand(p,Card.IsAbleToGrave,d-1,d-1,REASON_EFFECT)
end



