<%--
  Created by IntelliJ IDEA.
  User: Dedé
  Date: 02/05/2025
  Time: 14:41
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.mack.clinica.model.Usuario" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
  <meta charset="UTF-8">
  <title>Meu Cadastro</title>
  <link rel="stylesheet" href="/css/style.css">
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
  <h1>Meu Cadastro</h1>
  <form method="post" action="meuCadastro" class="form-container">

    <label for="userNome">Nome:</label>
    <input type="text" id="userNome" name="userNome" value="${paciente.nome}">

    <label for="userEmail">Email:</label>
    <input type="text" id="userEmail" name="userEmail" value="${paciente.email}">

    <label for="userSenha">Senha:</label>
    <input type="text" id="userSenha" name="userSenha" value="${paciente.senha}">

    <label for="userFone">Celular:</label>
    <input type="text" id="userFone" name="userFone" value="${paciente.celular}">

    <label for="userCPF">CPF:</label>
    <input type="text" id="userCPF" name="userCPF" value="${paciente.cpf}">

    <button type="submit" class="button">Alterar</button>
  </form>
</div>

</body>
</html>

