<template>
  <div class="p-3" style="min-width: 150px;">
    <div class="flex flex-align-center flex-items-center" style="position: relative;">
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

      <!-- CLASS -->
      <div class="class-selector">
        <div @click="openedClass = !openedClass" :class="classFor(selectedClass)" class="class-selector-current">
          {{ selectedClass }}
        </div>
        <!-- Class selector -->
        <div :class="openedClassSelector" class="class-selector-list">
          <div value="druid" class="class-selector-item" :class="classFor('druid')" @click="selectNewClass('druid')">Druid</div>
          <div value="hunter" class="class-selector-item" :class="classFor('hunter')" @click="selectNewClass('hunter')">Hunter</div>
          <div value="mage" class="class-selector-item" :class="classFor('mage')" @click="selectNewClass('mage')">Mage</div>
          <div value="priest" class="class-selector-item" :class="classFor('priest')" @click="selectNewClass('priest')">Priest</div>
          <div value="rogue" class="class-selector-item" :class="classFor('rogue')" @click="selectNewClass('rogue')">Rogue</div>
          <div value="shaman" class="class-selector-item" :class="classFor('shaman')" @click="selectNewClass('shaman')">Shaman</div>
          <div value="warrior" class="class-selector-item" :class="classFor('warrior')" @click="selectNewClass('warrior')">Warrior</div>
          <div value="warlock" class="class-selector-item" :class="classFor('warlock')" @click="selectNewClass('warlock')">Warlock</div>
        </div>
      </div>

    </div>
    <div v-if="error">
      {{ error }}
    </div>
  </div>
</template>

<script>
export default {
  name: 'CompoSlot',
  props: {
    theSlot: {
      type: Object,
      required: true
    },
    compoId: {
      type: Number,
      required: true
    }
  },
  data () {
    return {
      error: '',
      currentSlot: '',
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
    this.setupSlot()
  },
  computed: {
    openedRoleSelector () {
      return this.openedRole ? '' : 'hide'
    },
    openedClassSelector () {
      return this.openedClass ? '' : 'hide'
    },
    openedGoalSelector () {
      return this.openedGoal ? '' : 'hide'
    }
  },
  methods: {
    classFor (chClass) {
      return `bg-${chClass}`
    },
    setupSlot () {
      this.selectedClass = this.currentSlot.ch_class
      this.selectedRole = this.currentSlot.role
    },
    setError (error, text) {
      this.error = (error.response && error.response.data) || error.message || text
    },
    updateCurrentSlot () {
      this.$http.secured.patch(`/api/v1/basic_compos/${this.compoId}/update_slot`, {
        slot_id: this.currentSlot.id,
        ch_class: this.selectedClass,
        role: this.selectedRole,
        goal: this.selectedGoal
      }).then(response => {
        this.currentSlot = Object.values(response.data.template).find(slot => slot.id === this.currentSlot.id)
        this.setupSlot()
      }).catch(error => this.setError(error, 'Cannot update the slot'))
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
