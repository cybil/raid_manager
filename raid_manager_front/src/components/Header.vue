<template>
  <div class="flex">
    <div>
      <img src="@/assets/logo.png" class="logo-header">
    </div>

    <div class="flex flex-items-center">
      <router-link v-if="!signedIn()" to="/signin" class="nav-link">Sign In</router-link>
      <router-link v-if="!signedIn()" to="/signup" class="nav-link">Sign Up</router-link>
      <router-link v-if="signedIn()" to="/characters" class="nav-link">Characters</router-link>
      <router-link v-if="signedIn()" to="/roosters" class="nav-link">Roosters</router-link>
      <a v-if="signedIn()" href="javascript:void(0);" @click.prevent="signOut" class="nav-link">Sign out</a>

      <div class="nav-link">
        {{currentUser}}
      </div>
    </div>

  </div>
</template>

<script>
export default {
  name: 'Header',
  created () {
    this.signedIn()
  },
  computed: {
    currentUser () {
      return localStorage.email
    }
  },
  methods: {
    setError (error, text) {
      this.error = (error.response && error.response.data && error.response.data.error) || text
    },
    signedIn () {
      return localStorage.signedIn
    },
    signOut () {
      this.$http.secured.delete('/signout')
        .then(response => {
          delete localStorage.csrf
          delete localStorage.signedIn
          this.$router.replace('/')
        })
        .catch(error => this.setError(error, 'Cannot sign out'))
    }
  }
}
</script>

<style scoped>
.logo-header {
  padding: 10px;
  width: 100px;
}
</style>
