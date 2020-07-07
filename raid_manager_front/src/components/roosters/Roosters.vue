<template>
  <div>
    <div v-if="error" class="text-red">{{ error }}</div>
    <h3>Add a new Rooster</h3>

    <form @submit.prevent="addRooster" class="col-md-8 mx-auto">
      <div class="form-group">
        <input type="text" autofocus autocomplete class="form-control" placeholder="Your rooster's name" v-model="newRooster.name">
      </div>

      <input type="submit" value="Validate" class="btn btn-success">
    </form>

    <div class="col-md-10 mx-auto">
      <table class="table table-hover">
        <thead>
          <th>Name</th>
          <th></th>
          <th></th>
        </thead>
        <tbody>
          <tr v-for="rooster in roosters" :key="rooster.id" :rooster="rooster">
            <td>{{rooster.name}}</td>
            <td>-</td>
            <td>-</td>
            <td><button @click.prevent="editRooster(rooster)" class="btn btn-primary">Edit</button></td>
            <td><button @click.prevent="removeRooster(rooster)" class="btn btn-danger">X</button></td>
          </tr>
        </tbody>
      </table>

    </div>
  </div>
</template>

<script>
export default {
  name: 'Roosters',
  data () {
    return {
      roosters: [],
      newRooster: [],
      editedRooster: '',
      error: ''
    }
  },
  created () {
    if (!localStorage.signedIn) {
      this.$router.replace('/')
    } else {
      this.$http.secured.get('/api/v1/roosters')
        .then(response => {
          this.roosters = response.data
        })
        .catch(error => this.setError(error, 'Something went wrong'))
    }
  },
  methods: {
    setError (error, text) {
      this.error = (error.response && error.response.data && error.response.data.error) || text
    },
    addRooster () {
      const value = this.newRooster
      if (!value) {
        return
      }
      this.$http.secured.post('/api/v1/roosters', {
        rooster: {
          name: this.newRooster.name
        }
      }).then(response => {
        this.roosters.push(response.data)
        this.newRooster = ''
      }).catch(error => this.setError(error, 'Cannot add the rooster'))
    },
    removeRooster (rooster) {
      this.$http.secured.delete(`/api/v1/roosters/${rooster.id}`)
        .then(response => {
          this.roosters.splice(this.roosters.indexOf(rooster), 1)
        })
        .catch(error => this.setError(error, 'Cannot delete the rooster'))
    },
    editRooster (rooster) {
      this.$router.replace(`/roosters/${rooster.id}`)
    },
    updateRooster (rooster) {
      this.editedRooster = ''
      this.$http.secured.patch(`/api/v1/roosters/${rooster.id}`, {
        rooster: {
          name: rooster.name
        }
      }).catch(error => this.setError(error, 'Cannot update the rooster'))
    }
  }
}
</script>
