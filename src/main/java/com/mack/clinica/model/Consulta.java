package com.mack.clinica.model;

import java.time.LocalDateTime;

public class Consulta {
    private int id_consulta;
    private int paciente_id;
    private int profissional_id;
    private LocalDateTime data_hora;
    private String status;
    private String observacoes;
    private Usuario medico;
    private String dataFormatada;
    private String horaFormatada;
    private Usuario paciente;

    // Getters e Setters
    public int getId_consulta() {
        return id_consulta;
    }
    public void setId_consulta(int id_consulta) {
        this.id_consulta = id_consulta;
    }

    public int getPaciente_id() {
        return paciente_id;
    }
    public void setPaciente_id(int paciente_id) {
        this.paciente_id = paciente_id;
    }

    public int getProfissional_id() {return profissional_id;}
    public void setProfissional_id(int profissional_id) {this.profissional_id = profissional_id;}

    public LocalDateTime getData_hora() {return data_hora;}
    public void setData_hora(LocalDateTime data_hora) {this.data_hora = data_hora;}

    public String getStatus() {return status;}
    public void setStatus(String status) {this.status = status;}

    public String getObservacoes() {return observacoes;}
    public void setObservacoes(String observacoes) {this.observacoes = observacoes;}

    public Usuario getMedico() {return medico;}
    public void setMedico(Usuario medico) {this.medico = medico;}

    public String getDataFormatada() {return dataFormatada;}
    public void setDataFormatada(String dataFormatada) {this.dataFormatada = dataFormatada;}

    public String getHoraFormatada() { return horaFormatada; }
    public void setHoraFormatada(String horaFormatada) { this.horaFormatada = horaFormatada; }

    public boolean isExpirada() {
        return data_hora != null && data_hora.isBefore(LocalDateTime.now());
    }

    public Usuario getPaciente() {return paciente;}
    public void setPaciente(Usuario paciente) {this.paciente = paciente;}

}