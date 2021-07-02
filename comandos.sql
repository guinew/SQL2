select numero, nome from banco;
select banco_numero, numero, nome from agencia;

with tbl_tmp_banco AS(
	select numero, nome
	from banco
)

select numero, nome
from tbl_tmp_banco;

with params as (
	select 213 as banco_numero
), tbl_tmp_banco AS(
	select numero, nome
	from banco
	join params on params.banco_numero = banco.numero
)
SELECT numero, nome from tbl_tmp_banco;

select banco.numero, banco.nome
from banco
join (
	select 213 AS banco_numero
) params on params.banco_numero = banco.numero;

with clientes_e_transacoes as (
	select cliente.nome AS cliente_nome,
			tipo_transacao.nome as tipo_transacao_nome,
			cliente_transacoes.valor as tipo_transacao_valor
	from cliente_transacoes
	join cliente on cliente.numero = cliente_transacoes.cliente_numero
	join tipo_transacao on tipo_transacao.id = cliente_transacoes.tipo_transacao_id
)
select cliente_nome, tipo_transacao_nome, tipo_transacao_valor
from clientes_e_transacoes;



with clientes_e_transacoes as (
	select cliente.nome AS cliente_nome,
			tipo_transacao.nome as tipo_transacao_nome,
			cliente_transacoes.valor as tipo_transacao_valor
	from cliente_transacoes
	join cliente on cliente.numero = cliente_transacoes.cliente_numero
	join tipo_transacao on tipo_transacao.id = cliente_transacoes.tipo_transacao_id
	join banco on banco.numero = cliente_transacoes.banco_numero and banco.nome ilike 'itau'
)
select cliente_nome, tipo_transacao_nome, tipo_transacao_valor
from clientes_e_transacoes;

SELECT numero, nome from banco;
SELECT banco_numero, numero, nome FROM agencia;
Select numero, nome FROM cliente;
Select banco_numero, agencia_numero, numero, digito, cliente_numero FROM conta_corrente;
Select id, nome FROM tipo_transacao;
SELECT banco_numero, agencia_numero, conta_corrente_numero , conta_corrente_digito, cliente_numero, valor from cliente_transacoes;

SELECT count(1) from agencia; -- 296
SELECT count (1) FROM banco; -- 151
-- 296
select banco.numero, banco.nome, agencia.numero, agencia.nome
from banco
join agencia ON agencia.banco_numero = banco.numero;
-- 296
select count (banco_numero)
from banco
join agencia ON agencia.banco_numero = banco.numero;

select count (distinct banco_numero)
from banco
join agencia ON agencia.banco_numero = banco.numero;
group BY banco.numero;

select banco.numero, banco.nome, agencia.numero, agencia.nome
FROM banco
LEFT join agencia on agencia.banco_numero = banco.numero;	

select agencia.numero, agencia.nome, banco.numero, banco.nome
from agencia
left join banco on banco.numero = agencia.banco_numero;

Select banco.numero, banco.nome, agencia.numero, agencia.nome
from banco
full join agencia on agencia.banco_numero = banco.numero;


CREATE table if not exists teste_a (id serial primary key, valor varchar(10));

CREATE table if not exists teste_b (id serial primary key, valor varchar(10));


insert into teste_a (valor) VALUES ('teste1');
insert into teste_a (valor) VALUES ('teste2');
insert into teste_a (valor) VALUES ('teste3');
insert into teste_a (valor) VALUES ('teste4');

insert into teste_b (valor) VALUES ('teste_a');
insert into teste_b (valor) VALUES ('teste_b');
insert into teste_b (valor) VALUES ('teste_c');
insert into teste_b (valor) VALUES ('teste_d');

select tbla.valor, tblb.valor
from teste_a tbla
cross join teste_b tblb;

drop table if exists teste_a;
drop table if exists teste_b;

select banco.nome,
		agencia.nome,
		conta_corrente.numero,
		conta_corrente.digito,
		cliente.nome
from banco
join agencia on agencia.banco_numero = banco.numero
join conta_corrente on conta_corrente.banco_numero = banco.numero
			and conta_corrente.agencia_numero = agencia.numero
join cliente
	on cliente.numero = conta_corrente.cliente_numero;
	

			
