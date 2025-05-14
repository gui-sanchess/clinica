package com.mack.clinica.controller;

import com.mack.clinica.model.*;
import com.mack.clinica.model.UsuarioDAO;
import com.mack.clinica.model.ConsultasDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/consultarAgenda")
public class ConsultarAgendaServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private Integer parseInteger(String value) {
        try {
            return (value != null && !value.isEmpty()) ? Integer.parseInt(value) : null;
        } catch (NumberFormatException e) {
            return null;
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Filtros
        Integer pacienteId = parseInteger(request.getParameter("filtroPaciente"));
        System.out.println("Pacienteid:" + pacienteId);
        Integer medicoId = parseInteger(request.getParameter("filtroMedico"));
        System.out.println("Medicoid:" + medicoId);
        String dataIni = request.getParameter("filtroDataIni");
        String dataFim= request.getParameter("filtroDataFim");

        List<Integer> pacientesIds = new ArrayList<>();
        List<Integer> medicosIds = new ArrayList<>();
        List<String> datas = new ArrayList<>();

        if (pacienteId != null) pacientesIds.add(pacienteId);
        if (medicoId != null) medicosIds.add(medicoId);
        if (dataIni != null && !dataIni.isEmpty()) datas.add(dataIni);
        if (dataFim != null && !dataFim.isEmpty()) datas.add(dataFim);

        String basePath = getServletContext().getRealPath("/");
        ConsultasDAO dao = new ConsultasDAO();
        UsuarioDAO usu_dao = new UsuarioDAO(basePath);

        request.setAttribute("consultas", dao.listarConsultasFiltradas(datas, pacientesIds, medicosIds, basePath));
        request.setAttribute("medicos", usu_dao.listarMedicos());
        request.setAttribute("pacientes", usu_dao.listarPacientes());

        request.getRequestDispatcher("/consultar_agenda.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Integer idConsulta = parseInteger(request.getParameter("idConsulta"));
        if (idConsulta != null) {
            ConsultasDAO dao = new ConsultasDAO();
            dao.excluirConsulta(idConsulta, request.getServletContext().getRealPath("/"));
        }
        response.sendRedirect("consultarAgenda");
}
}