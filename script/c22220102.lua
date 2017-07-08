--月之首脑¤白泽球
function c22220102.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,c22220102.xyzfilter,2,3,nil,nil,5)
	c:EnableReviveLimit()  
	aux.EnablePendulumAttribute(c)
	--draw
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_DRAW+CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_ATTACK_ANNOUNCE)
	e2:SetRange(LOCATION_PZONE)
	e2:SetCountLimit(1)
	e2:SetCondition(c22220102.conp)
	e2:SetTarget(c22220102.tgp)
	e2:SetOperation(c22220102.opp)
	c:RegisterEffect(e2)
-----------------------------------------------------------
	--atk & def
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetCode(EFFECT_SET_BASE_ATTACK)
	e4:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e4:SetRange(LOCATION_MZONE)
	e4:SetValue(c22220102.atkval)
	c:RegisterEffect(e4)
	local e5=e4:Clone()
	e5:SetCode(EFFECT_SET_BASE_DEFENSE)
	e5:SetValue(c22220102.defval)
	c:RegisterEffect(e5)
---------------------------------------------------------
	--indestructable
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCode(EFFECT_INDESTRUCTABLE_COUNT)
	e3:SetCountLimit(1)
	e3:SetCondition(c22220102.con1)
	e3:SetValue(c22220102.valcon1)
	c:RegisterEffect(e3)
	--indestructable
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCode(EFFECT_INDESTRUCTABLE_COUNT)
	e3:SetCountLimit(1)
	e3:SetCondition(c22220102.con2)
	e3:SetValue(c22220102.valcon2)
	c:RegisterEffect(e3)
	--immune
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EFFECT_IMMUNE_EFFECT)
	e2:SetCondition(c22220102.con3)
	e2:SetValue(c22220102.efilter3)
	c:RegisterEffect(e2)
	--immune
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EFFECT_IMMUNE_EFFECT)
	e2:SetCondition(c22220102.con4)
	e2:SetValue(c22220102.efilter4)
	c:RegisterEffect(e2)
	--immune
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EFFECT_IMMUNE_EFFECT)
	e2:SetCondition(c22220102.con5)
	e2:SetValue(c22220102.efilter5)
	c:RegisterEffect(e2)
	--pierce
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_PIERCE)
	e3:SetCondition(c22220102.con6)
	c:RegisterEffect(e3)
	--attack all
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_ATTACK_ALL)
	e3:SetValue(1)
	e3:SetCondition(c22220102.con7)
	c:RegisterEffect(e3)
	--remove
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e3:SetCategory(CATEGORY_REMOVE)
	e3:SetCode(EVENT_BATTLED)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCondition(c22220102.con8)
	e3:SetTarget(c22220102.tg8)
	e3:SetOperation(c22220102.op8)
	c:RegisterEffect(e3)
	--DIRECT_ATTACK
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_DIRECT_ATTACK)
	e3:SetCondition(c22220102.con9)
	c:RegisterEffect(e3)
	--atk & def
	local e9=Effect.CreateEffect(c)
	e9:SetType(EFFECT_TYPE_SINGLE)
	e9:SetCode(EFFECT_UPDATE_ATTACK)
	e9:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e9:SetCondition(c22220102.con10)
	e9:SetRange(LOCATION_MZONE)
	e9:SetValue(1200)
	c:RegisterEffect(e9)
	local e5=e9:Clone()
	e5:SetCode(EFFECT_UPDATE_DEFENSE)
	e5:SetValue(800)
	c:RegisterEffect(e5)
------------------------------------------------------------
	--pendulum set
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_BATTLE_DESTROYED)
	e3:SetTarget(c22220102.pentg)
	e3:SetOperation(c22220102.penop)
	c:RegisterEffect(e3)

end
c22220102.pendulum_level=2
c22220102.named_with_Shirasawa_Tama=1
function c22220102.IsShirasawaTama(c)
	local m=_G["c"..c:GetCode()]
	return m and m.named_with_Shirasawa_Tama
end
function c22220102.xyzfilter(c)
	return c22220102.IsShirasawaTama(c) and c:IsType(TYPE_MONSTER)
end
function c22220102.atkval(e,c)
	return c:GetOverlayCount()*300
end
function c22220102.defval(e,c)
	return c:GetOverlayCount()*200
end
function c22220102.valcon1(e,re,r,rp)
	return bit.band(r,REASON_EFFECT)~=0
end
function c22220102.filter1(c)
	return c:IsCode(22220001)
end
function c22220102.con1(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetOverlayGroup():IsExists(c22220102.filter1,1,nil)
end
function c22220102.valcon2(e,re,r,rp)
	return bit.band(r,REASON_BATTLE)~=0
end
function c22220102.filter2(c)
	return c:IsCode(22220002)
end
function c22220102.con2(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetOverlayGroup():IsExists(c22220102.filter2,1,nil)
end
function c22220102.filter3(c)
	return c:IsCode(22220003)
end
function c22220102.con3(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetOverlayGroup():IsExists(c22220102.filter3,1,nil)
end
function c22220102.efilter3(e,te)
	return te:IsActiveType(TYPE_MONSTER) and te:GetOwnerPlayer()~=e:GetHandlerPlayer()
end
function c22220102.filter4(c)
	return c:IsCode(22220004)
end
function c22220102.con4(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetOverlayGroup():IsExists(c22220102.filter4,1,nil)
end
function c22220102.efilter4(e,te)
	return te:IsActiveType(TYPE_TRAP) and te:GetOwnerPlayer()~=e:GetHandlerPlayer()
end
function c22220102.filter5(c)
	return c:IsCode(22220005)
end
function c22220102.con5(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetOverlayGroup():IsExists(c22220102.filter5,1,nil)
end
function c22220102.efilter5(e,te)
	return te:IsActiveType(TYPE_SPELL) and te:GetOwnerPlayer()~=e:GetHandlerPlayer()
end
function c22220102.filter6(c)
	return c:IsCode(22220006)
end
function c22220102.con6(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetOverlayGroup():IsExists(c22220102.filter6,1,nil)
end
function c22220102.filter7(c)
	return c:IsCode(22220008)
end
function c22220102.con7(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetOverlayGroup():IsExists(c22220102.filter7,1,nil)
end
function c22220102.filter8(c)
	return c:IsCode(22220010)
end
function c22220102.con8(e,tp,eg,ep,ev,re,r,rp)
	local a=Duel.GetAttacker()
	local d=Duel.GetAttackTarget()
	local c=e:GetHandler()
	return d and (a==c or d==c) and e:GetHandler():GetOverlayGroup():IsExists(c22220102.filter8,1,nil)
end
function c22220102.tg8(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local tc=e:GetHandler():GetBattleTarget()
	Duel.SetTargetCard(tc)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,tc,1,0,0)
end
function c22220102.op8(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.Destroy(tc,REASON_EFFECT,LOCATION_REMOVED)
	end
end
function c22220102.filter9(c)
	return c:IsCode(22220101)
end
function c22220102.con9(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetOverlayGroup():IsExists(c22220102.filter9,1,nil)
end
function c22220102.pentg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLocation(tp,LOCATION_SZONE,6) or Duel.CheckLocation(tp,LOCATION_SZONE,7) end
end
function c22220102.penop(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():IsRelateToEffect(e)
		and (Duel.CheckLocation(tp,LOCATION_SZONE,6) or Duel.CheckLocation(tp,LOCATION_SZONE,7)) then
		Duel.MoveToField(e:GetHandler(),tp,tp,LOCATION_SZONE,POS_FACEUP,true)
	end
end
function c22220102.conp(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetAttacker():IsControler(1-tp)
end
function c22220102.tgp(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,1) end
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c22220102.opp(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return false end
	if Duel.Draw(tp,1,REASON_EFFECT)==0 then return end
	local tc=Duel.GetOperatedGroup():GetFirst()
	if tc:IsType(TYPE_MONSTER) and c22220102.IsShirasawaTama(tc) then
		if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
		if tc:IsCanBeSpecialSummoned(e,0,tp,false,false) and Duel.SelectYesNo(tp,aux.Stringid(22220102,2)) then
			Duel.ConfirmCards(1-tp,tc)
			Duel.BreakEffect()
			if Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)~=0 and not Duel.GetAttacker():IsImmuneToEffect(e) then
				Duel.BreakEffect()
				Duel.ChangeAttackTarget(tc)
			end
		end
	end
end
function c22220102.filter10(c)
	return c:IsCode(22220011)
end
function c22220102.con10(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetOverlayGroup():IsExists(c22220102.filter10,1,nil)
end

