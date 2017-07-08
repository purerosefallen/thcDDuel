--艾露　咒戰裝　
function c26260101.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,c26260101.syfilter,aux.NonTuner(nil),1)
	c:EnableReviveLimit()
	--REMOVE_TYPE_EFFECT
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetCode(EFFECT_REMOVE_TYPE)
	e1:SetRange(LOCATION_MZONE+LOCATION_GRAVE)
	e1:SetCondition(c26260101.remcon)
	e1:SetValue(TYPE_EFFECT)
	c:RegisterEffect(e1)
	--special summon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(26260101,0))
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_SPSUMMON_PROC)
	e2:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e2:SetRange(LOCATION_EXTRA)
	e2:SetValue(SUMMON_TYPE_SYNCHRO)
	e2:SetCondition(c26260101.con1)
	e2:SetOperation(c26260101.op1)
	c:RegisterEffect(e2)
	--special summon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(26260101,1))
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_SPSUMMON_PROC)
	e2:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetValue(SUMMON_TYPE_SYNCHRO)
	e2:SetCondition(c26260101.con2)
	e2:SetOperation(c26260101.op2)
	c:RegisterEffect(e2)
	--spsummonsucess
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(26260101,2))
	e1:SetCategory(CATEGORY_TOGRAVE)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCountLimit(1,26260101)
	e1:SetCondition(c26260101.tgcon)
	e1:SetTarget(c26260101.tgtg)
	e1:SetOperation(c26260101.tgop)
	c:RegisterEffect(e1)
	--decktograve
	local e3 = Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(26260101,4))
	e3:SetCountLimit(1)
	e3:SetCategory(CATEGORY_DESTROY+CATEGORY_TOGRAVE)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCondition(aux.IsDualState)
	e3:SetTarget(c26260101.tg3)
	e3:SetOperation(c26260101.op3)
	c:RegisterEffect(e3)
	--SpecialSummon
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(26260101,5))
	e4:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TODECK)
	e4:SetType(EFFECT_TYPE_TRIGGER_O+EFFECT_TYPE_FIELD)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCode(EVENT_PHASE+PHASE_END)
	e4:SetCountLimit(1)
	e4:SetCondition(c26260101.condition)
	e4:SetTarget(c26260101.target)
	e4:SetOperation(c26260101.operation)
	c:RegisterEffect(e4)
end
c26260101.named_with_Modaoqiaoke=1
c26260101.named_with_Elu=1
c26260101.named_with_Zhouzhan=1
function c26260101.IsModaoqiaoke(c)
	local m=_G["c"..c:GetCode()]
	return m and m.named_with_Modaoqiaoke
end
function c26260101.IsModaozhuangshu(c)
	local m=_G["c"..c:GetCode()]
	return m and m.named_with_Modaozhuangshu
end
function c26260101.IsElu(c)
	local m=_G["c"..c:GetCode()]
	return m and m.named_with_Elu
end
function c26260101.IsZhouzhan(c)
	local m=_G["c"..c:GetCode()]
	return m and m.named_with_Zhouzhan
end
function c26260101.syfilter(c)
	return c:IsFaceup() and c26260101.IsElu(c)
end
function c26260101.remcon(e,tp,eg,ep,ev,re,r,rp)
	return not e:GetHandler():IsDualState()
end
function c26260101.spfilter1(c)
	return c:IsFaceup() and c26260101.IsElu(c) and c:IsDualState() and c:IsAbleToRemoveAsCost()
end
function c26260101.spfilter11(c)
	return c26260101.IsZhouzhan(c) and c:IsType(TYPE_SPELL) and c:IsAbleToRemoveAsCost()
end
function c26260101.con1(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.IsExistingMatchingCard(c26260101.spfilter1,tp,LOCATION_ONFIELD,0,1,nil) and Duel.IsExistingMatchingCard(c26260101.spfilter11,tp,LOCATION_ONFIELD,0,1,nil,tp)
end
function c26260101.op1(e,tp,eg,ep,ev,re,r,rp)   
	local c=e:GetHandler()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g1=Duel.SelectMatchingCard(tp,c26260101.spfilter1,tp,LOCATION_ONFIELD,0,1,1,nil)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g2=Duel.SelectMatchingCard(tp,c26260101.spfilter11,tp,LOCATION_ONFIELD,0,1,1,nil)
	g1:Merge(g2)
	Duel.Remove(g1,POS_FACEUP,REASON_COST)
end
function c26260101.con2(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.IsExistingMatchingCard(c26260101.spfilter2,tp,LOCATION_REMOVED,0,2,nil) and not e:GetHandler():IsType(TYPE_EFFECT)
end
function c26260101.spfilter2(c)
	return c26260101.IsZhouzhan(c) and c:IsType(TYPE_SPELL) and c:IsAbleToDeckAsCost()
end
function c26260101.op2(e,tp,eg,ep,ev,re,r,rp)   
	local c=e:GetHandler()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=Duel.SelectMatchingCard(tp,c26260101.spfilter2,tp,LOCATION_REMOVED,0,2,2,nil)
	Duel.SendtoDeck(g,nil,2,REASON_COST)
	c:EnableDualState()
end
function c26260101.tgcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetSummonType()==SUMMON_TYPE_SYNCHRO
end
function c26260101.tgtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then 
		return Duel.IsExistingMatchingCard(Card.IsFacedown,tp,0,LOCATION_SZONE,1,nil)
	end
end
function c26260101.tgop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local g=Duel.GetMatchingGroup(Card.IsFacedown,tp,0,LOCATION_SZONE,nil)
	if g:GetCount()>0 then
		Duel.ConfirmCards(tp,g)
		if c:IsDualState() and Duel.IsExistingMatchingCard(Card.IsDiscardable,tp,LOCATION_HAND,0,1,nil) and Duel.SelectYesNo(tp,aux.Stringid(26260101,3)) then   
			Duel.DiscardHand(tp,Card.IsDiscardable,1,1,REASON_COST+REASON_DISCARD,nil)
			local sg=Duel.SelectMatchingCard(tp,Card.IsAbleToGrave,tp,0,LOCATION_SZONE,1,1,nil)
			Duel.SendtoGrave(sg,REASON_EFFECT)
		end
	end
end
function c26260101.tg3(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then 
		return Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)>0
	end
end
function c26260101.desfilter1(c)
	return c:IsFaceup() and c:IsType(TYPE_SPELL) and c:IsDestructable()
end
function c26260101.desfilter2(c)
	return c:IsFaceup() and c:IsType(TYPE_TRAP) and c:IsDestructable()
end
function c26260101.op3(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local g=Duel.GetDecktopGroup(tp,1)
	local tc=g:GetFirst()
	if Duel.SendtoGrave(tc,REASON_EFFECT)>0 then
		if tc:IsType(TYPE_SPELL) and Duel.IsExistingMatchingCard(c26260101.desfilter1,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil) then 
			local sg=Duel.SelectMatchingCard(tp,c26260101.desfilter1,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,nil)
			Duel.Destroy(sg,REASON_EFFECT)
		end
		if tc:IsType(TYPE_TRAP) and Duel.IsExistingMatchingCard(c26260101.desfilter2,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil) then 
			local sg=Duel.SelectMatchingCard(tp,c26260101.desfilter2,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,nil)
			Duel.Destroy(sg,REASON_EFFECT)
		end
	end
end
function c26260101.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetCurrentPhase()==PHASE_END and e:GetHandler():IsDualState()
end
function c26260101.sspfilter(c,e,tp)
	return c26260101.IsModaoqiaoke(c) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c26260101.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c26260101.sspfilter,tp,LOCATION_DECK+LOCATION_REMOVED,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK+LOCATION_REMOVED)
end
function c26260101.operation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.SendtoDeck(e:GetHandler(),nil,2,REASON_EFFECT)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c26260101.sspfilter,tp,LOCATION_DECK+LOCATION_REMOVED,0,1,1,nil,e,tp)
	if g:GetCount()~=0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
		local tc=g:GetFirst()
		if tc:IsFaceup() and tc:IsType(TYPE_DUAL) and not tc:IsDualState() and Duel.CheckLPCost(tp,500) and Duel.SelectYesNo(tp,aux.Stringid(26260101,6)) then
			Duel.PayLPCost(tp,500)
			tc:EnableDualState()
		end
	end
end