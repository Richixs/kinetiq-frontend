<script setup lang="ts">
import { computed, onBeforeUnmount, ref } from 'vue'
import MovilCard from '@/components/MovilCard.vue'
import { apiUrl } from '@/config/api'
import type { Movil } from '@/types'

const MAX_MOVILES = 3
const DEFAULT_COLORS = ['#e74c3c', '#3498db', '#2ecc71']
const DEFAULT_LABELS = ['A', 'B', 'C']

function makeDefaultMovil(index: number): Movil {
  return {
    label: DEFAULT_LABELS[index] ?? `M${index + 1}`,
    x_0: 0,
    v: 5,
    a: 0,
    t_start: 0,
    color: DEFAULT_COLORS[index] ?? '#ffffff',
  }
}

const tMax = ref<number>(20)
const moviles = ref<Movil[]>([makeDefaultMovil(0)])

const loading = ref(false)
const videoUrl = ref<string | null>(null)
const errorMessage = ref<string | null>(null)

const canAddMovil = computed(() => moviles.value.length < MAX_MOVILES)
const canRemoveMovil = computed(() => moviles.value.length > 1)

function addMovil() {
  if (!canAddMovil.value) return
  moviles.value.push(makeDefaultMovil(moviles.value.length))
}

function removeMovil(index: number) {
  if (!canRemoveMovil.value) return
  moviles.value.splice(index, 1)
}

function revokeCurrentVideo() {
  if (videoUrl.value) {
    URL.revokeObjectURL(videoUrl.value)
    videoUrl.value = null
  }
}

async function submit() {
  errorMessage.value = null
  revokeCurrentVideo()
  loading.value = true

  try {
    const response = await fetch(apiUrl('/api/v1/simulations/render'), {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({
        t_max: tMax.value,
        moviles: moviles.value,
      }),
    })

    if (!response.ok) {
      const body = await response.text()
      throw new Error(`Error ${response.status}: ${body || response.statusText}`)
    }

    const blob = await response.blob()
    videoUrl.value = URL.createObjectURL(blob)
  } catch (err) {
    errorMessage.value = err instanceof Error ? err.message : String(err)
  } finally {
    loading.value = false
  }
}

onBeforeUnmount(() => {
  revokeCurrentVideo()
})
</script>

<template>
  <main>
    <header class="app-header">
      <div class="brand">
        <p class="brand-name">Kinetiq</p>
        <p class="brand-subtitle">Simulador de cinemática - MRU y MRUV en 1D</p>
      </div>
      <nav class="header-actions">
        <RouterLink to="/about" class="about-link">Sobre nosotros</RouterLink>
        <a
          class="github-link"
          href="https://github.com/Richixs/kinetiq-frontend"
          target="_blank"
          rel="noopener noreferrer"
          aria-label="Repositorio de Kinetiq en GitHub"
        >
          <svg viewBox="0 0 24 24" aria-hidden="true">
            <path
              d="M12 0C5.37 0 0 5.37 0 12c0 5.3 3.44 9.8 8.2 11.38.6.11.82-.26.82-.58 0-.29-.01-1.04-.02-2.04-3.34.72-4.04-1.61-4.04-1.61-.55-1.39-1.34-1.76-1.34-1.76-1.09-.74.08-.73.08-.73 1.2.08 1.84 1.24 1.84 1.24 1.08 1.84 2.82 1.31 3.5 1 .11-.78.42-1.31.76-1.61-2.67-.3-5.47-1.34-5.47-5.94 0-1.31.47-2.38 1.23-3.22-.12-.3-.53-1.52.12-3.17 0 0 1.01-.32 3.3 1.23.96-.27 1.98-.41 3-.42 1.02.01 2.04.15 3 .42 2.28-1.55 3.29-1.23 3.29-1.23.65 1.65.24 2.87.12 3.17.77.84 1.23 1.91 1.23 3.22 0 4.62-2.8 5.64-5.48 5.94.43.37.82 1.1.82 2.22 0 1.61-.01 2.9-.01 3.3 0 .32.21.69.83.57C20.57 21.79 24 17.29 24 12c0-6.63-5.37-12-12-12z"
            />
          </svg>
        </a>
      </nav>
    </header>

    <form class="sim-form" @submit.prevent="submit">
      <section class="panel">
        <h2>Configuración global</h2>
        <div class="field">
          <label for="t-max">Tiempo total de simulación (s)</label>
          <input
            id="t-max"
            v-model.number="tMax"
            type="number"
            min="0.1"
            step="0.1"
            required
            :disabled="loading"
          />
        </div>
      </section>

      <section class="panel">
        <div class="panel-head">
          <h2>Móviles</h2>
          <button
            type="button"
            class="btn btn-secondary"
            :disabled="!canAddMovil || loading"
            @click="addMovil"
          >
            + Agregar móvil
          </button>
        </div>

        <MovilCard
          v-for="(movil, idx) in moviles"
          :key="idx"
          v-model="moviles[idx]!"
          :can-remove="canRemoveMovil"
          :disabled="loading"
          @remove="removeMovil(idx)"
        />
      </section>

      <div class="actions">
        <button type="submit" class="btn btn-primary" :disabled="loading">
          {{ loading ? 'Renderizando...' : 'Simular' }}
        </button>
      </div>
    </form>

    <section v-if="loading || videoUrl || errorMessage" class="panel output">
      <h2>Resultado</h2>

      <div v-if="loading" class="loading">
        <div class="spinner" aria-hidden="true"></div>
        <p>Generando la animación con Manim. Puede tardar ~15 segundos.</p>
      </div>

      <p v-else-if="errorMessage" class="error">{{ errorMessage }}</p>

      <video v-else-if="videoUrl" :src="videoUrl" controls autoplay class="video"></video>
    </section>

    <footer class="credits">
      <p class="credits-title">Equipo de desarrollo</p>
      <ul class="credits-list">
        <li>Shamir L. Terán Mustafá</li>
        <li>Steven J. Ramos Salazar</li>
        <li>Marioli Leon Saravia</li>
        <li>Victoria Soto Marañón</li>
      </ul>
    </footer>
  </main>
</template>

<style scoped>
main {
  display: flex;
  flex-direction: column;
  gap: 1.25rem;
}

.app-header {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 0.15rem 0.1rem 0.8rem;
  border-bottom: 1px solid var(--color-border);
}

.brand {
  display: flex;
  flex-direction: column;
  align-items: flex-start;
  gap: 0.1rem;
}

.brand::before {
  content: none;
}

.brand-name {
  margin: 0;
  font-size: clamp(1.28rem, 2.3vw, 1.6rem);
  font-weight: 700;
  letter-spacing: 0.02em;
  color: var(--color-heading);
}

.brand-subtitle {
  margin: 0;
  color: var(--color-text);
  opacity: 0.86;
  font-size: clamp(0.8rem, 1.55vw, 0.92rem);
}

.header-actions {
  display: flex;
  align-items: center;
  gap: 0.5rem;
}

.about-link {
  color: var(--color-heading);
  text-decoration: none;
  font-size: 0.88rem;
  padding: 0.4rem 0.75rem;
  border: 1px solid var(--color-border);
  border-radius: 8px;
  transition:
    transform 0.16s ease,
    border-color 0.16s ease,
    background-color 0.16s ease;
}

.about-link:hover {
  transform: translateY(-0.5px);
  border-color: var(--color-accent);
  background: rgba(0, 188, 212, 0.08);
}

.github-link {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  width: 2rem;
  height: 2rem;
  border-radius: 8px;
  border: 1px solid transparent;
  color: var(--color-heading);
  background: transparent;
  transition:
    transform 0.16s ease,
    border-color 0.16s ease,
    background-color 0.16s ease;
}

.github-link svg {
  width: 1.1rem;
  height: 1.1rem;
  fill: currentColor;
}

.github-link:hover {
  transform: translateY(-0.5px);
  border-color: var(--color-accent);
  background: rgba(0, 188, 212, 0.08);
}

.sim-form {
  display: flex;
  flex-direction: column;
  gap: 1rem;
}

.panel {
  border: 1px solid var(--color-border);
  border-radius: 12px;
  padding: 1.25rem 1.5rem;
  background: linear-gradient(180deg, rgba(30, 30, 52, 0.95), rgba(22, 22, 38, 0.98));
  box-shadow: 0 10px 24px rgba(0, 0, 0, 0.28);
  backdrop-filter: blur(4px);
}

.panel h2 {
  margin: 0 0 1rem 0;
  font-size: 1.05rem;
  font-weight: 600;
  color: var(--color-heading);
}

.panel-head {
  display: flex;
  align-items: center;
  justify-content: space-between;
  margin-bottom: 1rem;
}

.panel-head h2 {
  margin: 0;
}

.field {
  display: flex;
  flex-direction: column;
  gap: 0.35rem;
  max-width: 320px;
}

.field label {
  font-size: 0.82rem;
  letter-spacing: 0.02em;
  color: var(--color-text);
  opacity: 0.88;
  text-transform: uppercase;
}

.field input[type='number'] {
  padding: 0.55rem 0.65rem;
  border: 1px solid var(--color-border);
  border-radius: 8px;
  background: var(--color-background);
  color: var(--color-heading);
  font: inherit;
  font-size: 0.95rem;
  transition:
    border-color 0.2s,
    box-shadow 0.2s;
}

.field input:focus {
  outline: none;
  border-color: var(--color-accent);
  box-shadow: 0 0 0 3px var(--color-accent-subtle);
}

.btn {
  padding: 0.55rem 1.1rem;
  border: 1px solid transparent;
  border-radius: 10px;
  font: inherit;
  font-size: 0.88rem;
  font-weight: 600;
  cursor: pointer;
  transition:
    transform 0.16s ease,
    opacity 0.16s ease,
    border-color 0.16s ease;
}

.btn:disabled {
  opacity: 0.5;
  cursor: not-allowed;
}

.btn-primary {
  background: linear-gradient(140deg, var(--color-accent), var(--color-accent-hover));
  color: #ffffff;
  font-weight: 600;
  padding: 0.78rem 2.1rem;
  font-size: 1rem;
  box-shadow: 0 8px 20px rgba(0, 151, 167, 0.24);
}

.btn-primary:hover:not(:disabled) {
  transform: translateY(-1px);
}

.btn-secondary {
  background: rgba(34, 211, 238, 0.08);
  color: var(--color-heading);
  border-color: var(--color-border);
}

.btn-secondary:hover:not(:disabled) {
  border-color: var(--color-accent);
}

.actions {
  display: flex;
  justify-content: center;
  margin-top: 0.4rem;
}

.loading {
  display: flex;
  align-items: center;
  gap: 1rem;
  padding: 0.9rem 0;
}

.spinner {
  width: 28px;
  height: 28px;
  border: 3px solid var(--color-border);
  border-top-color: var(--color-accent);
  border-radius: 50%;
  animation: spin 0.8s linear infinite;
  flex-shrink: 0;
}

@keyframes spin {
  to {
    transform: rotate(360deg);
  }
}

.error {
  color: var(--color-error);
  padding: 0.75rem 1rem;
  background: var(--color-error-bg);
  border-radius: 8px;
  border: 1px solid var(--color-error-border);
}

.video {
  width: 100%;
  border-radius: 10px;
  border: 1px solid var(--color-border);
  background: #000;
}

.credits {
  margin-top: 1rem;
  padding-top: 1.25rem;
  border-top: 1px solid var(--color-border);
  text-align: center;
  color: var(--color-text);
  opacity: 0.75;
}

.credits-title {
  margin: 0 0 0.5rem 0;
  font-size: 0.9rem;
  font-weight: 600;
  letter-spacing: 0.05em;
  text-transform: uppercase;
  color: var(--color-heading);
}

.credits-list {
  list-style: none;
  padding: 0;
  margin: 0;
  display: flex;
  justify-content: center;
  flex-wrap: wrap;
  gap: 0.5rem 1.5rem;
  font-size: 0.9rem;
}

@media (max-width: 640px) {
  .app-header {
    padding: 0.05rem 0 0.72rem;
  }

  .brand-subtitle {
    max-width: 15.5rem;
    line-height: 1.35;
  }

  .panel {
    padding: 1rem;
    border-radius: 12px;
  }

  .sim-form {
    gap: 0.85rem;
  }

  .panel-head {
    flex-direction: column;
    align-items: flex-start;
    gap: 0.75rem;
  }

  .btn-primary {
    width: 100%;
  }

  .actions {
    width: 100%;
  }
}
</style>
