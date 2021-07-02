-- Database: financas

-- DROP DATABASE financas;

CREATE DATABASE financas
    WITH 
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'Portuguese_Brazil.1252'
    LC_CTYPE = 'Portuguese_Brazil.1252'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1;
	
	-- Table: public.agencia

-- DROP TABLE public.agencia;

CREATE TABLE public.agencia
(
    banco_numero integer NOT NULL,
    numero integer NOT NULL,
    nome character varying(80) COLLATE pg_catalog."default" NOT NULL,
    ativo boolean NOT NULL DEFAULT true,
    data_criacao timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT agencia_pkey PRIMARY KEY (banco_numero, numero),
    CONSTRAINT agencia_banco_numero_fkey FOREIGN KEY (banco_numero)
        REFERENCES public.banco (numero) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE public.agencia
    OWNER to postgres;
	
	-- Table: public.banco

-- DROP TABLE public.banco;

CREATE TABLE public.banco
(
    numero integer NOT NULL,
    nome character varying(50) COLLATE pg_catalog."default" NOT NULL,
    ativo boolean NOT NULL DEFAULT true,
    data_criacao timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT banco_pkey PRIMARY KEY (numero)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE public.banco
    OWNER to postgres;
	
	-- Table: public.cliente

-- DROP TABLE public.cliente;

CREATE TABLE public.cliente
(
    numero bigint NOT NULL DEFAULT nextval('cliente_numero_seq'::regclass),
    nome character varying(120) COLLATE pg_catalog."default" NOT NULL,
    email character varying(250) COLLATE pg_catalog."default" NOT NULL,
    ativo boolean NOT NULL DEFAULT true,
    data_criacao timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT cliente_pkey PRIMARY KEY (numero)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE public.cliente
    OWNER to postgres;
	
	-- Table: public.cliente_transacoes

-- DROP TABLE public.cliente_transacoes;

CREATE TABLE public.cliente_transacoes
(
    id bigint NOT NULL DEFAULT nextval('cliente_transacoes_id_seq'::regclass),
    banco_numero integer NOT NULL,
    agencia_numero integer NOT NULL,
    conta_corrente_numero bigint NOT NULL,
    conta_corrente_digito smallint NOT NULL,
    cliente_numero bigint NOT NULL,
    tipo_transacao_id smallint NOT NULL,
    valor numeric(15,2),
    data_criacao timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT cliente_transacoes_pkey PRIMARY KEY (id),
    CONSTRAINT cliente_transacoes_banco_numero_fkey FOREIGN KEY (cliente_numero, conta_corrente_digito, agencia_numero, conta_corrente_numero, banco_numero)
        REFERENCES public.conta_corrente (cliente_numero, digito, agencia_numero, numero, banco_numero) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE public.cliente_transacoes
    OWNER to postgres;
	
	-- Table: public.conta_corrente

-- DROP TABLE public.conta_corrente;

CREATE TABLE public.conta_corrente
(
    banco_numero integer NOT NULL,
    agencia_numero integer NOT NULL,
    numero bigint NOT NULL,
    digito smallint NOT NULL,
    cliente_numero bigint NOT NULL,
    ativo boolean NOT NULL DEFAULT true,
    data_criacao timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT conta_corrente_pkey PRIMARY KEY (banco_numero, agencia_numero, numero, digito, cliente_numero),
    CONSTRAINT conta_corrente_banco_numero_fkey FOREIGN KEY (agencia_numero, banco_numero)
        REFERENCES public.agencia (numero, banco_numero) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT conta_corrente_cliente_numero_fkey FOREIGN KEY (cliente_numero)
        REFERENCES public.cliente (numero) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE public.conta_corrente
    OWNER to postgres;
	
	-- Table: public.funcionarios

-- DROP TABLE public.funcionarios;

CREATE TABLE public.funcionarios
(
    id integer NOT NULL DEFAULT nextval('funcionarios_id_seq'::regclass),
    nome character varying(50) COLLATE pg_catalog."default",
    gerente integer,
    CONSTRAINT funcionarios_pkey PRIMARY KEY (id),
    CONSTRAINT funcionarios_gerente_fkey FOREIGN KEY (gerente)
        REFERENCES public.funcionarios (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE public.funcionarios
    OWNER to postgres;
	
	-- Table: public.teste

-- DROP TABLE public.teste;

CREATE TABLE public.teste
(
    cpf character varying(11) COLLATE pg_catalog."default" NOT NULL,
    nome character varying(50) COLLATE pg_catalog."default" NOT NULL,
    created_at timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT teste_pkey PRIMARY KEY (cpf)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE public.teste
    OWNER to postgres;
	
	-- Table: public.tipo_transacao

-- DROP TABLE public.tipo_transacao;

CREATE TABLE public.tipo_transacao
(
    id smallint NOT NULL DEFAULT nextval('tipo_transacao_id_seq'::regclass),
    nome character varying(50) COLLATE pg_catalog."default" NOT NULL,
    ativo boolean NOT NULL DEFAULT true,
    data_criacao timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT tipo_transacao_pkey PRIMARY KEY (id)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE public.tipo_transacao
    OWNER to postgres;
	
	