--3L·MyonMyonMyonMyonMyonMyon
local m=37564844
local cm=_G["c"..m]
if not pcall(function() require("expansions/script/c37564765") end) then require("script/c37564765") end
cm.named_with_myon=6
function cm.initial_effect(c)
	senya.leff(c,m)
	aux.AddXyzProcedure(c,aux.FALSE,10,5,cm.xfilter,m*16)
	c:EnableReviveLimit()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	c:RegisterEffect(e1)
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(37564827)
	e3:SetValue(senya.order_table_new(cm.omit_group_3L))
	e3:SetRange(LOCATION_MZONE)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	c:RegisterEffect(e3)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_ADJUST)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCondition(function(e,tp)
		return Duel.IsExistingMatchingCard(senya.lefffilter,tp,LOCATION_GRAVE,0,1,nil,e:GetHandler())
	end)
	e2:SetOperation(cm.op)
	c:RegisterEffect(e2)
end
function cm.effect_operation_3L(c,ctlm)
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(m,1))
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_FUSION_SUMMON)
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCode(EVENT_FREE_CHAIN)
	e3:SetHintTiming(0,0x1e0)
	e3:SetCountLimit(ctlm)
	e3:SetCost(senya.desccost(cm.cost))
	e3:SetTarget(cm.target)
	e3:SetOperation(cm.activate)
	e3:SetReset(RESET_EVENT+0x1fe0000)
	c:RegisterEffect(e3,true)
	return e3
end
cm.single_effect_3L=true
function cm.omit_group_3L(c)
	return Duel.GetMatchingGroup(aux.TRUE,c:GetControler(),LOCATION_GRAVE,0,nil)
end
function cm.xfilter(c)
	return senya.check_set(c,"myon") and c:IsType(TYPE_XYZ) and c:IsFaceup() and c:GetOverlayCount()>2
end
function cm.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then
		if not c:IsReleasable() then return false end
		local ct=0
		local t=senya.lgetcd(c)
		for i,v in pairs(t) do
			local mt=senya.load_metatable(v)
			if mt and mt.named_with_myon then ct=ct+1 end
		end
		return ct>=4
	end
	Duel.Release(c,REASON_COST)
end
function cm.sfilter(c,e,tp)
	return c:IsType(TYPE_FUSION) and c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_FUSION,tp,false,false) and c:CheckFusionMaterial()
end
function cm.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>-1
		and Duel.IsExistingMatchingCard(cm.sfilter,tp,LOCATION_EXTRA,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function cm.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,cm.sfilter,tp,LOCATION_EXTRA,0,1,1,nil,e,tp)
	local tc=g:GetFirst()
	if not tc then return end
	tc:SetMaterial(nil)
	Duel.SpecialSummon(tc,SUMMON_TYPE_FUSION,tp,tp,false,false,POS_FACEUP)
end
function cm.op(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local og=Duel.GetMatchingGroup(senya.lefffilter,tp,LOCATION_GRAVE,0,nil,c)
	og:ForEach(function(tc)  
		local t=senya.lgeff(c,tc,false,63)
		if not t then return end
		for i,te in pairs(t) do
			te:SetCondition(cm.ccon(te:GetCondition(),tc:GetOriginalCode()))
			if te:IsHasType(0x7e0) then
				te:SetCost(cm.ccost(te:GetCost(),tc:GetOriginalCode()),tc.single_effect_3L)
			end
		end
	end)
end
function cm.kfilter(c,cd)
	return c:GetOriginalCode()==cd
end
function cm.ccon(con,cd)
	return function(e,tp,eg,ep,ev,re,r,rp)
		local p=tp or e:GetHandlerPlayer()
		if Duel.IsExistingMatchingCard(cm.kfilter,p,LOCATION_GRAVE,0,1,nil,cd) and e:GetHandler():IsHasEffect(37564827) then
			return (not con or con(e,tp,eg,ep,ev,re,r,rp))
		else
			senya.lreseff(e:GetHandler(),cd)
			return false
		end
	end
end
function cm.excfilter(c,cd)
	return c:GetOriginalCode()==cd and c:IsAbleToRemoveAsCost()
end
function cm.ccost(costf,cd,chks)
	if chks then
		return function(e,tp,eg,ep,ev,re,r,rp,chk)
			local c=e:GetHandler()
			if chk==0 then return Duel.IsExistingMatchingCard(cm.excfilter,tp,LOCATION_GRAVE,0,1,c,cd) and (not costf or costf(e,tp,eg,ep,ev,re,r,rp,0)) end
			if costf then costf(e,tp,eg,ep,ev,re,r,rp,1) end
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
			local g=Duel.SelectMatchingCard(tp,cm.excfilter,tp,LOCATION_GRAVE,0,1,1,c,cd)
			Duel.Remove(g,POS_FACEUP,REASON_COST)
		end
	else
		return function(e,tp,eg,ep,ev,re,r,rp,chk)
			local c=e:GetHandler()
			local ctlm=c.custom_ctlm_3L or 1
			if chk==0 then return Duel.IsExistingMatchingCard(cm.excfilter,tp,LOCATION_GRAVE,0,1,c,cd) and c:GetFlagEffect(cd-3000)<ctlm and (not costf or costf(e,tp,eg,ep,ev,re,r,rp,0)) end
			if costf then costf(e,tp,eg,ep,ev,re,r,rp,1) end
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
			local g=Duel.SelectMatchingCard(tp,cm.excfilter,tp,LOCATION_GRAVE,0,1,1,c,cd)
			Duel.Remove(g,POS_FACEUP,REASON_COST)   
			c:RegisterFlagEffect(cd-3000,0x1fe1000+RESET_PHASE+PHASE_END,0,1)
		end
	end
end