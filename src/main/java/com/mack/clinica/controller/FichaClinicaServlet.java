package com.mack.clinica.controller;

import com.mack.clinica.model.Prontuario;
import com.mack.clinica.model.ProntuariosDAO;
import com.mack.clinica.model.Usuario;
import com.mack.clinica.model.UsuarioDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/fichaClinica")
public class FichaClinicaServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String realPathBase = request.getServletContext().getRealPath("/");
        ProntuariosDAO prontuarioDAO = new ProntuariosDAO();
        UsuarioDAO usuarioDAO = new UsuarioDAO(realPathBase); // para buscar médicos

        List<Prontuario> prontuarios = prontuarioDAO.listarProntuarios(realPathBase);
        List<Usuario> pacientes = usuarioDAO.listarPacientes();
        List<Usuario> medicos = usuarioDAO.listarMedicos();

        request.setAttribute("prontuarios", prontuarios);
        request.setAttribute("pacientes", pacientes);
        request.setAttribute("medicos", medicos);

        request.getRequestDispatcher("/ficha_clinica.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String realPathBase = request.getServletContext().getRealPath("/");
        ProntuariosDAO prontuarioDAO = new ProntuariosDAO();
        boolean sucesso = false;

        try {
            String idStr = request.getParameter("id_prontuario");

            Prontuario prontuario = new Prontuario();
            prontuario.setPaciente_id(Integer.parseInt(request.getParameter("pacienteId")));
            prontuario.setProfissional_id(Integer.parseInt(request.getParameter("profissionalId")));
            prontuario.setDataFormatada(request.getParameter("dataFormatada"));
            prontuario.setAnotacoes_medicas(request.getParameter("anotacoes_medicas"));
            prontuario.setPrescricoes(request.getParameter("prescricoes"));

            if (idStr != null && !idStr.isEmpty()) {
                prontuario.setId_prontuario(Integer.parseInt(idStr));

            } else {
                sucesso = prontuarioDAO.inserirProntuario(prontuario, realPathBase);
            }

            if (sucesso) {
                response.sendRedirect("mensagem_sucesso_ficha.jsp?sucesso=1");
            } else {
                response.sendRedirect("fichaClinica?erro=1");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("fichaClinica?erro=500");
        }
    }
}
