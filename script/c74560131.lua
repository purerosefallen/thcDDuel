--HibinoつKureha
function c74560131.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,aux.FilterBoolFunction(Card.IsRace,RACE_FAIRY),aux.NonTuner(nil),3)
	c:EnableReviveLimit()
	--pendulum summon
	aux.EnablePendulumAttribute(c)
	--can not disable summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_CANNOT_DISABLE_SPSUMMON)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	c:RegisterEffect(e1)
	--Draw
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(74560131,0))
	e4:SetCategory(CATEGORY_DRAW+CATEGORY_TODECK)
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e4:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e4:SetCode(EVENT_CUSTOM+74567456)
	e4:SetRange(LOCATION_PZONE)
	e4:SetCountLimit(1)
	e4:SetTarget(c74560131.tgp)
	e4:SetOperation(c74560131.opp)
	c:RegisterEffect(e4)
	--SynchroSummonP
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(74560131,1))
	e4:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e4:SetType(EFFECT_TYPE_IGNITION)
	e4:SetRange(LOCATION_PZONE)
	e4:SetCondition(c74560131.consp)
	e4:SetCost(c74560131.costsp)
	e4:SetTarget(c74560131.tgsp)
	e4:SetOperation(c74560131.opsp)
	c:RegisterEffect(e4)
	--special summon rule
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(74560131,2))
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_SPSUMMON_PROC)
	e2:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e2:SetRange(LOCATION_EXTRA)
	e2:SetCondition(c74560131.sprcon)
	e2:SetOperation(c74560131.sprop)
	c:RegisterEffect(e2)
	--Draw
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(74560131,3))
	e1:SetCategory(CATEGORY_TODECK+CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_DAMAGE_STEP)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetTarget(c74560131.tg)
	e1:SetOperation(c74560131.op)
	c:RegisterEffect(e1)
	--print
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(74560131,4))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetCountLimit(1)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCost(c74560131.scost)
	e1:SetTarget(c74560131.starget)
	e1:SetOperation(c74560131.soperation)
	c:RegisterEffect(e1)
	--token
	local e5=Effect.CreateEffect(c)
	e5:SetDescription(aux.Stringid(74560131,5))
	e5:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOKEN)
	e5:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e5:SetRange(LOCATION_MZONE)
	e5:SetCode(EVENT_PHASE+PHASE_END)
	e5:SetCountLimit(1)
	e5:SetProperty(EFFECT_FLAG_REPEAT)
	e5:SetTarget(c74560131.sptg)
	e5:SetOperation(c74560131.spop)
	c:RegisterEffect(e5)
	--damage reduce
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_CHANGE_DAMAGE)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(1,0)
	e2:SetCondition(c74560131.damcon)
	e2:SetValue(c74560131.damval)
	c:RegisterEffect(e2)
	--pendulum
	local e7=Effect.CreateEffect(c)
	e7:SetDescription(aux.Stringid(74560131,6))
	e7:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e7:SetCode(EVENT_DESTROYED)
	e7:SetProperty(EFFECT_FLAG_DELAY)
	e7:SetCondition(c74560131.pencon)
	e7:SetTarget(c74560131.pentg)
	e7:SetOperation(c74560131.penop)
	c:RegisterEffect(e7)
end
c74560131.named_with_Die=1
function c74560131.IsDie(c)
	local m=_G["c"..c:GetCode()]
	return m and m.named_with_Die
end
function c74560131.tgp(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFieldGroupCount(tp,LOCATION_HAND,0)>0  and Duel.IsPlayerCanDraw(tp,1) end
end
function c74560131.filter11(c)
	return (c74560131.IsDie(c) or c:IsCode(74560012,74561201))
end
function c74560131.opp(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	if Duel.GetFieldGroupCount(tp,LOCATION_HAND,0)>0 then
		local g=Duel.GetFieldGroup(tp,LOCATION_HAND,0)
		local m=g:GetCount()
		Duel.SendtoDeck(g,nil,2,REASON_EFFECT)
		Duel.Draw(tp,m+1,REASON_EFFECT)
		local sg=Duel.SelectMatchingCard(tp,c74560131.filter11,tp,LOCATION_HAND+LOCATION_ONFIELD,0,1,1,nil)
		Duel.SendtoDeck(sg,nil,-1,REASON_EFFECT)
		Duel.RaiseEvent(sg,EVENT_CUSTOM+74567456,e,0,tp,0,0)
	end
end
function c74560131.consp(e)
	local seq=e:GetHandler():GetSequence()
	local tc=Duel.GetFieldCard(e:GetHandlerPlayer(),LOCATION_SZONE,13-seq)
	return tc and tc:IsCode(74560132)
end
function c74560131.costfilterp(c)
	return bit.band(c:GetReason(),0x80008)==0x80008 and c:IsType(TYPE_MONSTER)
end
function c74560131.costsp(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c74560131.costfilterp,tp,LOCATION_GRAVE,0,3,nil) end
	local g=Duel.SelectMatchingCard(tp,c74560131.costfilterp,tp,LOCATION_GRAVE,0,3,3,nil)
	Duel.SendtoDeck(g,tp,-1,REASON_COST)
	Duel.RaiseEvent(g,EVENT_CUSTOM+74567456,e,0,tp,0,0)
end
function c74560131.tgsp(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c74560131.opsp(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	if Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)==0 and Duel.GetLocationCount(tp,LOCATION_MZONE)<=0
		and c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_SYNCHRO,tp,false,false) then
		Duel.SendtoGrave(c,REASON_RULE)
	end
end
function c74560131.sprfilter1(c)
	return c:IsFaceup() and (c74560131.IsDie(c) or c:IsCode(74560012,74561201))
end
function c74560131.sprcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c74560131.sprfilter1,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,8,nil,tp)
end
function c74560131.sprop(e,tp,eg,ep,ev,re,r,rp,c)
	local g=Duel.SelectMatchingCard(tp,c74560131.sprfilter1,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,8,8,nil,tp)
	Duel.SendtoDeck(g,nil,-1,REASON_COST+REASON_MATERIAL+REASON_SYNCHRO)
	Duel.RaiseEvent(g,EVENT_CUSTOM+74567456,e,0,tp,0,0)
end
function c74560131.filter(c)
	return c74560131.IsDie(c) and c:IsAbleToHand()
end
function c74560131.tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c74560131.filter,tp,LOCATION_GRAVE+LOCATION_REMOVED,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c74560131.op(e,tp,eg,ep,ev,re,r,rp)
	local m=Duel.GetMatchingGroupCount(c74560131.filter,tp,LOCATION_GRAVE+LOCATION_REMOVED,0,nil)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=Duel.SelectMatchingCard(tp,c74560131.filter,tp,LOCATION_GRAVE+LOCATION_REMOVED,0,1,m,nil)
	local n=g:GetCount()
	if n>0 then
		Duel.SendtoDeck(g,nil,2,REASON_EFFECT)
		Duel.Draw(tp,n/4,REASON_EFFECT)
	end
end
function c74560131.scost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(nil,tp,LOCATION_HAND+LOCATION_ONFIELD,0,1,nil) end
	local g=Duel.SelectMatchingCard(tp,nil,tp,LOCATION_HAND+LOCATION_ONFIELD,0,1,1,nil)
	Duel.SendtoDeck(g,tp,-1,REASON_COST)
	Duel.RaiseEvent(g,EVENT_CUSTOM+74567456,e,0,tp,0,0)
end
function c74560131.starget(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(nil,tp,0,LOCATION_ONFIELD,1,nil) end
end
function c74560131.soperation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.IsExistingMatchingCard(nil,tp,0,LOCATION_ONFIELD,1,nil) then
		local g=Duel.SelectMatchingCard(tp,nil,tp,0,LOCATION_ONFIELD,1,1,nil)
		local tc=g:GetFirst()
		local og=tc:GetOverlayGroup()
		Duel.SendtoGrave(og,REASON_EFFECT)
		Duel.SendtoDeck(g,nil,-1,REASON_EFFECT)
		Duel.RaiseEvent(g,EVENT_CUSTOM+74567456,e,0,tp,0,0)
	end
end
function c74560131.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,0)
end
function c74560131.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	if not Duel.IsPlayerCanSpecialSummonMonster(tp,74560012,nil,0x4011,0,0,1,RACE_ZOMBIE,ATTRIBUTE_DARK) then return end
	local token=Duel.CreateToken(tp,74560012)
	Duel.SpecialSummonStep(token,0,Duel.GetTurnPlayer(),Duel.GetTurnPlayer(),false,false,POS_FACEUP)
	local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_AVOID_BATTLE_DAMAGE)
		e1:SetValue(1)
		token:RegisterEffect(e1)
	Duel.SpecialSummonComplete()
end
function c74560131.damfilter(c)
	return c:IsCode(74560012)
end
function c74560131.damcon(e,c)
	return Duel.IsExistingMatchingCard(c74560131.damfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil)
end
function c74560131.damval(e,re,val,r,rp,rc)
	if bit.band(r,REASON_BATTLE)==REASON_BATTLE then return 0 end
	return val
end
function c74560131.pencon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsPreviousLocation(LOCATION_MZONE) and c:IsFaceup()
end
function c74560131.pentg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLocation(tp,LOCATION_SZONE,6) or Duel.CheckLocation(tp,LOCATION_SZONE,7) end
end
function c74560131.penop(e,tp,eg,ep,ev,re,r,rp)
	if not Duel.CheckLocation(tp,LOCATION_SZONE,6) and not Duel.CheckLocation(tp,LOCATION_SZONE,7) then return false end
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.MoveToField(c,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
	end
end