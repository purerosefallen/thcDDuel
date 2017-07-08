--魔法衍生物つdie毛
function c74561202.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
end
c74561202.named_with_Die=1
function c74561202.IsDie(c)
	local m=_G["c"..c:GetCode()]
	return m and m.named_with_Die
end