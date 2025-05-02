package com.mack.clinica.model;

import com.mack.clinica.util.DatabaseConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.mack.clinica.model.Usuario;

public class UsuarioDAO {

    /**
     * Consulta o usuário pelo email e senha no banco.
     * @param email Email do usuário.
     * @param senha Senha do usuário.
     * @param realPathBase Caminho real da aplicação para localizar o banco.
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
                // Se encontrou o usuário, cria um objeto Usuario
                Usuario usuario = new Usuario();
                usuario.setId(rs.getInt("id"));
                usuario.setNome(rs.getString("nome"));
                usuario.setTipo(rs.getString("tipo"));
                return usuario;
            }

        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("Erro ao buscar usuário no banco de dados.", e);
        }
        return null;
    }

    public Usuario listarPaciente(int id, String realPathBase) {

        try (Connection conn = DatabaseConnection.getConnection(realPathBase)){
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


    public boolean alterarUsuario(int id, String nome, String cpf, String senha, String email, String celular, String realPathBase) {

        try (Connection conn = DatabaseConnection.getConnection(realPathBase)) {
            String sql = "UPDATE usuarios set nome=?,email=?,cpf=?,celular=?,senha=? where id=?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, nome);
            System.out.println("nome: " + nome);
            stmt.setString(2, email);
            System.out.println("email: " + email);
            stmt.setString(3, cpf);
            System.out.println("cpf: " + cpf);
            stmt.setString(4, celular);
            System.out.println("celular: " + celular);
            stmt.setString(5, senha);
            System.out.println("senha: " + senha);
            stmt.setInt(6, id);
            System.out.println("ID: " + id);
            int linhasAfetadas = stmt.executeUpdate();
            System.out.println("Linhas afetadas: " + linhasAfetadas);
            return linhasAfetadas > 0;
        } catch (SQLException e) {
            System.out.println("entrou aqui");
            e.printStackTrace();
            return false;
        }
    }
}
