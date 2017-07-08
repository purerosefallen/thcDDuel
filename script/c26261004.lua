--魔导战术-炮战
function c26261004.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(26261004,0))
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c26261004.target)
	e1:SetOperation(c26261004.activate)
	c:RegisterEffect(e1)
	--SpecialSummon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetRange(LOCATION_GRAVE)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetCountLimit(1,26261004)
	e1:SetCondition(c26261004.condition2)
	e1:SetTarget(c26261004.target2)
	e1:SetOperation(c26261004.activate2)
	c:RegisterEffect(e1)
end
c26261004.named_with_Modaozhanshu=1
c26261004.named_with_Paozhan=1
function c26261004.IsElu(c)
	local m=_G["c"..c:GetCode()]
	return m and m.named_with_Elu
end
function c26261004.IsModaoqiaoke(c)
	local m=_G["c"..c:GetCode()]
	return m and m.named_with_Modaoqiaoke
end
function c26261004.IsModaozhuangshu(c)
	local m=_G["c"..c:GetCode()]
	return m and m.named_with_Modaozhuangshu
end
function c26261004.IsModaozhanshu(c)
	local m=_G["c"..c:GetCode()]
	return m and m.named_with_Modaozhanshu
end
function c26261004.IsPaozhan(c)
	local m=_G["c"..c:GetCode()]
	return m and m.named_with_Paozhan
end
function c26261004.cfilter(c)
	return c:IsFaceup() and c26261004.IsPaozhan(c)
end
function c26261004.tgfilter(c)
	return c:IsFaceup() and c26261004.IsModaoqiaoke(c)
end
function c26261004.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local tp=e:GetHandler():GetControler()
	local fa=Duel.GetFlagEffect(tp,26262626)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c26261004.tgfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c26261004.tgfilter,tp,LOCATION_MZONE,0,1,nil) and fa<2 end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	local g=Duel.SelectTarget(tp,c26261004.tgfilter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c26261004.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.RegisterFlagEffect(tp,26262626,RESET_PHASE+PHASE_END,0,1)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	local seq=tc:GetSequence()
	local sg=Duel.GetFieldCard(1-tp,LOCATION_MZONE,4-seq)
	if sg then 
		Duel.Remove(sg,POS_FACEDOWN,REASON_EFFECT)
	else 
		Duel.Recover(tp,tc:GetAttack()/2,REASON_EFFECT)
	end
	if tc:IsFaceup() and tc:IsType(TYPE_DUAL) and not tc:IsDualState() and Duel.CheckLPCost(tp,500) and Duel.SelectYesNo(tp,aux.Stringid(26261004,1)) then
		Duel.BreakEffect()
		Duel.PayLPCost(tp,500)
		tc:EnableDualState()
	end
	c:CancelToGrave()
end
function c26261004.condition2(e,tp,eg,ep,ev,re,r,rp)
	if tp==Duel.GetTurnPlayer() then return false end
	local at=Duel.GetAttackTarget()
	if at and at:IsFaceup() and c26261004.IsModaoqiaoke(at) then
		return true
	end
	return false
end
function c26261004.target2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsPlayerCanSpecialSummonMonster(tp,26261004,nil,0x21,1000,1000,3,RACE_MACHINE,ATTRIBUTE_LIGHT) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,LOCATION_GRAVE)
end
function c26261004.activate2(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateAttack()
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and Duel.IsPlayerCanSpecialSummonMonster(tp,26261004,nil,0x21,1000,1000,3,RACE_MACHINE,ATTRIBUTE_LIGHT) then
		c:AddMonsterAttribute(TYPE_EFFECT+TYPE_TUNER)
		Duel.SpecialSummonStep(c,0,tp,tp,true,false,POS_FACEUP)
		c:AddMonsterAttributeComplete()
		--code
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CHANGE_CODE)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetRange(LOCATION_MZONE)
		e1:SetValue(26260104)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		c:RegisterEffect(e1)
		local e3=Effect.CreateEffect(c)
		e3:SetType(EFFECT_TYPE_SINGLE)
		e3:SetCode(EFFECT_LEAVE_FIELD_REDIRECT)
		e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e3:SetReset(RESET_EVENT+0x47e0000)
		e3:SetValue(LOCATION_REMOVED)
		c:RegisterEffect(e3,true)
		Duel.SpecialSummonComplete()
	end
end