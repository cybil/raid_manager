<template>
  <div>
    <div v-if="error" class="alert alert-danger col-md-11 mx-auto">{{ error }}</div>
    <h3>Add a new roster</h3>

    <form @submit.prevent="addroster" class="col-md-8 mx-auto">
      <div class="form-group">
        <input type="text" autofocus autocomplete class="form-control" placeholder="Your roster's name" v-model="newroster.name">
      </div>

      <div class="form-group text-left">
        <label for="compoId">Compo</label>
        <select v-model="newroster.compoId" class="form-control" name="compoId">
          <option v-for="compo in compos" :key="compo.id" :value="compo.id">
            {{ compo.name }} [{{ Object.values(compo.template).length }}]
          </option>
        </select>
      </div>

      <input type="submit" value="Validate" class="btn btn-success">
    </form>

    <hr>

    <div class="col-md-10 mx-auto">
      <table class="table table-hover">
        <thead>
          <th>Name</th>
          <th>Compo</th>
          <th>Status</th>
          <th></th>
          <th></th>
        </thead>
        <tbody>
          <tr v-for="roster in rosters" :key="roster.id" :roster="roster">
            <td>{{ roster.name }}</td>
            <td>{{ Object.values(roster.template).length }}</td>
            <td>{{ statusFor(roster) }}</td>
            <td><button @click.prevent="editRoster(roster)" class="btn btn-primary">Edit</button></td>
            <td><button @click.prevent="removeRoster(roster)" class="btn btn-danger">X</button></td>
          </tr>
        </tbody>
      </table>

    </div>
  </div>
</template>

<script>
export default {
  name: 'rosters',
  data () {
    return {
      rosters: [],
      compos: [],
      newroster: [],
      editedroster: '',
      error: ''
    }
  },
  created () {
    if (!localStorage.signedIn) {
      this.$router.replace('/')
    } else {
      this.$http.secured.get('/api/v1/rosters')
        .then(response => {
          this.rosters = response.data
          this.fetchCompos()
        })
        .catch(error => this.setError(error, 'Something went wrong'))
    }
  },
  methods: {
    statusFor (roster) {
      let compo = Object.values(roster.template)
      let filledSlots = compo.filter(slot => slot.character_id !== null)
      return `${filledSlots.length} / ${compo.length}`
    },
    setError (error, text) {
      this.error = (error.response && error.response.data) || error.message || text
    },
    fetchCompos () {
      if (this.compos.length > 0) {
        return
      }
      this.$http.secured.get('/api/v1/basic_compos')
        .then(response => {
          this.compos = response.data
        })
        .catch(error => this.setError(error, 'Something went wrong'))
    },
    addroster () {
      const value = this.newroster
      if (!value) {
        return
      }
      this.$http.secured.post('/api/v1/rosters', {
        roster: {
          name: this.newroster.name
        },
        compo_id: this.newroster.compoId
      }).then(response => {
        this.rosters.push(response.data)
        this.newroster = ''
        this.error = ''
      }).catch(error => this.setError(error, 'Cannot add the roster'))
    },
    removeRoster (roster) {
      this.$http.secured.delete(`/api/v1/rosters/${roster.id}`)
        .then(response => {
          this.rosters.splice(this.rosters.indexOf(roster), 1)
          this.error = ''
        })
        .catch(error => this.setError(error, 'Cannot delete the roster'))
    },
    editRoster (roster) {
      this.$router.replace(`/rosters/${roster.id}`)
    }
  }
}
</script>
