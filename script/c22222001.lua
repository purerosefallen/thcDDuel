--白泽球的装甲
function c22222001.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetCondition(c22222001.condition)
	e1:SetOperation(c22222001.activate)
	c:RegisterEffect(e1)	
end
c22222001.named_with_Shirasawa_Tama=1
function c22222001.IsShirasawaTama(c)
	local m=_G["c"..c:GetCode()]
	return m and m.named_with_Shirasawa_Tama
end
function c22222001.confilter(c)
	return c:IsFaceup() and c22222001.IsShirasawaTama(c)
end
function c22222001.condition(e,tp,eg,ep,ev,re,r,rp)
	return tp~=Duel.GetTurnPlayer() and Duel.IsExistingMatchingCard(c22222001.confilter,tp,LOCATION_MZONE,0,1,nil)
end
function c22222001.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetAttacker()
	local val=tc:GetAttack()
	Duel.Remove(tc,POS_FACEUP,REASON_EFFECT)
	Duel.Damage(1-tp,val/2,REASON_EFFECT)

end