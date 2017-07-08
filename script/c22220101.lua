--须臾的罪人¤白泽球
function c22220101.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,c22220101.xyzfilter,2,2)
	c:EnableReviveLimit()   
	aux.EnablePendulumAttribute(c)
	--draw
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(22220101,0))
	e2:SetCategory(CATEGORY_DRAW)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetRange(LOCATION_PZONE)
	e2:SetCode(EVENT_DESTROYED)
	e2:SetCountLimit(1)
	e2:SetCondition(c22220101.drcon)
	e2:SetTarget(c22220101.drtg)
	e2:SetOperation(c22220101.drop)
	c:RegisterEffect(e2)
	--tohand
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(22220101,1))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetCountLimit(1,22220101)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCost(c22220101.xcost)
	e1:SetTarget(c22220101.xtarget)
	e1:SetOperation(c22220101.xoperation)
	c:RegisterEffect(e1)
	--equip
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(22220101,2))
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCategory(CATEGORY_EQUIP)
	e1:SetRange(LOCATION_MZONE)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,0x1e0)
	e1:SetTarget(c22220101.eqtg1)
	e1:SetOperation(c22220101.eqop)
	c:RegisterEffect(e1)
	--pendulum set
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_BATTLE_DESTROYED)
	e3:SetTarget(c22220101.pentg)
	e3:SetOperation(c22220101.penop)
	c:RegisterEffect(e3)
	--xyz lv
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_SINGLE)
	e5:SetCode(EFFECT_XYZ_LEVEL)
	e5:SetValue(2)
	c:RegisterEffect(e5)
end
c22220101.pendulum_level=2
c22220101.named_with_Shirasawa_Tama=1
function c22220101.IsShirasawaTama(c)
	local m=_G["c"..c:GetCode()]
	return m and m.named_with_Shirasawa_Tama
end
function c22220101.xyzfilter(c)
	return c22220101.IsShirasawaTama(c) and c:IsType(TYPE_MONSTER)
end
function c22220101.cfilter(c,tp)
	return c22220101.IsShirasawaTama(c) and c:GetPreviousControler()==tp
end
function c22220101.drcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c22220101.cfilter,1,nil,tp)
end
function c22220101.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,1) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(1)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c22220101.drop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
end
function c22220101.xcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c22220101.xfilter(c)
	return c22220101.IsShirasawaTama(c) and c:IsAbleToHand()
end
function c22220101.xtarget(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c22220101.xfilter,tp,LOCATION_GRAVE+LOCATION_REMOVED,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_GRAVE+LOCATION_REMOVED)
end
function c22220101.xoperation(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c22220101.xfilter,tp,LOCATION_GRAVE+LOCATION_REMOVED,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
function c22220101.eefilter(c)
	return c:IsFaceup() and c22220101.IsShirasawaTama(c)
end
function c22220101.eqtg1(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsFaceup() and chkc~=e:GetHandler() end
	if chk==0 then return e:GetHandler():GetFlagEffect(22220101)==0 and Duel.GetLocationCount(tp,LOCATION_SZONE)>0
		and Duel.IsExistingTarget(c22220101.eefilter,tp,LOCATION_MZONE,0,1,e:GetHandler()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	local g=Duel.SelectTarget(tp,c22220101.eefilter,tp,LOCATION_MZONE,0,1,1,e:GetHandler())
	Duel.SetOperationInfo(0,CATEGORY_EQUIP,g,1,0,0)
	e:GetHandler():RegisterFlagEffect(22220101,RESET_EVENT+0x7e0000+RESET_PHASE+PHASE_END,0,1)
end
function c22220101.eqop(e,tp,eg,ep,ev,re,r,rp)
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
	e1:SetDescription(aux.Stringid(22220101,3))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,0x1e0)
	e1:SetRange(LOCATION_SZONE)
	e1:SetTarget(c22220101.sptg)
	e1:SetOperation(c22220101.spop)
	e1:SetReset(RESET_EVENT+0x1fe0000)
	c:RegisterEffect(e1)
	--DIRECT_ATTACK
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_EQUIP)
	e5:SetCode(EFFECT_DIRECT_ATTACK)
	c:RegisterEffect(e5)
	--eqlimit
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetCode(EFFECT_EQUIP_LIMIT)
	e4:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e4:SetValue(c22220101.eqlimit)
	e4:SetReset(RESET_EVENT+0x1fe0000)
	e4:SetLabelObject(tc)
	c:RegisterEffect(e4)
end
function c22220101.eqlimit(e,c)
	return c==e:GetLabelObject()
end
function c22220101.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():GetFlagEffect(22220101)==0 and Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,true,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
	e:GetHandler():RegisterFlagEffect(22220101,RESET_EVENT+0x7e0000+RESET_PHASE+PHASE_END,0,1)
end
function c22220101.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.SpecialSummon(c,0,tp,tp,true,false,POS_FACEUP)
	end
end
function c22220101.pentg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLocation(tp,LOCATION_SZONE,6) or Duel.CheckLocation(tp,LOCATION_SZONE,7) end
end
function c22220101.penop(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():IsRelateToEffect(e)
		and (Duel.CheckLocation(tp,LOCATION_SZONE,6) or Duel.CheckLocation(tp,LOCATION_SZONE,7)) then
		Duel.MoveToField(e:GetHandler(),tp,tp,LOCATION_SZONE,POS_FACEUP,true)
	end
end