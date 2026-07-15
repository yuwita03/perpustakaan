import { createRouter, createWebHistory } from 'vue-router'
import { useAuthStore } from '../stores/auth'
import LoginView from '../views/LoginView.vue'
import AppLayout from '../components/AppLayout.vue'
import DashboardView from '../views/DashboardView.vue'
import AnggotaView from '../views/AnggotaView.vue'
import BukuView from '../views/BukuView.vue'
import TransaksiView from '../views/TransaksiView.vue'
import DokumenView from '../views/DokumenView.vue'
import AksesView from '../views/AksesView.vue'
import LaporanView from '../views/LaporanView.vue'

const routes = [
  { path: '/login', name: 'Login', component: LoginView },
  {
    path: '/',
    component: AppLayout,
    meta: { requiresAuth: true },
    children: [
      { path: '', name: 'Dashboard', component: DashboardView },
      { path: 'anggota', name: 'Anggota', component: AnggotaView },
      { path: 'buku', name: 'Buku', component: BukuView },
      { path: 'transaksi', name: 'Transaksi', component: TransaksiView },
      { path: 'dokumen', name: 'Dokumen', component: DokumenView },
      { path: 'akses', name: 'Akses', component: AksesView },
      { path: 'laporan', name: 'Laporan', component: LaporanView },
    ],
  },
]

const router = createRouter({
  history: createWebHistory(),
  routes,
})

router.beforeEach((to, from, next) => {
  const auth = useAuthStore()
  if (to.meta.requiresAuth && !auth.isLoggedIn) {
    next('/login')
  } else if (to.path === '/login' && auth.isLoggedIn) {
    next('/')
  } else {
    next()
  }
})

export default router
