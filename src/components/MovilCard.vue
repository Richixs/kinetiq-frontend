<script setup lang="ts">
import type { Movil } from '@/types'

const movil = defineModel<Movil>({ required: true })

defineProps<{
  canRemove: boolean
  disabled?: boolean
}>()

defineEmits<{
  (e: 'remove'): void
}>()
</script>

<template>
  <div class="movil-card" :style="{ borderLeftColor: movil.color }">
    <div class="movil-head">
      <strong>Móvil {{ movil.label }}</strong>
      <button
        type="button"
        class="btn btn-danger"
        :disabled="!canRemove || disabled"
        @click="$emit('remove')"
      >
        Eliminar
      </button>
    </div>

    <div class="grid">
      <div class="field">
        <label>Etiqueta</label>
        <input v-model="movil.label" type="text" maxlength="4" required :disabled="disabled" />
      </div>
      <div class="field">
        <label>Color</label>
        <input v-model="movil.color" type="color" :disabled="disabled" />
      </div>
      <div class="field">
        <label>Posición inicial x₀ (m)</label>
        <input v-model.number="movil.x_0" type="number" step="0.1" required :disabled="disabled" />
      </div>
      <div class="field">
        <label>Velocidad v (m/s)</label>
        <input v-model.number="movil.v" type="number" step="0.1" required :disabled="disabled" />
      </div>
      <div class="field">
        <label>t de arranque (s)</label>
        <input
          v-model.number="movil.t_start"
          type="number"
          min="0"
          step="0.1"
          required
          :disabled="disabled"
        />
      </div>
    </div>
  </div>
</template>

<style scoped>
.movil-card {
  border: 1px solid var(--color-border);
  border-left-width: 4px;
  border-radius: 6px;
  padding: 1rem 1.25rem;
  margin-bottom: 0.75rem;
  background: var(--color-background);
}

.movil-card:last-child {
  margin-bottom: 0;
}

.movil-head {
  display: flex;
  align-items: center;
  justify-content: space-between;
  margin-bottom: 0.75rem;
}

.grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(160px, 1fr));
  gap: 0.75rem 1rem;
}

.field {
  display: flex;
  flex-direction: column;
  gap: 0.25rem;
}

.field label {
  font-size: 0.85rem;
  color: var(--color-text);
  opacity: 0.8;
}

.field input[type='text'],
.field input[type='number'] {
  padding: 0.45rem 0.6rem;
  border: 1px solid var(--color-border);
  border-radius: 4px;
  background: var(--color-background);
  color: var(--color-heading);
  font: inherit;
  font-size: 0.95rem;
}

.field input[type='color'] {
  height: 2.2rem;
  padding: 0.1rem;
  border: 1px solid var(--color-border);
  border-radius: 4px;
  background: var(--color-background);
  cursor: pointer;
}

.field input:focus {
  outline: 2px solid hsla(160, 100%, 37%, 0.5);
  outline-offset: 1px;
}

.btn {
  padding: 0.35rem 0.7rem;
  border: 1px solid transparent;
  border-radius: 4px;
  font: inherit;
  font-size: 0.85rem;
  cursor: pointer;
}

.btn:disabled {
  opacity: 0.5;
  cursor: not-allowed;
}

.btn-danger {
  background: transparent;
  color: #e74c3c;
}

.btn-danger:hover:not(:disabled) {
  background: rgba(231, 76, 60, 0.12);
}
</style>
