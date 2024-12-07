extends Node

#Basic signals for gaining energy and triggering an entity's attack
signal gainEnergy(who)
signal timeToAttack(who)
signal sendAttack(attacker,)

#Signals to update amount of energy gained per second or to change the amount of time it takes to attack
signal updateEnergyGain(who: Entity, amount: float)
signal updateAttackCooldown(who: Entity, amount: float)

#Signal for when an Entity dies
signal deathSignal(victim: Entity, killer: Entity)
