package com.mack.clinica.model;

import com.mack.clinica.util.DatabaseConnection;

import java.sql.*;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

public class ConsultasDAO {



    // Método para listar consultas filtradas
    public List<Consulta> listarConsultasFiltradas(
            List<String> datas,
            List<Integer> pacientesIds,
            List<Integer> medicosIds,
            String pathBase) {

        StringBuilder sql = new StringBuilder(
                "SELECT c.id, c.paciente_id, c.profissional_id, c.data_hora, c.status, c.observacoes, " +
                        "p.nome AS nome_paciente, m.nome AS nome_medico " +
                        "FROM consultas c " +
                        "JOIN usuarios p ON c.paciente_id = p.id " +
                        "JOIN usuarios m ON c.profissional_id = m.id " +
                        "WHERE 1=1"
        );
        List<Object> params = new ArrayList<>();

        // Filtro data
        if (!datas.isEmpty()) {
            sql.append(" AND DATE(c.data_hora) BETWEEN ? AND ? ");
            //datas.forEach(d -> params.add(Date.valueOf(d)));
            datas.forEach(params::add);
            datas.forEach(d -> System.out.println(d));
        }

        // Filtro pacientes
        if (!pacientesIds.isEmpty()) {
            sql.append(" AND c.paciente_id IN (")
                    .append(String.join(",", Collections.nCopies(pacientesIds.size(), "?"))).append(")");
            pacientesIds.forEach(params::add);
        }

        // Filtro médicos
        if (!medicosIds.isEmpty()) {
            sql.append(" AND c.profissional_id IN (")
                    .append(String.join(",", Collections.nCopies(medicosIds.size(), "?"))).append(")");
            medicosIds.forEach(params::add);
        }

        sql.append(" ORDER BY c.data_hora ASC");
        System.out.println("SQL: " + sql.toString());
        List<Consulta> consultas = new ArrayList<>();
        try (Connection conn = DatabaseConnection.getConnection(pathBase);
             PreparedStatement stmt = conn.prepareStatement(sql.toString())) {
            System.out.println("Antes do for");
            for (int i = 0; i < params.size(); i++) {
                stmt.setObject(i + 1, params.get(i));
            }
            System.out.println("Antes do executeQuery");
            ResultSet rs = stmt.executeQuery();
            System.out.println("Depois do executeQuery");
            while (rs.next()) {
                consultas.add(mapearConsultaComPacienteEUsuario(rs));
            }
            System.out.println("Depois do while");
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return consultas;
    }

    // Método auxiliar para mapear o ResultSet para a classe Consulta
    private Consulta mapearConsultaComPacienteEUsuario(ResultSet rs) throws SQLException {
        Consulta consulta = new Consulta();
        consulta.setId_consulta(rs.getInt("id"));
        consulta.setPaciente_id(rs.getInt("paciente_id"));
        consulta.setProfissional_id(rs.getInt("profissional_id"));

        String dataHoraStr = rs.getString("data_hora");
        if (dataHoraStr != null) {
            LocalDateTime dataHora = LocalDateTime.parse(dataHoraStr);

            // Armazena no objeto como LocalDateTime
            consulta.setData_hora(dataHora);

            // Formata e separa
            DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");
            DateTimeFormatter timeFormatter = DateTimeFormatter.ofPattern("HH:mm");

            consulta.setDataFormatada(dataHora.format(dateFormatter));
            consulta.setHoraFormatada(dataHora.format(timeFormatter));
        }

        consulta.setStatus(rs.getString("status"));
        consulta.setObservacoes(rs.getString("observacoes"));

        // Cria objetos Usuario para paciente e médico
        Usuario paciente = new Usuario();
        paciente.setId(rs.getInt("paciente_id"));
        paciente.setNome(rs.getString("nome_paciente"));

        Usuario medico = new Usuario();
        medico.setId(rs.getInt("profissional_id"));
        medico.setNome(rs.getString("nome_medico"));

        consulta.setPaciente(paciente);
        consulta.setMedico(medico);

        return consulta;
    }

    public void excluirConsulta(int idConsulta, String realPathBase) {
        String sql = "DELETE FROM consultas WHERE id = ?";

        try (Connection conn = DatabaseConnection.getConnection(realPathBase);
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, idConsulta);
            int linhasAfetadas = stmt.executeUpdate();

            if (linhasAfetadas == 0) {
                System.err.println("Nenhuma consulta encontrada com o ID: " + idConsulta);
            } else {
                System.out.println("Consulta ID " + idConsulta + " excluída com sucesso.");
            }

        } catch (SQLException e) {
            System.err.println("Erro ao excluir consulta:");
            e.printStackTrace();
        }
    }

    public List<Consulta> listarConsultas(int id, String realPathBase) {
        List<Consulta> consultas = new ArrayList<>();

        try (Connection conn = DatabaseConnection.getConnection(realPathBase)) {
            String sql = "SELECT c.id, c.paciente_id, c.profissional_id, c.data_hora, c.status, c.observacoes, u.nome AS nome_medico FROM consultas c JOIN usuarios u ON c.profissional_id = u.id WHERE c.paciente_id = ? ORDER BY data_hora ASC";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, id);

            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Consulta consulta = new Consulta();
                consulta.setId_consulta(rs.getInt("id"));
                consulta.setPaciente_id(rs.getInt("paciente_id"));
                consulta.setProfissional_id(rs.getInt("profissional_id"));


                String dataHoraStr = rs.getString("data_hora");
                if (dataHoraStr != null) {
                    LocalDateTime dataHora = LocalDateTime.parse(dataHoraStr);

                    // Armazena no objeto como LocalDateTime
                    consulta.setData_hora(dataHora);

                    // Formata e separa
                    DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");
                    DateTimeFormatter timeFormatter = DateTimeFormatter.ofPattern("HH:mm");

                    consulta.setDataFormatada(dataHora.format(dateFormatter));
                    consulta.setHoraFormatada(dataHora.format(timeFormatter));
                }

                consulta.setStatus(rs.getString("status"));
                consulta.setObservacoes(rs.getString("observacoes"));

                Usuario medico = new Usuario();
                medico.setId(rs.getInt("profissional_id"));
                medico.setNome(rs.getString("nome_medico"));
                consulta.setMedico(medico);

                consultas.add(consulta);
            }

        } catch (SQLException e) {
            System.err.println("Erro ao buscar consultas: " + e.getMessage());
        }

        return consultas;
    }

}
