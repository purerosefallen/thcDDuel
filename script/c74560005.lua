--MorisawaつUmi
function c74560005.initial_effect(c)
	--tohand
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND)
	e1:SetDescription(aux.Stringid(74560005,0))
	e1:SetCountLimit(1,74560005)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetRange(LOCATION_MZONE+LOCATION_HAND)
	e1:SetCost(c74560005.cost)
	e1:SetTarget(c74560005.target)
	e1:SetOperation(c74560005.operation)
	c:RegisterEffect(e1)
	--print
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(74560005,1))
	e2:SetCategory(CATEGORY_DRAW+CATEGORY_TODECK)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e2:SetCode(EVENT_CUSTOM+74567456)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCountLimit(1)
	e2:SetCost(c74560005.cost)
	e2:SetOperation(c74560005.op)
	c:RegisterEffect(e2)
end
c74560005.named_with_Die=1
function c74560005.IsDie(c)
	local m=_G["c"..c:GetCode()]
	return m and m.named_with_Die
end
function c74560005.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SendtoDeck(e:GetHandler(),tp,-1,REASON_COST)
	Duel.RaiseEvent(e:GetHandler(),EVENT_CUSTOM+74567456,e,0,tp,0,0)
end
function c74560005.filter(c)
	return c74560005.IsDie(c) and c:IsAbleToHand()
end
function c74560005.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c74560005.filter,tp,LOCATION_DECK,0,1,nil) end
end
function c74560005.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c74560005.filter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
function c74560005.op(e,tp,eg,ep,ev,re,r,rp)
	local t = {
		[1] = {desc=aux.Stringid(74560001,2),code=74560001},
		[2] = {desc=aux.Stringid(74560001,3),code=74560002},
		[3] = {desc=aux.Stringid(74560001,4),code=74560003},
		[4] = {desc=aux.Stringid(74560001,5),code=74560004},
		[5] = {desc=aux.Stringid(74560001,6),code=74560005},
		[6] = {desc=aux.Stringid(74560001,7),code=74560006},
		[7] = {desc=aux.Stringid(74560001,8),code=74560008},
		[8] = {desc=aux.Stringid(74560001,9),code=74560009},
		[9] = {desc=aux.Stringid(74560001,10),code=74560010},
		[10] = {desc=aux.Stringid(74560001,11),code=74560011},
	}
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(74560001,12))
	local sel=Duel.SelectOption(tp,Nef.unpackOneMember(t, "desc"))+1
	local code=t[sel].code
	local token=Duel.CreateToken(tp,code)
	Duel.SendtoDeck(token,tp,2,REASON_EFFECT)
	Duel.Draw(tp,1,REASON_EFFECT)
end







