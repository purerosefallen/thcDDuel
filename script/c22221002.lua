--白泽球式三段冲
function c22221002.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c22221002.descon)
	e1:SetTarget(c22221002.destg)
	e1:SetOperation(c22221002.desop)
	c:RegisterEffect(e1)
end
c22221002.named_with_Shirasawa_Tama=1
function c22221002.IsShirasawaTama(c)
	local m=_G["c"..c:GetCode()]
	return m and m.named_with_Shirasawa_Tama
end
function c22221002.confilter(c)
	return c:IsFaceup() and c22221002.IsShirasawaTama(c)
end
function c22221002.descon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c22221002.confilter,tp,LOCATION_ONFIELD,0,3,nil)
end
function c22221002.filter1(c)
	return c:IsFaceup() and c:IsDestructable()
end
function c22221002.filter2(c)
	return c:IsFaceup() and c:IsType(TYPE_SPELL+TYPE_TRAP) and c:IsDestructable()
end
function c22221002.filter3(c)
	return c:IsFacedown() and c:IsDestructable()
end
function c22221002.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return 
		Duel.IsExistingMatchingCard(c22221002.filter1,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) or
		Duel.IsExistingMatchingCard(c22221002.filter2,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil) or
		Duel.IsExistingMatchingCard(c22221002.filter3,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil)
	end
	local t={}
	local p=1
	if Duel.IsExistingMatchingCard(c22221002.filter1,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) then t[p]=aux.Stringid(22221002,0) p=p+1 end
	if Duel.IsExistingMatchingCard(c22221002.filter2,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil) then t[p]=aux.Stringid(22221002,1) p=p+1 end
	if Duel.IsExistingMatchingCard(c22221002.filter3,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil) then t[p]=aux.Stringid(22221002,2) p=p+1 end
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(22221002,3))
	local sel=Duel.SelectOption(tp,table.unpack(t))+1
	local opt=t[sel]-aux.Stringid(22221002,0)
	local sg=nil
	if opt==0 then sg=Duel.GetMatchingGroup(c22221002.filter1,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	elseif opt==1 then sg=Duel.GetMatchingGroup(c22221002.filter2,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,nil)
	else sg=Duel.GetMatchingGroup(c22221002.filter3,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,nil) end
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,sg,sg:GetCount(),0,0)
	e:SetLabel(opt)
end
function c22221002.desop(e,tp,eg,ep,ev,re,r,rp)
	local opt=e:GetLabel()
	local sg=nil
	if opt==0 then sg=Duel.GetMatchingGroup(c22221002.filter1,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	elseif opt==1 then sg=Duel.GetMatchingGroup(c22221002.filter2,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,nil)
	else sg=Duel.GetMatchingGroup(c22221002.filter3,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,nil) end
	Duel.Destroy(sg,REASON_EFFECT)
end