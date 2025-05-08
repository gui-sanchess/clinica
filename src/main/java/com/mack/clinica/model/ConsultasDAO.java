package com.mack.clinica.model;

import com.mack.clinica.util.DatabaseConnection;

import java.sql.*;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

public class ConsultasDAO {

    public List<Consulta> listarConsultas(int id, String realPathBase) {
        List<Consulta> consultas = new ArrayList<>();

        try (Connection conn = DatabaseConnection.getConnection(realPathBase)) {
            String sql = "SELECT c.id, c.paciente_id, c.profissional_id, c.data_hora, c.status, c.observacoes, u.nome AS nome_medico FROM consultas c JOIN usuarios u ON c.profissional_id = u.id WHERE c.paciente_id = ?";
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
