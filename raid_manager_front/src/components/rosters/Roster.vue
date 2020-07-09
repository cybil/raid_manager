<template>
  <div>
    <div v-if="error" class="alert alert-danger col-md-11 mx-auto">{{ error }}</div>
    <h3>Roster {{roster.name}}</h3>

    <div class="flex flex-align-center flex-items-center col-md-11 mx-auto">
      <div v-for="grpNum in (Object.values(compo).length / 5)" :key="grpNum">
        <SlotSelector
          v-for="(currentSlot, slotIndex) in Object.values(compo).slice((grpNum - 1) * 5, ((grpNum - 1) * 5) + 5)" :key="slotIndex"
          :theSlot="currentSlot"
          :rosterId="roster.id"
          :characters="characters"
        />
      </div>
   </div>

  </div>
</template>

<script>
import SlotSelector from './SlotSelector.vue'

export default {
  name: 'roster',
  components: { SlotSelector },
  data () {
    return {
      roster: '',
      characters: [],
      selectedCharacter: [],
      error: ''
    }
  },
  created () {
    if (!localStorage.signedIn) {
      this.$router.replace('/')
    } else {
      this.$http.secured.get(`/api/v1/rosters/${this.$route.params.id}`)
        .then(response => {
          this.roster = response.data
          this.fetchCharacters()
        })
        .catch(error => this.setError(error, 'Something went wrong'))
    }
  },
  computed: {
    compo () {
      if (this.roster === '') {
        return []
      }
      return Object.values(this.roster.template)
    }
  },
  methods: {
    setError (error, text) {
      this.error = (error.response && error.response.data && error.response.data.error) || text
    },
    fetchCharacters () {
      if (this.roster === '' || this.characters.length > 0) {
        return
      }
      this.$http.secured.get('/api/v1/characters/all')
        .then(response => {
          this.characters = response.data
          this.fetchCharacters()
        })
        .catch(error => this.setError(error, 'Something went wrong'))
    }
  }
}
</script>
