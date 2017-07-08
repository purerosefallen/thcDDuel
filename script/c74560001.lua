--LysitheaつLowell
function c74560001.initial_effect(c)
	--special summon
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(74560001,0))
	e4:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e4:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e4:SetCode(EVENT_CUSTOM+74567456)
	e4:SetRange(LOCATION_HAND+LOCATION_GRAVE)
	e4:SetCountLimit(1,74560001)
	e4:SetTarget(c74560001.sptg)
	e4:SetOperation(c74560001.spop)
	c:RegisterEffect(e4)
	--print
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TODECK+CATEGORY_DRAW)
	e1:SetDescription(aux.Stringid(74560001,1))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetCountLimit(1)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCost(c74560001.cost)
	e1:SetTarget(c74560001.target)
	e1:SetOperation(c74560001.operation)
	c:RegisterEffect(e1)
end
c74560001.named_with_Die=1
function c74560001.IsDie(c)
	local m=_G["c"..c:GetCode()]
	return m and m.named_with_Die
end
function c74560001.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c74560001.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
	end
end
function c74560001.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(nil,tp,LOCATION_HAND,0,1,nil) end
	local g=Duel.SelectMatchingCard(tp,nil,tp,LOCATION_HAND,0,1,1,nil)
	Duel.SendtoDeck(g,tp,-1,REASON_COST)
	Duel.RaiseEvent(g,EVENT_CUSTOM+74567456,e,0,tp,0,0)
end
function c74560001.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
end
function c74560001.operation(e,tp,eg,ep,ev,re,r,rp)
	local t = {
		[1] = {desc=aux.Stringid(74560001,2),code=74560001},
		[2] = {desc=aux.Stringid(74560001,3),code=74560002},
		[3] = {desc=aux.Stringid(74560001,4),code=74560003},
		[4] = {desc=aux.Stringid(74560001,5),code=74560004},
		[5] = {desc=aux.Stringid(74560001,6),code=74560005},
		[6] = {desc=aux.Stringid(74560001,7),code=74560006},
		[7] = {desc=aux.Stringid(74560001,8),code=74560008},
		[8] = {desc=aux.Stringid(74560001,9),code=74560009},
		[9] = {desc=aux.Stringid(74560001,10),code=74560010},
		[10] = {desc=aux.Stringid(74560001,11),code=74560011},
	}
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(74560001,12))
	local sel=Duel.SelectOption(tp,Nef.unpackOneMember(t, "desc"))+1
	local code=t[sel].code
	local token=Duel.CreateToken(tp,code)
	Duel.SendtoDeck(token,tp,2,REASON_EFFECT)
	Duel.Draw(tp,1,REASON_EFFECT)
end