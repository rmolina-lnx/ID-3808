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

   PROCEDURE pr_consulta_otras_obligaciones(n_numnit  ap014mcliente.aanumnit%type,
                                            n_x_json  OUT CLOB);
END pk_er_otras_obligaciones;
/