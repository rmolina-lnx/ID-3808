CREATE OR REPLACE PACKAGE BODY pk_er_otras_obligaciones IS
  /* 
   +----------------------------------------------------------------------+
   | Sistemas Enlinea S.A.                           Copyright (c) 2004   |
   +----------------------------------------------------------------------+
   | Fecha de Creación : 10-JUL-2024                                      |
   | Autor: Rafael Molina Osias     email:rmolina@sistemasenlinea.com.co  |
   +----------------------------------------------------------------------+
   | Actualizaciones :                                                    |
   +----------------------------------------------------------------------+
  */ 
   PROCEDURE pr_print_t_registros (t_registro pk_gr_constante.ty_t_cv_numero_varchar, i_sw VARCHAR2 DEFAULT pk_gr_constante.n_true)IS
      c_loop           BINARY_INTEGER;
   BEGIN
      IF i_sw = pk_gr_constante.n_true THEN
         c_loop := t_registro.FIRST;
         DBMS_OUTPUT.PUT_LINE('==========(RJM) t_registros =======');
         LOOP
            EXIT WHEN c_loop IS NULL;
            DBMS_OUTPUT.PUT_LINE(' t_registro('||c_loop||') ==========> '||CHR(10)||t_registro(c_loop));   
            c_loop := t_registro.NEXT(c_loop);
         END LOOP;
      DBMS_OUTPUT.PUT_LINE('==========(RJM) t_registros =======');
      END IF;
   END pr_print_t_registros;
   
   PROCEDURE pr_t_atributo_valor (t_atributo_valor pk_gr_constante.ty_t_clave_valor, i_sw VARCHAR2 DEFAULT pk_gr_constante.n_true)IS
      c_loop           VARCHAR2(32000);
   BEGIN
      
      IF i_sw = pk_gr_constante.n_true THEN
         DBMS_OUTPUT.PUT_LINE('==========(RJM) pr_t_atributo_valor =======');
         c_loop := t_atributo_valor.FIRST;      
         LOOP
            EXIT WHEN c_loop IS NULL;
            DBMS_OUTPUT.PUT_LINE('t_atributo_valor('||c_loop||') => '||t_atributo_valor(c_loop));   
            c_loop := t_atributo_valor.NEXT(c_loop);
         END LOOP;
      END IF;
   END pr_t_atributo_valor;
   

   PROCEDURE pr_mostrar_otras_obligaciones(v_k_idterc    NUMBER,
                                           n_funcionario VARCHAR2,
                                           n_x_json     OUT CLOB,
                                           f_f_corte     DATE DEFAULT SYSDATE)IS
      n_x_xml                     CLOB;
      n_aux                       CLOB;
      t_registro                  pk_gr_constante.ty_t_cv_numero_varchar;
      t_conversion                pk_er_json.ty_t_conversion;
      t_atributo_valor            pk_gr_constante.ty_t_clave_valor;
      t_matriz_numero_clave_valor pk_gr_constante.ty_t_matriz_numero_clave_valor;
      c_loop_2                    BINARY_INTEGER;
      c_loop                      BINARY_INTEGER;
            
      PROCEDURE pr_llena_conversion IS
      BEGIN

         t_conversion.DELETE;
         t_conversion('k_tipodr').n_valor        := 'CODIGO_TIPO_DOCUMENTO';
--         t_conversion('k_tipodr').n_lista        := pk_gr_constante.n_true;    
         t_conversion('k_numdoc').n_valor        := 'NUMERO_DOCUMENTO';
--         t_conversion('k_numdoc').n_lista        := pk_gr_constante.n_true;    
         t_conversion('n_tipodr').n_valor        := 'TIPO_DOCUMENTO';
--         t_conversion('n_tipodr').n_lista        := pk_gr_constante.n_true;
         t_conversion('f_docref').n_valor        := 'FECHA_DOCUMENTO';
--         t_conversion('f_docref').n_lista        := pk_gr_constante.n_true;
         t_conversion('v_saldo_favor').n_valor   := 'VALOR_SALDO_FAVOR';
--         t_conversion('v_saldo_favor').n_lista   := pk_gr_constante.n_true;
         t_conversion('v_saldo_cargo').n_valor   := 'VALOR_SALDO_CARGO';
--         t_conversion('v_saldo_cargo').n_lista   := pk_gr_constante.n_true; 
         t_conversion('i_tipodr').n_valor        := 'TIPO_DOUMENTO_SOPORTE';
--         t_conversion('i_tipodr').n_lista        := pk_gr_constante.n_true;
         t_conversion('i_tipodoc').n_valor       := 'IDENTIFICADOR_TIPO_DOUMENTO';
--         t_conversion('i_tipodoc').n_lista       := pk_gr_constante.n_true;

      END pr_llena_conversion;

       BEGIN -- Pirncipal
   
      pk_we_consulta.pr_mostrar_otras_obligaciones(v_k_idterc,n_funcionario,n_x_xml);
      n_aux   := XMLTYPE (n_x_xml).EXTRACT('consulta_otras_obligaciones/otras_obligaciones/registro' ).getClobVal(); 
      t_registro:= pk_er_json.fu_split(n_aux,'<registro>');
                  
      c_loop_2 := 0;
      c_loop := t_registro.first;
      
      LOOP
         EXIT WHEN c_loop IS NULL;
         pr_llena_conversion;     
         pk_er_json.pr_conversion_xml('registro', t_registro(c_loop),t_conversion, t_atributo_valor);
         t_matriz_numero_clave_valor (c_loop_2):= t_atributo_valor;
         c_loop:= t_registro.NEXT(c_loop);
         c_loop_2 := c_loop_2 + 1;
      END LOOP;
      n_x_json:= pk_er_json.fu_arma_trama_multiregistro('otras_obligaciones',t_matriz_numero_clave_valor,pk_gr_constante.n_true);
       
   EXCEPTION WHEN OTHERS THEN
      pk_gr_control_error.pr_control_error (dbms_utility.format_error_backtrace()||' '||SQLERRM, SQLCODE,'CONSULTA',SQLERRM,'AH');
      RAISE_APPLICATION_ERROR( -20000,dbms_utility.format_error_backtrace()||' '||SQLERRM);
   END pr_mostrar_otras_obligaciones;
   


END pk_er_otras_obligaciones;