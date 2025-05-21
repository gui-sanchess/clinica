<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.mack.clinica.model.Consulta" %>
<%@ page import="java.time.LocalDateTime" %>
<%@ page import="java.time.ZoneId" %>

<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <title>Minha Agenda | Clínica Saúde Total</title>
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
                        <a href="minhaAgenda" class="flex items-center space-x-3 p-3 rounded-lg bg-blue-100">
                            <i class="fas fa-calendar-alt text-orange-500"></i><span class="text-black">Minha Agenda</span>
                        </a>
                    </li>
                    <li>
                        <a href="meuCadastro" class="flex items-center space-x-3 p-3 rounded-lg hover:bg-gray-100">
                            <i class="fas fa-user text-purple-600"></i><span class="text-black">Meu Cadastro</span>
                        </a>
                    </li>
                </ul>
            </nav>
        </div>
        <div class="p-4 border-t border-gray-200">
            <a href="${pageContext.request.contextPath}/logout" class="w-full flex items-center justify-center space-x-2 p-3 text-red-600 hover:bg-gray-100 rounded-lg">
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
                <h2 class="text-xl font-bold text-gray-800">Minha Agenda</h2>
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
            <h1 class="text-2xl font-bold text-gray-800 mb-6">Minha Agenda</h1>
            <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">

                <%
                    List<Consulta> consultas = (List<Consulta>) request.getAttribute("consultas");
                    LocalDateTime agora = LocalDateTime.now(ZoneId.systemDefault());

                    if (consultas != null && !consultas.isEmpty()) {
                        for (Consulta consulta : consultas) {
                            LocalDateTime dataHoraConsulta = consulta.getData_hora();
                            boolean expirada = dataHoraConsulta.isBefore(agora);
                %>

                <div class="bg-white p-4 rounded-lg shadow-md border border-gray-200">
                    <div class="<%= expirada ? "opacity-50" : "" %>">
                        <h3 class="text-lg font-semibold text-gray-800">
                            <%= consulta.getMedico() != null ? consulta.getMedico().getNome() : "Médico não informado" %>
                        </h3>
                        <p class="text-sm text-gray-600">Data: <%= consulta.getDataFormatada() %></p>
                        <p class="text-sm text-gray-600">Hora: <%= consulta.getHoraFormatada() %></p>
                        <p class="text-sm text-gray-600">Status: <%= consulta.getStatus() %></p>
                        <p class="text-sm text-gray-600">Observações: <%= consulta.getObservacoes() != null ? consulta.getObservacoes() : "Nenhuma" %></p>
                    </div>

                    <% if (expirada) { %>
                    <form method="post" action="minhaAgenda" class="mt-3">
                        <input type="hidden" name="idConsulta" value="<%= consulta.getId_consulta() %>">
                        <button type="submit" class="flex items-center gap-2 text-red-600 hover:text-red-800 font-medium">
                            <i class="fas fa-trash"></i> Excluir
                        </button>
                    </form>
                    <% } %>
                </div>

                <%
                    }
                } else {
                %>
                <p class="text-gray-600">Nenhuma consulta agendada.</p>
                <%
                    }
                %>

            </div>
        </main>
    </div>
</div>

</body>
</html>
