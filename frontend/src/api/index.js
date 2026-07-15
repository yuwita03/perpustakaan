import axios from 'axios'

const api = axios.create({
  baseURL: '/api',
  withCredentials: true,
})

export function login(username, password) {
  return api.post('/auth/login', { username, password })
}

export function logout() {
  return api.post('/auth/logout')
}

export function getMe() {
  return api.get('/auth/me')
}

export function getAnggota() {
  return api.get('/anggota')
}

export function getAnggotaById(id) {
  return api.get(`/anggota/${id}`)
}

export function createAnggota(data) {
  return api.post('/anggota', data)
}

export function updateAnggota(id, data) {
  return api.put(`/anggota/${id}`, data)
}

export function toggleStatusAnggota(id) {
  return api.put(`/anggota/${id}/toggle-status`)
}

export function searchAnggota(q) {
  return api.get(`/anggota/search?q=${q}`)
}

export function getBuku() {
  return api.get('/buku')
}

export function getBukuById(id) {
  return api.get(`/buku/${id}`)
}

export function createBuku(data) {
  return api.post('/buku', data)
}

export function updateBuku(id, data) {
  return api.put(`/buku/${id}`, data)
}

export function deleteBuku(id) {
  return api.delete(`/buku/${id}`)
}

export function searchBuku(q) {
  return api.get(`/buku/search?q=${q}`)
}

export function getKategori() {
  return api.get('/kategori')
}

export function createKategori(data) {
  return api.post('/kategori', data)
}

export function getPeminjaman() {
  return api.get('/peminjaman')
}

export function createPeminjaman(data) {
  return api.post('/peminjaman', data)
}

export function getPengembalian() {
  return api.get('/pengembalian')
}

export function createPengembalian(data) {
  return api.post('/pengembalian', data)
}

export function getDokumen() {
  return api.get('/dokumen')
}

export function createDokumen(data) {
  return api.post('/dokumen', data)
}

export function deleteDokumen(id) {
  return api.delete(`/dokumen/${id}`)
}

export function getStatistik() {
  return api.get('/laporan/statistik')
}

export function getBukuTersedia() {
  return api.get('/laporan/buku-tersedia')
}

export function getBukuDipinjam() {
  return api.get('/laporan/buku-dipinjam')
}

export function getRiwayat() {
  return api.get('/laporan/riwayat')
}

export function getBukuTerpopuler() {
  return api.get('/laporan/buku-terpopuler')
}

export function getKualitasData() {
  return api.get('/laporan/kualitas-data')
}

export function getLaporanPerPeriode(mulai, selesai) {
  return api.get(`/laporan/per-periode?mulai=${mulai}&selesai=${selesai}`)
}

export function importCSV(data) {
  return api.post('/csv/import', { data })
}

export default api
