<script setup lang="ts">
interface Member {
  name: string
  role: string
}

const members: Member[] = [
  { name: 'Shamir L. Terán Mustafá', role: 'Integrante del equipo' },
  { name: 'Steven J. Ramos Salazar', role: 'Integrante del equipo' },
  { name: 'Marioli Leon Saravia', role: 'Integrante del equipo' },
  { name: 'Victoria Soto Marañón', role: 'Integrante del equipo' },
]
</script>

<template>
  <main>
    <header class="app-header">
      <div class="brand">
        <p class="brand-name">Sobre el equipo</p>
        <p class="brand-subtitle">Los desarrolladores detrás de Kinetiq</p>
      </div>
      <RouterLink to="/" class="home-link">← Inicio</RouterLink>
    </header>

    <section class="panel intro">
      <p>
        Kinetiq es un proyecto académico desarrollado para la materia de Física General en la
        carrera de Ingeniería Informática de la Universidad Mayor de San Simón. Su objetivo es
        ofrecer un simulador interactivo de cinemática en una dimensión — tanto MRU como MRUV — con
        animaciones generadas por Manim.
      </p>
    </section>

    <section class="team-grid">
      <article v-for="member in members" :key="member.name" class="member-card">
        <div class="avatar" aria-hidden="true">
          <svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
            <circle cx="12" cy="8" r="4" />
            <path d="M12 14c-4 0-8 2-8 6v2h16v-2c0-4-4-6-8-6z" />
          </svg>
        </div>
        <p class="member-name">{{ member.name }}</p>
        <p class="member-role">{{ member.role }}</p>
      </article>
    </section>
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

.home-link {
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

.home-link:hover {
  transform: translateY(-0.5px);
  border-color: var(--color-accent);
  background: rgba(0, 188, 212, 0.08);
}

.panel {
  border: 1px solid var(--color-border);
  border-radius: 12px;
  padding: 1.25rem 1.5rem;
  background: linear-gradient(180deg, rgba(30, 30, 52, 0.95), rgba(22, 22, 38, 0.98));
  box-shadow: 0 10px 24px rgba(0, 0, 0, 0.28);
  backdrop-filter: blur(4px);
}

.intro p {
  margin: 0;
  line-height: 1.65;
  color: var(--color-text);
  opacity: 0.9;
  font-size: 0.95rem;
}

.team-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
  gap: 1rem;
}

.member-card {
  display: flex;
  flex-direction: column;
  align-items: center;
  text-align: center;
  padding: 1.5rem 1rem;
  border: 1px solid var(--color-border);
  border-radius: 12px;
  background: linear-gradient(180deg, rgba(32, 32, 56, 0.74), rgba(26, 26, 46, 0.78));
  box-shadow: 0 8px 20px rgba(0, 0, 0, 0.2);
  gap: 0.8rem;
}

.avatar {
  width: 120px;
  height: 120px;
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  background: linear-gradient(135deg, rgba(0, 188, 212, 0.14), rgba(255, 255, 255, 0.04));
  border: 2px solid var(--color-border);
  overflow: hidden;
}

.avatar svg {
  width: 70%;
  height: 70%;
  fill: var(--color-text);
  opacity: 0.55;
}

.member-name {
  margin: 0;
  font-size: 1rem;
  font-weight: 600;
  color: var(--color-heading);
}

.member-role {
  margin: 0;
  font-size: 0.82rem;
  color: var(--color-text);
  opacity: 0.7;
  letter-spacing: 0.02em;
}

@media (max-width: 640px) {
  .app-header {
    padding: 0.05rem 0 0.72rem;
  }

  .avatar {
    width: 96px;
    height: 96px;
  }
}
</style>
