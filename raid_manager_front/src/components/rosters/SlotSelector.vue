<template>
  <div class="p-3" style="min-width: 150px;position: relative;">
    <div class="flex flex-align-center flex-items-center" :class="classFor(currentSlot.ch_class)" style="position: relative;border: 1px solid #e6e6e6;">
      <!-- ROLE -->
      <div class="role-selector">
        <div @click="openedRole = !openedRole" class="pointer p-1">
          <img v-if="currentSlot.role === 'tank'" src="@/assets/tank.png" class="logo-role">
          <img v-if="currentSlot.role === 'heal'" src="@/assets/heal.png" class="logo-role">
          <img v-if="currentSlot.role === 'dps'" src="@/assets/dps.png" class="logo-role">
        </div>
        <!-- Role selector -->
        <div style="position: absolute; left:0px; top:100%;z-index: 10;background-color: #fff;border: 1px solid #e6e6e6;border-radius: 3px;box-shadow: 0px 0px 5px rgba(0, 0, 0, 0.7);" :class="openedRoleSelector">
          <div class="p-1 pointer" @click="selectNewRole('tank')"><img src="@/assets/tank.png" class="logo-role"></div>
          <div class="p-1 pointer" @click="selectNewRole('heal')"><img src="@/assets/heal.png" class="logo-role"></div>
          <div class="p-1 pointer" @click="selectNewRole('dps')"><img src="@/assets/dps.png" class="logo-role"></div>
        </div>
      </div>

      <!-- GOAL -->
      <div class="goal-selector">
        <div @click="openedGoal = !openedGoal" class="pointer p-1">
          <img v-if="currentSlot.goal === 'mt'" src="@/assets/mt.png" class="logo-role">
          <img v-if="currentSlot.goal === 'ot1'" src="@/assets/ot1.png" class="logo-role">
          <img v-if="currentSlot.goal === 'ot2'" src="@/assets/ot2.png" class="logo-role">
          <img v-if="currentSlot.goal === 'ot3'" src="@/assets/ot3.png" class="logo-role">
          <img v-if="currentSlot.goal === 'ot4'" src="@/assets/ot4.png" class="logo-role">
          <img v-if="currentSlot.goal === 'puller'" src="@/assets/puller.png" class="logo-role">
          <img v-if="currentSlot.goal === 'raid_heal'" src="@/assets/raid_heal.png" class="logo-role">
          <img v-if="currentSlot.goal === 'tank_heal'" src="@/assets/tank_heal.png" class="logo-role">
          <img v-if="currentSlot.goal === 'heal'" src="@/assets/heal.png" class="logo-role">
          <img v-if="currentSlot.goal === 'dps'" src="@/assets/dps.png" class="logo-role">
          <img v-if="currentSlot.goal === 'tank'" src="@/assets/tank.png" class="logo-role">
        </div>
        <!-- Goal selector -->
        <div style="position: absolute; left:0px; top:100%;z-index: 10;background-color: #fff;border: 1px solid #e6e6e6;border-radius: 3px;box-shadow: 0px 0px 5px rgba(0, 0, 0, 0.7);" :class="openedGoalSelector">
          <div class="flex flex-items-center class-selector-item pr-3" @click="selectNewGoal('mt')">
            <img src="@/assets/mt.png" class="logo-role">
            <div class="pl-2">MT</div>
          </div>
          <div class="flex flex-items-center class-selector-item pr-3" @click="selectNewGoal('ot1')">
            <img src="@/assets/ot1.png" class="logo-role">
            <div class="pl-2">OT1</div>
          </div>
          <div class="flex flex-items-center class-selector-item pr-3" @click="selectNewGoal('ot2')">
            <img src="@/assets/ot2.png" class="logo-role">
            <div class="pl-2">OT2</div>
          </div>
          <div class="flex flex-items-center class-selector-item pr-3" @click="selectNewGoal('ot3')">
            <img src="@/assets/ot3.png" class="logo-role">
            <div class="pl-2">OT3</div>
          </div>
          <div class="flex flex-items-center class-selector-item pr-3" @click="selectNewGoal('ot4')">
            <img src="@/assets/ot4.png" class="logo-role">
            <div class="pl-2">OT4</div>
          </div>
          <div class="flex flex-items-center class-selector-item pr-3" @click="selectNewGoal('puller')">
            <img src="@/assets/puller.png" class="logo-role">
            <div class="pl-2">Puller</div>
          </div>
          <div class="flex flex-items-center class-selector-item pr-3" @click="selectNewGoal('raid_heal')">
            <img src="@/assets/raid_heal.png" class="logo-role">
            <div class="pl-2">Raid heal</div>
          </div>
          <div class="flex flex-items-center class-selector-item pr-3" @click="selectNewGoal('tank_heal')">
            <img src="@/assets/tank_heal.png" class="logo-role">
            <div class="pl-2">Tank heal</div>
          </div>
          <div class="flex flex-items-center class-selector-item pr-3" @click="selectNewGoal('heal')">
            <img src="@/assets/heal.png" class="logo-role">
            <div class="pl-2">Heal</div>
          </div>
          <div class="flex flex-items-center class-selector-item pr-3" @click="selectNewGoal('dps')">
            <img src="@/assets/dps.png" class="logo-role">
            <div class="pl-2">Dps</div>
          </div>
        </div>
      </div>

      <div class="class-select-wrapper">
        <!-- CHAR -->
        <select class="form-control" v-model="selectedChar" @change="updateCurrentSlot()" style="min-width: 150px;">
          <option value="">-</option>
          <option v-for="char in availableCharacters" :key="char.id" :value="char.id">
            {{ char.name }} [{{ char.ch_class }}]
          </option>
        </select>

        <!-- CLASS -->
        <div class="role-selector">
          <div @click="openedClass = !openedClass" class="pointer p-1">
            <img v-if="currentSlot.ch_class === 'druid'" src="@/assets/druid.png" class="logo-role">
            <img v-if="currentSlot.ch_class === 'hunter'" src="@/assets/hunter.png" class="logo-role">
            <img v-if="currentSlot.ch_class === 'mage'" src="@/assets/mage.png" class="logo-role">
            <img v-if="currentSlot.ch_class === 'priest'" src="@/assets/priest.png" class="logo-role">
            <img v-if="currentSlot.ch_class === 'rogue'" src="@/assets/rogue.png" class="logo-role">
            <img v-if="currentSlot.ch_class === 'shaman'" src="@/assets/shaman.png" class="logo-role">
            <img v-if="currentSlot.ch_class === 'warrior'" src="@/assets/warrior.png" class="logo-role">
            <img v-if="currentSlot.ch_class === 'warlock'" src="@/assets/warlock.png" class="logo-role">
          </div>
          <!-- Class selector -->
          <div style="position: absolute; right:3px; top:100%;z-index: 10;background-color: #fff;border: 1px solid #e6e6e6;border-radius: 3px;box-shadow: 0px 0px 5px rgba(0, 0, 0, 0.7);" :class="openedClassSelector">
            <div class="p-1 pointer" @click="selectNewClass('druid')"><img src="@/assets/druid.png" class="logo-role"></div>
            <div class="p-1 pointer" @click="selectNewClass('hunter')"><img src="@/assets/hunter.png" class="logo-role"></div>
            <div class="p-1 pointer" @click="selectNewClass('mage')"><img src="@/assets/mage.png" class="logo-role"></div>
            <div class="p-1 pointer" @click="selectNewClass('priest')"><img src="@/assets/priest.png" class="logo-role"></div>
            <div class="p-1 pointer" @click="selectNewClass('rogue')"><img src="@/assets/rogue.png" class="logo-role"></div>
            <div class="p-1 pointer" @click="selectNewClass('shaman')"><img src="@/assets/shaman.png" class="logo-role"></div>
            <div class="p-1 pointer" @click="selectNewClass('warrior')"><img src="@/assets/warrior.png" class="logo-role"></div>
            <div class="p-1 pointer" @click="selectNewClass('warlock')"><img src="@/assets/warlock.png" class="logo-role"></div>
          </div>
        </div>
      </div>
    </div>

    <div v-if="error" style="font-size: 14px;position: absolute;width: 89%;z-index: 10;background-color: #fff;border: 1px solid #e6e6e6;padding: 2px;">
      {{ error }} <span @click="clearError()" class="pointer btn-sm btn-danger">x</span>
    </div>
  </div>
</template>

<script>
export default {
  name: 'SlotSelector',
  props: {
    theSlot: {
      type: Object,
      required: true
    },
    rosterId: {
      type: Number,
      required: true
    },
    characters: {
      type: Array,
      required: true
    }
  },
  data () {
    return {
      error: '',
      currentSlot: '',
      selectedChar: '',
      openedRole: false,
      openedClass: false,
      openedGoal: false,
      selectedRole: '',
      selectedClass: '',
      selectedGoal: ''
    }
  },
  created () {
    this.currentSlot = this.theSlot
    this.selectedChar = this.currentSlot.character_id
  },
  computed: {
    availableCharacters () {
      return this.characters.filter(char => char.roles.includes(this.currentSlot.role) && char.ch_class === this.currentSlot.ch_class)
    },
    openedRoleSelector () {
      return this.openedRole ? '' : 'hide'
    },
    openedGoalSelector () {
      return this.openedGoal ? '' : 'hide'
    },
    openedClassSelector () {
      return this.openedClass ? '' : 'hide'
    }
  },
  methods: {
    classFor (chClass) {
      return `bg-${chClass}`
    },
    setError (error, text) {
      this.error = (error.response && error.response.data && error.response.data.message) || text
    },
    clearError () {
      this.error = ''
    },
    updateCurrentSlot () {
      this.$http.secured.patch(`/api/v1/rosters/${this.rosterId}/update_slot`, {
        slot_id: this.currentSlot.id,
        character_id: this.selectedChar,
        role: this.selectedRole,
        goal: this.selectedGoal,
        ch_class: this.selectedClass,
        roster_id: this.rosterId
      }).then(response => {
        this.currentSlot = Object.values(response.data.template).find(slot => slot.id === this.currentSlot.id)
        this.selectedRole = this.currentSlot.role
        this.selectedClass = this.currentSlot.ch_class
        this.selectedGoal = this.currentSlot.goal
        this.selectedChar = this.currentSlot.character_id
      }).catch(error => {
        this.selectedChar = ''
        this.selectedRole = ''
        this.selectedClass = ''
        this.selectedGoal = ''
        this.setError(error, 'Cannot add the character')
      })
    },
    selectNewRole (newRole) {
      this.openedRole = false
      this.selectedRole = newRole
      this.updateCurrentSlot()
    },
    selectNewClass (newClass) {
      this.openedClass = false
      this.selectedClass = newClass
      this.updateCurrentSlot()
    },
    selectNewGoal (newGoal) {
      this.openedGoal = false
      this.selectedGoal = newGoal
      this.updateCurrentSlot()
    }
  }
}
</script>
