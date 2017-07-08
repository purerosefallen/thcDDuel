--普通的魔法使¤白泽球
function c22220010.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
	--atk&def
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetRange(LOCATION_PZONE)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetTarget(c22220010.tgval)
	e1:SetValue(c22220010.atkval)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_UPDATE_DEFENSE)
	c:RegisterEffect(e2)
	--equip
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(22220010,1))
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetCategory(CATEGORY_EQUIP)
	e3:SetRange(LOCATION_HAND)
	e3:SetTarget(c22220010.eqtg)
	e3:SetOperation(c22220010.eqop)
	c:RegisterEffect(e3)
	--remove
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(22220010,2))
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e3:SetCategory(CATEGORY_REMOVE)
	e3:SetCode(EVENT_BATTLED)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCondition(c22220010.rmcon)
	e3:SetTarget(c22220010.rmtg)
	e3:SetOperation(c22220010.rmop)
	c:RegisterEffect(e3)
	--remove
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(22220010,0))
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCode(EVENT_DAMAGE)
	e2:SetCondition(c22220010.condition)
	e2:SetOperation(c22220010.operation)
	c:RegisterEffect(e2)
	-- atk up
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetCondition(c22220010.condtionz)
	e1:SetValue(c22220010.valuez)
	c:RegisterEffect(e1)	
end
c22220010.named_with_Shirasawa_Tama=1
function c22220010.IsShirasawaTama(c)
	local m=_G["c"..c:GetCode()]
	return m and m.named_with_Shirasawa_Tama
end
function c22220010.ffilter(c)
	return c22220010.IsShirasawaTama(c) and c:IsFaceup()
end

function c22220010.condtionz(e)
	local ph=Duel.GetCurrentPhase()
	return (ph==PHASE_DAMAGE or ph==PHASE_DAMAGE_CAL)
		and (Duel.GetAttacker()==e:GetHandler() or Duel.GetAttackTarget()==e:GetHandler())
end

function c22220010.valuez(e,c)
	local tp = e:GetHandler():GetControler()
	return Duel.GetMatchingGroupCount(c22220010.ffilter, tp, LOCATION_EXTRA, 0, nil)*200
end
function c22220010.tgfilter(c)
	return c:IsFaceup() and c22220010.IsShirasawaTama(c) and c:IsControler(tp)
end
function c22220010.tgval(e,c)
	local g=Duel.GetMatchingGroup(c22220010.tgfilter,c:GetControler(),LOCATION_MZONE,0,nil)
	return g
end
function c22220010.atkfilter(c)
	return c:IsFaceup() and c22220010.IsShirasawaTama(c) and c:IsType(TYPE_MONSTER)
end
function c22220010.atkval(e,c)
	local g=Duel.GetMatchingGroup(c22220010.atkfilter,c:GetControler(),LOCATION_EXTRA,0,nil)
	return g:GetClassCount(Card.GetCode)*150
end
function c22220010.eqfilter(c)
	return c:IsFaceup() and c22220010.IsShirasawaTama(c)
end
function c22220010.eqtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c22220010.eqfilter(chkc) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_SZONE)>0
		and Duel.IsExistingTarget(c22220010.eqfilter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	Duel.SelectTarget(tp,c22220010.eqfilter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c22220010.eqop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	local tc=Duel.GetFirstTarget()
	if Duel.GetLocationCount(tp,LOCATION_SZONE)<=0 or tc:GetControler()~=tp or tc:IsFacedown() or not tc:IsRelateToEffect(e) then
		Duel.SendtoGrave(c,REASON_EFFECT)
		return
	end
	Duel.Equip(tp,c,tc,true)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_EQUIP_LIMIT)
	e1:SetReset(RESET_EVENT+0x1fe0000)
	e1:SetValue(c22220010.eqlimit)
	e1:SetLabelObject(tc)
	c:RegisterEffect(e1)
end
function c22220010.eqlimit(e,c)
	return c==e:GetLabelObject()
end
function c22220010.rmcon(e,tp,eg,ep,ev,re,r,rp)
	local a=Duel.GetAttacker()
	local d=Duel.GetAttackTarget()
	local c=e:GetHandler():GetEquipTarget()
	return d and (a==c or d==c)
end
function c22220010.rmtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local tc=e:GetHandler():GetEquipTarget():GetBattleTarget()
	Duel.SetTargetCard(tc)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,tc,1,0,0)
end
function c22220010.rmop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.Destroy(tc,REASON_EFFECT,LOCATION_REMOVED)
	end
end
function c22220010.condition(e,tp,eg,ep,ev,re,r,rp)
	return ep==tp
end
function c22220010.operation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.Remove(e:GetHandler(),POS_FACEUP,REASON_EFFECT)~=0 then
		Duel.BreakEffect()
	local g=Duel.GetFieldGroup(tp,LOCATION_ONFIELD,LOCATION_ONFIELD)
	if g:GetCount()<1 then return end
	local sg=g:RandomSelect(1-tp,1)
	Duel.Destroy(sg,REASON_EFFECT)
end
	end