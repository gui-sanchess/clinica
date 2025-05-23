<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <title>Ficha Clínica | Clínica Saúde Total</title>
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
                    <li>
                        <a href="admin_dashboard" class="flex items-center space-x-3 p-3 rounded-lg text-gray-700 hover:bg-gray-100">
                            <i class="fas fa-home text-blue-600"></i><span>Home</span>
                        </a>
                    </li>
                    <li>
                        <a href="cadastroPacientes" class="flex items-center space-x-3 p-3 rounded-lg text-gray-700 hover:bg-gray-100">
                            <i class="fas fa-user-plus text-green-600"></i><span>Cadastro de Pacientes</span>
                        </a>
                    </li>
                    <li>
                        <a href="cadastroMedicos" class="flex items-center space-x-3 p-3 rounded-lg text-gray-700 hover:bg-gray-100">
                            <i class="fas fa-user-md text-purple-600"></i><span>Cadastro de Médicos</span>
                        </a>
                    </li>
                    <li>
                        <a href="consultarAgenda" class="flex items-center space-x-3 p-3 rounded-lg text-gray-700 hover:bg-gray-100">
                            <i class="fas fa-calendar-alt text-orange-500"></i><span>Consultar Agenda</span>
                        </a>
                    </li>
                    <li>
                        <a href="fichaClinica" class="flex items-center space-x-3 p-3 rounded-lg bg-blue-100 text-blue-800">
                            <i class="fas fa-file-medical text-red-600"></i><span>Ficha Clínica</span>
                        </a>
                    </li>
                </ul>
            </nav>
        </div>
        <div class="p-4 border-t border-gray-200">
            <a href="${pageContext.request.contextPath}/logout"
               class="w-full flex items-center justify-center space-x-2 p-3 text-red-600 hover:bg-red-100 rounded-lg">
                <i class="fas fa-sign-out-alt"></i><span>Logout</span>
            </a>
        </div>
    </div>

    <!-- Main Content -->
    <div class="flex-1 overflow-auto">

        <!-- Header -->
        <header class="bg-white border-b border-gray-200 p-4">
            <div class="flex items-center justify-between">
                <h2 class="text-xl font-bold text-gray-800">Ficha Clínica</h2>
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
                             alt="Admin" class="w-8 h-8 rounded-full"/>
                    </div>
                </div>
            </div>
        </header>

        <!-- Conteúdo principal -->
        <main class="p-6">

            <!-- Botão para abrir modal -->
            <button onclick="abrirModal()"
                    class="bg-blue-600 hover:bg-blue-700 text-white px-4 py-2 rounded-lg mb-4">
                <i class="fas fa-file-medical mr-2"></i> Nova Ficha
            </button>

            <!-- Lista de fichas -->
            <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
                <c:forEach var="prontuario" items="${prontuarios}">
                    <div class="bg-white p-5 rounded-xl shadow-md border border-gray-200">
                        <div class="flex justify-between items-start mb-2">
                            <h3 class="text-lg font-semibold text-gray-800 flex items-center gap-2">
                                <i class="fas fa-file-medical text-red-600"></i>Ficha Clínica
                            </h3>
                            <form action="fichaClinica" method="post">
                                <input type="hidden" name="_method" value="DELETE">
                                <input type="hidden" name="ProntuarioId" value="${prontuario.getId_prontuario()}">
                                <button type="submit" class="flex items-center gap-1 text-red-600 hover:text-red-800 font-medium"
                                        title="Excluir">
                                    <i class="fas fa-trash"></i>Excluir
                                </button>
                            </form>
                        </div>
                        <p class="text-sm text-gray-700"><strong>Paciente:</strong> ${prontuario.paciente.nome}</p>
                        <p class="text-sm text-gray-700"><strong>Profissional:</strong> ${prontuario.medico.nome}</p>
                        <p class="text-sm text-gray-700"><strong>Data:</strong> ${prontuario.dataFormatada}</p>
                        <p class="mt-2 text-sm text-gray-700 font-semibold">Anotações:</p>
                        <p class="text-sm text-gray-600">${prontuario.anotacoes_medicas}</p>
                        <p class="mt-2 text-sm text-gray-700 font-semibold">Prescrições:</p>
                        <p class="text-sm text-gray-600">${prontuario.prescricoes}</p>
                    </div>
                </c:forEach>
            </div>

            <!-- Modal -->
            <div id="modal"
                 class="fixed inset-0 bg-black bg-opacity-50 hidden flex items-center justify-center z-50">
                <div class="bg-white p-6 rounded-lg w-full max-w-md shadow-lg relative">
                    <button onclick="fecharModal()"
                            class="absolute top-3 right-3 text-gray-500 hover:text-red-500 text-xl font-bold">&times;
                    </button>
                    <h2 class="text-lg font-bold text-gray-800 mb-4">Nova Ficha</h2>
                    <form action="fichaClinica" method="post">
                        <select name="pacienteId" required
                                class="w-full mb-2 p-2 border border-gray-300 rounded-lg">
                            <option value="" disabled selected>Selecione o Paciente</option>
                            <c:forEach var="p" items="${pacientes}">
                                <option value="${p.id}">${p.nome}</option>
                            </c:forEach>
                        </select>
                        <select name="profissionalId" required
                                class="w-full mb-2 p-2 border border-gray-300 rounded-lg">
                            <option value="" disabled selected>Selecione o Profissional</option>
                            <c:forEach var="m" items="${medicos}">
                                <option value="${m.id}">${m.nome}</option>
                            </c:forEach>
                        </select>
                        <input type="date" name="dataFormatada" required
                               class="w-full p-2 mb-2 border border-gray-300 rounded-lg">
                        <textarea name="anotacoes_medicas" rows="3" placeholder="Anotações Médicas" required
                                  class="w-full p-2 mb-2 border border-gray-300 rounded-lg"></textarea>
                        <textarea name="prescricoes" rows="2" placeholder="Prescrições" required
                                  class="w-full p-2 mb-4 border border-gray-300 rounded-lg"></textarea>
                        <button type="submit"
                                class="w-full bg-blue-600 text-white py-2 rounded-lg hover:bg-blue-700">
                            Salvar
                        </button>
                    </form>
                </div>
            </div>

        </main>
    </div>
</div>

<!-- Script Modal -->
<script>
    function abrirModal() {
        document.getElementById('modal').style.display = 'flex';
    }

    function fecharModal() {
        document.getElementById('modal').style.display = 'none';
    }
</script>

</body>
</html>
