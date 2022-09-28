import { createRouter, createWebHistory } from 'vue-router'
import SideNav from '../components/SideNav.vue'
import HomeView from '../views/Home.vue'
import AboutView from '../views/About.vue'
import GettingStarted from '../views/Getting-Started/index.vue'
import Login from '../views/Auth/Login.vue'

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: '/',
      name: 'sideNav',
      component: SideNav,
      children: [
        {
          path: '/',
          name: 'home',
          component: HomeView,
        },
        {
          path: '/about',
          name: 'about',
          component: AboutView,
        },
        {
          path: '/start',
          name: 'getting started',
          component: GettingStarted,
        },
      ],
    },
    {
      path: '/login',
      name: 'auth',
      component: Login,
    },
  ],
})
export default router