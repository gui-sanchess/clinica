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
        String realPathBase = request.getServletContext().getRealPath("/");
        UsuarioDAO dao = new UsuarioDAO(realPathBase);

        String idStr = request.getParameter("medicoId"); // novo parâmetro oculto do formulário
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
                medico.setTipo("medico"); // defina o tipo para 'medico'
                sucesso = dao.inserirUsuario(medico, realPathBase); // você precisará criar esse método no DAO
            }

            if (sucesso) {
                response.sendRedirect("cadastroMedicos"); // volta pra mesma página já com atualização
            } else {
                response.sendRedirect("cadastroMedicos?erro=1");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("cadastroMedicos?erro=500");
        }
    }
}
