package com.mack.clinica.model;

import java.util.Date;

public class Prontuario {
    private int id_prontuario;
    private int paciente_id;
    private int profissional_id;
    private Date data_hora;
    private String anotacoes_medicas;
    private String prescricoes;
    private Usuario medico;
    private String dataFormatada;

    private Usuario paciente;

    // Getters e Setters
    public int getId_prontuario() {
        return id_prontuario;
    }
    public void setId_prontuario(int id_prontuario) {
        this.id_prontuario = id_prontuario;
    }

    public int getPaciente_id() {
        return paciente_id;
    }
    public void setPaciente_id(int paciente_id) {
        this.paciente_id = paciente_id;
    }

    public int getProfissional_id() {return profissional_id;}
    public void setProfissional_id(int profissional_id) {this.profissional_id = profissional_id;}

    public Date getData_hora() {return data_hora;}
    public void setData_hora(Date data_hora) {this.data_hora = data_hora;}

    public String getAnotacoes_medicas() {return anotacoes_medicas;}
    public void setAnotacoes_medicas(String anotacoes_medicas) {this.anotacoes_medicas = anotacoes_medicas;}

    public String getPrescricoes() {return prescricoes;}
    public void setPrescricoes(String prescricoes) {this.prescricoes = prescricoes;}

    public Usuario getMedico() {return medico;}
    public void setMedico(Usuario medico) {this.medico = medico;}

    public String getDataFormatada() {return dataFormatada;}
    public void setDataFormatada(String dataFormatada) {this.dataFormatada = dataFormatada;}

    public Usuario getPaciente() {return paciente;}
    public void setPaciente(Usuario paciente) {this.paciente = paciente;}

}