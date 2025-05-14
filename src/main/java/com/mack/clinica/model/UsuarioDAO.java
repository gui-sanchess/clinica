package com.mack.clinica.model;

import com.mack.clinica.util.DatabaseConnection;

import java.sql.*;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

public class UsuarioDAO {

    private String realPathBase;

    public UsuarioDAO(String realPathBase) {
        this.realPathBase = realPathBase;
    }

    /**
     * Consulta o usuário pelo email e senha no banco.
     * @param email Email do usuário.
     * @param senha Senha do usuário.
     * @return Objeto Usuario encontrado ou null se não encontrado.
     */
    public static Usuario buscarUsuario(String email, String senha, String realPathBase) {
        try (Connection conn = DatabaseConnection.getConnection(realPathBase)) {
            String sql = "SELECT id, nome, tipo FROM usuarios WHERE email = ? AND senha = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, email);
            stmt.setString(2, senha);

            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                Usuario usuario = new Usuario();
                usuario.setId(rs.getInt("id"));
                usuario.setNome(rs.getString("nome"));
                usuario.setTipo(rs.getString("tipo"));
                return usuario;
            }

        } catch (SQLException e) {
            System.err.println("Erro ao buscar usuário: " + e.getMessage());
        }
        return null;
    }

    /**
     * Retorna os dados de um paciente pelo ID.
     */
    public Usuario listarPaciente(int id) {
        try (Connection conn = DatabaseConnection.getConnection(realPathBase)) {
            String sql = "SELECT * FROM usuarios WHERE id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, id);

            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                Usuario paciente = new Usuario();
                paciente.setId(rs.getInt("id"));
                paciente.setNome(rs.getString("nome"));
                paciente.setEmail(rs.getString("email"));
                paciente.setCelular(rs.getString("celular"));
                paciente.setCpf(rs.getString("cpf"));
                paciente.setSenha(rs.getString("senha"));
                return paciente;
            }

        } catch (SQLException e) {
            System.err.println("Erro ao buscar paciente: " + e.getMessage());
        }
        return null;
    }

    /**
     * Atualiza os dados de um usuário existente.
     */
    public boolean alterarUsuario(int id, String nome, String cpf, String senha, String email, String celular, String realPathBase) {
        try (Connection conn = DatabaseConnection.getConnection(realPathBase)) {
            String sql = "UPDATE usuarios SET nome=?, email=?, cpf=?, celular=?, senha=? WHERE id=?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, nome);
            stmt.setString(2, email);
            stmt.setString(3, cpf);
            stmt.setString(4, celular);
            stmt.setString(5, senha);  // ⚠️ considere usar hash no futuro
            stmt.setInt(6, id);

            int linhasAfetadas = stmt.executeUpdate();
            return linhasAfetadas > 0;
        } catch (SQLException e) {
            System.err.println("Erro ao atualizar usuário: " + e.getMessage());
            return false;
        }
    }

    /**
     * Retorna uma lista de todos os médicos cadastrados.
     */
    public List<Usuario> listarMedicos() {
        List<Usuario> medicos = new ArrayList<>();
        String sql = "SELECT * FROM usuarios WHERE tipo = 'medico'";

        try (Connection conn = DatabaseConnection.getConnection(realPathBase);
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Usuario u = new Usuario();
                u.setId(rs.getInt("id"));
                u.setNome(rs.getString("nome"));
                u.setEmail(rs.getString("email"));
                u.setCelular(rs.getString("celular"));
                u.setCpf(rs.getString("cpf"));
                u.setSenha(rs.getString("senha"));
                medicos.add(u);
            }
        } catch (SQLException e) {
            System.err.println("Erro ao buscar médicos: " + e.getMessage());
        }

        return medicos;
    }

    /**
     * Insere um novo usuário no banco.
     */
    public boolean inserirUsuario(Usuario usuario, String realPathBase) {
        String sql = "INSERT INTO usuarios (nome, email, senha, cpf, celular, tipo) VALUES (?, ?, ?, ?, ?, ?)";

        try (Connection conn = DatabaseConnection.getConnection(realPathBase);
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, usuario.getNome());
            stmt.setString(2, usuario.getEmail());
            stmt.setString(3, usuario.getSenha()); // ⚠️ usar hash é mais seguro
            stmt.setString(4, usuario.getCpf());
            stmt.setString(5, usuario.getCelular());
            stmt.setString(6, usuario.getTipo());

            int linhasAfetadas = stmt.executeUpdate();
            return linhasAfetadas > 0;

        } catch (SQLException e) {
            System.err.println("Erro ao inserir usuário: " + e.getMessage());
            return false;
        }
    }

    /**
     * Retorna uma lista de todos os pacientes cadastrados.
     */
    public List<Usuario> listarPacientes() {
        List<Usuario> pacientes = new ArrayList<>();
        String sql = "SELECT * FROM usuarios WHERE tipo = 'paciente'";

        try (Connection conn = DatabaseConnection.getConnection(realPathBase);
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Usuario u = new Usuario();
                u.setId(rs.getInt("id"));
                u.setNome(rs.getString("nome"));
                u.setEmail(rs.getString("email"));
                u.setCelular(rs.getString("celular"));
                u.setCpf(rs.getString("cpf"));
                u.setSenha(rs.getString("senha"));
                pacientes.add(u);
            }
        } catch (SQLException e) {
            System.err.println("Erro ao buscar pacientes: " + e.getMessage());
        }

        return pacientes;
    }

}
