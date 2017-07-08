--SakuraiつRyuuka
function c74560002.initial_effect(c)
	--special summon
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(74560002,0))
	e4:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e4:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e4:SetCode(EVENT_CUSTOM+74567456)
	e4:SetRange(LOCATION_HAND+LOCATION_GRAVE)
	e4:SetCountLimit(1,74560002)
	e4:SetTarget(c74560002.sptg)
	e4:SetOperation(c74560002.spop)
	c:RegisterEffect(e4)
	--SpecialSummon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(74560002,1))
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET+CATEGORY_SPECIAL_SUMMON)
	e2:SetCountLimit(1)
	e2:SetTarget(c74560002.tg)
	e2:SetOperation(c74560002.op)
	c:RegisterEffect(e2)
end
c74560002.named_with_Die=1
function c74560002.IsDie(c)
	local m=_G["c"..c:GetCode()]
	return m and m.named_with_Die
end
function c74560002.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c74560002.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
	end
end
function c74560002.tg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and chkc:IsFaceup() end
	if chk==0 then return Duel.IsExistingTarget(c74560002.filter2,tp,LOCATION_MZONE,0,1,nil) and Duel.IsExistingMatchingCard(c74560002.filter,tp,LOCATION_DECK,0,1,nil,e,tp) and Duel.GetLocationCount(tp,LOCATION_MZONE)>0 end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c74560002.filter2,tp,LOCATION_MZONE,0,1,1,nil)
end
function c74560002.filter(c,e,tp)
	return c:IsCanBeSpecialSummoned(e,0,tp,false,false) and c74560002.IsDie(c)
end
function c74560002.filter2(c,e,tp)
	return (c74560002.IsDie(c) or c:IsCode(74560012)) and c:IsFaceup()
end
function c74560002.op(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	local tc=Duel.GetFirstTarget()
	local sg=Duel.SelectMatchingCard(tp,c74560002.filter,tp,LOCATION_DECK,0,1,1,nil,e,tp)
	local tc2=sg:GetFirst()
	Duel.SpecialSummon(tc2,0,tp,tp,false,false,POS_FACEUP)
	Duel.SendtoDeck(tc,tp,-1,REASON_EFFECT)
	Duel.RaiseEvent(tc,EVENT_CUSTOM+74567456,e,0,tp,0,0)
end


