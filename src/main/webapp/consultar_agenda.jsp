<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.util.*, com.mack.clinica.model.Consulta, com.mack.clinica.model.Usuario" %>

<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <title>Consultar Agenda</title>
    <link rel="stylesheet" href="/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />

    <style>
        body {
            background-color: #f4f4f4;
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
        }

        .logout-link {
            color: #f1c40f;
        }

        .content {
            max-width: 1200px;
            margin: 40px auto;
            padding: 20px;
        }

        h1 {
            text-align: center;
            margin-bottom: 20px;
        }

        .filter-toggle-btn {
            text-align: center;
            margin-bottom: 20px;
        }

        .filter-toggle-btn button {
            background: none;
            border: none;
            cursor: pointer;
        }

        .filter-form {
            background-color: #ffffff;
            padding: 20px;
            margin-bottom: 30px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
            display: none;
            flex-wrap: wrap;
            gap: 15px;
            justify-content: center;
        }

        .filter-form input,
        .filter-form select {
            padding: 10px;
            border-radius: 5px;
            border: 1px solid #ccc;
        }

        .filter-form button {
            background-color: #3498db;
            color: white;
            padding: 10px 15px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }

        .filter-form button:hover {
            background-color: #2980b9;
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
            position: relative;
        }

        .card p {
            margin: 5px 0;
        }

        .botao-lixeira {
            cursor: pointer;
            position: absolute;
            top: 15px;
            right: 15px;
        }

        .botao-lixeira i {
            font-size: 18px;
            color: #e74c3c;
        }

        .btn {
            background-color: #e74c3c;
            color: white;
            padding: 10px 15px;
            border: none;
            border-radius: 5px;
            margin-top: 10px;
            cursor: pointer;
        }

        .btn:hover {
            background-color: #c0392b;
        }

        .btn-sec {
            background-color: #95a5a6;
        }

        .modal {
            display: none;
            position: fixed;
            top: 0; left: 0;
            width: 100%; height: 100%;
            background: rgba(0,0,0,0.4);
            justify-content: center;
            align-items: center;
        }

        .modal-content {
            background: white;
            padding: 25px;
            border-radius: 10px;
            width: 400px;
            position: relative;
        }

        .close {
            position: absolute;
            right: 15px;
            top: 10px;
            font-size: 20px;
            cursor: pointer;
        }
    </style>
</head>
<body>

<!-- Navbar -->
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
    <h1>Consultar Agenda</h1>

    <!-- Botão do Filtro -->
    <div class="filter-toggle-btn">
        <button onclick="toggleFiltro()" title="Filtrar Consultas">
            <i class="fas fa-filter fa-2x" style="color: #3498db;"></i>
        </button>
    </div>

    <!-- Formulário de Filtro -->
    <form action="consultarAgenda" method="get" class="filter-form" id="filtroContainer">
        <input type="date" name="filtroDataIni" placeholder="Data Inicial">
        <input type="date" name="filtroDataFim" placeholder="Data Final">

        <select name="filtroPaciente">
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

        <select name="filtroMedico">
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

        <button type="submit">Filtrar</button>
    </form>

    <!-- Lista de Consultas -->
    <div class="cards-container">
        <%
            List<Consulta> consultas = (List<Consulta>) request.getAttribute("consultas");
            if (consultas != null && !consultas.isEmpty()) {
                for (Consulta consulta : consultas) {
        %>
        <div class="card">
            <p><strong>Data:</strong> <%= consulta.getDataFormatada() %></p>
            <p><strong>Hora:</strong> <%= consulta.getHoraFormatada() %></p>
            <p><strong>Paciente:</strong> <%= consulta.getPaciente().getNome() %></p>
            <p><strong>Médico:</strong> <%= consulta.getMedico().getNome() %></p>
            <p><strong>Status:</strong> <%= consulta.getStatus() %></p>
            <p><strong>Observações:</strong> <%= consulta.getObservacoes() %></p>

            <form method="post" action="consultarAgenda" class="form-excluir">
                <input type="hidden" name="idConsulta" value="<%= consulta.getId_consulta() %>">
                <span class="botao-lixeira" onclick="this.closest('form').submit()" role="button" tabindex="0">
                        <i class="fas fa-trash-alt"></i>
                    </span>
            </form>
        </div>
        <%
            }
        } else {
        %>
        <p style="text-align: center;">Nenhuma consulta encontrada.</p>
        <%
            }
        %>
    </div>
</div>

<script>
    function toggleFiltro() {
        const container = document.getElementById("filtroContainer");
        container.style.display = (container.style.display === "none" || container.style.display === "") ? "flex" : "none";
    }
</script>

</body>
</html>