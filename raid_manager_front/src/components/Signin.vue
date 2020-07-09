<template>
  <div class="max-w-sm m-auto my-8">
    <div class="border p-10 rounded shadow">
      <h3 class="text-2xl mb-6">Sign In</h3>

      <form @submit.prevent="signin">
        <div v-if="error" class="text-red">
          {{ error }}
        </div>
        <div class="form-group">
          <label for="email" class="label">Email</label>
          <input type="email" v-model="email" class="form-control" id="email" placeholder="xxx@example.com">
        </div>

        <div class="form-group">
          <label for="password" class="label">Password</label>
          <input type="password" v-model="password" class="form-control" id="password">
        </div>

        <button type="submit" class="btn btn-success">Sign In</button>

        <div class="my-4">
          <router-link to="/signup" class="link">Sign Up</router-link>
        </div>
      </form>
    </div>
  </div>
</template>

<script>
export default {
  name: 'Signin',
  data () {
    return {
      email: '',
      password: '',
      error: ''
    }
  },
  created () {
    this.checkSignedIn()
  },
  updated () {
    this.checkSignedIn()
  },
  methods: {
    signin () {
      this.$http.plain.post('/signin', {
        email: this.email,
        password: this.password
      })
        .then(response => this.signinSuccessful(response))
        .catch(response => this.signinFailed(response))
    },
    signinSuccessful (response) {
      if (!response.data.csrf) {
        this.signinFailed(response)
        return
      }
      localStorage.csrf = response.data.csrf
      localStorage.signedIn = true
      localStorage.email = response.data.email
      this.error = ''
      this.$router.replace('/characters')
    },
    signinFailed (error) {
      this.error = (error.response && error.response.data && error.response.data.error) || ''
      delete localStorage.csrf
      delete localStorage.email
      // delete localStorage.signedIn
      localStorage.signedIn = false
    },
    checkSignedIn () {
      if (localStorage.signedIn) {
        this.$router.replace('/characters')
      }
    }
  }
}
</script>
