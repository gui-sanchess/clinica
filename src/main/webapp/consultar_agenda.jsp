<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.util.*, com.mack.clinica.model.Consulta, com.mack.clinica.model.Usuario" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <title>Consultar Agenda | Clínica Saúde Total</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"/>
</head>

<%
    String dataIni = request.getParameter("filtroDataIni");
    String dataFim = request.getParameter("filtroDataFim");
    String paciente = request.getParameter("filtroPaciente");
    String medico = request.getParameter("filtroMedico");

    boolean filtroAtivo =
            (dataIni != null && !dataIni.isEmpty()) ||
                    (dataFim != null && !dataFim.isEmpty()) ||
                    (paciente != null && !paciente.isEmpty()) ||
                    (medico != null && !medico.isEmpty());
%>

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
                    <li><a href="admin_dashboard" class="flex items-center space-x-3 p-3 rounded-lg text-gray-700 hover:bg-gray-100">
                        <i class="fas fa-home text-blue-600"></i><span>Home</span></a></li>
                    <li><a href="cadastroPacientes" class="flex items-center space-x-3 p-3 rounded-lg text-gray-700 hover:bg-gray-100">
                        <i class="fas fa-user-plus text-green-600"></i><span>Cadastro de Pacientes</span></a></li>
                    <li><a href="cadastroMedicos" class="flex items-center space-x-3 p-3 rounded-lg text-gray-700 hover:bg-gray-100">
                        <i class="fas fa-user-md text-purple-600"></i><span>Cadastro de Médicos</span></a></li>
                    <li><a href="consultarAgenda" class="flex items-center space-x-3 p-3 rounded-lg bg-blue-100 text-blue-800">
                        <i class="fas fa-calendar-alt text-orange-500"></i><span>Consultar Agenda</span></a></li>
                    <li><a href="fichaClinica" class="flex items-center space-x-3 p-3 rounded-lg text-gray-700 hover:bg-gray-100">
                        <i class="fas fa-file-medical text-red-600"></i><span>Ficha Clínica</span></a></li>
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
                <h2 class="text-xl font-bold text-gray-800">Consultar Agenda</h2>
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

            <!-- Botões principais -->
            <div class="flex space-x-3 mb-4">
                <button onclick="toggleFiltro()"
                        class="bg-blue-600 hover:bg-blue-700 text-white px-4 py-2 rounded-lg">
                    <i class="fas fa-filter mr-2"></i> Filtrar Consultas
                </button>

                <% if (filtroAtivo) { %>
                <a href="consultarAgenda"
                   class="bg-gray-300 hover:bg-gray-400 text-black rounded px-5 py-2 flex items-center justify-center">
                    Redefinir Filtros
                </a>
                <% } %>
            </div>

            <!-- Filtro -->
            <form action="consultarAgenda" method="get" id="filtroContainer"
                  class="bg-white p-6 rounded-lg shadow border border-gray-200 mb-6 space-y-4 hidden">
                <div class="grid grid-cols-1 md:grid-cols-4 gap-4">
                    <div>
                        <label class="block mb-1 text-sm font-medium text-gray-700">Início</label>
                        <input type="date" name="filtroDataIni"
                               class="border border-gray-300 rounded px-3 py-2 w-full"/>
                    </div>
                    <div>
                        <label class="block mb-1 text-sm font-medium text-gray-700">Fim</label>
                        <input type="date" name="filtroDataFim"
                               class="border border-gray-300 rounded px-3 py-2 w-full"/>
                    </div>
                    <div>
                        <label class="block mb-1 text-sm font-medium text-gray-700">Paciente</label>
                        <select name="filtroPaciente"
                                class="border border-gray-300 rounded px-3 py-2 w-full">
                            <option value="">Todos os Pacientes</option>
                            <%
                                List<Usuario> pacientes = (List<Usuario>) request.getAttribute("pacientes");
                                if (pacientes != null) {
                                    for (Usuario p : pacientes) {
                            %>
                            <option value="<%= p.getId() %>"><%= p.getNome() %></option>
                            <%
                                    }
                                }
                            %>
                        </select>
                    </div>
                    <div>
                        <label class="block mb-1 text-sm font-medium text-gray-700">Médico</label>
                        <select name="filtroMedico"
                                class="border border-gray-300 rounded px-3 py-2 w-full">
                            <option value="">Todos os Médicos</option>
                            <%
                                List<Usuario> medicos = (List<Usuario>) request.getAttribute("medicos");
                                if (medicos != null) {
                                    for (Usuario m : medicos) {
                            %>
                            <option value="<%= m.getId() %>"><%= m.getNome() %></option>
                            <%
                                    }
                                }
                            %>
                        </select>
                    </div>
                </div>
                <button type="submit"
                        class="bg-blue-600 text-white rounded px-5 py-2 hover:bg-blue-700">
                    Aplicar Filtro
                </button>
            </form>

            <!-- Cards de Consultas -->
            <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
                <%
                    List<Consulta> consultas = (List<Consulta>) request.getAttribute("consultas");
                    if (consultas != null && !consultas.isEmpty()) {
                        for (Consulta consulta : consultas) {
                %>
                <div class="bg-white p-5 rounded-xl shadow-md border border-gray-200">
                    <div class="flex justify-between items-start mb-2">
                        <h3 class="text-lg font-semibold text-gray-800 flex items-center gap-2">
                            <i class="fas fa-calendar-alt text-orange-500"></i>Consulta
                        </h3>
                        <form method="post" action="consultarAgenda">
                            <input type="hidden" name="idConsulta" value="<%= consulta.getId_consulta() %>"/>
                            <button type="submit" title="Excluir"
                                    class="flex items-center gap-1 text-red-600 hover:text-red-800 font-medium">
                                <i class="fas fa-trash"></i>Excluir
                            </button>
                        </form>
                    </div>
                    <p class="text-sm text-gray-700"><strong>Data:</strong> <%= consulta.getDataFormatada() %></p>
                    <p class="text-sm text-gray-700"><strong>Hora:</strong> <%= consulta.getHoraFormatada() %></p>
                    <p class="text-sm text-gray-700"><strong>Paciente:</strong> <%= consulta.getPaciente().getNome() %></p>
                    <p class="text-sm text-gray-700"><strong>Médico:</strong> <%= consulta.getMedico().getNome() %></p>
                    <p class="text-sm text-gray-700"><strong>Status:</strong> <%= consulta.getStatus() %></p>
                    <p class="text-sm text-gray-700"><strong>Observações:</strong> <%= consulta.getObservacoes() != null ? consulta.getObservacoes() : "Nenhuma" %></p>
                </div>
                <%
                    }
                } else {
                %>
                <p class="text-center text-gray-600 col-span-full">Nenhuma consulta encontrada.</p>
                <%
                    }
                %>
            </div>

        </main>
    </div>
</div>

<script>
    function toggleFiltro() {
        const f = document.getElementById('filtroContainer');
        f.classList.toggle('hidden');
    }
</script>

</body>
</html>