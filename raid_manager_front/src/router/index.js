import Vue from 'vue'
import Router from 'vue-router'
import Signin from '@/components/Signin.vue'
import Signup from '@/components/Signup.vue'
import Characters from '@/components/characters/Characters.vue'
import Roosters from '@/components/roosters/Roosters.vue'
import Rooster from '@/components/roosters/Rooster.vue'

Vue.use(Router)

export default new Router({
  mode: 'history',
  routes: [
    {
      path: '/characters',
      name: 'Characters',
      component: Characters
    },
    {
      path: '/roosters/:id',
      name: 'Rooster',
      component: Rooster
    },
    {
      path: '/roosters',
      name: 'Roosters',
      component: Roosters
    },
    {
      path: '/',
      name: 'Signin',
      component: Signin
    },
    {
      path: '/signup',
      name: 'Signup',
      component: Signup
    }
  ]
})
