<template>
  <div>
    <div v-if="error" class="alert alert-danger col-md-11 mx-auto">{{ error }}</div>
    <h3>Compo {{ compo.name }}</h3>

    <div class="flex flex-align-center flex-items-center col-md-11 mx-auto">
      <div v-for="grpNum in (Object.values(temp).length / 5)" :key="grpNum">
        <CompoSlot
          v-for="(currentSlot, slotIndex) in Object.values(temp).slice((grpNum - 1) * 5, ((grpNum - 1) * 5) + 5)" :key="slotIndex"
          :theSlot="currentSlot"
          :compoId="compo.id"
        />
      </div>
   </div>

  </div>
</template>

<script>
import CompoSlot from './CompoSlot.vue'

export default {
  name: 'BasicCompo',
  components: { CompoSlot },
  data () {
    return {
      compo: '',
      error: ''
    }
  },
  computed: {
    temp () {
      if (this.compo === '') {
        return []
      }
      return Object.values(this.compo.template)
    }
  },
  created () {
    if (!localStorage.signedIn) {
      this.$router.replace('/')
    } else {
      this.$http.secured.get(`/api/v1/basic_compos/${this.$route.params.id}`)
        .then(response => {
          this.compo = response.data
        })
        .catch(error => this.setError(error, 'Something went wrong'))
    }
  },
  methods: {
    setError (error, text) {
      this.error = (error.response && error.response.data) || error.message || text
    }
  }
}
</script>
