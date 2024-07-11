CREATE OR REPLACE PACKAGE pk_er_otras_obligaciones IS
  /* 
   +----------------------------------------------------------------------+
   | Sistemas Enlinea S.A.                           Copyright (c) 2024   |
   +----------------------------------------------------------------------+
   | Fecha de Creación : 10-JUL-2024                                      |
   | Autor: Rafael Molina Osias     email:rmolina@sistemasenlinea.com.co  |
   +----------------------------------------------------------------------+
   | Actualizaciones :                                                    |
   +----------------------------------------------------------------------+
  */ 

   PROCEDURE pr_mostrar_otras_obligaciones(v_k_idterc    NUMBER,
                                           n_funcionario VARCHAR2,
                                           n_x_json     OUT CLOB,
                                           f_f_corte     DATE DEFAULT SYSDATE);
END pk_er_otras_obligaciones;
/