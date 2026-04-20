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
        <label>Velocidad inicial v (m/s)</label>
        <input v-model.number="movil.v" type="number" step="0.1" required :disabled="disabled" />
      </div>
      <div class="field">
        <label>Aceleración a (m/s²)</label>
        <input v-model.number="movil.a" type="number" step="0.1" required :disabled="disabled" />
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
  border-radius: 10px;
  padding: 1rem 1.25rem;
  margin-bottom: 0.75rem;
  background: linear-gradient(180deg, rgba(32, 32, 56, 0.74), rgba(26, 26, 46, 0.78));
}

.movil-card:last-child {
  margin-bottom: 0;
}

.movil-head {
  display: flex;
  align-items: center;
  justify-content: space-between;
  margin-bottom: 0.9rem;
}

.movil-head strong {
  color: var(--color-heading);
  letter-spacing: 0.01em;
}

.grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(160px, 1fr));
  gap: 0.85rem 1rem;
}

.field {
  display: flex;
  flex-direction: column;
  gap: 0.32rem;
}

.field label {
  font-size: 0.78rem;
  text-transform: uppercase;
  letter-spacing: 0.03em;
  color: var(--color-text);
  opacity: 0.88;
}

.field input[type='text'],
.field input[type='number'] {
  padding: 0.5rem 0.6rem;
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

.field input[type='color'] {
  height: 2.2rem;
  padding: 0.1rem;
  border: 1px solid var(--color-border);
  border-radius: 8px;
  background: var(--color-background);
  cursor: pointer;
}

.field input:focus {
  outline: none;
  border-color: var(--color-accent);
  box-shadow: 0 0 0 3px var(--color-accent-subtle);
}

.btn {
  padding: 0.4rem 0.8rem;
  border: 1px solid transparent;
  border-radius: 8px;
  font: inherit;
  font-size: 0.82rem;
  font-weight: 600;
  cursor: pointer;
}

.btn:disabled {
  opacity: 0.5;
  cursor: not-allowed;
}

.btn-danger {
  background: rgba(248, 113, 113, 0.06);
  border-color: rgba(248, 113, 113, 0.25);
  color: var(--color-error);
}

.btn-danger:hover:not(:disabled) {
  background: var(--color-error-bg);
}
</style>
