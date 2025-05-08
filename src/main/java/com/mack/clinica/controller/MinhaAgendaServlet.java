package com.mack.clinica.controller;

import com.mack.clinica.model.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/minhaAgenda")
public class MinhaAgendaServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Obtém o caminho real do projeto
        String realPathBase = request.getServletContext().getRealPath("/");
        // Instancia o DAO passando o caminho
        ConsultasDAO dao = new ConsultasDAO();
        Integer id = (Integer) request.getSession().getAttribute("id");

        // Busca a lista o usuario
        List<Consulta> consultas = dao.listarConsultas(id, realPathBase);
        // Atribui a lista no request para ser usada no JSP
        request.setAttribute("consultas", consultas);
        // Encaminha para a página de minha agenda
        request.getRequestDispatcher("/minha_agenda.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int idConsulta = Integer.parseInt(request.getParameter("idConsulta"));
        String realPath = getServletContext().getRealPath("/");

        ConsultasDAO consultaDAO = new ConsultasDAO();
        consultaDAO.excluirConsulta(idConsulta, realPath);

        response.sendRedirect("minhaAgenda");
    }
}