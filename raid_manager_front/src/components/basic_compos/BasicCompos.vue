<template>
  <div>
    <div v-if="error" class="alert alert-danger col-md-11 mx-auto">{{ error }}</div>
    <h3>Add a new Basic compo</h3>
    <form @submit.prevent="addCompo" class="col-md-8 mx-auto">
      <div class="form-group">
        <input type="text" autofocus autocomplete class="form-control" placeholder="The compo's name" v-model="newCompo.name">
      </div>

      <div class="form-group text-left">
        <label for="size">Size</label>
        <select v-model="newCompo.size" class="form-control" name="size">
          <option value="40">40</option>
          <option value="20">20</option>
          <option value="25">25</option>
          <option value="10">10</option>
        </select>
      </div>

      <input type="submit" value="Validate" class="btn btn-success">
    </form>

    <hr>

    <div class="col-md-10 mx-auto">
      <table class="table table-hover">
        <thead>
          <th>Name</th>
          <th>Size</th>
          <th></th>
          <th></th>
          <th></th>
        </thead>
        <tbody>
          <tr v-for="compo in compos" :key="compo.id" :compo="compo">
            <td>{{compo.name}}</td>
            <td>{{Object.values(compo.template).length}}</td>
            <td>-</td>
            <td><button @click.prevent="editCompo(compo)" class="btn btn-primary">Edit</button></td>
            <td><button @click.prevent="removeCompo(compo)" class="btn btn-danger">X</button></td>
          </tr>
        </tbody>
      </table>
    </div>

  </div>
</template>

<script>
export default {
  name: 'BasicCompos',
  data () {
    return {
      compos: [],
      newCompo: [],
      error: ''
    }
  },
  created () {
    if (!localStorage.signedIn) {
      this.$router.replace('/')
    } else {
      this.$http.secured.get('/api/v1/basic_compos')
        .then(response => {
          this.compos = response.data
        })
        .catch(error => this.setError(error, 'Something went wrong'))
    }
  },
  methods: {
    setError (error, text) {
      this.error = error.response
    },
    addCompo () {
      const value = this.newCompo
      if (!value) {
        return
      }
      this.$http.secured.post('/api/v1/basic_compos', {
        basic_compo: {
          name: this.newCompo.name
        },
        size: this.newCompo.size
      }).then(response => {
        this.compos.push(response.data)
        this.newCompo = []
      }).catch(error => this.setError(error, 'Cannot add the compo'))
    },
    removeCompo (compo) {
      this.$http.secured.delete(`/api/v1/basic_compos/${compo.id}`)
        .then(response => {
          this.compos.splice(this.compos.indexOf(compo), 1)
        })
        .catch(error => this.setError(error, 'Cannot delete the compo'))
    },
    editCompo (compo) {
      this.$router.replace(`/basic-compos/${compo.id}`)
    }
  }
}
</script>
