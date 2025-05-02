package com.mack.clinica.model;

/**
 * Modelo que representa o usuário do sistema.
 */
public class Usuario {
    private int id;
    private String nome;
    private String tipo; // paciente ou admin
    private String email;
    private String cpf;
    private String celular;
    private String senha;

    // Getters e Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public String getTipo() {
        return tipo;
    }

    public void setTipo(String tipo) {
        this.tipo = tipo;
    }

    public String getEmail() {return email;}
    public void setEmail(String email) {this.email = email;}

    public String getCpf() {return cpf;}
    public void setCpf(String cpf) {this.cpf = cpf;}

    public String getCelular() {return celular;}
    public void setCelular(String celular) {this.celular = celular;}

    public String getSenha() {return senha;}
    public void setSenha(String senha) {this.senha = senha;}

}
