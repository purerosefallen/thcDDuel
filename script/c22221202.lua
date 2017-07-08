--白泽球的增援
function c22221202.initial_effect(c)
	c:SetUniqueOnField(1,0,22221202)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOGRAVE+CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c22221202.target)
	e1:SetOperation(c22221202.activate)
	c:RegisterEffect(e1)
	--SpecialSummon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(22221202, 0))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCountLimit(1,EFFECT_COUNT_CODE_SINGLE)
	e2:SetCost(c22221202.cost2)
	e2:SetTarget(c22221202.tg)
	e2:SetOperation(c22221202.op)
	c:RegisterEffect(e2)
	--tohand
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(22221202, 1))
	e2:SetCategory(CATEGORY_TOHAND)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCountLimit(1,EFFECT_COUNT_CODE_SINGLE)
	e2:SetCost(c22221202.cost2)
	e2:SetTarget(c22221202.tg3)
	e2:SetOperation(c22221202.op3)
	c:RegisterEffect(e2)
	--todeck
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(22221202, 2))
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCountLimit(1,EFFECT_COUNT_CODE_SINGLE)
	e2:SetCost(c22221202.cost2)
	e2:SetTarget(c22221202.tg2)
	e2:SetOperation(c22221202.op2)
	c:RegisterEffect(e2)
	--maintain
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e5:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e5:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e5:SetRange(LOCATION_SZONE)
	e5:SetCountLimit(1)
	e5:SetOperation(c22221202.mtop)
	c:RegisterEffect(e5)
end
c22221202.named_with_Shirasawa_Tama=1
function c22221202.IsShirasawaTama(c)
	local m=_G["c"..c:GetCode()]
	return m and m.named_with_Shirasawa_Tama
end
function c22221202.filter(c)
	return (c:GetSequence()==6 or c:GetSequence()==7) and c22221202.IsShirasawaTama(c) and c:IsAbleToHand()
end
function c22221202.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local g=Duel.GetMatchingGroup(c22221202.filter,tp,LOCATION_SZONE,0,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,g:GetCount(),0,0)
end
function c22221202.activate(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local g=Duel.GetMatchingGroup(c22221202.filter,tp,LOCATION_SZONE,0,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,tp,REASON_EFFECT)
	end
end
function c22221202.filter2(c)
	return  c22221202.IsShirasawaTama(c) and c:IsAbleToGraveAsCost() and c:IsType(TYPE_MONSTER) and c:IsFaceup()
end
function c22221202.filter3(c)
	return  c22221202.IsShirasawaTama(c) and c:IsType(TYPE_MONSTER) and c:IsAbleToGraveAsCost()
end
function c22221202.filter4(c,e,tp)
	return  c22221202.IsShirasawaTama(c) and c:IsType(TYPE_MONSTER) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c22221202.cost2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c22221202.filter2,tp,LOCATION_EXTRA,0,1,nil) and Duel.IsExistingMatchingCard(c22221202.filter3,tp,LOCATION_HAND,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g1=Duel.SelectMatchingCard(tp,c22221202.filter2,tp,LOCATION_EXTRA,0,1,1,nil)
	local g2=Duel.SelectMatchingCard(tp,c22221202.filter3,tp,LOCATION_HAND,0,1,1,nil)
	g1:Merge(g2)
	Duel.SendtoGrave(g1,REASON_COST)
end
function c22221202.tg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_DECK+LOCATION_GRAVE) and c22221202.filter4(chkc,e,tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingTarget(c22221202.filter4,tp,LOCATION_DECK+LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c22221202.filter4,tp,LOCATION_DECK+LOCATION_GRAVE,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,tp,LOCATION_DECK+LOCATION_GRAVE)
end
function c22221202.op(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and e:GetHandler():IsRelateToEffect(e) then
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
	end
end
function c22221202.filter5(c)
	return  c22221202.IsShirasawaTama(c) and c:IsType(TYPE_MONSTER)
end
function c22221202.tg2(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_REMOVED+LOCATION_DECK) and c22221202.filter5(chkc) end
	if chk==0 then return Duel.IsExistingMatchingCard(c22221202.filter5,tp,LOCATION_REMOVED+LOCATION_DECK,0,2,nil) end
end
function c22221202.op2(e,tp,eg,ep,ev,re,r,rp)
	if Duel.IsExistingMatchingCard(c22221202.filter5,tp,LOCATION_REMOVED+LOCATION_DECK,0,2,nil) then 
		local g=Duel.SelectMatchingCard(tp,c22221202.filter5,tp,LOCATION_REMOVED+LOCATION_DECK,0,2,2,nil)
		if e:GetHandler():IsRelateToEffect(e) then
			Duel.SendtoExtraP(g,nil,REASON_EFFECT)
		end
	end
end
function c22221202.filter6(c)
	return  c22221202.IsShirasawaTama(c) and c:IsType(TYPE_MONSTER) and c:IsAbleToHand()
end
function c22221202.tg3(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE+LOCATION_REMOVED) and c22221202.filter6(chkc,e,tp) end
	if chk==0 then return Duel.IsExistingTarget(c22221202.filter6,tp,LOCATION_GRAVE+LOCATION_REMOVED,0,1,nil) end
end
function c22221202.op3(e,tp,eg,ep,ev,re,r,rp)
	if Duel.IsExistingMatchingCard(c22221202.filter6,tp,LOCATION_GRAVE+LOCATION_REMOVED,0,1,nil) then 
		local g=Duel.SelectMatchingCard(tp,c22221202.filter5,tp,LOCATION_GRAVE+LOCATION_REMOVED,0,1,1,nil)
		local tc=g:GetFirst()
		if e:GetHandler():IsRelateToEffect(e) then
			Duel.SendtoHand(tc,nil,REASON_EFFECT)
		end
	end
end
function c22221202.mtfilter(c)
	return c:IsFaceup() and c22221202.IsShirasawaTama(c)
end
function c22221202.mtop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetTurnPlayer()~=tp then return end
	if Duel.IsExistingMatchingCard(c22221202.mtfilter,tp,LOCATION_MZONE,0,1,nil) then
		local g=Duel.SelectMatchingCard(tp,c22221202.mtfilter,tp,LOCATION_MZONE,0,1,1,nil)
		Duel.Remove(g,POS_FACEUP,REASON_RULE)
	else
		Duel.Remove(e:GetHandler(),POS_FACEUP,REASON_RULE)
	end
end





