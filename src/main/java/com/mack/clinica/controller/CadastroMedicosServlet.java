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

@WebServlet("/cadastroMedicos")
public class CadastroMedicosServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String realPathBase = request.getServletContext().getRealPath("/");
        UsuarioDAO dao = new UsuarioDAO(realPathBase);
        List<Usuario> medicos = dao.listarMedicos();

        request.setAttribute("medicos", medicos);
        request.getRequestDispatcher("/cadastro_medico.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String method = request.getParameter("_method");

        if ("DELETE".equalsIgnoreCase(method)) {
            doDelete(request, response); // redireciona para doDelete se for delete
            return;
        }

        String realPathBase = request.getServletContext().getRealPath("/");
        UsuarioDAO dao = new UsuarioDAO(realPathBase);
        String idStr = request.getParameter("medicoId");
        boolean sucesso = false;

        try {
            Usuario medico = new Usuario();
            medico.setNome(request.getParameter("userNome"));
            medico.setEmail(request.getParameter("userEmail"));
            medico.setSenha(request.getParameter("userSenha"));
            medico.setCpf(request.getParameter("userCPF"));
            medico.setCelular(request.getParameter("userFone"));

            if (idStr != null && !idStr.isEmpty()) {
                int id = Integer.parseInt(idStr);
                sucesso = dao.alterarUsuario(id, medico.getNome(), medico.getCpf(), medico.getSenha(),
                        medico.getEmail(), medico.getCelular(), realPathBase);
            } else {
                medico.setTipo("medico");
                sucesso = dao.inserirUsuario(medico, realPathBase);
            }

            if (sucesso) {
                response.sendRedirect("/mensagem_sucesso_consultar.jsp?sucesso=1");
            } else {
                response.sendRedirect("cadastroMedicos?erro=1");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("cadastroMedicos?erro=500");
        }
    }

    @Override
    protected void doDelete(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String idStr = request.getParameter("medicoId");
        String realPathBase = request.getServletContext().getRealPath("/");

        if (idStr != null && !idStr.isEmpty()) {
            try {
                int id = Integer.parseInt(idStr);
                UsuarioDAO dao = new UsuarioDAO(realPathBase);
                dao.excluirUsuario(id);
                response.sendRedirect("cadastroMedicos");
            } catch (Exception e) {
                e.printStackTrace();
                response.sendRedirect("cadastroMedicos?erro=500");
            }
        } else {
            response.sendRedirect("cadastroMedicos?erro=400");
        }
    }
}
