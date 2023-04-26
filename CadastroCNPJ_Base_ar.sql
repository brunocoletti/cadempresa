------------------------------------------
-- Script para Inclus�o de Novas Empresas
------------------------------------------
declare
   --
   vn_multorg_id   number;
   vn_pessoa_id    number;
   vn_empresa_id   number;
   vn_num_cnpj     number(8,0);
   vn_num_filial   number(4,0);
   vn_dig_cnpj     number(2,0);
   --
begin
   --
   -- Recupera��o do registro da Mult-Organiza��o
   --
   begin
      select mo.id
        into vn_multorg_id
        from csf_own.mult_org mo
       where mo.cd = 'XXXXXXXXXXXXXXX'; -- cd
   exception
      when others then
         vn_multorg_id := 0;
   end;
   --
   -- Cria��o do registro Pessoa
   --
   select csf_own.pessoa_seq.nextval
     into vn_pessoa_id
     from dual;
   --
   insert into csf_own.pessoa ( id
                              , dm_tipo_incl
                              , cod_part
                              , nome
                              , dm_tipo_pessoa
                              , fantasia
                              , lograd
                              , nro
                              , cx_postal
                              , compl
                              , bairro
                              , cidade_id
                              , cep
                              , fone
                              , fax
                              , email
                              , pais_id
                              , multorg_id
                              , dm_st_proc
                              )
                       values ( vn_pessoa_id -- id
                              , 0 -- dm_tipo_incl
                              , 'XXXXXXXXXXXXXXX' -- cod_part
                              , 'XXXXXXXXXXXXXXX' -- nome
                              , 1 -- dm_tipo_pessoa
                              , 'XXXXXXXXXXXXXXX' -- fantasia
                              , 'XXXXXXXXXXXXXXX' -- lograd
                              , 'XXXXXXXXXXXXXXX' -- nro
                              , '' -- cx_postal
                              , 'XXXXXXXXXXXXXXX' -- compl
                              , 'XXXXXXXXXXXXXXX' -- bairro
                              , (select ci.id from csf_own.cidade ci where ci.descr = 'XXXXXXXXXXXXXXX') -- cidade_id
                              , XXXXXXXXXXXXXXX -- cep
                              , 'XXXXXXXXXXXXXXX' -- fone
                              , '' -- fax
                              , 'XXXXXXXXXXXXXXX' -- email EM MINUSCULO
                              , (select es.pais_id from csf_own.estado es where es.id = (select ci.estado_id from csf_own.cidade ci where ci.descr = 'XXXXXXXXXXXXXXX')) -- pais_id
                              , vn_multorg_id -- multorg_id
                              , 1 -- dm_st_proc
                              );
   --
   -- Atribui��o variaveis do CNPJ
   vn_num_cnpj := XXXXXXXXXXXXXXX ;
   vn_num_filial := XXXXXXXXXXXXXXX ;
   vn_dig_cnpj := XXXXXXXXXXXXXXX ;
   --vn_pessoa_id
   -- Cria��o do registro Jur�dico
   --
   insert into csf_own.juridica ( id
                                , pessoa_id
                                , num_cnpj
                                , num_filial
                                , dig_cnpj
                                , ie
                                , iest
                                , im
                                , cnae
                                , suframa
                                )
                         values ( csf_own.juridica_seq.nextval -- id
                                , vn_pessoa_id -- pessoa_id
                                , vn_num_cnpj -- num_cnpj
                                , vn_num_filial -- num_filial
                                , vn_dig_cnpj -- dig_cnpj
                                , '' -- ie
                                , '' -- iest
                                , '' -- im
                                , '' -- cnae
                                , '' -- suframa
                                );
   --
   -- Cria��o do registro Empresa
   --
   select csf_own.empresa_seq.nextval
     into vn_empresa_id
     from dual;
   --
   insert into csf_own.empresa ( id
                               , pessoa_id
                               , dm_situacao
                               , dm_tp_amb
                               , dm_tp_impr
                               , dm_forma_emiss
                               , ar_empresa_id
                               , dt_ini_integr
                               , default_cons_stat
                               , caminho_chave_jks
                               , senha_chave_jks
                               , caminho_cert_pfx
                               , senha_cert_pfx
                               , nro_tentativas_comunic
                               , max_qtd_nfe_lote
                               , max_qtd_impressao
                               , email_nome
                               , email_ender_remet
                               , email_template_subject
                               , email_template_body
                               , email_template_body_canc
                               , email_body_cobr_xml_terc
                               , nro_tent_com_scan
                               , nro_tent_com_dpec
                               , dir_integra
                               , multorg_id
                               )
                        values ( vn_empresa_id -- id
                               , vn_pessoa_id -- pessoa_id
                               , 1 -- dm_situacao
                               , 2 -- dm_tp_amb
                               , 1 -- dm_tp_impr
                               , 1 -- dm_forma_emiss
                               , (select e.id from csf_own.juridica j, csf_own.empresa e where j.num_cnpj = vn_num_cnpj and j.num_filial = 1 and j.pessoa_id = e.pessoa_id) -- ar_empresa_id
                               , sysdate -- dt_ini_integr
                               , 0 -- default_cons_stat
                               , 'certraiz_compliance.jks' -- caminho_chave_jks
                               , 'compliance' -- senha_chave_jks
                               , '' -- caminho_cert_pfx
                               , '' -- senha_cert_pfx
                               , 30 -- nro_tentativas_comunic
                               , 1 -- max_qtd_nfe_lote
                               , 1 -- max_qtd_impressao
                               , 'teste' -- email_nome
                               , 'cliente@compliancefiscal.com.br' -- email_ender_remet
                               , 'Nota Fiscal Eletr�nica Nro:#nro_documento#/S�rie:#serie_documento# emitida por #remetente_nota_fantasia#' -- email_template_subject
                               , '---------------------------------------------------------
                                  -- N A O   R E S P O N D E R   A   E S S E   E M A I L --
                                  ---------------------------------------------------------
                                  Email gerado automaticamente pelo servico: Compliance-Nfe
                                  	         Compliance Solucoes Fiscais
                                          Nfe Segura e com reducao de custos.
                                        www.compliancefiscal.com.br 16.35169600
                                  ---------------------------------------------------------

                                  A(o) #razao_social_destinatario#

                                    As #hora_aprovacao_lote#  foi  aprovada  a emissao  da
                                  seguinte nota fiscal em formato eletronico:

                                  EMITENTE:
                                  =========
                                  Razao Social.: #razao_social_emitente#
                                  CNPJ/CPF.....: #cnpj_emitente#
                                  Telefone.....: #telefone_emitente#

                                  DESTINATARIO
                                  ============
                                  Razao Social.: #razao_social_destinatario#
                                  CNPJ/CPF.....: #cnpj_destinatario#

                                  DETALHES
                                  ========
                                  Chave Acesso.: #nro_chave_acesso#
                                  Documento....: #nro_documento# / Serie: #serie_documento#
                                  Data Emissao.: #data_emissao#
                                  Valor Total..: #valor_total#
                                  Link de acesso: #link_nfse#'
                               , '-- N A O   R E S P O N D E R   A   E S S E   E M A I L --
                                  ---------------------------------------------------------
                                  Email gerado automaticamente pelo servico: Compliance-Nfe
                                  	         Compliance Solucoes Fiscais
                                          Nfe Segura e com reducao de custos.
                                        www.compliancefiscal.com.br 16.35169600
                                  ---------------------------------------------------------
                                  A(o) #razao_social_destinatario#

                                    Cancelamento de Nota Fiscal Eletronica:
                                  EMITENTE:
                                  =========
                                  Razao Social.: #razao_social_emitente#
                                  CNPJ/CPF.....: #cnpj_emitente#
                                  Telefone.....: #telefone_emitente#

                                  DESTINAT�RIO
                                  ============
                                  Razao Social.: #razao_social_destinatario#
                                  CNPJ/CPF.....: #cnpj_destinatario#

                                  DETALHES
                                  ========
                                  Chave Acesso.: #nro_chave_acesso#
                                  Documento....: #nro_documento# / Serie: #serie_documento#
                                  Data Emissao.: #data_emissao#
                                  Valor Total..: #valor_total#'
                               , '--------------------------------------------------------- -- N � O   R E S P O N D E R   A   E S S E   E M A I L -- --------------------------------------------------------- Email gerado automaticamente pelo servi�o: Compliance-Nfe  �(o) #razao_social_fornecedor#    Solicitamos o envio do XML da NF-e abaixo:  EMITENTE: ========= Raz�o Social.: #razao_social_fornecedor#  DESTINAT�RIO ============ Raz�o Social.: #razao_social_empresa# CNPJ/CPF.....: #cnpj_empresa# Telefone.....: #telefone_empresa#  DETALHES ======== Chave Acesso.: #nro_chave_acesso# Documento....: #nro_documento# / S�rie: #serie_documento#'
                               , 5 -- nro_tent_com_scan
                               , 5 -- nro_tent_com_dpec
                               , 'XXXXXXXXXXXXXXX' -- dir_integra /complianceServer/ComplianceFiscal/Integra/13013263000187/
                               , vn_multorg_id -- multorg_id
                               );
   --
   insert into csf_own.usuario_empresa ( id
                                       , usuario_id
                                       , empresa_id
                                       , dm_acesso
                                       , dm_empr_default
                                       )
                                values ( csf_own.usuempr_seq.nextval
                                       , (select usuario_id from mult_org where cd = 'xxxxx') -- usuario_id
                                       , vn_empresa_id -- empresa_id
                                       , 1 -- dm_acesso
                                       , 0 -- dm_empr_default
                                       );
   --
   -- Cria��o do registro Valores de Par�metros - Sa�da para Impressora com Erro de Valida��o
   --
   insert into csf_own.csf_param_vl ( id
                                    , csfparametro_id
                                    , id_ref
                                    , seq
                                    , vl
                                    , dm_tp_param
                                    , obj_referen_id
                                    )
                             values ( csf_own.csfparamvl_seq.nextval -- id
                                    , (select cp.id from csf_own.csf_parametro cp where cp.ident_int = 'TIPO_LOG_SAIDA_IMPR') -- csfparametro_id
                                    , vn_empresa_id -- id_ref
                                    , 1 -- seq
                                    , 1 -- vl
                                    , 6 -- dm_tp_param
                                    , (select ct.id from csf_own.csf_tipo_log ct where ct.cd = 'ERRO_VALIDA') -- obj_referen_id
                                    );
   --
   -- Cria��o do registro Valores de Par�metros - Sa�da para Impressora com Erro de Impress�o
   --
   insert into csf_own.csf_param_vl ( id
                                    , csfparametro_id
                                    , id_ref
                                    , seq
                                    , vl
                                    , dm_tp_param
                                    , obj_referen_id
                                    )
                             values ( csf_own.csfparamvl_seq.nextval -- id
                                    , (select cp.id from csf_own.csf_parametro cp where cp.ident_int = 'TIPO_LOG_SAIDA_IMPR') -- csfparametro_id
                                    , vn_empresa_id -- id_ref
                                    , 1 -- seq
                                    , 1 -- vl
                                    , 6 -- dm_tp_param
                                    , (select ct.id from csf_own.csf_tipo_log ct where ct.cd = 'ERRO_IMP_ARQ') -- obj_referen_id
                                    );
   --
   --
   -- Efetivar os processos
   --
   commit;
   --
end;
/
