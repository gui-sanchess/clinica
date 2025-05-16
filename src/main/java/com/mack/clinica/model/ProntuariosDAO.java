package com.mack.clinica.model;

import com.mack.clinica.util.DatabaseConnection;

import java.sql.*;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

public class ProntuariosDAO {


    public List<Prontuario> listarProntuarios(String realPathBase) {
        List<Prontuario> prontuarios = new ArrayList<>();

        try (Connection conn = DatabaseConnection.getConnection(realPathBase)) {
            String sql = "SELECT c.id, c.paciente_id, c.profissional_id, c.data, c.anotacoes_medicas, c.prescricoes, u.nome AS nome_medico, up.nome AS nome_paciente  FROM prontuarios c JOIN usuarios u ON c.profissional_id = u.id JOIN usuarios up ON c.paciente_id=up.id ORDER BY data ASC";
            PreparedStatement stmt = conn.prepareStatement(sql);

            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Prontuario prontuario = new Prontuario();
                prontuario.setId_prontuario(rs.getInt("id"));
                prontuario.setPaciente_id(rs.getInt("paciente_id"));

                Usuario paciente = new Usuario();
                paciente.setId(rs.getInt("paciente_id"));
                paciente.setNome(rs.getString("nome_paciente"));
                prontuario.setPaciente(paciente);

                prontuario.setProfissional_id(rs.getInt("profissional_id"));


                String dataStr = rs.getString("data");
                if (dataStr != null) {
                    LocalDate data = LocalDate.parse(dataStr); // só data
                    prontuario.setDataFormatada(data.format(DateTimeFormatter.ofPattern("dd/MM/yyyy")));
                }

                prontuario.setAnotacoes_medicas(rs.getString("anotacoes_medicas"));
                prontuario.setPrescricoes(rs.getString("prescricoes"));

                Usuario medico = new Usuario();
                medico.setId(rs.getInt("profissional_id"));
                medico.setNome(rs.getString("nome_medico"));
                prontuario.setMedico(medico);

                prontuarios.add(prontuario);
            }

        } catch (SQLException e) {
            System.err.println("Erro ao buscar consultas: " + e.getMessage());
        }

        return prontuarios;
    }


    public boolean inserirProntuario(Prontuario prontuario, String realPathBase) {
        String sql = "INSERT INTO prontuarios (id, paciente_id, profissional_id, anotacoes_medicas, prescricoes, data) VALUES ((SELECT max(id)+1 from prontuarios), ?, ?, ?, ?, ?)";

        try (Connection conn = DatabaseConnection.getConnection(realPathBase);
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, prontuario.getPaciente_id());
            stmt.setInt(2, prontuario.getProfissional_id());
            stmt.setString(3, prontuario.getAnotacoes_medicas());
            stmt.setString(4, prontuario.getPrescricoes());
            stmt.setString(5, prontuario.getDataFormatada()); // Aqui era o erro!

            int linhasAfetadas = stmt.executeUpdate();
            return linhasAfetadas > 0;

        } catch (SQLException e) {
            System.err.println("Erro ao inserir usuário: " + e.getMessage());
            return false;
        }
    }

}
