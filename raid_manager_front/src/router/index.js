import Vue from 'vue'
import Router from 'vue-router'
import Signin from '@/components/Signin.vue'
import Signup from '@/components/Signup.vue'
import Characters from '@/components/characters/Characters.vue'
import Rosters from '@/components/rosters/Rosters.vue'
import Roster from '@/components/rosters/Roster.vue'
import BasicCompos from '@/components/basic_compos/BasicCompos.vue'
import BasicCompo from '@/components/basic_compos/BasicCompo.vue'

Vue.use(Router)

export default new Router({
  mode: 'history',
  routes: [
    {
      path: '/basic-compos',
      name: 'BasicCompos',
      component: BasicCompos
    },
    {
      path: '/basic-compos/:id',
      name: 'BasicCompo',
      component: BasicCompo
    },
    {
      path: '/characters',
      name: 'Characters',
      component: Characters
    },
    {
      path: '/rosters/:id',
      name: 'Roster',
      component: Roster
    },
    {
      path: '/rosters',
      name: 'Rosters',
      component: Rosters
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
