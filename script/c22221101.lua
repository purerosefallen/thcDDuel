--白泽球之塔
function c22221101.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCountLimit(1,22221101+EFFECT_COUNT_CODE_DUEL)
	e1:SetTarget(c22221101.tg)
	e1:SetOperation(c22221101.activate)
	c:RegisterEffect(e1)
	--Overlay
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(22221101,1))
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCondition(aux.exccon)
	e2:SetCountLimit(1)
	e2:SetCost(c22221101.cost)
	e2:SetTarget(c22221101.target)
	e2:SetOperation(c22221101.op)
	c:RegisterEffect(e2)
	
end
c22221101.named_with_Shirasawa_Tama=1
function c22221101.IsShirasawaTama(c)
	local m=_G["c"..c:GetCode()]
	return m and m.named_with_Shirasawa_Tama
end
function c22221101.filter1(c,e,tp)
	return c22221101.IsShirasawaTama(c) and c:IsType(TYPE_XYZ) and c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_XYZ,tp,tp,false,false)
end
function c22221101.filter2(c,e,tp)
	return c22221101.IsShirasawaTama(c) and c:IsType(TYPE_MONSTER)
end
function c22221101.tg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_EXTRA) and c22221101.filter1(chkc,e,tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingTarget(c22221101.filter1,tp,LOCATION_EXTRA,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	local g=Duel.SelectTarget(tp,c22221101.filter1,tp,LOCATION_EXTRA,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,tp,LOCATION_EXTRA)
end
function c22221101.activate(e,tp,eg,ep,ev,re,r,rp)
	local sc=Duel.GetFirstTarget()
	Duel.SpecialSummon(sc,SUMMON_TYPE_XYZ,tp,tp,false,false,POS_FACEUP)
	sc:CompleteProcedure()
	local g2=Duel.SelectMatchingCard(tp,c22221101.filter2,tp,LOCATION_GRAVE+LOCATION_REMOVED,0,1,5,nil)
	Duel.Overlay(sc,g2)
end
function c22221101.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToRemoveAsCost() end
	Duel.Remove(e:GetHandler(),POS_FACEUP,REASON_COST)
end
function c22221101.filter3(c,e,tp)
	return c22221101.IsShirasawaTama(c) and c:IsType(TYPE_MONSTER) and c:IsFaceup()
end
function c22221101.filter4(c,e,tp)
	return c22221101.IsShirasawaTama(c) and c:IsType(TYPE_XYZ)
end
function c22221101.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_MZONE) and c22221101.filter4(chkc,e,tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>-1
		and Duel.IsExistingTarget(c22221101.filter4,tp,LOCATION_MZONE,0,1,nil,e,tp) and Duel.IsExistingTarget(c22221101.filter3,tp,LOCATION_EXTRA,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,c22221101.filter4,tp,LOCATION_MZONE,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c22221101.op(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	local g=Duel.SelectMatchingCard(tp,c22221101.filter3,tp,LOCATION_EXTRA,0,1,2,nil)
	Duel.Overlay(tc,g)
end

