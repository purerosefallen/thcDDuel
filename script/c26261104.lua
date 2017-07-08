--魔导装束-炮战装
function c26261104.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_EQUIP)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP)
	e1:SetTarget(c26261104.target)
	e1:SetOperation(c26261104.operation)
	c:RegisterEffect(e1)
	--set
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(26261104,1))
	e3:SetCategory(CATEGORY_REMOVE)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e3:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_CHAIN_UNIQUE)
	e3:SetCode(EVENT_TO_GRAVE)
	e3:SetCountLimit(1,26261104)
	e3:SetTarget(c26261104.rtg)
	e3:SetOperation(c26261104.rop)
	c:RegisterEffect(e3)
end
c26261104.named_with_Modaozhuangshu=1
c26261104.named_with_Paozhan=1
function c26261104.IsElu(c)
	local m=_G["c"..c:GetCode()]
	return m and m.named_with_Elu
end
function c26261104.IsModaozhuangshu(c)
	local m=_G["c"..c:GetCode()]
	return m and m.named_with_Modaozhuangshu
end
function c26261104.IsPaozhan(c)
	local m=_G["c"..c:GetCode()]
	return m and m.named_with_Paozhan
end
function c26261104.filter(c)
	return c:IsFaceup() and c26261104.IsElu(c)
end
function c26261104.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_MZONE) and c26261104.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c26261104.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	local g=Duel.SelectTarget(tp,c26261104.filter,tp,LOCATION_MZONE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_EQUIP,e:GetHandler(),1,0,0)
end
function c26261104.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsLocation(LOCATION_SZONE) then return end
	local tc=Duel.GetFirstTarget()
	if c:IsRelateToEffect(e) and tc:IsRelateToEffect(e) and tc:IsFaceup() then
		Duel.Equip(tp,c,tc)
		c:CancelToGrave()
		local val=Duel.GetFieldGroupCount(tp,LOCATION_HAND,0)*300
		--Atk/def
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_EQUIP)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		e1:SetValue(val)
		c:RegisterEffect(e1)
		--Atk/def
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_EQUIP)
		e1:SetCode(EFFECT_UPDATE_DEFENSE)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		e1:SetValue(val)
		c:RegisterEffect(e1)
		--Equip limit
		local e4=Effect.CreateEffect(c)
		e4:SetType(EFFECT_TYPE_SINGLE)
		e4:SetCode(EFFECT_EQUIP_LIMIT)
		e4:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e4:SetValue(c26261104.eqlimit)
		e4:SetReset(RESET_EVENT+0x1fe0000)
		c:RegisterEffect(e4)
	end
end
function c26261104.eqlimit(e,c)
	return c26261104.IsElu(c)
end
function c26261104.rfilter(c)
	return c26261104.IsModaozhuangshu(c) and c:IsAbleToRemove() and not c:IsCode(26261104)
end
function c26261104.rtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c26261104.rfilter,tp,LOCATION_DECK+LOCATION_GRAVE,0,1,nil) end
end
function c26261104.rop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c26261104.rfilter,tp,LOCATION_DECK+LOCATION_GRAVE,0,1,1,nil)
	local tc=g:GetFirst()
	if tc then
		Duel.Remove(tc,POS_FACEUP,REASON_EFFECT)
	end
end