--AliceつCarolin
function c74562201.initial_effect(c)
	c:SetUniqueOnField(1,0,74562201)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c74562201.target)
	e1:SetOperation(c74562201.operation)
	c:RegisterEffect(e1)
	--set
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetCategory(CATEGORY_TODECK+CATEGORY_DRAW)
	e2:SetCode(EVENT_CUSTOM+74562201)
	e2:SetRange(LOCATION_SZONE)
	e2:SetProperty(0x14000)
	e2:SetCountLimit(1,74562201)
	e2:SetTarget(c74562201.tg)
	e2:SetOperation(c74562201.op)
	c:RegisterEffect(e2)
	if not c74562201.gchk then
		c74562201.gchk=true
		c74562201[0]=5
		c74562201[1]=5
		local e3=Effect.GlobalEffect()
		e3:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
		e3:SetCode(EVENT_CUSTOM+74567456)
		e3:SetOperation(c74562201.addop)
		Duel.RegisterEffect(e3,0)
	end
end

c74562201.named_with_Die=1
function c74562201.IsDie(c)
	local m=_G["c"..c:GetCode()]
	return m and m.named_with_Die
end
function c74562201.addop(e,tp,eg,ep,ev,re,r,rp)
	if c74562201[rp]<=1 then
		c74562201[rp]=5
		Duel.RaiseEvent(eg,EVENT_CUSTOM+74562201,re,r,rp,ep,ev)
	else c74562201[rp]=c74562201[rp]-1 end
end
function c74562201.tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(nil,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil) end
end
function c74562201.op(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():IsRelateToEffect(e) and Duel.IsExistingMatchingCard(nil,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil) then
		local g=Duel.SelectMatchingCard(tp,nil,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,nil)
		local tc=g:GetFirst()
		local og=tc:GetOverlayGroup()
		Duel.SendtoGrave(og,REASON_EFFECT)
		Duel.SendtoDeck(g,nil,-1,REASON_EFFECT)
		Duel.RaiseEvent(g,EVENT_CUSTOM+74567456,e,0,tp,0,0)
	end
end
function c74562201.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(nil,tp,LOCATION_GRAVE+LOCATION_REMOVED,0,1,nil) and Duel.IsExistingMatchingCard(nil,1-tp,LOCATION_GRAVE+LOCATION_REMOVED,0,1,nil) end
end
function c74562201.operation(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():IsRelateToEffect(e) and Duel.IsExistingMatchingCard(nil,tp,LOCATION_GRAVE+LOCATION_REMOVED,0,1,nil) and Duel.IsExistingMatchingCard(nil,1-tp,LOCATION_GRAVE+LOCATION_REMOVED,0,1,nil) then
		local g1=Duel.SelectMatchingCard(tp,nil,tp,LOCATION_GRAVE+LOCATION_REMOVED,0,1,1,nil)
		local g2=Duel.SelectMatchingCard(1-tp,nil,1-tp,LOCATION_GRAVE+LOCATION_REMOVED,0,1,1,nil)
		g1:Merge(g2)
		Duel.SendtoDeck(g1,nil,-1,REASON_EFFECT)
		Duel.RaiseEvent(g1,EVENT_CUSTOM+74567456,e,0,tp,0,0)
	end
end






