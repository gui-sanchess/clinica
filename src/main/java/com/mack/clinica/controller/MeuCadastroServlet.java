package com.mack.clinica.controller;

import com.mack.clinica.model.Usuario;
import com.mack.clinica.model.UsuarioDAO;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpSession;


@WebServlet("/meuCadastro")
public class MeuCadastroServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Obtém o caminho real do projeto
        String realPathBase = request.getServletContext().getRealPath("/");
        // Instancia o DAO passando o caminho
        UsuarioDAO dao = new UsuarioDAO(realPathBase);
        Integer id = (Integer) request.getSession().getAttribute("id");

        // Busca a lista o usuario
        Usuario paciente = dao.listarPaciente(id);
        // Atribui a lista no request para ser usada no JSP
        request.setAttribute("paciente", paciente);
        // Encaminha para a página de agendamento
        request.getRequestDispatcher("/meu_cadastro.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Pega dados do formulário
            Usuario usuario =  new Usuario();
            usuario.setNome(request.getParameter("userNome"));
            usuario.setEmail(request.getParameter("userEmail"));
            usuario.setSenha(request.getParameter("userSenha"));
            usuario.setCpf(request.getParameter("userCPF"));
            usuario.setCelular(request.getParameter("userFone"));

            // Pega o id do usuario da sessão
            Integer id = (Integer) request.getSession().getAttribute("id");
            if (id == null) {
                System.out.println("Usuário logado não autenticado. Redirecionando para login.");
                response.sendRedirect("index.jsp");
                return;
            }

            // Conecta no banco
            String realPathBase = request.getServletContext().getRealPath("/");

            UsuarioDAO dao = new UsuarioDAO(realPathBase);

            // Agenda a consulta
            boolean sucesso = dao.alterarUsuario(id,usuario.getNome(),usuario.getCpf(),usuario.getSenha(),usuario.getEmail(),usuario.getCelular(),realPathBase);
            System.out.println("Sucesso: " + sucesso);
            if (sucesso) {
                // apresenta o pop-up de sucesso e mensagem_sucesso.jsp redireciona para o painel do paciente
                response.sendRedirect("/mensagem_sucesso_meucadastro.jsp");

            } else {
                response.sendRedirect("index.jsp?erro=meuCadastro");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("paciente_dashboard.jsp?msg=erro");
        }
    }
}

