--黑暗中的光虫¤白泽球
function c22220006.initial_effect(c)
	aux.EnablePendulumAttribute(c)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetRange(LOCATION_PZONE)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCountLimit(1)
	e1:SetCondition(c22220006.spcon)
	e1:SetTarget(c22220006.tgt)
	e1:SetOperation(c22220006.opt)
	c:RegisterEffect(e1)
	--equip
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(22220006,0))
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCategory(CATEGORY_EQUIP)
	e1:SetRange(LOCATION_MZONE)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,0x1e0)
	e1:SetTarget(c22220006.eqtg1)
	e1:SetOperation(c22220006.eqop)
	c:RegisterEffect(e1)
	--Remove
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(22220006,2))
	e1:SetCategory(CATEGORY_REMOVE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_GRAVE)
	e1:SetCountLimit(1)
	e1:SetCost(c22220006.cost)
	e1:SetTarget(c22220006.target)
	e1:SetOperation(c22220006.operation)
	c:RegisterEffect(e1)
end
c22220006.named_with_Shirasawa_Tama=1
function c22220006.IsShirasawaTama(c)
	local m=_G["c"..c:GetCode()]
	return m and m.named_with_Shirasawa_Tama
end
function c22220006.filtert(c,tp)
	return c:GetSummonPlayer()==1-tp
end
function c22220006.spcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c22220006.filtert,1,nil,tp)
end
function c22220006.tgt(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanSpecialSummonMonster(tp,22220007,nil,nil,0,0,12,RACE_BEAST,ATTRIBUTE_EARTH,POS_FACEUP_DEFENSE,1-tp) and Duel.GetLocationCount(1-tp,LOCATION_MZONE)>1 end
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,2,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,2,0,0)
end
function c22220006.opt(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return false end
	if Duel.IsPlayerCanSpecialSummonMonster(tp,22220007,nil,nil,0,0,12,RACE_BEAST,ATTRIBUTE_EARTH,POS_FACEUP_DEFENSE,1-tp) and Duel.GetLocationCount(1-tp,LOCATION_MZONE)>1 then
		for i=1,2 do
			local token=Duel.CreateToken(tp,22220007)
			Duel.SpecialSummonStep(token,0,tp,1-tp,false,false,POS_FACEUP_DEFENSE)
		end
		Duel.SpecialSummonComplete()
	end
end
function c22220006.eefilter(c)
	return c:IsFaceup() and c22220006.IsShirasawaTama(c)
end
function c22220006.eqtg1(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsFaceup() and chkc~=e:GetHandler() end
	if chk==0 then return e:GetHandler():GetFlagEffect(22220006)==0 and Duel.GetLocationCount(tp,LOCATION_SZONE)>0
		and Duel.IsExistingTarget(c22220006.eefilter,tp,LOCATION_MZONE,0,1,e:GetHandler()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	local g=Duel.SelectTarget(tp,c22220006.eefilter,tp,LOCATION_MZONE,0,1,1,e:GetHandler())
	Duel.SetOperationInfo(0,CATEGORY_EQUIP,g,1,0,0)
	e:GetHandler():RegisterFlagEffect(22220006,RESET_EVENT+0x7e0000+RESET_PHASE+PHASE_END,0,1)
end
function c22220006.eqop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if not c:IsRelateToEffect(e) or c:IsFacedown() then return end
	if not tc:IsRelateToEffect(e) or tc:IsFacedown() then
		Duel.SendtoGrave(c,REASON_EFFECT)
		return
	end
	if not Duel.Equip(tp,c,tc,false) then return end
	--unequip
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(22220006,1))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,0x1e0)
	e1:SetRange(LOCATION_SZONE)
	e1:SetTarget(c22220006.sptg)
	e1:SetOperation(c22220006.spop)
	e1:SetReset(RESET_EVENT+0x1fe0000)
	c:RegisterEffect(e1)
	--PIERCE
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_EQUIP)
	e5:SetCode(EFFECT_PIERCE)
	c:RegisterEffect(e5)
	--eqlimit
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetCode(EFFECT_EQUIP_LIMIT)
	e4:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e4:SetValue(c22220006.eqlimit)
	e4:SetReset(RESET_EVENT+0x1fe0000)
	e4:SetLabelObject(tc)
	c:RegisterEffect(e4)
end
function c22220006.eqlimit(e,c)
	return c==e:GetLabelObject()
end
function c22220006.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():GetFlagEffect(22220006)==0 and Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,true,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
	e:GetHandler():RegisterFlagEffect(22220006,RESET_EVENT+0x7e0000+RESET_PHASE+PHASE_END,0,1)
end
function c22220006.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.SpecialSummon(c,0,tp,tp,true,false,POS_FACEUP)
	end
end

function c22220006.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToRemoveAsCost() end
	Duel.Remove(e:GetHandler(),POS_FACEUP,REASON_COST)
end
function c22220006.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:GetControler()~=tp and chkc:GetLocation()==LOCATION_GRAVE and chkc:IsAbleToRemove() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsAbleToRemove,tp,0,LOCATION_GRAVE,2,nil) end
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,2,0,0)
end
function c22220006.operation(e,tp,eg,ep,ev,re,r,rp,chk)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectTarget(tp,Card.IsAbleToRemove,tp,0,LOCATION_GRAVE,2,2,nil)
	Duel.Remove(g,POS_FACEUP,REASON_EFFECT)
end