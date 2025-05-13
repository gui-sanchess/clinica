package com.mack.clinica.controller;

import com.mack.clinica.model.Usuario;
import com.mack.clinica.model.UsuarioDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/cadastroPacientes")
public class CadastroPacientesServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String realPathBase = request.getServletContext().getRealPath("/");

        UsuarioDAO dao = new UsuarioDAO(realPathBase);
        List<Usuario> pacientes = dao.listarPacientes();

        request.setAttribute("pacientes", pacientes);
        request.getRequestDispatcher("/cadastro_paciente.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String realPathBase = request.getServletContext().getRealPath("/");
        UsuarioDAO dao = new UsuarioDAO(realPathBase);

        String idStr = request.getParameter("pacienteId"); // campo oculto do formulário para edição
        boolean sucesso = false;

        try {
            Usuario paciente = new Usuario();
            paciente.setNome(request.getParameter("userNome"));
            paciente.setEmail(request.getParameter("userEmail"));
            paciente.setSenha(request.getParameter("userSenha"));
            paciente.setCpf(request.getParameter("userCPF"));
            paciente.setCelular(request.getParameter("userFone"));

            if (idStr != null && !idStr.isEmpty()) {
                // Editar paciente existente
                int id = Integer.parseInt(idStr);
                sucesso = dao.alterarUsuario(id,
                        paciente.getNome(),
                        paciente.getCpf(),
                        paciente.getSenha(),
                        paciente.getEmail(),
                        paciente.getCelular(),
                        realPathBase);
            } else {
                // Inserir novo paciente
                paciente.setTipo("paciente");
                sucesso = dao.inserirUsuario(paciente, realPathBase);
            }

            if (sucesso) {
                response.sendRedirect("cadastroPacientes?sucesso=1");
            } else {
                response.sendRedirect("cadastroPacientes?erro=1");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("cadastroPacientes?erro=500");
        }
    }
}
