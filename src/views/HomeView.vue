<script setup lang="ts">
import { computed, onBeforeUnmount, ref } from 'vue'
import MovilCard from '@/components/MovilCard.vue'
import type { Movil } from '@/types'

const MAX_MOVILES = 3
const DEFAULT_COLORS = ['#e74c3c', '#3498db', '#2ecc71']
const DEFAULT_LABELS = ['A', 'B', 'C']

function makeDefaultMovil(index: number): Movil {
  return {
    label: DEFAULT_LABELS[index] ?? `M${index + 1}`,
    x_0: 0,
    v: 5,
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
    const response = await fetch('/api/v1/simulations/render', {
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
    <header class="page-header">
      <h1>Kinetiq</h1>
      <p class="subtitle">Simulador de cinemática — MRU en 1D</p>
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
          {{ loading ? 'Renderizando…' : 'Simular' }}
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
  </main>
</template>

<style scoped>
main {
  display: flex;
  flex-direction: column;
  gap: 1.5rem;
}

.page-header {
  text-align: center;
  padding-bottom: 0.5rem;
}

.page-header h1 {
  font-size: 2.2rem;
  font-weight: 600;
  color: var(--color-heading);
  margin: 0;
}

.subtitle {
  color: var(--color-text);
  opacity: 0.75;
  margin-top: 0.25rem;
}

.panel {
  border: 1px solid var(--color-border);
  border-radius: 8px;
  padding: 1.25rem 1.5rem;
  background: var(--color-background-soft);
}

.panel h2 {
  margin: 0 0 1rem 0;
  font-size: 1.1rem;
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
  gap: 0.25rem;
  max-width: 320px;
}

.field label {
  font-size: 0.85rem;
  color: var(--color-text);
  opacity: 0.8;
}

.field input[type='number'] {
  padding: 0.45rem 0.6rem;
  border: 1px solid var(--color-border);
  border-radius: 4px;
  background: var(--color-background);
  color: var(--color-heading);
  font: inherit;
  font-size: 0.95rem;
}

.field input:focus {
  outline: 2px solid hsla(160, 100%, 37%, 0.5);
  outline-offset: 1px;
}

.btn {
  padding: 0.55rem 1.1rem;
  border: 1px solid transparent;
  border-radius: 4px;
  font: inherit;
  font-size: 0.9rem;
  cursor: pointer;
  transition: opacity 0.15s;
}

.btn:disabled {
  opacity: 0.5;
  cursor: not-allowed;
}

.btn-primary {
  background: hsl(160, 100%, 37%);
  color: #fff;
  font-weight: 600;
  padding: 0.7rem 1.8rem;
  font-size: 1rem;
}

.btn-primary:hover:not(:disabled) {
  background: hsl(160, 100%, 32%);
}

.btn-secondary {
  background: transparent;
  color: var(--color-heading);
  border-color: var(--color-border);
}

.btn-secondary:hover:not(:disabled) {
  border-color: var(--color-border-hover);
}

.actions {
  display: flex;
  justify-content: center;
}

.loading {
  display: flex;
  align-items: center;
  gap: 1rem;
  padding: 1rem 0;
}

.spinner {
  width: 28px;
  height: 28px;
  border: 3px solid var(--color-border);
  border-top-color: hsl(160, 100%, 37%);
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
  color: #e74c3c;
  padding: 0.75rem 1rem;
  background: rgba(231, 76, 60, 0.08);
  border-radius: 4px;
  border: 1px solid rgba(231, 76, 60, 0.3);
}

.video {
  width: 100%;
  max-width: 100%;
  border-radius: 6px;
  background: #000;
}
</style>
