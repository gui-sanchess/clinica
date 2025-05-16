<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.util.*, com.mack.clinica.model.Prontuario, com.mack.clinica.model.Usuario" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <title>Ficha Clínica</title>
    <link rel="stylesheet" href="/css/style.css">
    <style>
        body {
            background-color: #f4f4f4;
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
        }

        .content {
            max-width: 1200px;
            margin: 40px auto;
            padding: 20px;
        }

        h1 {
            text-align: center;
            margin-bottom: 30px;
        }

        .cards-container {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 20px;
        }

        .card {
            background-color: white;
            border-radius: 10px;
            padding: 20px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }

        .card h3 {
            margin-top: 0;
        }

        .card p {
            margin: 5px 0;
        }

        .btn {
            background-color: #3498db;
            color: white;
            padding: 10px 15px;
            border: none;
            border-radius: 5px;
            margin-top: 10px;
            cursor: pointer;
        }

        .btn:hover {
            background-color: #2980b9;
        }

        form {
            margin-bottom: 40px;
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }

        form input, form select, form textarea {
            width: 100%;
            margin-bottom: 15px;
            padding: 10px;
            border-radius: 5px;
            border: 1px solid #ccc;
        }

        label {
            font-weight: bold;
        }
    </style>
</head>
<body>

<div class="navbar">
    <div class="nav-links">
        <a href="admin_dashboard">Home</a>
        <a href="cadastroPacientes">Cadastro de Pacientes</a>
        <a href="cadastroMedicos">Cadastro de Médicos</a>
        <a href="consultarAgenda">Consultar Agenda</a>
        <a href="fichaClinica">Ficha Clínica</a>
        <a href="${pageContext.request.contextPath}/logout" class="logout-link">Logout</a>
    </div>
</div>

<div class="content">
    <h1>Ficha Clínica</h1>

    <!-- Formulário de Adição -->
    <form action="fichaClinica" method="post">
        <h2>Adicionar Prontuário</h2>

        <label for="paciente_id">Paciente:</label>
        <select name="paciente_id" id="paciente_id" required>
            <option value="">Selecione o paciente</option>
            <%
                List<Usuario> pacientes = (List<Usuario>) request.getAttribute("pacientes");
                for (Usuario paciente : pacientes) {
            %>
            <option value="<%= paciente.getId() %>"><%= paciente.getNome() %></option>
            <% } %>
        </select>

        <label for="profissional_id">Médico:</label>
        <select name="profissional_id" id="profissional_id" required>
            <option value="">Selecione o médico</option>
            <%
                List<Usuario> medicos = (List<Usuario>) request.getAttribute("medicos");
                for (Usuario medico : medicos) {
            %>
            <option value="<%= medico.getId() %>"><%= medico.getNome() %></option>
            <% } %>
        </select>

        <label for="data">Data:</label>
        <input type="date" name="data" id="data" required>

        <label for="anotacoes_medicas">Anotações Médicas:</label>
        <textarea name="anotacoes_medicas" id="anotacoes_medicas" required></textarea>

        <label for="prescricoes">Prescrições:</label>
        <textarea name="prescricoes" id="prescricoes" required></textarea>

        <button type="submit" class="btn">Salvar</button>
    </form>

    <!-- Exibição dos Prontuários -->
    <div class="cards-container">
        <%
            List<Prontuario> prontuarios = (List<Prontuario>) request.getAttribute("prontuarios");
            if (prontuarios != null && !prontuarios.isEmpty()) {
                for (Prontuario prontuario : prontuarios) {
        %>
        <div class="card">
            <h3>Paciente: <%= prontuario.getPaciente().getNome() %></h3>
            <p><strong>Médico:</strong> <%= prontuario.getMedico().getNome() %></p>
            <p><strong>Data:</strong> <%= prontuario.getDataFormatada() %></p>
            <p><strong>Diagnóstico:</strong> <%= prontuario.getAnotacoes_medicas() %></p>
            <p><strong>Prescrição:</strong> <%= prontuario.getPrescricoes() %></p>
        </div>
        <%
            }
        } else {
        %>
        <p style="text-align:center;">Nenhum prontuário encontrado.</p>
        <%
            }
        %>
    </div>
</div>

</body>
</html>
