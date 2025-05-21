<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="com.mack.clinica.model.Usuario" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
  <meta charset="UTF-8">
  <title>Meu Cadastro | Clínica Saúde Total</title>
  <script src="https://cdn.tailwindcss.com"></script>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
</head>
<body class="bg-gray-50">

<div class="flex h-screen overflow-hidden">

  <!-- Sidebar -->
  <div class="sidebar bg-white w-64 border-r border-gray-200 flex flex-col">
    <div class="p-4 border-b border-gray-200">
      <div class="flex items-center space-x-2">
        <i class="fas fa-heartbeat text-3xl text-blue-600"></i>
        <h1 class="text-xl font-bold text-gray-800">Saúde Total</h1>
      </div>
      <p class="text-xs text-gray-500 mt-1">Painel do Paciente</p>
    </div>
    <div class="flex-1 overflow-y-auto p-4">
      <nav>
        <ul class="space-y-1">
          <li>
            <a href="paciente_dashboard" class="flex items-center space-x-3 p-3 rounded-lg hover:bg-gray-100">
              <i class="fas fa-home text-blue-600"></i><span class="text-black">Home</span>
            </a>
          </li>
          <li>
            <a href="agendarConsulta" class="flex items-center space-x-3 p-3 rounded-lg hover:bg-gray-100">
              <i class="fas fa-calendar-plus text-green-600"></i><span class="text-black">Agendar Consulta</span>
            </a>
          </li>
          <li>
            <a href="minhaAgenda" class="flex items-center space-x-3 p-3 rounded-lg hover:bg-gray-100">
              <i class="fas fa-calendar-alt text-orange-500"></i><span class="text-black">Minha Agenda</span>
            </a>
          </li>
          <li>
            <a href="meuCadastro" class="flex items-center space-x-3 p-3 rounded-lg bg-blue-100">
              <i class="fas fa-user text-purple-600"></i><span class="text-black">Meu Cadastro</span>
            </a>
          </li>
        </ul>
      </nav>
    </div>
    <div class="p-4 border-t border-gray-200">
      <a href="${pageContext.request.contextPath}/logout"
         class="w-full flex items-center justify-center space-x-2 p-3 text-red-600 hover:bg-gray-100 rounded-lg">
        <i class="fas fa-sign-out-alt"></i>
        <span>Logout</span>
      </a>
    </div>
  </div>

  <!-- Main Content -->
  <div class="flex-1 overflow-auto">
    <!-- Header -->
    <header class="bg-white border-b border-gray-200 p-4">
      <div class="flex items-center justify-between">
        <h2 class="text-xl font-bold text-gray-800">Meu Cadastro</h2>
        <div class="flex items-center space-x-4">
          <div class="relative">
            <input type="text" placeholder="Buscar..."
                   class="pl-10 pr-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-blue-500"/>
            <i class="fas fa-search absolute left-3 top-3 text-gray-400"></i>
          </div>
          <div class="flex items-center space-x-2">
            <div class="relative">
              <i class="fas fa-bell text-gray-500 text-xl cursor-pointer hover:text-gray-700"></i>
              <span class="absolute -top-1 -right-1 bg-red-500 text-white text-xs rounded-full
                                         h-4 w-4 flex items-center justify-center">3</span>
            </div>
            <img src="https://edurank.org/assets/img/uni-logos/mackenzie-presbyterian-university-logo.png"
                 alt="Mackenzie" class="w-8 h-8 rounded-full"/>
          </div>
        </div>
      </div>
    </header>

    <!-- Conteúdo principal -->
    <main class="p-6">
      <div class="bg-white p-6 rounded-lg shadow-md border border-gray-200 max-w-xl mx-auto">
        <h3 class="text-2xl font-bold text-gray-800 mb-6">Alterar Dados</h3>
        <form method="post" action="meuCadastro" class="space-y-4">

          <div>
            <label for="userNome" class="block text-sm font-medium text-gray-700 mb-1">Nome:</label>
            <input type="text" id="userNome" name="userNome" value="${paciente.nome}"
                   class="w-full border border-gray-300 rounded-lg p-2 focus:outline-none focus:ring-2 focus:ring-blue-500">
          </div>

          <div>
            <label for="userEmail" class="block text-sm font-medium text-gray-700 mb-1">Email:</label>
            <input type="email" id="userEmail" name="userEmail" value="${paciente.email}"
                   class="w-full border border-gray-300 rounded-lg p-2 focus:outline-none focus:ring-2 focus:ring-blue-500">
          </div>

          <div class="relative">
            <label for="userSenha" class="block text-sm font-medium text-gray-700 mb-1">Senha:</label>
            <input type="password" id="userSenha" name="userSenha" value="${paciente.senha}"
                   class="w-full border border-gray-300 rounded-lg p-2 pr-10 focus:outline-none focus:ring-2 focus:ring-blue-500">
            <i class="fas fa-eye absolute right-3 top-9 cursor-pointer text-gray-500 hover:text-gray-700"
               onclick="toggleSenha()"></i>
          </div>

          <div>
            <label for="userFone" class="block text-sm font-medium text-gray-700 mb-1">Celular:</label>
            <input type="text" id="userFone" name="userFone" value="${paciente.celular}"
                   class="w-full border border-gray-300 rounded-lg p-2 focus:outline-none focus:ring-2 focus:ring-blue-500">
          </div>

          <div>
            <label for="userCPF" class="block text-sm font-medium text-gray-700 mb-1">CPF:</label>
            <input type="text" id="userCPF" name="userCPF" value="${paciente.cpf}"
                   class="w-full border border-gray-300 rounded-lg p-2 focus:outline-none focus:ring-2 focus:ring-blue-500">
          </div>

          <button type="submit"
                  class="w-full bg-blue-600 hover:bg-blue-700 text-white py-2 rounded-lg font-medium">
            <i class="fas fa-save mr-2"></i> Salvar Alterações
          </button>
        </form>
      </div>
    </main>
  </div>
</div>

<!-- Script para visualizar a senha -->
<script>
  function toggleSenha() {
    const senhaInput = document.getElementById('userSenha');
    const icon = event.target;
    if (senhaInput.type === 'password') {
      senhaInput.type = 'text';
      icon.classList.remove('fa-eye');
      icon.classList.add('fa-eye-slash');
    } else {
      senhaInput.type = 'password';
      icon.classList.remove('fa-eye-slash');
      icon.classList.add('fa-eye');
    }
  }
</script>

</body>
</html>
