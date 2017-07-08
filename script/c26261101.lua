--魔導裝束-呪戰裝
function c26261101.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_EQUIP)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP)
	e1:SetTarget(c26261101.target)
	e1:SetOperation(c26261101.operation)
	c:RegisterEffect(e1)
	--set
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(26261101,1))
	e3:SetCategory(CATEGORY_REMOVE)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e3:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_CHAIN_UNIQUE)
	e3:SetCode(EVENT_TO_GRAVE)
	e3:SetCountLimit(1,26261101)
	e3:SetTarget(c26261101.rtg)
	e3:SetOperation(c26261101.rop)
	c:RegisterEffect(e3)
end
c26261101.named_with_Modaozhuangshu=1
c26261101.named_with_Zhouzhan=1
function c26261101.IsElu(c)
	local m=_G["c"..c:GetCode()]
	return m and m.named_with_Elu
end
function c26261101.IsModaozhuangshu(c)
	local m=_G["c"..c:GetCode()]
	return m and m.named_with_Modaozhuangshu
end
function c26261101.IsZhouzhan(c)
	local m=_G["c"..c:GetCode()]
	return m and m.named_with_Zhouzhan
end
function c26261101.filter(c)
	return c:IsFaceup() and c26261101.IsElu(c)
end
function c26261101.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_MZONE) and c26261101.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c26261101.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	local g=Duel.SelectTarget(tp,c26261101.filter,tp,LOCATION_MZONE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_EQUIP,e:GetHandler(),1,0,0)
end
function c26261101.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsLocation(LOCATION_SZONE) then return end
	local tc=Duel.GetFirstTarget()
	if c:IsRelateToEffect(e) and tc:IsRelateToEffect(e) and tc:IsFaceup() then
		Duel.Equip(tp,c,tc)
		c:CancelToGrave()
		--Atk/def
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_EQUIP)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		e1:SetValue(500)
		c:RegisterEffect(e1)
		--Atk/def
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_EQUIP)
		e1:SetCode(EFFECT_UPDATE_DEFENSE)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		e1:SetValue(500)
		c:RegisterEffect(e1)
		local e3=Effect.CreateEffect(c)
		e3:SetType(EFFECT_TYPE_EQUIP)
		e3:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
		e3:SetReset(RESET_EVENT+0x1fe0000)
		e3:SetValue(1)
		c:RegisterEffect(e3,true)
		--Equip limit
		local e4=Effect.CreateEffect(c)
		e4:SetType(EFFECT_TYPE_SINGLE)
		e4:SetCode(EFFECT_EQUIP_LIMIT)
		e4:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e4:SetValue(c26261101.eqlimit)
		e4:SetReset(RESET_EVENT+0x1fe0000)
		c:RegisterEffect(e4)
	end
end
function c26261101.eqlimit(e,c)
	return c26261101.IsElu(c)
end
function c26261101.rfilter(c)
	return c26261101.IsModaozhuangshu(c) and c:IsAbleToRemove() and not c:IsCode(26261101)
end
function c26261101.rtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c26261101.rfilter,tp,LOCATION_DECK+LOCATION_GRAVE,0,1,nil) end
end
function c26261101.rop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c26261101.rfilter,tp,LOCATION_DECK+LOCATION_GRAVE,0,1,1,nil)
	local tc=g:GetFirst()
	if tc then
		Duel.Remove(tc,POS_FACEUP,REASON_EFFECT)
	end
end