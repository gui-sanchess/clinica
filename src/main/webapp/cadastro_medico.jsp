<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <title>Cadastro de Médicos | Clínica Saúde Total</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
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
            <p class="text-xs text-gray-500 mt-1">Painel Administrativo</p>
        </div>

        <div class="flex-1 overflow-y-auto p-4">
            <nav>
                <ul class="space-y-1">
                    <li><a href="admin_dashboard" class="flex items-center space-x-3 p-3 rounded-lg hover:bg-gray-100"><i class="fas fa-home text-blue-600"></i><span class="text-black">Home</span></a></li>
                    <li><a href="cadastroPacientes" class="flex items-center space-x-3 p-3 rounded-lg hover:bg-gray-100"><i class="fas fa-user-plus text-green-600"></i><span class="text-black">Cadastro de Pacientes</span></a></li>
                    <li><a href="cadastroMedicos" class="flex items-center space-x-3 p-3 rounded-lg bg-blue-100"><i class="fas fa-user-md text-purple-600"></i><span class="text-black">Cadastro de Médicos</span></a></li>
                    <li><a href="consultarAgenda" class="flex items-center space-x-3 p-3 rounded-lg hover:bg-gray-100"><i class="fas fa-calendar-alt text-orange-500"></i><span class="text-black">Consultar Agenda</span></a></li>
                    <li><a href="fichaClinica" class="flex items-center space-x-3 p-3 rounded-lg hover:bg-gray-100"><i class="fas fa-file-medical text-pink-600"></i><span class="text-black">Ficha Clínica</span></a></li>
                </ul>
            </nav>
        </div>

        <div class="p-4 border-t border-gray-200">
            <a href="${pageContext.request.contextPath}/logout" class="w-full flex items-center justify-center space-x-2 p-3 text-gray-700 hover:bg-gray-100 rounded-lg">
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
                <h2 class="text-xl font-bold text-gray-800">Cadastro de Médicos</h2>
                <div class="flex items-center space-x-4">
                    <div class="relative">
                        <input type="text" placeholder="Buscar..."
                               class="pl-10 pr-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-blue-500"/>
                        <i class="fas fa-search absolute left-3 top-3 text-gray-400"></i>
                    </div>
                    <div class="flex items-center space-x-2">
                        <div class="relative">
                            <i class="fas fa-bell text-gray-500 text-xl cursor-pointer hover:text-gray-700"></i>
                            <span class="absolute -top-1 -right-1 bg-red-500 text-white text-xs rounded-full h-4 w-4 flex items-center justify-center">3</span>
                        </div>
                        <img src="https://edurank.org/assets/img/uni-logos/mackenzie-presbyterian-university-logo.png"
                             alt="Mackenzie" class="w-8 h-8 rounded-full"/>
                    </div>
                </div>
            </div>
        </header>

        <!-- Conteúdo principal -->
        <main class="p-6">
            <button class="bg-blue-600 hover:bg-blue-700 text-white px-4 py-2 rounded-lg mb-4"
                    onclick="abrirModalInserir()">
                <i class="fas fa-user-md mr-2"></i> Novo Médico
            </button>

            <!-- Lista de médicos -->
            <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
                <c:forEach var="medico" items="${medicos}">
                    <div class="bg-white p-4 rounded-lg shadow-md border border-gray-200">
                        <h3 class="text-lg font-semibold text-gray-800">${medico.getNome()}</h3>
                        <p class="text-gray-600 text-sm">Email: <c:out value="${medico.getEmail()}"/></p>
                        <p class="text-gray-600 text-sm">CPF: <c:out value="${medico.getCpf()}"/></p>
                        <p class="text-gray-600 text-sm">Celular: <c:out value="${medico.getCelular()}"/></p>
                        <div class="mt-3 flex space-x-2">
                            <button onclick="abrirModalEditar(${medico.getId()}, '${medico.getNome()}', '${medico.getEmail()}', '${medico.getCpf()}', '${medico.getCelular()}')"
                                    class="text-blue-600 hover:underline">
                                <i class="fas fa-edit"></i> Editar
                            </button>
                            <form method="post" style="display:inline;">
                                <input type="hidden" name="_method" value="DELETE">
                                <input type="hidden" name="medicoId" value="${medico.getId()}">
                                <button type="submit" class="text-red-600 hover:text-red-800 ml-2">
                                    <i class="fas fa-trash"></i> Excluir
                                </button>
                            </form>
                        </div>
                    </div>
                </c:forEach>
            </div>

            <!-- Modal -->
            <div id="modal" class="fixed inset-0 bg-black bg-opacity-50 hidden flex items-center justify-center z-50">
                <div class="bg-white p-6 rounded-lg w-full max-w-md shadow-lg relative">
                    <button onclick="fecharModal()" class="absolute top-3 right-3 text-gray-500 hover:text-red-500 text-xl font-bold">&times;</button>
                    <h2 id="modalTitle" class="text-lg font-bold text-gray-800 mb-4">Cadastro de Médico</h2>
                    <form action="cadastroMedicos" method="post">
                        <input type="hidden" name="medicoId" id="medicoId">
                        <input type="text" name="userNome" id="userNome" placeholder="Nome" required
                               class="w-full p-2 mb-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500">
                        <input type="email" name="userEmail" id="userEmail" placeholder="Email" required
                               class="w-full p-2 mb-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500">
                        <input type="text" name="userCPF" id="userCPF" placeholder="CPF" required
                               class="w-full p-2 mb-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500">
                        <input type="text" name="userFone" id="userFone" placeholder="Celular" required
                               class="w-full p-2 mb-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500">
                        <input type="password" name="userSenha" id="userSenha" placeholder="Senha" required
                               class="w-full p-2 mb-4 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500">
                        <button type="submit" class="w-full bg-blue-600 text-white py-2 rounded-lg hover:bg-blue-700">Salvar</button>
                    </form>
                </div>
            </div>
        </main>
    </div>
</div>

<script>
    function abrirModalInserir() {
        document.getElementById('modalTitle').innerText = 'Cadastrar Novo Médico';
        document.getElementById('medicoId').value = '';
        document.getElementById('userNome').value = '';
        document.getElementById('userEmail').value = '';
        document.getElementById('userCPF').value = '';
        document.getElementById('userFone').value = '';
        document.getElementById('userSenha').value = '';
        document.getElementById('modal').style.display = 'flex';
    }

    function abrirModalEditar(id, nome, email, cpf, celular) {
        document.getElementById('modalTitle').innerText = 'Editar Médico';
        document.getElementById('medicoId').value = id;
        document.getElementById('userNome').value = nome;
        document.getElementById('userEmail').value = email;
        document.getElementById('userCPF').value = cpf;
        document.getElementById('userFone').value = celular;
        document.getElementById('userSenha').value = '';
        document.getElementById('modal').style.display = 'flex';
    }

    function fecharModal() {
        document.getElementById('modal').style.display = 'none';
    }
</script>

</body>
</html>