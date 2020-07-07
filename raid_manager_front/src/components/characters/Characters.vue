<template>
  <div>
    <div v-if="error" class="alert alert-danger col-md-11">{{ error }}</div>
    <h3>Add a new Character</h3>

    <form @submit.prevent="addCharacter" class="col-md-8 mx-auto">
      <div class="form-group">
        <input type="text" autofocus autocomplete class="form-control" placeholder="Your character's name" v-model="newCharacter.name">
      </div>

      <div class="form-group text-left">
        <label for="race">Race</label>
        <select name="race" v-model="newCharacter.race" class="form-control">
          <option value="orc">Orc</option>
          <option value="tauren">Tauren</option>
          <option value="troll">Troll</option>
          <option value="undead">Undead</option>
        </select>
      </div>

      <div class="form-group text-left">
        <label for="class">Class</label>
        <select name="class" v-model="newCharacter.ch_class" class="form-control">
          <option value="druid">Druid</option>
          <option value="hunter">Hunter</option>
          <option value="mage">Mage</option>
          <option value="priest">Priest</option>
          <option value="rogue">Rogue</option>
          <option value="shaman">Shaman</option>
          <option value="warrior">Warrior</option>
          <option value="warlock">Warlock</option>
        </select>
      </div>

      <input type="submit" value="Validate" class="btn btn-success">
    </form>

    <hr>

    <div class="col-md-10 mx-auto">
      <table class="table table-hover">
        <thead>
          <th>Name</th>
          <th>Race</th>
          <th>Class</th>
          <th></th>
        </thead>
        <tbody>
          <tr v-for="char in characters" :key="char.id" :char="char">
            <td>{{char.name}}</td>
            <td>{{char.race.toUpperCase()}}</td>
            <td><b :class="colorForClass(char.ch_class)">{{char.ch_class.toUpperCase()}}</b></td>
            <td><button @click.prevent="removeCharacter(char)" class="btn btn-danger">X</button></td>
          </tr>
        </tbody>
      </table>
    </div>
  </div>
</template>

<script>
export default {
  name: 'Characters',
  data () {
    return {
      characters: [],
      newCharacter: [],
      editedCharacter: '',
      error: null
    }
  },
  created () {
    if (!localStorage.signedIn) {
      this.$router.replace('/')
    } else {
      this.$http.secured.get('/api/v1/characters')
        .then(response => {
          this.characters = response.data
        })
        .catch(error => this.setError(error, 'Something went wrong'))
    }
  },
  methods: {
    colorForClass (ch_class) {
      return `text-${ch_class}`
    },
    setError (error, text) {
      this.error = (error.response && error.response.data && error.response.data.error) || text
    },
    addCharacter () {
      const value = this.newCharacter
      if (!value) {
        return
      }
      this.$http.secured.post('/api/v1/characters', {
        character: {
          name: this.newCharacter.name,
          race: this.newCharacter.race,
          ch_class: this.newCharacter.ch_class
        }
      }).then(response => {
        this.characters.push(response.data)
        this.newCharacter = []
      }).catch(error => this.setError(error, 'Cannot add the character'))
    },
    removeCharacter (character) {
      this.$http.secured.delete(`/api/v1/characters/${character.id}`)
        .then(response => {
          this.characters.splice(this.characters.indexOf(character), 1)
        })
        .catch(error => this.setError(error, 'Cannot delete the character'))
    },
    editCharacter (character) {
      this.editedCharacter = character
    },
    updateCharacter (character) {
      this.editedCharacter = []
      this.$http.secured.patch(`/api/v1/characters/${character.id}`, {
        character: {
          name: character.name
        }
      }).catch(error => this.setError(error, 'Cannot update the character'))
    }
  }
}
</script>
