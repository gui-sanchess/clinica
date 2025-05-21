<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.mack.clinica.model.Consulta" %>
<%@ page import="java.time.LocalDateTime" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="java.time.ZoneId" %>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css">

<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <title>Minha Agenda</title>
</head>
<body>

<!-- Menu de Navegação -->
<div class="navbar">
    <div class="nav-links">
        <a href="paciente_dashboard">Home</a>
        <a href="agendarConsulta">Agendamento de Consultas</a>
        <a href="minhaAgenda">Minha Agenda</a>
        <a href="meuCadastro">Meu Cadastro</a>
        <a href="${pageContext.request.contextPath}/logout" class="logout-link">Logout</a>
    </div>
</div>
<!-- Conteúdo centralizado -->
<div class="content">
    <h1>Minha Agenda</h1>
    <%
        List<Consulta> consultas = (List<Consulta>) request.getAttribute("consultas");
        LocalDateTime agora = LocalDateTime.now(ZoneId.systemDefault());
        if (consultas != null && !consultas.isEmpty()) {
            for (Consulta consulta : consultas) {
                LocalDateTime dataHoraConsulta = consulta.getData_hora();
                boolean expirada = dataHoraConsulta.isBefore(agora);
    %>

    <article class="consulta-card <%= expirada ? "expirada" : "" %>">
        <header>
            <h3><%= consulta.getMedico() != null ? consulta.getMedico().getNome() : "Médico não informado" %></h3>
        </header>
        <div class="consulta-detalhes">
            <p><strong>Data:</strong> <%= consulta.getDataFormatada() %></p>
            <p><strong>Hora:</strong> <%= consulta.getHoraFormatada() %></p>
            <p><strong>Status:</strong> <%= consulta.getStatus() %></p>
            <p><strong>Observações:</strong> <%= consulta.getObservacoes() != null ? consulta.getObservacoes() : "Nenhuma" %></p>
        </div>

        <% if (expirada) { %>
        <form method="post" action="minhaAgenda" class="form-excluir" title="Excluir consulta expirada">
            <input type="hidden" name="idConsulta" value="<%= consulta.getId_consulta() %>">
            <span class="botao-lixeira" onclick="this.closest('form').submit()" role="button" tabindex="0">
                <i class="fas fa-trash-alt"></i>
            </span>
        </form>
        <% } %>
    </article>

    <%
        }
    } else {
    %>
    <p>Nenhuma consulta agendada.</p>
    <%
        }
    %>
</div>

<!-- Script para animar remoção -->
<script>
    document.querySelectorAll('.form-excluir').forEach(form => {
        form.addEventListener('submit', function(e) {
            e.preventDefault();
            const card = this.closest('.consulta-card');
            card.classList.add('consulta-removida');
            setTimeout(() => {
                form.submit();
            }, 500);
        });
    });
</script>

</body>
</html>
