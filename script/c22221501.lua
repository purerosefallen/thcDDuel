--白泽球教室
function c22221501.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--atk down
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_DAMAGE_CALCULATING)
	e2:SetRange(LOCATION_FZONE)
	e2:SetOperation(c22221501.atkup)
	c:RegisterEffect(e2)
	--maintain
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e5:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e5:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e5:SetRange(LOCATION_FZONE)
	e5:SetCountLimit(1)
	e5:SetOperation(c22221501.mtop)
	c:RegisterEffect(e5)
	--Draw
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetCountLimit(1)
	e3:SetRange(LOCATION_FZONE)
	e3:SetCondition(c22221501.drcon)
	e3:SetOperation(c22221501.drop)
	c:RegisterEffect(e3)
	--actlimit
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD)
	e4:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e4:SetCode(EFFECT_CANNOT_ACTIVATE)
	e4:SetRange(LOCATION_FZONE)
	e4:SetTargetRange(0,1)
	e4:SetValue(c22221501.aclimit)
	e4:SetCondition(c22221501.actcon)
	c:RegisterEffect(e4)
end
c22221501.named_with_Shirasawa_Tama=1
function c22221501.IsShirasawaTama(c)
	local m=_G["c"..c:GetCode()]
	return m and m.named_with_Shirasawa_Tama
end

function c22221501.atkup(e,tp,eg,ep,ev,re,r,rp,chk)
	local a=Duel.GetAttacker()
	local d=Duel.GetAttackTarget()
	if not d or not (c22221501.IsShirasawaTama(d) and d:GetControler()==tp) then return end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetValue(-300)
	a:RegisterEffect(e1)
	local e2=Effect.CreateEffect(e:GetHandler())
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_UPDATE_DEFENSE)
	e2:SetValue(-200)
	a:RegisterEffect(e2)
end
function c22221501.mtfilter(c)
	return c:IsFaceup() and c22221501.IsShirasawaTama(c)
end

function c22221501.mtop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetTurnPlayer()~=tp then return end
	if Duel.IsExistingMatchingCard(c22221501.mtfilter,tp,LOCATION_MZONE,0,1,nil) then
		local g=Duel.SelectMatchingCard(tp,c22221501.mtfilter,tp,LOCATION_MZONE,0,1,1,nil)
		Duel.Remove(g,POS_FACEUP,REASON_RULE)
	else
		Duel.Remove(e:GetHandler(),POS_FACEUP,REASON_RULE)
	end
end
function c22221501.aclimit(e,re,tp)
	return not re:GetHandler():IsImmuneToEffect(e)
end
function c22221501.cfilter(c,tp)
	return c:IsFaceup() and c22221501.IsShirasawaTama(c) and c:IsControler(tp)
end
function c22221501.actcon(e)
	local tp=e:GetHandlerPlayer()
	local a=Duel.GetAttacker()
	local d=Duel.GetAttackTarget()
	return (a and c22221501.cfilter(a,tp)) or (d and c22221501.cfilter(d,tp))
end
function c22221501.filterd(c,e,tp)
	return c22221501.IsShirasawaTama(c)
end
function c22221501.drcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetMatchingGroupCount(c22221501.filterd,tp,LOCATION_GRAVE+LOCATION_REMOVED,0,nil)>2
end
function c22221501.drop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return false end
	local g=Duel.SelectMatchingCard(tp,c22221501.filterd,tp,LOCATION_GRAVE+LOCATION_REMOVED,0,3,9,nil)
	Duel.SendtoDeck(g,nil,2,REASON_EFFECT)
	local ct=math.floor(g:GetCount()/3)
	Duel.Draw(tp,ct,REASON_EFFECT)
end





