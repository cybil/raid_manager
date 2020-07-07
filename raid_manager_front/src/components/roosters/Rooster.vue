<template>
  <div>
    <div v-if="error" class="text-red">{{ error }}</div>
    <h3>Add a character to the rooster {{rooster.name}}</h3>

    <form @submit.prevent="addCharacter()" class="col-md-8 mx-auto">
      <div class="form-group">
        <label for="race">Character</label>
        <select v-model="selectedCharacter.name" class="form-control">
          <option v-for="char in this.characters" :key="char.id" :char="char" value="char.id">
            {{ char.name }} <{{ char.ch_class }}>
          </option>
        </select>
      </div>

      <div class="form-group">
        <label for="race">Role</label>
        <select v-model="selectedCharacter.role" class="form-control">
          <option>Tank</option>
          <option>Heal</option>
          <option>DPS</option>
        </select>
      </div>

      <div class="form-group">
        <input type="submit" value="Add" class="btn btn-success">
      </div>
    </form>

    <hr>

    <div>

    </div>

  </div>
</template>

<script>
export default {
  name: 'Rooster',
  data () {
    return {
      rooster: '',
      characters: [],
      selectedCharacter: [],
      error: ''
    }
  },
  created () {
    if (!localStorage.signedIn) {
      this.$router.replace('/')
    } else {
      this.$http.secured.get(`/api/v1/roosters/${this.$route.params.id}`)
        .then(response => {
          this.rooster = response.data
          this.fetchCharacters()
        })
        .catch(error => this.setError(error, 'Something went wrong'))
    }
  },
  methods: {
    fetchCharacters () {
      if (this.rooster === '') {
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