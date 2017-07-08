--魔导巧壳-娜芙加
function c26260003.initial_effect(c)
	aux.EnableDualAttribute(c)
	--search
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(26260003,0))
	e4:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e4:SetType(EFFECT_TYPE_QUICK_O)
	e4:SetCode(EVENT_FREE_CHAIN)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCountLimit(1,26260003)
	e4:SetCondition(aux.IsDualState)
	e4:SetCost(c26260003.cost)
	e4:SetTarget(c26260003.target)
	e4:SetOperation(c26260003.operation)
	c:RegisterEffect(e4)
end
c26260003.named_with_Modaoqiaoke=1
function c26260003.IsModaoqiaoke(c)
	local m=_G["c"..c:GetCode()]
	return m and m.named_with_Modaoqiaoke
end
function c26260003.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToRemove() end
	Duel.Remove(e:GetHandler(),POS_FACEUP,REASON_COST)
end
function c26260003.filter(c,e,tp)
	return c26260003.IsModaoqiaoke(c) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c26260003.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then 
		local g=Duel.GetMatchingGroup(c26260003.filter,tp,LOCATION_DECK+LOCATION_REMOVED,0,nil,e,tp)
		return not Duel.IsPlayerAffectedByEffect(tp,59822133)
			and Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and g:GetClassCount(Card.GetCode)>=2 end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,2,tp,LOCATION_DECK+LOCATION_REMOVED)
end
function c26260003.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local g=Duel.GetMatchingGroup(c26260003.filter,tp,LOCATION_DECK+LOCATION_REMOVED,0,nil,e,tp)
	if not Duel.IsPlayerAffectedByEffect(tp,59822133)
		and Duel.GetLocationCount(tp,LOCATION_MZONE)>1
		and g:GetClassCount(Card.GetCode)>=2 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local sg1=g:Select(tp,1,1,nil)
		g:Remove(Card.IsCode,nil,sg1:GetFirst():GetCode())
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local sg2=g:Select(tp,1,1,nil)
		sg1:Merge(sg2)
		local fid=c:GetFieldID()
		local tc=sg1:GetFirst()
		while tc do
			Duel.SpecialSummonStep(tc,0,tp,tp,false,false,POS_FACEUP)
			tc=sg1:GetNext()
		end
		sg1:KeepAlive()
		Duel.SpecialSummonComplete()
	end
end