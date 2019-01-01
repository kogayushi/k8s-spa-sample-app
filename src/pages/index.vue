<template>
  <section class="container">
    <div>
      <h1 class="title">
        sample spa
      </h1>
      <h2 class="subtitle">
        you submitted text will be here
      </h2>
      <div
        v-for="sample in samples"
        :key="sample.id">
        <p>{{ sample.text }}</p>
      </div>
      <br>
      <hr>
      <br>
      <input v-model="text">
      <div style="display: inline-flex;">
        <button
          class="button--grey"
          @click="submit"
        >submit
        </button>
        <logout url="/logout"/>
      </div>
    </div>
  </section>
</template>

<script>
import Logout from '~/components/Logout.vue'

export default {
  components: {
    Logout
  },
  data: function() {
    return {
      text: null
    }
  },
  async asyncData(app) {
    let response = await app.$axios.get(`/api/samples`)
    return { samples: response.data }
  },
  methods: {
    async submit() {
      await this.$axios.post(`/api/samples`, {
        text: this.text
      })
      let self = this
      this.$nextTick(async function() {
        self.samples.splice(0)
        let response = await self.$axios.get(`/api/samples`)
        self.samples = response.data
      })
    }
  }
}
</script>

<style>
.container {
  min-height: 100vh;
  display: flex;
  justify-content: center;
  align-items: center;
  text-align: center;
}

.title {
  font-family: 'Quicksand', 'Source Sans Pro', -apple-system, BlinkMacSystemFont,
    'Segoe UI', Roboto, 'Helvetica Neue', Arial, sans-serif;
  display: block;
  font-weight: 300;
  font-size: 100px;
  color: #35495e;
  letter-spacing: 1px;
}

.subtitle {
  font-weight: 300;
  font-size: 42px;
  color: #526488;
  word-spacing: 5px;
  padding-bottom: 15px;
}

.links {
  padding-top: 15px;
}
</style>
