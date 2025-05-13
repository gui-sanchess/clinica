<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.util.*, com.mack.clinica.model.Usuario" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <title>Cadastro de Médicos</title>
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

        .add-btn {
            display: block;
            margin-left: auto;
            margin-bottom: 20px;
            background-color: #2ecc71;
        }

        .add-btn:hover {
            background-color: #27ae60;
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

        .modal-content input {
            width: 100%;
            padding: 10px;
            margin: 8px 0;
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

<!-- Navbar original já estilizada no CSS -->
<div class="navbar">
    <div class="nav-links">
        <a href="admin_dashboard">Home</a>
        <a href="#">Cadastro de Pacientes</a>
        <a href="cadastroMedicos">Cadastro de Médicos</a>
        <a href="#">Consultar Agenda</a>
        <a href="#">Ficha Clínica</a>
        <a href="${pageContext.request.contextPath}/logout" class="logout-link">Logout</a>
    </div>
</div>

<div class="content">
    <h1>Médicos Cadastrados</h1>

    <!-- Botão de adicionar -->
    <button class="btn add-btn" onclick="abrirModalInserir()">+ Adicionar Médico</button>

    <!-- Cards em duas colunas -->
    <div class="cards-container">
        <%
            List<Usuario> medicos = (List<Usuario>) request.getAttribute("medicos");
            if (medicos != null && !medicos.isEmpty()) {
                for (Usuario medico : medicos) {
        %>
        <div class="card">
            <h3><%= medico.getNome() %></h3>
            <p><strong>Email:</strong> <%= medico.getEmail() %></p>
            <p><strong>CPF:</strong> <%= medico.getCpf() %></p>
            <p><strong>Celular:</strong> <%= medico.getCelular() %></p>
            <button class="btn" onclick="abrirModalEditar('<%= medico.getId() %>', '<%= medico.getNome() %>', '<%= medico.getEmail() %>', '<%= medico.getCpf() %>', '<%= medico.getCelular() %>')">Editar</button>
        </div>
        <%
            }
        } else {
        %>
        <p>Nenhum médico cadastrado.</p>
        <%
            }
        %>
    </div>
</div>

<!-- Modal para inserção/edição -->
<div class="modal" id="modalForm">
    <div class="modal-content">
        <span class="close" onclick="fecharModal()">&times;</span>
        <h2 id="modalTitle">Cadastrar Médico</h2>
        <form action="cadastroMedicos" method="post">
            <input type="hidden" name="medicoId" id="medicoId">
            <input type="text" name="userNome" id="userNome" placeholder="Nome" required>
            <input type="email" name="userEmail" id="userEmail" placeholder="Email" required>
            <input type="text" name="userCPF" id="userCPF" placeholder="CPF" required>
            <input type="text" name="userFone" id="userFone" placeholder="Celular" required>
            <input type="password" name="userSenha" id="userSenha" placeholder="Senha" required>
            <button type="submit" class="btn" style="width: 100%; margin-top: 10px;">Salvar</button>
        </form>
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
        document.getElementById('modalForm').style.display = 'flex';
    }

    function abrirModalEditar(id, nome, email, cpf, celular) {
        document.getElementById('modalTitle').innerText = 'Editar Médico';
        document.getElementById('medicoId').value = id;
        document.getElementById('userNome').value = nome;
        document.getElementById('userEmail').value = email;
        document.getElementById('userCPF').value = cpf;
        document.getElementById('userFone').value = celular;
        document.getElementById('userSenha').value = '';
        document.getElementById('modalForm').style.display = 'flex';
    }

    function fecharModal() {
        document.getElementById('modalForm').style.display = 'none';
    }
</script>

</body>
</html>
