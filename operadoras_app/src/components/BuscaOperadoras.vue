<template>
  <div class="container">
    <h2>Buscar Operadoras</h2>
    <input v-model="query" @input="buscar" placeholder="Digite o nome da operadora..." />
    
    <ul v-if="operadoras.length">
      <li v-for="op in operadoras" :key="op.registro_ans" @click="verDetalhes(op)">
        {{ op.razao_social }} ({{ op.cnpj }})
      </li>
    </ul>
    <p v-else>Nenhuma operadora encontrada.</p>

    <div v-if="operadoraSelecionada" class="detalhes">
      <h3>Detalhes da Operadora</h3>
      <p><strong>Razão Social:</strong> {{ operadoraSelecionada.razao_social }}</p>
      <p><strong>CNPJ:</strong> {{ operadoraSelecionada.cnpj }}</p>
      <p><strong>Registro ANS:</strong> {{ operadoraSelecionada.registro_ans }}</p>
      <p><strong>Telefone:</strong> {{ operadoraSelecionada.telefone }}</p>
      <p><strong>Município:</strong> {{ operadoraSelecionada.uf }}</p>
      <p><strong>Cidade:</strong> {{ operadoraSelecionada.cidade }}</p>
      <p><strong>Logradouro:</strong> {{ operadoraSelecionada.logradouro }}</p>
      <p><strong>Bairro:</strong> {{ operadoraSelecionada.bairro }}</p>
      <p><strong>Número:</strong> {{ operadoraSelecionada.numero }}</p>
      <p><strong>Email:</strong> {{ operadoraSelecionada.endereco_eletronico }}</p>
    </div>
  </div>
</template>

<script>
import axios from 'axios';

export default {
  data() {
    return {
      query: '',
      operadoras: [],
      operadoraSelecionada: null 
    };
  },
  methods: {
    async buscar() {
      if (this.query.length < 3) {
        this.operadoras = [];
        this.operadoraSelecionada = null;
        return;
      }
      try {
        const response = await axios.get(`http://localhost:5000/buscar?q=${this.query}`);
        this.operadoras = response.data;
        this.operadoraSelecionada = null; 
      } catch (error) {
        console.error("Erro ao buscar operadoras:", error);
      }
    },
    verDetalhes(operadora) {
      this.operadoraSelecionada = operadora;  
    }
  }
};
</script>

<style>
.container {
  max-width: 600px;
  margin: auto;
  text-align: center;
}

input {
  width: 100%;
  padding: 8px;
  margin-bottom: 10px;
}

ul {
  list-style: none;
  padding: 0;
}

li {
  cursor: pointer;
  margin-bottom: 10px;
  padding: 8px;
  background-color: #f4f4f4;
  border-radius: 5px;
}

li:hover {
  background-color: #ddd;
}

.detalhes {
  margin-top: 20px;
  text-align: left;
  border-top: 1px solid #ccc;
  padding-top: 20px;
}

.detalhes p {
  margin: 5px 0;
}
</style>
