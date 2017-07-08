--白泽球的裁决
function c22221001.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_COIN+CATEGORY_REMOVE+CATEGORY_TOGRAVE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,22221001)
	e1:SetCondition(c22221001.condition)
	e1:SetTarget(c22221001.target)
	e1:SetOperation(c22221001.activate)
	c:RegisterEffect(e1)
end
c22221001.named_with_Shirasawa_Tama=1
function c22221001.IsShirasawaTama(c)
	local m=_G["c"..c:GetCode()]
	return m and m.named_with_Shirasawa_Tama
end
function c22221001.cfilter(c)
	return c:IsFaceup() and c22221001.IsShirasawaTama(c)
end
function c22221001.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c22221001.cfilter,tp,LOCATION_ONFIELD,0,1,nil)
end
function c22221001.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsAbleToRemove,tp,0,LOCATION_GRAVE,1,nil)
		and Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)>=Duel.GetFieldGroupCount(tp,0,LOCATION_GRAVE) end
	Duel.SetOperationInfo(0,CATEGORY_COIN,nil,0,tp,1)
end
function c22221001.activate(e,tp,eg,ep,ev,re,r,rp)
	local coin=Duel.SelectOption(tp,60,61)
	local res=Duel.TossCoin(tp,1)
	if coin~=res then Duel.Remove(Duel.GetFieldGroup(tp,0,LOCATION_GRAVE),POS_FACEUP,REASON_EFFECT)
	else Duel.DiscardDeck(tp,Duel.GetFieldGroupCount(tp,0,LOCATION_GRAVE),REASON_EFFECT) end
end